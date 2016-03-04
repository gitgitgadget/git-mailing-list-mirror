From: Jeff King <peff@peff.net>
Subject: Re: t9700-perl-git.sh is broken on some configurations
Date: Fri, 4 Mar 2016 03:56:49 -0500
Message-ID: <20160304085649.GA29752@sigill.intra.peff.net>
References: <CAP8UFD1z9H=SygaMVzpc__mXTbnFc2XiW0LZ+sfzdCPmrnXW6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 09:57:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ablXi-00025V-9x
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 09:57:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758765AbcCDI4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 03:56:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:54619 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758752AbcCDI4x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 03:56:53 -0500
Received: (qmail 22449 invoked by uid 102); 4 Mar 2016 08:56:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Mar 2016 03:56:52 -0500
Received: (qmail 13654 invoked by uid 107); 4 Mar 2016 08:57:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Mar 2016 03:57:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Mar 2016 03:56:49 -0500
Content-Disposition: inline
In-Reply-To: <CAP8UFD1z9H=SygaMVzpc__mXTbnFc2XiW0LZ+sfzdCPmrnXW6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288239>

On Fri, Mar 04, 2016 at 09:13:51AM +0100, Christian Couder wrote:

> Indeed on the command line I get:
> 
> ------------------------
> $ t/t9700/test.pl
> ok 2 - use Git;
> Bareword found where operator expected at t/t9700/test.pl line 36,
> near "s/\\/\//gr"
> syntax error at t/t9700/test.pl line 36, near "s/\\/\//gr"
> Execution of t/t9700/test.pl aborted due to compilation errors.
> ------------------------
> 
> A quick look at t/t9700/test.pl line 36 was not enough for me to spot
> the problem.
> 
> Perl version is: perl 5, version 18, subversion 2 (v5.18.2) built for
> x86_64-linux
> 
> The machine is running CentOS 6.5.

I can't reproduce on any of the machines I have handy (perl 5.14, 5.20,
and 5.22). I don't have 5.18 handy. The line in question looks fine to
me, so perhaps it is a temporary regression in 5.18.

Does it help to wrap it in parentheses, like:

diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 7e8c40b..edeeb0e 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -33,7 +33,7 @@ is($r->config_int("test.int"), 2048, "config_int: integer");
 is($r->config_int("test.nonexistent"), undef, "config_int: nonexistent");
 ok($r->config_bool("test.booltrue"), "config_bool: true");
 ok(!$r->config_bool("test.boolfalse"), "config_bool: false");
-is($r->config_path("test.path") =~ s/\\/\//gr, $r->config("test.pathexpanded"),
+is(($r->config_path("test.path") =~ s/\\/\//gr), $r->config("test.pathexpanded"),
    "config_path: ~/foo expansion");
 is_deeply([$r->config_path("test.pathmulti")], ["foo", "bar"],
    "config_path: multiple values");

or even write it out longhand without "/r":

diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 7e8c40b..52471cf 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -33,7 +33,9 @@ is($r->config_int("test.int"), 2048, "config_int: integer");
 is($r->config_int("test.nonexistent"), undef, "config_int: nonexistent");
 ok($r->config_bool("test.booltrue"), "config_bool: true");
 ok(!$r->config_bool("test.boolfalse"), "config_bool: false");
-is($r->config_path("test.path") =~ s/\\/\//gr, $r->config("test.pathexpanded"),
+my $test_path = $r->config_path("test.path");
+$test_path =~ s/\\/\//g;
+is($test_path, $r->config("test.pathexpanded"),
    "config_path: ~/foo expansion");
 is_deeply([$r->config_path("test.pathmulti")], ["foo", "bar"],
    "config_path: multiple values");

? Those are just guesses, but if we are tickling a bug in perl's parser,
this might avoid them. I also wondered when "/r" appeared. It was in
5.14, so you're presumably good there. The "use" statement at the top of
the script says "5.008", so perhaps we should be writing it out longhand
anyway (that version is "only" 5 years old, so I suspect there are still
systems around with 5.12 or older).

-Peff
