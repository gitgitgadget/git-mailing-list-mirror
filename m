Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFCA259498
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 01:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736214182; cv=none; b=XCb0sMu8SGY31OXGoHAdGSW1FEO7a6PB/bcLP4bUOmkoFL7XDMN8johIkTrZi71NgpCShYIQRjt87MucftECGjhNviHKEwCTX07HQ8zectBBHRNjTu7UrfJ+snnu8nvbH1Tgvxa06JxlCIHnube9pzkUHU7i9/U7TVhew5jbs2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736214182; c=relaxed/simple;
	bh=3tnxEQyidpLUEywIu0sqdcjlTjqNoPR1/26ejkArl48=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=swiJB9yamLJ/QVL68WQhQ0uwM7QZYZ/QWd5qycN0BdQpUvVjj6YDoVz9POMVTOZ2zyvnAeCGwWhXBP9OFWOb0g/WRnuivaOhap9xQBZe5ULTYg/FFRYyXFUnQ7X9shCiEXCAomoCFxT/a4wT7pX1pvz+C3AxKIdSjx2djoQ302o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 5071guDh1383107
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 7 Jan 2025 01:42:57 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <git@vger.kernel.org>
Subject: [BUG] Git 2.48.0-rc2 - Test t0610.26 Fails
Date: Mon, 6 Jan 2025 20:42:51 -0500
Organization: Nexbridge Inc.
Message-ID: <002c01db60a5$7a367060$6ea35120$@nexbridge.com>
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
Thread-Index: Adtgo17spf+lKBBxQ+it31JWUH61yg==
Content-Language: en-ca
X-Antivirus: Norton (VPS 250106-2, 1/6/2025), Outbound message
X-Antivirus-Status: Clean

The following breaks at rc2. It worked correctly at rc1 on x86 but
apparently not on ia64.

The OpenSSL random generator on ia64 uses PRNGD. On x86, the hardware
randomizer
is used. Nonetheless, this is not working properly:

expecting success of 0610.47 'ref transaction: many concurrent writers':
        test_when_finished "rm -rf repo" &&
        git init repo &&
        (
                cd repo &&
                # Set a high timeout. While a couple of seconds should be
                # plenty, using the address sanitizer will significantly
slow
                # us down here. So we are aiming way higher than you would
ever
                # think is necessary just to keep us from flaking. We could
                # also lock indefinitely by passing -1, but that could
                # potentially block CI jobs indefinitely if there was a bug
                # here.
                git config set reftable.lockTimeout 300000 &&
                test_commit --no-tag initial &&

                head=$(git rev-parse HEAD) &&
                for i in $(test_seq 100)
                do
                        printf "%s commit\trefs/heads/branch-%s\n" "$head"
"$i" ||
                        return 1
                done >expect &&
                printf "%s commit\trefs/heads/main\n" "$head" >>expect &&

                for i in $(test_seq 100)
                do
                        { git update-ref refs/heads/branch-$i HEAD& } ||
                        return 1
                done &&

                wait &&
                git for-each-ref --sort=v:refname >actual &&
                test_cmp expect actual
        )

+ test_when_finished rm -rf repo
+ git init repo
Initialized empty Git repository in
/home/ituglib/randall/jenkins/.jenkins/workspace/Git_Pipeline/t/trash
directory.t0610-reftable-basics/repo/.git/
+ cd repo
+ git config set reftable.lockTimeout 300000
+ test_commit --no-tag initial
[main (root-commit) 68d032e] initial
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 initial.t
+ + git rev-parse HEAD
head=68d032e9edd3481ac96382786ececc37ec28709e
+ 1> expect
+ test_seq 100
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 1
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 2
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 3
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 4
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 5
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 6
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 7
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 8
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 9
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 10
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 11
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 12
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 13
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 14
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 15
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 16
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 17
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 18
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 19
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 20
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 21
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 22
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 23
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 24
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 25
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 26
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 27
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 28
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 29
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 30
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 31
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 32
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 33
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 34
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 35
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 36
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 37
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 38
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 39
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 40
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 41
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 42
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 43
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 44
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 45
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 46
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 47
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 48
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 49
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 50
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 51
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 52
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 53
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 54
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 55
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 56
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 57
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 58
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 59
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 60
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 61
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 62
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 63
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 64
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 65
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 66
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 67
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 68
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 69
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 70
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 71
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 72
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 73
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 74
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 75
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 76
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 77
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 78
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 79
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 80
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 81
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 82
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 83
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 84
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 85
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 86
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 87
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 88
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 89
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 90
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 91
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 92
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 93
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 94
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 95
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 96
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 97
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 98
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 99
+ printf %s commit\trefs/heads/branch-%s\n
68d032e9edd3481ac96382786ececc37ec28709e 100
+ printf %s commit\trefs/heads/main\n
68d032e9edd3481ac96382786ececc37ec28709e
+ 1>> expect
+ test_seq 100
+ git update-ref refs/heads/branch-1 HEAD
+ git update-ref refs/heads/branch-2 HEAD
+ git update-ref refs/heads/branch-7 HEAD
+ git update-ref refs/heads/branch-3 HEAD
+ git update-ref refs/heads/branch-5 HEAD
+ git update-ref refs/heads/branch-6 HEAD
+ git update-ref refs/heads/branch-4 HEAD
+ git update-ref refs/heads/branch-8 HEAD
+ git update-ref refs/heads/branch-9 HEAD
+ git update-ref refs/heads/branch-10 HEAD
+ git update-ref refs/heads/branch-11 HEAD
+ git update-ref refs/heads/branch-12 HEAD
+ git update-ref refs/heads/branch-13 HEAD
+ git update-ref refs/heads/branch-14 HEAD
+ git update-ref refs/heads/branch-15 HEAD
+ git update-ref refs/heads/branch-16 HEAD
+ git update-ref refs/heads/branch-17 HEAD
+ git update-ref refs/heads/branch-18 HEAD
+ git update-ref refs/heads/branch-19 HEAD
+ git update-ref refs/heads/branch-20 HEAD
+ git update-ref refs/heads/branch-21 HEAD
+ git update-ref refs/heads/branch-22 HEAD
+ git update-ref refs/heads/branch-23 HEAD
+ git update-ref refs/heads/branch-24 HEAD
+ git update-ref refs/heads/branch-25 HEAD
+ git update-ref refs/heads/branch-26 HEAD
+ git update-ref refs/heads/branch-27 HEAD
+ git update-ref refs/heads/branch-28 HEAD
+ git update-ref refs/heads/branch-29 HEAD
+ git update-ref refs/heads/branch-31 HEAD
+ git update-ref refs/heads/branch-30 HEAD
+ git update-ref refs/heads/branch-34 HEAD
+ git update-ref refs/heads/branch-37 HEAD
+ git update-ref refs/heads/branch-38 HEAD
+ git update-ref refs/heads/branch-35 HEAD
+ git update-ref refs/heads/branch-36 HEAD
+ git update-ref refs/heads/branch-39 HEAD
+ git update-ref refs/heads/branch-40 HEAD
+ git update-ref refs/heads/branch-41 HEAD
+ git update-ref refs/heads/branch-32 HEAD
+ git update-ref refs/heads/branch-42 HEAD
+ git update-ref refs/heads/branch-33 HEAD
+ git update-ref refs/heads/branch-43 HEAD
+ git update-ref refs/heads/branch-44 HEAD
+ git update-ref refs/heads/branch-45 HEAD
+ git update-ref refs/heads/branch-46 HEAD
+ git update-ref refs/heads/branch-47 HEAD
+ git update-ref refs/heads/branch-48 HEAD
+ git update-ref refs/heads/branch-49 HEAD
+ git update-ref refs/heads/branch-52 HEAD
+ git update-ref refs/heads/branch-50 HEAD
+ git update-ref refs/heads/branch-51 HEAD
+ git update-ref refs/heads/branch-53 HEAD
+ git update-ref refs/heads/branch-56 HEAD
+ git update-ref refs/heads/branch-58 HEAD
+ git update-ref refs/heads/branch-61 HEAD
+ git update-ref refs/heads/branch-64 HEAD
+ git update-ref refs/heads/branch-55 HEAD
+ git update-ref refs/heads/branch-67 HEAD
+ git update-ref refs/heads/branch-59 HEAD
+ git update-ref refs/heads/branch-69 HEAD
+ git update-ref refs/heads/branch-63 HEAD
+ git update-ref refs/heads/branch-65 HEAD
+ git update-ref refs/heads/branch-68 HEAD
+ git update-ref refs/heads/branch-62 HEAD
+ git update-ref refs/heads/branch-60 HEAD
+ git update-ref refs/heads/branch-66 HEAD
+ git update-ref refs/heads/branch-54 HEAD
+ git update-ref refs/heads/branch-57 HEAD
+ git update-ref refs/heads/branch-71 HEAD
+ git update-ref refs/heads/branch-70 HEAD
+ git update-ref refs/heads/branch-72 HEAD
+ git update-ref refs/heads/branch-74 HEAD
+ git update-ref refs/heads/branch-73 HEAD
+ git update-ref refs/heads/branch-75 HEAD
+ git update-ref refs/heads/branch-77 HEAD
+ git update-ref refs/heads/branch-78 HEAD
+ git update-ref refs/heads/branch-82 HEAD
+ git update-ref refs/heads/branch-81 HEAD
+ git update-ref refs/heads/branch-76 HEAD
+ git update-ref refs/heads/branch-80 HEAD
+ git update-ref refs/heads/branch-79 HEAD
+ git update-ref refs/heads/branch-83 HEAD
+ wait
+ git update-ref refs/heads/branch-84 HEAD
+ git update-ref refs/heads/branch-85 HEAD
+ git update-ref refs/heads/branch-88 HEAD
+ git update-ref refs/heads/branch-96 HEAD
+ git update-ref refs/heads/branch-92 HEAD
+ git update-ref refs/heads/branch-93 HEAD
+ git update-ref refs/heads/branch-89 HEAD
+ git update-ref refs/heads/branch-86 HEAD
+ git update-ref refs/heads/branch-94 HEAD
+ git update-ref refs/heads/branch-95 HEAD
+ git update-ref refs/heads/branch-87 HEAD
+ git update-ref refs/heads/branch-90 HEAD
+ git update-ref refs/heads/branch-91 HEAD
+ git update-ref refs/heads/branch-98 HEAD
+ git update-ref refs/heads/branch-97 HEAD
+ git update-ref refs/heads/branch-99 HEAD
+ git update-ref refs/heads/branch-100 HEAD
fatal: unable to get random bytes
fatal: unable to get random bytes
fatal: unable to get random bytes
fatal: unable to get random bytes
fatal: unable to get random bytes
fatal: unable to get random bytes
fatal: unable to get random bytes
+ git for-each-ref --sort=v:refname
+ 1> actual
+ test_cmp expect actual
--- expect      2025-01-07 01:39:05 +0000
+++ actual      2025-01-07 01:40:41 +0000
@@ -37,14 +37,12 @@
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-37
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-38
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-39
-68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-40
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-41
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-42
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-43
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-44
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-45
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-46
-68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-47
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-48
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-49
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-50
@@ -59,20 +57,16 @@
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-59
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-60
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-61
-68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-62
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-63
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-64
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-65
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-66
-68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-67
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-68
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-69
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-70
-68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-71
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-72
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-73
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-74
-68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-75
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-76
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-77
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-78
@@ -80,21 +74,16 @@
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-80
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-81
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-82
-68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-83
-68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-84
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-85
-68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-86
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-87
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-88
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-89
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-90
-68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-91
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-92
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-93
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-94
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-95
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-96
-68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-97
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-98
 68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-99
 68d032e9edd3481ac96382786ececc37ec28709e commit
refs/heads/branch-100
error: last command exited with $?=1
not ok 47 - ref transaction: many concurrent writers


