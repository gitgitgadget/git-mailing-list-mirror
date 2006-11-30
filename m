X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Make git-commit cleverer - have it figure out whether it needs -a automatically
Date: Thu, 30 Nov 2006 13:24:04 +0000
Message-ID: <200611301324.04993.andyparkins@gmail.com>
References: <ekmlar$ask$2@sea.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 13:24:22 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <ekmlar$ask$2@sea.gmane.org>
X-TUID: 1162e3952db52cf9
X-UID: 178
X-Length: 1704
Content-Disposition: inline
X-OriginalArrivalTime: 30 Nov 2006 13:25:48.0211 (UTC) FILETIME=[0C3F8830:01C71483]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32742>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpltg-0001uJ-66 for gcvg-git@gmane.org; Thu, 30 Nov
 2006 14:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936364AbWK3NYK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 08:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936392AbWK3NYK
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 08:24:10 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:35548 "EHLO
 369run02s.360vision.com") by vger.kernel.org with ESMTP id S936364AbWK3NYI
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 08:24:08 -0500
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Thu, 30 Nov 2006 13:25:48 +0000
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1GpltW-00054J-00 for <git@vger.kernel.org>; Thu, 30 Nov
 2006 13:24:06 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Raimund Bauer offered this suggestion (paraphrased):

"Maybe we could do git-commit -a  _only_ if the index matches HEAD, and
otherwise keep current behavior?  So people who don't care about the
index won't get tripped up, and when you do have a dirty index, you get
told about it?"

Johannes Schindelin pointed out that this isn't the right thing to do for
an --amend, so that is checked for.

Additionally, it's probably not the right thing to do if any files are
specified with "--only" or "--include", so they turn this behaviour off
as well.

I've also output a message as suggested by Andreas Ericsson.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 git-commit.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index 81c3a0c..fabfeae 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -265,6 +265,14 @@ $1"
 done
 case "$edit_flag" in t) no_edit= ;; esac
 
+# Clever commit - if this commit would do nothing, then make it an "all"
+# commit
+if [ -z "$(git-diff-index --cached --name-only HEAD)" \
+	-a -z "$amend" -a -z "$only" -a -z "$also" ]; then
+	echo "Nothing to commit but changes in working tree. Assuming 'git commit -a'"
+	all=t
+fi
+
 ################################################################
 # Sanity check options
 
-- 
1.4.4.1.g3ece-dirty
