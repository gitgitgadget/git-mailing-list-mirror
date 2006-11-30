X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH/RFC] Make git-commit cleverer - have it figure out whether it needs -a automatically
Date: Thu, 30 Nov 2006 12:59:32 +0000
Message-ID: <200611301259.32387.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 12:59:52 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-TUID: 1f8a791a82262c42
X-UID: 177
X-Length: 1472
Content-Disposition: inline
X-OriginalArrivalTime: 30 Nov 2006 13:01:15.0870 (UTC) FILETIME=[9EAA1FE0:01C7147F]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32737>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GplVt-0003fO-3V for gcvg-git@gmane.org; Thu, 30 Nov
 2006 13:59:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936369AbWK3M7h (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 07:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936380AbWK3M7h
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 07:59:37 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:57818 "EHLO
 369run02s.360vision.com") by vger.kernel.org with ESMTP id S936369AbWK3M7g
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 07:59:36 -0500
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Thu, 30 Nov 2006 13:01:15 +0000
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1GplVm-0004mh-00 for <git@vger.kernel.org>; Thu, 30 Nov
 2006 12:59:34 +0000
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

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
I've been using this today, and so far it's been quite friendly.  git-commit
is suddenly just doing the Right Thing.

It's so good that the only (small) hurdle, is remembering during an amend
that you need to update the index first to get any code changes in to the
amend - but that is the same as it ever was.

 git-commit.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index 81c3a0c..e9aed2b 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -265,6 +265,13 @@ $1"
 done
 case "$edit_flag" in t) no_edit= ;; esac
 
+# Clever commit - if this commit would do nothing, then make it an "all"
+# commit
+if [ -z "$(git-diff-index --cached --name-only HEAD)" \
+	-a -z "$amend" -a -z "$only" -a -z "$also" ]; then
+	all=t
+fi
+
 ################################################################
 # Sanity check options
 
-- 
1.4.4.1.g3ece-dirty
