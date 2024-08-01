Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34F02744E
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722536116; cv=none; b=Z4d9TYiKFnCqWYquxL95DKTQ8gSwGP8fwREJzrbfURmvkeg67hiXnDiL/JJD1t0haDx2AbUyw8Fg3AB+0Qr/CR7zcKe2co1W/aK30gwNNEOqIGMkeWKJf7xJEfz/x8UM6C/F3q4gsOPYU9nBI/Vq9xwo2+etl67EYt+eTAN8I1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722536116; c=relaxed/simple;
	bh=W9ObhV/6O7lsfh1vHQ9Mno6lj2s74r4m9TzAlHA/rZM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DBNJVLFFpXJg1S1LFd6A5HBSN08wlIkQrWiJZ2V3QA2UU++TE5fofl55GXPbGvH9qJo5mWuLe8llK25I+dQkDER3yj0rBKxaz2b/M10Dkv9vmkKVMkHSbnQudGKCpw1dKCtQBKP+ZFoiallYx2yecengQmYkBgttQmUUduRYEY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 471IFC2k3499929
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 1 Aug 2024 18:15:13 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <git@vger.kernel.org>
Subject: [Bug] Temp file use in t0018.6
Date: Thu, 1 Aug 2024 14:15:07 -0400
Organization: Nexbridge Inc.
Message-ID: <02d401dae43e$c076b000$41641000$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdrkPptZvjSokTaYSP+lTjI0H8ugPQ==

In the 2.46.0 test suite on NonStop I'm getting the following surprise
error:

expecting success of 0018.6 'advice should be printed when GIT_ADVICE is set
to true':
        q_to_tab >expect <<-\EOF &&
        On branch trunk

        No commits yet

        Untracked files:
          (use "git add <file>..." to include in what will be committed)
        QREADME

        nothing added to commit but untracked files present (use "git add"
to track)
        EOF

        test_when_finished "rm -fr advice-test" &&
        git init advice-test &&
        (
                cd advice-test &&
                >README &&
                GIT_ADVICE=true git status
        ) >actual &&
        cat actual > /tmp/actual &&
        test_cmp expect actual

Initialized empty Git repository in /home/randall/git-clar/t/trash
directory.t0018-advice/advice-test/.git/
./test-lib.sh: line 1071: /tmp/actual: Permission denied
not ok 6 - advice should be printed when GIT_ADVICE is set to true

This is the first I'm seeing a failure I'm seeing of this kind. We should be
using randomized temp
locations, not fixed. What is going on is that our main CI system runs under
one user id while I was
running another test under my own user. Our /tmp is configured so that users
who create files have
exclusive access to those files, regardless of security so /tmp/actual in
this case can only be used in
one run by one user. What we should be doing is probably generating
/tmp/actual.XXXXXXX
(randomized) or using actual in the trash directory as normal. In any event,
t0018 should be
cleaning up and removing /tmp/actual when done. I would suggest doing
something like this as
a start:

diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
index 29306b367c..1676a1a31d 100755
--- a/t/t0018-advice.sh
+++ b/t/t0018-advice.sh
@@ -97,7 +97,8 @@ test_expect_success 'advice should be printed when
GIT_ADVICE is set to true' '
                GIT_ADVICE=true git status
        ) >actual &&
        cat actual > /tmp/actual &&
-       test_cmp expect actual
+       test_cmp expect actual &&
+       rm /tmp/actual
 '

And then, as a real fix:

diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
index 29306b367c..deba8a1d91 100755
--- a/t/t0018-advice.sh
+++ b/t/t0018-advice.sh
@@ -96,8 +96,10 @@ test_expect_success 'advice should be printed when
GIT_ADVICE is set to true' '
                >README &&
                GIT_ADVICE=true git status
        ) >actual &&
-       cat actual > /tmp/actual &&
-       test_cmp expect actual
+       ACTUAL=/tmp/actual.$RANDOM &&
+       cat actual > $ACTUAL &&
+       test_cmp expect $ACTUAL &&
+       rm $ACTUAL
 '

Regards,
Randall



