From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] allow git-am to run in a subdirectory
Date: Sat, 1 Mar 2008 03:12:35 -0500
Message-ID: <20080301081235.GA31855@coredump.intra.peff.net>
References: <20080301062255.GA27538@coredump.intra.peff.net> <7vprue6ghc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 09:13:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVMqI-0002zy-Dl
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 09:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbYCAIMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 03:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754248AbYCAIMi
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 03:12:38 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1859 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754203AbYCAIMh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 03:12:37 -0500
Received: (qmail 12270 invoked by uid 111); 1 Mar 2008 08:12:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 01 Mar 2008 03:12:36 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Mar 2008 03:12:35 -0500
Content-Disposition: inline
In-Reply-To: <7vprue6ghc.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75639>

On Fri, Feb 29, 2008 at 11:38:55PM -0800, Junio C Hamano wrote:

> As long as you do not lose sight of the mailbox parameter by chdir'ing
> around, I am Ok with the patch.
> 
> ... and after I started writing that, I find...

Ugh. Below is a patch that saves the original pwd and prefixes it for
relative paths. However:

  - it probably doesn't correctly determine absolute versus relative
    paths on Windows. I don't think we have a solution for fixing this
    within shell scripts.

  - it will eat newlines in parameters names (actually, turning them
    into spaces)

The problem is that I need to turn the original "$@" into a new "$@"
that is correctly prefixed, which requires proper quoting. Please, spend
some of your shell guru points to show me how to do this correctly and
portably.

We could wait on doing the 'cd_to_toplevel' until after the mailsplit,
but then your .dotest will end up in a prefixed directory (and of course
we have a similar munging problem when we point .dotest to the right
spot).

Maybe I should just wait for a git-am rewrite in C. ;)

---
diff --git a/git-am.sh b/git-am.sh
index 2ecebc4..a5e0c43 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -2,6 +2,7 @@
 #
 # Copyright (c) 2005, 2006 Junio C Hamano
 
+SUBDIRECTORY_OK=Yes
 OPTIONS_KEEPDASHDASH=
 OPTIONS_SPEC="\
 git-am [options] <mbox>|<Maildir>...
@@ -25,6 +26,13 @@ skip            skip the current patch"
 . git-sh-setup
 set_reflog_action am
 require_work_tree
+orig_pwd=$(pwd)
+cd_to_toplevel
+if test "$(pwd)" = "$orig_pwd"; then
+	orig_pwd=
+else
+	orig_pwd="$orig_pwd/"
+fi
 
 git var GIT_COMMITTER_IDENT >/dev/null || exit
 
@@ -121,6 +129,21 @@ reread_subject () {
 	git stripspace <"$1" | sed -e 1q
 }
 
+shellquote() {
+	printf \'
+	printf "$1" | sed "s/'/\\'/g"
+	echo \'
+}
+
+handle_file_args() {
+	for i in "$@"; do
+		case "$i" in
+		/*) shellquote "$i";;
+		 *) shellquote "$orig_pwd$i";;
+		esac
+	done
+}
+
 prec=4
 dotest=.dotest sign= utf8=t keep= skip= interactive= resolved= binary=
 resolvemsg= resume=
@@ -148,7 +171,7 @@ do
 	--skip)
 		skip=t ;;
 	-d|--dotest)
-		shift; dotest=$1;;
+		shift; eval dotest=`handle_file_args "$1"` ;;
 	--resolvemsg)
 		shift; resolvemsg=$1 ;;
 	--whitespace)
@@ -163,6 +186,8 @@ do
 	shift
 done
 
+eval set -- `handle_file_args "$@"`
+
 # If the dotest directory exists, but we have finished applying all the
 # patches in them, clear it out.
 if test -d "$dotest" &&
