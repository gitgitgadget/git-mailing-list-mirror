From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH/RFC resend] gitk: Ignore limitdiffs option when displaying 
	commit file list
Date: Mon, 29 Mar 2010 10:29:06 -0400
Message-ID: <32c343771003290729x49407af7hf404b60203d123ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>, j.sixt@viscovery.net,
	markb@berlios.de
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 29 16:29:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwFxr-0001jK-Ex
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 16:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410Ab0C2O3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 10:29:10 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:53437 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271Ab0C2O3I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 10:29:08 -0400
Received: by wwe15 with SMTP id 15so8291469wwe.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 07:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:cc:content-type;
        bh=Ok0vKchJT6dEG1W1YXvdEUGsjCakTPgmwWhSPwa7Hnw=;
        b=Y15abndqPYPIUfxWAvTVDu67B8hMk7oaaGsxQepsv1fmzkjHBEZ6yCGkhtEQQ/hM05
         G5rXf+sCS2XB62rw10C1mDHzvPdjFNfQbWPso/bgA1H4ytNoR9gNOKDS+FTqUGMBjFbe
         JOvSNRIAc14n/KCblKGTv1IYbrqjdSKncf8UU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=CwyBOm2z5p+pbMaHmnatsI6DnsxC7IbT/gfJPMgCHw9B0RZs0jGfwAs8izlMmUvtrs
         cSpOWwUWwLwaiGBkHaOPlhjXRm4NSH227g8lT5bfglX10+yrRYIrFXAkoKX4Hj31RAc3
         RittKaoSjWhMY1bhQ33qrJlmPJ3Mqrldhcn9k=
Received: by 10.216.52.74 with HTTP; Mon, 29 Mar 2010 07:29:06 -0700 (PDT)
Received: by 10.216.85.83 with SMTP id t61mr750132wee.167.1269872947015; Mon, 
	29 Mar 2010 07:29:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143478>

When gitk is invoked with a path argument (e.g. gitk gitk-git),
the path is used to filter the list of files displayed in the
lower right window.  If a file does not start with the specified
substring, it is not displayed.  This is counter-intuitive for
a couple reasons:
 1) The files continue to be listed in the diff window.
 2) Merge commits (i.e. commits with more than 1 parent) still
    show the complete list of files in the lower right since
    these commits are processed by 'mergediff' rather than
    the 'startdiff' function.

With this change, the complete list of files affected by a
commit will always be shown in the lower right window.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

This is a resend with Paul Mackerras added to the CC list.

I noticed this issue recently when trying gitk.  After some research, I found
this thread [1] which explained the issue.  However, the operation still does
not seem consistent.  This patch fixes the "problem" that I encountered, but
I can't help wondering:
   1) I am breaking another feature?  Especially since the
        '$vfilelimit($curview) ne {}' check is now ignored.
   2) Can the limitdiffs option be completely removed?  If not, the behavior
       of startdiff and mergediff should at least be made consistent.

I copied the people that were involved in the earlier thread [1].

[1] http://thread.gmane.org/gmane.comp.version-control.git/133088

 gitk-git/gitk |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 1f36a3e..518061e 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -7450,17 +7450,7 @@ proc gettreediffline {gdtf ids} {
       return [expr {$nr >= $max? 2: 1}]
    }
    close $gdtf
-    if {$limitdiffs && $vfilelimit($curview) ne {}} {
-       set flist {}
-       foreach f $treediff {
-           if {[path_filter $vfilelimit($curview) $f]} {
-               lappend flist $f
-           }
-       }
-       set treediffs($ids) $flist
-    } else {
-       set treediffs($ids) $treediff
-    }
+    set treediffs($ids) $treediff
    unset treepending
    if {$cmitmode eq "tree" && [llength $diffids] == 1} {
       gettree $diffids
--
1.7.0.3.291.g5e4f6.dirty
