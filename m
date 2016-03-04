From: Jeff King <peff@peff.net>
Subject: [PATCH] t9700: fix test for perl older than 5.14
Date: Fri, 4 Mar 2016 06:43:21 -0500
Message-ID: <20160304114321.GA569@sigill.intra.peff.net>
References: <CAP8UFD1z9H=SygaMVzpc__mXTbnFc2XiW0LZ+sfzdCPmrnXW6g@mail.gmail.com>
 <20160304085649.GA29752@sigill.intra.peff.net>
 <1457089104.2660.79.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Fri Mar 04 12:43:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abo8v-0001L4-8N
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 12:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbcCDLn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 06:43:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:54661 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750764AbcCDLnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 06:43:25 -0500
Received: (qmail 30140 invoked by uid 102); 4 Mar 2016 11:43:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Mar 2016 06:43:24 -0500
Received: (qmail 14488 invoked by uid 107); 4 Mar 2016 11:43:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Mar 2016 06:43:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Mar 2016 06:43:21 -0500
Content-Disposition: inline
In-Reply-To: <1457089104.2660.79.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288246>

On Fri, Mar 04, 2016 at 11:58:24AM +0100, Dennis Kaarsemaker wrote:

> On vr, 2016-03-04 at 03:56 -0500, Jeff King wrote:
> > ? Those are just guesses, but if we are tickling a bug in perl's parser,
> > this might avoid them. I also wondered when "/r" appeared. It was in
> > 5.14, so you're presumably good there. The "use" statement at the top of
> > the script says "5.008", so perhaps we should be writing it out longhand
> > anyway (that version is "only" 5 years old, so I suspect there are still
> > systems around with 5.12 or older).
> 
> Knowing the system Christian is testing on, I think the problem is that
> the tests are actually being run against perl 5.10, which RHEL 6 ships
> as system perl. As that's still a supported OS, writing tests in a form
> compatible with it would be a good thing :)

That would make sense. `perl` in t9700-perl-git.sh (and all of our
scripts) is actually a shell function:

  perl () {
          command "$PERL_PATH" "$@"
  }

to make sure we respect PERL_PATH everywhere. And that defaults in the
Makefile to /usr/bin/perl. Christian presumably has 5.14 in his $PATH,
but /usr/bin/perl is the system 5.10.

One workaround would therefore be for him to tweak PERL_PATH, but
obviously that does not help anyone else. I think we should do this:

-- >8 --
Subject: t9700: fix test for perl older than 5.14

Commit d53c2c6 (mingw: fix t9700's assumption about
directory separators, 2016-01-27) uses perl's "/r" regex
modifier to do a non-destructive replacement on a string,
leaving the original unmodified and returning the result.

This feature was introduced in perl 5.14, but systems with
older perl are still common (e.g., CentOS 6.5 still has perl
5.10). Let's work around it by providing a helper function
that does the same thing using older syntax.

While we're at it, let's switch to using an alternate regex
separator, which is slightly more readable.

Reported-by: Christian Couder <christian.couder@gmail.com>
Helped-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Signed-off-by: Jeff King <peff@peff.net>
---
And yes, before anyone checks, the alternate separators are available
even in ancient versions of perl. :)

 t/t9700/test.pl | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 7e8c40b..1b75c91 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -17,6 +17,12 @@ BEGIN {
 use Cwd;
 use File::Basename;
 
+sub adjust_dirsep {
+	my $path = shift;
+	$path =~ s{\\}{/}g;
+	return $path;
+}
+
 BEGIN { use_ok('Git') }
 
 # set up
@@ -33,7 +39,7 @@ is($r->config_int("test.int"), 2048, "config_int: integer");
 is($r->config_int("test.nonexistent"), undef, "config_int: nonexistent");
 ok($r->config_bool("test.booltrue"), "config_bool: true");
 ok(!$r->config_bool("test.boolfalse"), "config_bool: false");
-is($r->config_path("test.path") =~ s/\\/\//gr, $r->config("test.pathexpanded"),
+is(adjust_dirsep($r->config_path("test.path")), $r->config("test.pathexpanded"),
    "config_path: ~/foo expansion");
 is_deeply([$r->config_path("test.pathmulti")], ["foo", "bar"],
    "config_path: multiple values");
-- 
2.8.0.rc0.309.g6677de9
