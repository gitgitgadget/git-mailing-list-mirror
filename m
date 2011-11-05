From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 1/3] t9350: point out that refs are not updated correctly
Date: Sun,  6 Nov 2011 00:23:25 +0100
Message-ID: <1320535407-4933-2-git-send-email-srabbelier@gmail.com>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Nov 06 00:25:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMpcS-0001pt-Oc
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 00:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523Ab1KEXZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 19:25:27 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51987 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab1KEXZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 19:25:26 -0400
Received: by mail-ey0-f174.google.com with SMTP id 27so2888126eye.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 16:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=q0K7e4nR8Rhi6v/yt8u+/E9lYetoq1Px9W6loOPjktw=;
        b=JxnRsSB4YCxDw8RVT1Xj2brf6KnookSxooOSIdbuIQAaWGHLT2rh/i1k9RAciDB4tv
         r0Qx5VmZwPosFRpHA7s+BdwV5Curl17e++/EGu/dKA1rOiSftr0+jvEchgW/Ff6iILvu
         aqUdgACBd77NMbehqtlJu8Oa9s7mtPM1dxqsc=
Received: by 10.14.9.103 with SMTP id 79mr1890973ees.147.1320535525514;
        Sat, 05 Nov 2011 16:25:25 -0700 (PDT)
Received: from laptop-sverre.lijbrandt.nl ([188.142.63.148])
        by mx.google.com with ESMTPS id v3sm37271459eej.7.2011.11.05.16.25.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 16:25:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.rc0.36.g67522.dirty
In-Reply-To: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184876>

This happens only when the corresponding commits are not exported in
the current fast-export run. This can happen either when the relevant
commit is already marked, or when the commit is explicitly marked
as UNINTERESTING with a negative ref by another argument.

This breaks fast-export based remote helpers, as they use marks
files to store which commits have already been seen. The call graph
is something as follows:

$ # push master to remote repo
$ git fast-export --{im,ex}port-marks=marksfile master
$ # make a commit on master and push it to remote
$ git fast-export --{im,ex}port-marks=marksfile master
$ # run `git branch foo` and push it to remote
$ git fast-export --{im,ex}port-marks=marksfile foo

When fast-export imports the marksfile and sees that all commits in
foo are marked as UNINTERESTING (they have already been exported
while pushing master), it exits without doing anything. However,
what we want is for it to reset 'foo' to the already-exported commit.

Either way demonstrates the problem, and since this is the most
succint way to demonstrate the problem it is implemented by passing
master..master on the commandline.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---
 t/t9350-fast-export.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 950d0ff..74914dc 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -440,4 +440,15 @@ test_expect_success 'fast-export quotes pathnames' '
 	)
 '
 
+cat > expected << EOF
+reset refs/heads/master
+from $(git rev-parse master)
+
+EOF
+
+test_expect_failure 'refs are updated even if no commits need to be exported' '
+	git fast-export master..master > actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.7.8.rc0.36.g67522.dirty
