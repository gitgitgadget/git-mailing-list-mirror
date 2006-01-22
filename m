From: sean <seanlkml@sympatico.ca>
Subject: Re: git cherry unkillable
Date: Sun, 22 Jan 2006 10:48:50 -0500
Message-ID: <BAYC1-PASMTP02221D60BC2E89DF618E0AAE110@CEZ.ICE>
References: <200601221323.33377.arvidjaar@mail.ru>
	<BAYC1-PASMTP10435A067270A659801A48AE110@CEZ.ICE>
	<BAYC1-PASMTP123903F6C83FFE0EDA6284AE110@CEZ.ICE>
	<200601221821.54461.arvidjaar@mail.ru>
	<BAYC1-PASMTP03EC255443CA14D57D82F6AE110@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: arvidjaar@mail.ru, git@vger.kernel.org, zsh-workers@sunsite.dk
X-From: git-owner@vger.kernel.org Sun Jan 22 16:53:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0hXK-0005HR-Iw
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 16:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWAVPxs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jan 2006 10:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWAVPxs
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jan 2006 10:53:48 -0500
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:35567 "EHLO
	BAYC1-PASMTP02.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751278AbWAVPxr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2006 10:53:47 -0500
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.6.171]) by BAYC1-PASMTP02.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 22 Jan 2006 07:53:46 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 92EEC644C23;
	Sun, 22 Jan 2006 10:53:45 -0500 (EST)
To: sean <seanlkml@sympatico.ca>
Message-Id: <20060122104850.33d07ad5.seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP03EC255443CA14D57D82F6AE110@CEZ.ICE>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.10; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 22 Jan 2006 15:53:46.0962 (UTC) FILETIME=[07836B20:01C61F6C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 22 Jan 2006 10:32:04 -0500
sean <seanlkml@sympatico.ca> wrote:

> Damn, would be so much nicer to get this stuff out of shell scripts.   Anyway,
> your discovery kills the idea of being able to just ignore the higher signal
> traps...   The following implements the same idea as my second patch
> in hopefully a slightly more cross-shell compatible way;  it works on bash
> and zsh at least.

Ooops, not even close on that attempt :o/   Here's a version that really does
work on zsh and bash; and should work on all shells.

Sean

diff --git a/git-cherry.sh b/git-cherry.sh
index 1a62320..4925f1f 100755
--- a/git-cherry.sh
+++ b/git-cherry.sh
@@ -49,7 +49,9 @@ ours=`git-rev-list $ours ^$limit` || exi
 tmp=.cherry-tmp$$
 patch=$tmp-patch
 mkdir $patch
-trap "rm -rf $tmp-*" 0 1 2 3 15
+cleanup() { rm -rf $tmp-*; }
+trap cleanup 0
+trap "cleanup;trap 0;exit 1" 1 2 3 15
 
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
diff --git a/git-format-patch.sh b/git-format-patch.sh
index 7e67c4e..574a79c 100755
--- a/git-format-patch.sh
+++ b/git-format-patch.sh
@@ -77,7 +77,9 @@ tt)
 esac
 
 tmp=.tmp-series$$
-trap 'rm -f $tmp-*' 0 1 2 3 15
+cleanup() { rm -f $tmp-*; }
+trap cleanup 0
+trap "cleanup;trap 0;exit 1" 1 2 3 15
 
 series=$tmp-series
 commsg=$tmp-commsg
diff --git a/git-ls-remote.sh b/git-ls-remote.sh
index f699268..0259a88 100755
--- a/git-ls-remote.sh
+++ b/git-ls-remote.sh
@@ -38,7 +38,9 @@ peek_repo="$(get_remote_url "$@")"
 shift
 
 tmp=.ls-remote-$$
-trap "rm -fr $tmp-*" 0 1 2 3 15
+cleanup() { rm -rf $tmp-*; }
+trap cleanup 0
+trap "cleanup;trap 0;exit 1" 1 2 3 15
 tmpdir=$tmp-d
 
 case "$peek_repo" in
diff --git a/git-reset.sh b/git-reset.sh
index 6c9e58a..3336690 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -4,7 +4,9 @@ USAGE='[--mixed | --soft | --hard]  [<co
 . git-sh-setup
 
 tmp=${GIT_DIR}/reset.$$
-trap 'rm -f $tmp-*' 0 1 2 3 15
+cleanup() { rm -f $tmp-*; }
+trap cleanup 0
+trap "cleanup;trap 0;exit 1" 1 2 3 15
 
 reset_type=--mixed
 case "$1" in
