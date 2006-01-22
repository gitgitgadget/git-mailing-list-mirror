From: sean <seanlkml@sympatico.ca>
Subject: Re: git cherry unkillable
Date: Sun, 22 Jan 2006 09:51:13 -0500
Message-ID: <BAYC1-PASMTP123903F6C83FFE0EDA6284AE110@CEZ.ICE>
References: <200601221323.33377.arvidjaar@mail.ru>
	<BAYC1-PASMTP10435A067270A659801A48AE110@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: arvidjaar@mail.ru, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 22 15:56:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0gdt-0003FL-B8
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 15:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWAVO4N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jan 2006 09:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWAVO4N
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jan 2006 09:56:13 -0500
Received: from bayc1-pasmtp12.bayc1.hotmail.com ([65.54.191.172]:911 "EHLO
	BAYC1-PASMTP12.CEZ.ICE") by vger.kernel.org with ESMTP
	id S932107AbWAVO4M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2006 09:56:12 -0500
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.6.171]) by BAYC1-PASMTP12.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 22 Jan 2006 06:58:57 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id B1AD4644C23;
	Sun, 22 Jan 2006 09:56:08 -0500 (EST)
To: sean <seanlkml@sympatico.ca>
Message-Id: <20060122095113.0eea7aa0.seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP10435A067270A659801A48AE110@CEZ.ICE>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.10; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 22 Jan 2006 14:58:58.0000 (UTC) FILETIME=[5F23A500:01C61F64]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 22 Jan 2006 06:39:04 -0500
sean <seanlkml@sympatico.ca> wrote:

> The attached patch works for me but i'm concerned about it a bit.  

Below is a better version that doesn't obscure the proper exit value in the normal
case and exits with 1 if interrupted by the user.   It also ensures that the cleanup
isn't executed twice when the script is interrupted.

However, for Bash (at least) none of this is necessary; all the traps could just 
be changed to only trap 0 and the cleanup will be executed for all cases.   However,
I don't know how compatible that is with other shells.   If other shells behave
the same, the best fix is just to strip the 1,2,3 and 15 from each of the existing
trap lines and not bother with the patch given below.

Sean


diff --git a/git-cherry.sh b/git-cherry.sh
index 1a62320..0b2ef1f 100755
--- a/git-cherry.sh
+++ b/git-cherry.sh
@@ -49,7 +49,8 @@ ours=`git-rev-list $ours ^$limit` || exi
 tmp=.cherry-tmp$$
 patch=$tmp-patch
 mkdir $patch
-trap "rm -rf $tmp-*" 0 1 2 3 15
+trap "rm -rf $tmp-*" 0
+trap "exit 1" 1 2 3 15
 
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
diff --git a/git-format-patch.sh b/git-format-patch.sh
index 7e67c4e..6ba6339 100755
--- a/git-format-patch.sh
+++ b/git-format-patch.sh
@@ -77,7 +77,8 @@ tt)
 esac
 
 tmp=.tmp-series$$
-trap 'rm -f $tmp-*' 0 1 2 3 15
+trap "rm -f $tmp-*" 0
+trap "exit 1" 1 2 3 15
 
 series=$tmp-series
 commsg=$tmp-commsg
diff --git a/git-ls-remote.sh b/git-ls-remote.sh
index f699268..7dc224b 100755
--- a/git-ls-remote.sh
+++ b/git-ls-remote.sh
@@ -38,7 +38,8 @@ peek_repo="$(get_remote_url "$@")"
 shift
 
 tmp=.ls-remote-$$
-trap "rm -fr $tmp-*" 0 1 2 3 15
+trap "rm -rf $tmp-*" 0
+trap "exit 1" 1 2 3 15
 tmpdir=$tmp-d
 
 case "$peek_repo" in
diff --git a/git-reset.sh b/git-reset.sh
index 6c9e58a..166b635 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -4,7 +4,8 @@ USAGE='[--mixed | --soft | --hard]  [<co
 . git-sh-setup
 
 tmp=${GIT_DIR}/reset.$$
-trap 'rm -f $tmp-*' 0 1 2 3 15
+trap "rm -f $tmp-*" 0
+trap "exit 1" 1 2 3 15
 
 reset_type=--mixed
 case "$1" in
