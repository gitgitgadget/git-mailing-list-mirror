From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: [PATCH 1/2] git_mkstemps: correctly test return value of open()
Date: Thu, 18 Jul 2013 18:46:13 -0400
Message-ID: <201307182246.r6IMkDiW021930@freeze.ariadne.com>
References: <cover.1373618940.git.trast@inf.ethz.ch> <9af38018d55c95a6807d305bb3a088e48916baac.1373618940.git.trast@inf.ethz.ch>
 <878v16kfqy.fsf@linux-k42r.v.cablecom.net> <7v38rd6l3j.fsf@alter.siamese.dyndns.org>
 <51E7E05E.4000201@gmail.com> <7v4nbr4v7m.fsf@alter.siamese.dyndns.org> <201307182032.r6IKWtWC016218@freeze.ariadne.com> <CAPc5daVVDCHqjyDV3zYVV33EFYjea7ge84+CE=M=QXagxnHd-A@mail.gmail.com>
Cc: n1xim.email@gmail.com, trast@inf.ethz.ch, git@vger.kernel.org,
	fonseca@diku.dk
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 00:46:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzwxq-0005bv-EB
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 00:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759220Ab3GRWqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 18:46:18 -0400
Received: from qmta05.westchester.pa.mail.comcast.net ([76.96.62.48]:43573
	"EHLO qmta05.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754941Ab3GRWqR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jul 2013 18:46:17 -0400
Received: from omta04.westchester.pa.mail.comcast.net ([76.96.62.35])
	by qmta05.westchester.pa.mail.comcast.net with comcast
	id 1xmY1m0070ldTLk55ymGxv; Thu, 18 Jul 2013 22:46:16 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta04.westchester.pa.mail.comcast.net with comcast
	id 1ymF1m01U1KKtkw01ymGFr; Thu, 18 Jul 2013 22:46:16 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r6IMkEs8021931;
	Thu, 18 Jul 2013 18:46:14 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r6IMkDiW021930;
	Thu, 18 Jul 2013 18:46:13 -0400
In-reply-to: <CAPc5daVVDCHqjyDV3zYVV33EFYjea7ge84+CE=M=QXagxnHd-A@mail.gmail.com>
	(gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1374187576;
	bh=Ol3l/R1A1Tkqnp4PGuKQR9Xk2xYFN7M+Fzi7Om/WQs8=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=OpXvGmckzFqsIx6DJ73KDasBPLfZejAmPuKHitFD1HYk4zc4f3x9LuSJTjOibpC+1
	 Wn7q0bR9tWjxhfXeFQYXYHp6drTeRMtxS10EREAKeIhizVY/sFB2aD5IAibH8/vEMJ
	 bwoVf8J2yGN535e04zXQq4EfzQza/jdW3cYis5KXE0e2kN4iUJMRDjEnc+mFHw0Sn9
	 L/2cJsFmQoH+Qb3NkvX1C31TKuprHgdM03C/GeAFepAb29rAynXovZQ39FYTj5xaKx
	 UfLYqCPUWFp7QE8sCS4vnRXBWSInEYH2eD5pH4nLXQ4NB7ExkWRA27v0DxcSHAlb/2
	 KA9fFFDgFkExQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230761>

> From: Junio C Hamano <gitster@pobox.com>
> 
> That's just a plain-vanilla part of POSIX shell behaviour, no?
> 
> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_07_05

"Close standard input" is so weird I never thought it was Posix.  In
that case, we can eliminate the C helper program:

diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 986b2a8..d427f3a 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -25,6 +25,13 @@ test_expect_success POSIXPERM,SANITY 'mktemp to unwritable directory prints file
 	grep "cannotwrite/test" err
 '
 
+test_expect_success 'git_mkstemps_mode does not fail if fd 0 is not open' '
+	git init &&
+	echo Test. >test-file &&
+	git add test-file &&
+	git commit -m Message. <&-
+'
+
 test_expect_success 'check for a bug in the regex routines' '
 	# if this test fails, re-build git with NO_REGEX=1
 	test-regex
diff --git a/wrapper.c b/wrapper.c
index dd7ecbb..6a015de 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -322,7 +322,7 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
 		template[5] = letters[v % num_letters]; v /= num_letters;
 
 		fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
-		if (fd > 0)
+		if (fd >= 0)
 			return fd;
 		/*
 		 * Fatal error (EPERM, ENOSPC etc).

Is this a sensible place to put this test?

Dale
