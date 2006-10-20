From: andyparkins@gmail.com
Subject: (unknown)
Date: Fri, 20 Oct 2006 15:21:04 +0100
Message-ID: <E1GavFA-0007TO-00@dvr.360vision.com>
X-From: git-owner@vger.kernel.org Fri Oct 20 16:22:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GavGI-0006Po-8l
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 16:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992622AbWJTOVJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 10:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992620AbWJTOVJ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 10:21:09 -0400
Received: from mail.360visiontechnology.com ([194.70.53.226]:10606 "EHLO
	369run02s.360vision.com") by vger.kernel.org with ESMTP
	id S2992622AbWJTOVH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 10:21:07 -0400
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 20 Oct 2006 15:23:58 +0100
Received: from localhost ([127.0.0.1])
	by dvr.360vision.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GavFA-0007TO-00
	for <git@vger.kernel.org>; Fri, 20 Oct 2006 15:21:04 +0100
X-OriginalArrivalTime: 20 Oct 2006 14:23:58.0560 (UTC) FILETIME=[61B8C600:01C6F453]
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29474>

>From 0e3c0aefc3276bd271553d171ed9bcc52d85230e Mon Sep 17 00:00:00 2001
From: Andy Parkins <andyparkins@gmail.com>
Date: Fri, 20 Oct 2006 15:21:02 +0100
Subject: [PATCH] Use email address only for looking up signing key in git-tag
To: git@vger.kernel.org
MIME-Version: 1.0
X-TUID: 312298ab1a3cb74a
X-UID: 98
X-Length: 2046
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PtNOFMGj306NIAG"
Message-Id: <200610201521.03122.andyparkins@gmail.com>

This is a multi-part message in MIME format.
--Boundary-00=_PtNOFMGj306NIAG
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


I did this:

  $ git tag -s adp-sign-tag
  gpg: skipped "Andy Parkins <andyparkins@gmail.com>": secret key not 
available
  gpg: signing failed: secret key not available
  failed to sign the tag with GPG.

I believe the problem is that I have used the comment field in my key's UID
definition.

  $ gpg --list-keys andy
  pub   1024D/4F712F6D 2003-08-14
  uid                  Andy Parkins (Google) <andyparkins@gmail.com>

So when git-tag looks for "Andy Parkins <andyparkins@gmail.com>"; it's not
found.  The answer is (I think) to search only on the email address when
looking for a key.
Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 git-tag.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

--Boundary-00=_PtNOFMGj306NIAG
Content-Type: text/x-patch;
  name="0e3c0aefc3276bd271553d171ed9bcc52d85230e.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="0e3c0aefc3276bd271553d171ed9bcc52d85230e.diff"

diff --git a/git-tag.sh b/git-tag.sh
index a0afa25..6fd98e2 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -73,7 +73,7 @@ git-check-ref-format "tags/$name" ||
 object=$(git-rev-parse --verify --default HEAD "$@") || exit 1
 type=$(git-cat-file -t $object) || exit 1
 tagger=$(git-var GIT_COMMITTER_IDENT) || exit 1
-: ${username:=$(expr "z$tagger" : 'z\(.*>\)')}
+: ${username:=$(expr "z$tagger" : 'z.*<\(.*\)>')}
 
 trap 'rm -f "$GIT_DIR"/TAG_TMP* "$GIT_DIR"/TAG_FINALMSG "$GIT_DIR"/TAG_EDITMSG' 0
 

--Boundary-00=_PtNOFMGj306NIAG--
