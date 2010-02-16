From: Johan Herland <johan@herland.net>
Subject: [PATCH] submodule summary: Don't barf when invoked in an empty repo
Date: Tue, 16 Feb 2010 11:21:14 +0100
Message-ID: <201002161121.14613.johan@herland.net>
References: <20100216041945.GB10296@vfb-9.home>
 <20100216062422.GC10296@vfb-9.home>
 <20100216072154.GF2169@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Jacob Helwig <jacob.helwig@gmail.com>,
	Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 11:21:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhKYX-0002Eo-UE
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 11:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932750Ab0BPKVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 05:21:20 -0500
Received: from smtp.getmail.no ([84.208.15.66]:46040 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932372Ab0BPKVT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 05:21:19 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXX00824JFHDZB0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 16 Feb 2010 11:21:17 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXX007GQJFFUM40@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 16 Feb 2010 11:21:17 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.16.100626
User-Agent: KMail/1.13.0 (Linux/2.6.32-ARCH; KDE/4.4.0; x86_64; ; )
In-reply-to: <20100216072154.GF2169@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140090>

When invoking "git submodule summary" in an empty repo (which can be
indirectly done by setting status.submodulesummary = true), it currently
emits an error message (via "git diff-index") since HEAD points to an
unborn branch.

This patch adds handling of the HEAD-points-to-unborn-branch special case,
so that "git submodule summary" no longer emits this error message.

The patch also adds a test case that verifies the fix.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Johan Herland <johan@herland.net>
---

On Tuesday 16 February 2010, Jeff King wrote:
> It looks like this code (git-submodule.sh:556-562):
> 
>         if rev=$(git rev-parse -q --verify "$1^0")
>         then
>                 head=$rev
>                 shift
>         else
>                 head=HEAD
>         fi
> 
> is meant to guess whether the argument is a revision or a file limiter,
> and if the latter, assume HEAD was meant. Which obviously breaks down
> when the argument is HEAD and it is invalid. The patch below seems to
> fix it for me, but I have no idea if I am breaking something else.
> 
> Can somebody more clueful about the submodule script take a look?

I don't know this code very well, but from looking at the commit introducing
this code (28f9af5: git-submodule summary: code framework), your analysis
makes sense. However, your fix doesn't work well for me.

> ---
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 664f217..4332992 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -555,10 +555,12 @@ cmd_summary() {
> 
>  	if rev=$(git rev-parse -q --verify "$1^0")
>  	then
>  		head=$rev
>  		shift
> +	elif test "$1" = "HEAD"; then
> +		return
>  	else
>  		head=HEAD
>  	fi
> 
>  	if [ -n "$files" ]

I'm working from the simple test case in the below patch, I get the
following output with your proposed fix:

  [...]
  trace: built-in: git 'rev-parse' '-q' '--verify' '^0'
  [...]
  trace: built-in: git 'diff-index' '--raw' 'HEAD' '--'
  fatal: bad revision 'HEAD'
  [...]

I.e. your fix doesn't work because $1 is empty (not "HEAD") at this point.

My alternative patch (below) does pass my test case (and all the other
tests as well)

I'd still like an ACK from the original author (Ping Yin) as well, as I'm
not sure if I overlooked something by removing the "$1^0".


Have fun! :)

...Johan


 git-submodule.sh             |    7 +++++--
 t/t7401-submodule-summary.sh |    7 +++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 664f217..906b7b2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -553,12 +553,15 @@ cmd_summary() {
 
 	test $summary_limit = 0 && return
 
-	if rev=$(git rev-parse -q --verify "$1^0")
+	if rev=$(git rev-parse -q --verify --default HEAD $1)
 	then
 		head=$rev
 		shift
+	elif test -z "$1" -o "$1" = "HEAD"
+	then
+		return
 	else
-		head=HEAD
+		head="HEAD"
 	fi
 
 	if [ -n "$files" ]
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index d3c039f..cee319d 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -227,4 +227,11 @@ test_expect_success 'fail when using --files together with --cached' "
     test_must_fail git submodule summary --files --cached
 "
 
+test_expect_success 'should not fail in an empty repo' "
+    git init xyzzy &&
+    cd xyzzy &&
+    git submodule summary >output 2>&1 &&
+    test_cmp output /dev/null
+"
+
 test_done
-- 
1.7.0.rc1.141.gd3fd


-- 
Johan Herland, <johan@herland.net>
www.herland.net
