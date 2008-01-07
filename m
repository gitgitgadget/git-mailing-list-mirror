From: Jeff King <peff@peff.net>
Subject: Re: CRLF problems with Git on Win32
Date: Mon, 7 Jan 2008 05:12:56 -0500
Message-ID: <20080107101256.GA25047@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <5C0F88FD-AB2F-4BAD-ADEC-75428F14260F@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Jan 07 11:13:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBozO-0006Gt-2O
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 11:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645AbYAGKNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 05:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754226AbYAGKND
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 05:13:03 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1967 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754371AbYAGKNB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 05:13:01 -0500
Received: (qmail 4143 invoked by uid 111); 7 Jan 2008 10:12:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 07 Jan 2008 05:12:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Jan 2008 05:12:56 -0500
Content-Disposition: inline
In-Reply-To: <5C0F88FD-AB2F-4BAD-ADEC-75428F14260F@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69778>

On Mon, Jan 07, 2008 at 10:57:52AM +0100, Steffen Prohaska wrote:

> or you can manually do what clone would do for you, i.e.
>
>     mkdir turqstat
>     cd turqstat
>     git init
>     git config core.autocrlf true
>     git remote add origin git://git.debian.org/git/turqstat/turqstat.git
>     git fetch origin
>     git checkout -b master origin/master
>
> (this is what I typically do).
>
> BTW, I think that git clone should be improved to avoid the
> workaround described above.  Maybe it could ask the user if it
> should set up a specific line ending conversion before checkout.
> Unfortunately, I had no time to write a patch, yet.

I don't know if there are other options that might impact how clone
works, but something like the patch below might make sense. It would
allow:

  git clone -c core.autocrlf=true ...

Note that the patch should not be applied; it doesn't handle values with
whitespace (and hopefully builtin clone will come soon after v1.5.4,
which would make doing it right much simpler).

---

diff --git a/git-clone.sh b/git-clone.sh
index b4e858c..a002550 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -23,6 +23,7 @@ reference=           reference repository
 o,origin=            use <name> instead of 'origin' to track upstream
 u,upload-pack=       path to git-upload-pack on the remote
 depth=               create a shallow clone of that depth
+c,config=            set a config option of the form key=value
 
 use-separate-remote  compatibility, do not use
 no-separate-remote   compatibility, do not use"
@@ -127,6 +128,7 @@ use_separate_remote=t
 depth=
 no_progress=
 local_explicitly_asked_for=
+config=
 test -t 1 || no_progress=--no-progress
 
 while test $# != 0
@@ -173,6 +175,9 @@ do
 	--depth)
 		shift
 		depth="--depth=$1" ;;
+	-c|--config)
+		shift
+		config="$config $1" ;;
 	--)
 		shift
 		break ;;
@@ -242,6 +247,12 @@ fi &&
 export GIT_DIR &&
 GIT_CONFIG="$GIT_DIR/config" git-init $quiet ${template+"$template"} || usage
 
+for i in $config; do
+	key=`echo $i | cut -d= -f1`
+	value=`echo $i | cut -d= -f2-`
+	git config $key $value
+done
+
 if test -n "$bare"
 then
 	GIT_CONFIG="$GIT_DIR/config" git config core.bare true
