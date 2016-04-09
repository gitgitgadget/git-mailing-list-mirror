From: Jeff King <peff@peff.net>
Subject: Re: Hardcoded #!/bin/sh in t5532 causes problems on Solaris
Date: Sat, 9 Apr 2016 17:04:30 -0400
Message-ID: <20160409210429.GB18989@sigill.intra.peff.net>
References: <570965B9.9040207@jupiterrise.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Tom G. Christensen" <tgc@jupiterrise.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 23:05:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ap04Y-0003ap-Vc
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 23:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbcDIVEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 17:04:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:47022 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750899AbcDIVEe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 17:04:34 -0400
Received: (qmail 14894 invoked by uid 102); 9 Apr 2016 21:04:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 09 Apr 2016 17:04:33 -0400
Received: (qmail 14588 invoked by uid 107); 9 Apr 2016 21:04:37 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 09 Apr 2016 17:04:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Apr 2016 17:04:30 -0400
Content-Disposition: inline
In-Reply-To: <570965B9.9040207@jupiterrise.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291134>

On Sat, Apr 09, 2016 at 10:27:37PM +0200, Tom G. Christensen wrote:

> Looking at the testsuite results on Solaris I see a failure in t5532.3.
> 
> Running the testsuite with -v -i revealed a shell syntax error:
> 
> proxying for example.com 9418
> ./proxy: syntax error at line 3: `cmd=$' unexpected
> not ok 3 - fetch through proxy works
> #
> #               git fetch fake &&
> #               echo one >expect &&
> #               git log -1 --format=%s FETCH_HEAD >actual &&
> #               test_cmp expect actual
> #
> 
> 
> Looking a t5532-fetch-proxy.sh the problem is obvious, it writes out a
> helper script which explicitly uses #!/bin/sh but fails to take into account
> that systems like Solaris has an ancient /bin/sh that knows nothing about
> POSIX things like $().
> Replacing $() with `` was enough to make the test pass.

Right, this is a recent regression from Elia's $() series. Rather than
just revert, I think the cleanup below is the best fix.

I did some quick grepping around, and I suspect you may run
into the same thing in other places (e.g., t3404.40 looks
like a similar case). We left a lot of "#!/bin/sh" cases
unconverted to write_script because we knew what they were
doing was trivial enough not to matter. But the $()
conversion made them non-trivial.

-- >8 --
Subject: [PATCH] t5532: use write_script

The recent cleanup in b7cbbff switched t5532's use of
backticks to $(). This matches our normal shell style, which
is good. But it also breaks the test on Solaris, where
/bin/sh does not understand $().

Our normal shell style assumes a modern-ish shell which
knows about $(). However, some tests create small helper
scripts and just write "#!/bin/sh" into them. These scripts
either need to go back to using backticks, or they need to
respect $SHELL_PATH. The easiest way to do the latter is to
use write_script.

While we're at it, let's also stick the script creation
inside a test_expect block (our usual style), and split the
perl snippet into its own script (to prevent quoting
madness).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5532-fetch-proxy.sh | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/t/t5532-fetch-proxy.sh b/t/t5532-fetch-proxy.sh
index d75ef0e..51c9669 100755
--- a/t/t5532-fetch-proxy.sh
+++ b/t/t5532-fetch-proxy.sh
@@ -12,10 +12,8 @@ test_expect_success 'setup remote repo' '
 	)
 '
 
-cat >proxy <<'EOF'
-#!/bin/sh
-echo >&2 "proxying for $*"
-cmd=$("$PERL_PATH" -e '
+test_expect_success 'setup proxy script' '
+	write_script proxy-get-cmd "$PERL_PATH" <<-\EOF &&
 	read(STDIN, $buf, 4);
 	my $n = hex($buf) - 4;
 	read(STDIN, $buf, $n);
@@ -23,11 +21,16 @@ cmd=$("$PERL_PATH" -e '
 	# drop absolute-path on repo name
 	$cmd =~ s{ /}{ };
 	print $cmd;
-')
-echo >&2 "Running '$cmd'"
-exec $cmd
-EOF
-chmod +x proxy
+	EOF
+
+	write_script proxy <<-\EOF
+	echo >&2 "proxying for $*"
+	cmd=$(./proxy-get-cmd)
+	echo >&2 "Running $cmd"
+	exec $cmd
+	EOF
+'
+
 test_expect_success 'setup local repo' '
 	git remote add fake git://example.com/remote &&
 	git config core.gitproxy ./proxy
-- 
2.8.1.245.g18e0f5c
