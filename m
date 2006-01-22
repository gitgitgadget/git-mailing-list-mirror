From: sean <seanlkml@sympatico.ca>
Subject: Re: git cherry unkillable
Date: Sun, 22 Jan 2006 06:39:04 -0500
Message-ID: <BAYC1-PASMTP10435A067270A659801A48AE110@CEZ.ICE>
References: <200601221323.33377.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 22 12:44:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0dds-0003MP-Dh
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 12:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWAVLoE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jan 2006 06:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWAVLoE
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jan 2006 06:44:04 -0500
Received: from bayc1-pasmtp10.bayc1.hotmail.com ([65.54.191.170]:20014 "EHLO
	BAYC1-PASMTP10.CEZ.ICE") by vger.kernel.org with ESMTP
	id S932412AbWAVLoD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2006 06:44:03 -0500
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.6.171]) by BAYC1-PASMTP10.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 22 Jan 2006 03:44:45 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id E976D644C23;
	Sun, 22 Jan 2006 06:43:58 -0500 (EST)
To: Andrey Borzenkov <arvidjaar@mail.ru>
Message-Id: <20060122063904.2dbefbe4.seanlkml@sympatico.ca>
In-Reply-To: <200601221323.33377.arvidjaar@mail.ru>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.10; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 22 Jan 2006 11:44:46.0062 (UTC) FILETIME=[3E0B00E0:01C61F49]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 22 Jan 2006 13:23:26 +0300
Andrey Borzenkov <arvidjaar@mail.ru> wrote:

> Hash: SHA1
> 
> I mistakenly run git cherry on linus tree which was a bit too much for my poor 
> old system. Trying to kill (^C) it I got
> 
> {pts/0}% git cherry ali1535 linus
> external diff died, stopping at include/linux/sysctl.h.
> external diff died, stopping at drivers/serial/suncore.c.
> diff: /home/bor/tmp/.diff_Y6CvCw: No such file or directory
> diff: /home/bor/tmp/.diff_tBqCCk: No such file or directory
> external diff died, stopping at include/asm-arm/arch-pxa/pxa-regs.h.
> external diff died, stopping at fs/cifs/file.c.
> external diff died, stopping at MAINTAINERS.
> diff: /home/bor/tmp/.diff_P12uX9: No such file or directory
> diff: /home/bor/tmp/.diff_R4v0g0: No such file or directory
> external diff died, stopping at net/ipv4/route.c.
> ....
> 
> and it jut goes on. This takes really some time here so ability to stop it 
> would be really nice. It still runs with CPU temp rocketing.
> 

Ouch yeah, you'd have to explicitly kill -9 from another command line.   The
same problem exists in a few other scripts too, although probably none that
can be as long lived as git-cherry.   

The attached patch works for me but i'm concerned about it a bit.  With this
patch it looks like the signal handler is executed twice; once as normal and
a second time in response to the added "exit" statement.   By adding 
";trap - 0;exit" it is only executed once, but i'm not sure how universal that
is, and letting it run twice shouldn't be a big deal anyway.

The other minor concern is that exit should maybe return an error value
instead; but that isn't approprirate when handling signal zero.   So it
might be better to have a separate trap for signal zero, but in the end
it doesn't seem worth the bother.

Sean

	diff --git a/git-cherry.sh b/git-cherry.sh
index 1a62320..a1e4d70 100755
--- a/git-cherry.sh
+++ b/git-cherry.sh
@@ -49,7 +49,7 @@ ours=`git-rev-list $ours ^$limit` || exi
 tmp=.cherry-tmp$$
 patch=$tmp-patch
 mkdir $patch
-trap "rm -rf $tmp-*" 0 1 2 3 15
+trap "rm -rf $tmp-*;exit" 0 1 2 3 15
 
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
diff --git a/git-format-patch.sh b/git-format-patch.sh
index 7e67c4e..38adaad 100755
--- a/git-format-patch.sh
+++ b/git-format-patch.sh
@@ -77,7 +77,7 @@ tt)
 esac
 
 tmp=.tmp-series$$
-trap 'rm -f $tmp-*' 0 1 2 3 15
+trap 'rm -f $tmp-*;exit' 0 1 2 3 15
 
 series=$tmp-series
 commsg=$tmp-commsg
diff --git a/git-ls-remote.sh b/git-ls-remote.sh
index f699268..ba96969 100755
--- a/git-ls-remote.sh
+++ b/git-ls-remote.sh
@@ -38,7 +38,7 @@ peek_repo="$(get_remote_url "$@")"
 shift
 
 tmp=.ls-remote-$$
-trap "rm -fr $tmp-*" 0 1 2 3 15
+trap "rm -fr $tmp-*;exit" 0 1 2 3 15
 tmpdir=$tmp-d
 
 case "$peek_repo" in
diff --git a/git-reset.sh b/git-reset.sh
index 6c9e58a..1b6781f 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -4,7 +4,7 @@ USAGE='[--mixed | --soft | --hard]  [<co
 . git-sh-setup
 
 tmp=${GIT_DIR}/reset.$$
-trap 'rm -f $tmp-*' 0 1 2 3 15
+trap 'rm -f $tmp-*;exit' 0 1 2 3 15
 
 reset_type=--mixed
 case "$1" in
