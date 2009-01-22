From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: [PATCH] mergetool merge/skip/abort
Date: Thu, 22 Jan 2009 09:17:39 -0500
Message-ID: <81bfc67a0901220617l22b5a8e4ma48bb069d67cae91@mail.gmail.com>
References: <81bfc67a0901210637j52fa7a55q51b599e9ff16f6dc@mail.gmail.com>
	 <20090121170434.GA21727@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Thu Jan 22 15:19:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ0Oj-0000IA-OT
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 15:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757403AbZAVORo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 09:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757244AbZAVORn
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 09:17:43 -0500
Received: from mail-ew0-f20.google.com ([209.85.219.20]:58120 "EHLO
	mail-ew0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756667AbZAVORl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 09:17:41 -0500
Received: by mail-ew0-f20.google.com with SMTP id 13so2500400ewy.13
        for <git@vger.kernel.org>; Thu, 22 Jan 2009 06:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZlVKJY2Gjo9rimZFOccv3APP/I1zMt6vzc+EkWW7xU4=;
        b=qVWVgWFWkcewHFiGcwX85IAjKxrfWE9Q9bplXWDMnm456iMSE4vwLbSIaqJK5PUPyQ
         pWGkAScs9x0AuY1E96a8P2yQsqSSMQZW/hGFF2T4P2umSMuP+b2IFpg51llxduXAN4tO
         W2prNFIpMAOC6BwlZaRuBAN8jUlYuMCYdU6u4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=usAd3+0P4XiVzUf2RzkaoJ8nbrli3IB/XOjrlwFMc21XTLQtT5pEgU+JIwZ6K09Ji3
         QblSA3H0MFCMAI9ygmDh98ROu222gdSsn9QDljqOz4ar7uFUOh6wtnn003PwGwo2Bhzk
         Aa0gvKbR5dNV3bxqcOjqBdzKlb9sVrKB8bqxA=
Received: by 10.223.113.193 with SMTP id b1mr348195faq.78.1232633859649; Thu, 
	22 Jan 2009 06:17:39 -0800 (PST)
In-Reply-To: <20090121170434.GA21727@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106751>

>From bf55fdd37f0fa4d0b3a10f43fa3d1815a6dbc6b3 Mon Sep 17 00:00:00 2001
From: Caleb Cushing <xenoterracide@gmail.com>
Date: Tue, 20 Jan 2009 11:33:30 -0500
Subject: [PATCH] mergetool merge/skip/abort
 add functionality to skip merging a file or abort from mergetool

---
 git-mergetool.sh |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 00e1337..bd5711e 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -177,8 +177,24 @@ merge_file () {
     describe_file "$local_mode" "local" "$LOCAL"
     describe_file "$remote_mode" "remote" "$REMOTE"
     if "$prompt" = true; then
-       printf "Hit return to start merge resolution tool (%s): " "$merge_tool"
-       read ans
+        while true; do
+            printf "Use (m)erge file or (s)kip file, or (a)bort? (%s): " \
+            "$merge_tool"
+            read ans
+            case "$ans" in
+                [mM]*|"")
+                    break
+                ;;
+                [sS]*)
+                    cleanup_temp_files
+                    return 0
+                ;;
+                [aA]*)
+                    cleanup_temp_files
+                    exit 0
+                ;;
+            esac
+        done
     fi

     case "$merge_tool" in
--
1.6.1

> This looks to me like no merge will happen if --no-prompt/-y or
>  mergetool.prompt is set to false. Have you tested with this option or
>  have I misread?

just tested and it works fine... meaning it doesn't prompt which is
what it's supposed to do.

>  Also, I think you've lost some tabs. Mergetool does have some
>  inconsistent tabbing but they way I've been aiming towards (which
>  matches most, but not all of git-mergetool.sh) is to use tabs == 8
>  spaces for indents but to indent each level by 4 spaces. e.g. three
>  levels of indent is one tab plus four spaces.

mixing tabs and spaces == bad, I just realized I can't see half your
indents because I had tabstop=4 in my vimrc because I like indents at
4 spaces which is what you are doing through emulation. this is why I
generally just use tabs or spaces. files like fstab and .sql are my
few exceptions, both of which I do more on columns than indents.

> I'd like to keep (additionally) the behaviour, that the merge starts
> with just pressing <Enter>. Because what you mostly want to do, when
> using git-mergetool, is actually merging.

done, and maybe you... but generally I've got more skips than merges,
but I've got a corner case.
-- 
Caleb Cushing

http://xenoterracide.blogspot.com
