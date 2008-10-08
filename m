From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH 4/7] gitk: Fix file list context menu for merge commits.
Date: Wed,  8 Oct 2008 11:05:37 +0400
Message-ID: <1223449540-20457-5-git-send-email-angavrilov@gmail.com>
References: <1223449540-20457-1-git-send-email-angavrilov@gmail.com>
 <1223449540-20457-2-git-send-email-angavrilov@gmail.com>
 <1223449540-20457-3-git-send-email-angavrilov@gmail.com>
 <1223449540-20457-4-git-send-email-angavrilov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 08 09:09:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnTAT-0006GO-3s
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 09:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbYJHHHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 03:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbYJHHHc
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 03:07:32 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:20741 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbYJHHHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 03:07:25 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2606173fgg.17
        for <git@vger.kernel.org>; Wed, 08 Oct 2008 00:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Py4ADEYAwTMXeuDl6PkjBUNd4o5AuoM8dDbHv+bsiDw=;
        b=UPx1p24mTovUILWP1apcN51YDgEFUQHC+xNUwrqn3TtcFZ7/ygvupLOyjmisUt9P6E
         bcLiu9ycwyLQvOMRe0eTEgeGVT0fl1FTEbw8Bss1TKl5NEg/ouhHOjVrPAYaHRZa2H2k
         7mMJgMkgp1+pSB7FBepI+6OjDjSNY9j+QtCEw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pdlm/sADsJKQ+1niGatL7C/4hUBf95xe+UDugJ82c03NyXWmNZxNjgH1c8Otkk4gsy
         4g7Xu3AbsuMOSkYOiVcqOazxHgV3thrFacuSaPXLduRt5VdC63BqBfAUY8roDNrZz53W
         //o9sj3w0SfPDGykeno+nMjlb87IPhnlyJw80=
Received: by 10.181.14.2 with SMTP id r2mr5826896bki.74.1223449644534;
        Wed, 08 Oct 2008 00:07:24 -0700 (PDT)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id e17sm15096059fke.10.2008.10.08.00.07.23
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 08 Oct 2008 00:07:23 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
In-Reply-To: <1223449540-20457-4-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97779>

Currently it displays an ugly error box, because the
treediffs array is not filled for such commits. This
is clearly unacceptable.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 3c77909..cfaf7a1 100755
--- a/gitk
+++ b/gitk
@@ -6479,7 +6479,7 @@ proc getblobline {bf id} {
 
 proc mergediff {id} {
     global diffmergeid mdifffd
-    global diffids
+    global diffids treediffs
     global parents
     global diffcontext
     global diffencoding
@@ -6487,6 +6487,7 @@ proc mergediff {id} {
 
     set diffmergeid $id
     set diffids $id
+    set treediffs($id) [list ]
     # this doesn't seem to actually affect anything...
     set cmd [concat | git diff-tree --no-commit-id --cc -U$diffcontext $id]
     if {$limitdiffs && $vfilelimit($curview) ne {}} {
@@ -6506,7 +6507,7 @@ proc mergediff {id} {
 
 proc getmergediffline {mdf id np} {
     global diffmergeid ctext cflist mergemax
-    global difffilestart mdifffd
+    global difffilestart mdifffd treediffs
     global ctext_file_names ctext_file_lines
     global diffencoding
 
@@ -6524,6 +6525,7 @@ proc getmergediffline {mdf id np} {
 	    $ctext insert end "\n"
 	    set here [$ctext index "end - 1c"]
 	    lappend difffilestart $here
+	    lappend treediffs($id) $fname
 	    add_flist [list $fname]
 	    lappend ctext_file_names $fname
 	    lappend ctext_file_lines [lindex [split $here "."] 0]
-- 
1.6.0.20.g6148bc
