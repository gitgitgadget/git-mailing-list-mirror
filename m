X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Make git-commit cleverer - have it figure out whether it needs -a automatically
Date: Thu, 30 Nov 2006 15:01:43 +0000
Message-ID: <200611301501.43436.andyparkins@gmail.com>
References: <fcaeb9bf0611300532x77c7fc8aq2ba77ff57b81cc05@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 15:02:51 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <fcaeb9bf0611300532x77c7fc8aq2ba77ff57b81cc05@mail.gmail.com>
X-TUID: ddb33c4b3239800a
X-UID: 179
X-Length: 1960
Content-Disposition: inline
X-OriginalArrivalTime: 30 Nov 2006 15:03:26.0706 (UTC) FILETIME=[B02EED20:01C71490]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32750>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpnQ8-0004DX-M8 for gcvg-git@gmane.org; Thu, 30 Nov
 2006 16:01:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967824AbWK3PBs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 10:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967828AbWK3PBs
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 10:01:48 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:53986 "EHLO
 369run02s.360vision.com") by vger.kernel.org with ESMTP id S967824AbWK3PBr
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 10:01:47 -0500
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Thu, 30 Nov 2006 15:03:26 +0000
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1GpnQ1-0006TU-00 for <git@vger.kernel.org>; Thu, 30 Nov
 2006 15:01:45 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Raimund Bauer offered this suggestion (paraphrased):

"Maybe we could do git-commit -a  _only_ if the index matches HEAD, and
otherwise keep current behavior?  So people who don't care about the
index won't get tripped up, and when you do have a dirty index, you get
told about it?"

Johannes Schindelin pointed out that this isn't the right thing to do for
an --amend, so that is checked for. Additionally, it's probably not the
right thing to do if any files are specified with "--only" or
"--include", so they turn this behaviour off as well.

Nguyen Thai Ngoc Duy asked that git-commit let you know it's done this
by adding an extra comment to the commit message.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 git-commit.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index 81c3a0c..b391257 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -265,6 +265,16 @@ $1"
 done
 case "$edit_flag" in t) no_edit= ;; esac
 
+# Clever commit - if this commit would do nothing, then make it an "all"
+# commit
+if [ -z "$(git-diff-index --cached --name-only HEAD)" \
+	-a -z "$amend" -a -z "$only" -a -z "$also" ]; then
+	echo "# There was nothing to commit but changes were detected in the" > $GIT_DIR/SQUASH_MSG
+	echo "# working tree. 'git commit -a' mode activated." >> $GIT_DIR/SQUASH_MSG
+	echo "#" >> $GIT_DIR/SQUASH_MSG
+	all=t
+fi
+
 ################################################################
 # Sanity check options
 
-- 
1.4.4.1.g3ece-dirty
