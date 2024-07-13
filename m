Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEDD13A86A
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720888900; cv=none; b=C/AaRA/PRoPrDm2P4um6rPH3RVZb84Jvr2XTxEzZlEvFM3j2Xyt5cw6UWwzTf1iAv5P1UyHT82/WToKbMu+32WUFoQK6kg8NQcVStRb0eaUs5XH5CYryOxSxOj4x3XMHs/Zj1Xv3JdXSMv0SVZhkunPW34hXDqyIaOs+luo2J/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720888900; c=relaxed/simple;
	bh=D3exVCS/ON/C9lWGStT6pFfGnCOhGpC5Y5O3lcORYJ4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kzDFc7p+wCJLuCdMFuAJwjDqJte63zakbQjzhqcOBs4o4yeetX/qABvHw0Yjbf21Jw+JZZ5gvOh1eX2Bkv96pat9zMbepWCMDVJNj08EHnGd0zbDgq0W3zrFGuHP4Vg6Hgy3YamYHAT9MVRTPHZB8GNxXutSWzGn0jNH82bkifc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46DGfaJW108039
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 16:41:37 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <git@vger.kernel.org>
Subject: [Test Breakage 2.46.0-rc0] Test t4135.06 fails on NonStop
Date: Sat, 13 Jul 2024 12:41:31 -0400
Organization: Nexbridge Inc.
Message-ID: <024201dad543$877221e0$965665a0$@nexbridge.com>
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
Thread-Index: AdrVQ4P1wRYJ50XsTBaCiqxpsK0mRw==
Content-Language: en-ca

Here is the breakage. This looks like a non-portable dependency on /dev/zero
was introduced.

expecting success of 4153.6 '--reject overrides --no-reject':
        rm -fr .git/rebase-apply &&
        git reset --hard &&
        git checkout first &&
        rm -f file.rej &&

        test_must_fail git am --no-reject side1.eml &&
        test_path_is_dir .git/rebase-apply &&
        test_path_is_missing file.rej &&

        test_must_fail git am --retry --reject </dev/zero &&
        test_path_is_dir .git/rebase-apply &&
        test_path_is_file file.rej

+ rm -fr .git/rebase-apply
+ git reset --hard
HEAD is now at 4f3810f side2
+ git checkout first
Warning: you are leaving 2 commits behind, not connected to
any of your branches:

  4f3810f side2
  deca85c side1

If you want to keep them by creating a new branch, this may be a good time
to do so with:

 git branch <new-branch-name> 4f3810f

HEAD is now at 3aaf771 first
+ rm -f file.rej
+ test_must_fail git am --no-reject side1.eml
Applying: side1
error: patch failed: file:1
error: file: patch does not apply
Patch failed at 0001 side1
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am
--abort".
hint: Disable this message with "git config advice.mergeConflict false"
+ test_path_is_dir .git/rebase-apply
+ test_path_is_missing file.rej
+ test_must_fail git am --retry --reject
+ test_eval_inner_[6]: /dev/zero: cannot open
error: last command exited with $?=1
not ok 6 - --reject overrides --no-reject
#
#               rm -fr .git/rebase-apply &&
#               git reset --hard &&
#               git checkout first &&
#               rm -f file.rej &&
#
#               test_must_fail git am --no-reject side1.eml &&
#               test_path_is_dir .git/rebase-apply &&
#               test_path_is_missing file.rej &&
#
#               test_must_fail git am --retry --reject </dev/zero &&
#               test_path_is_dir .git/rebase-apply &&
#               test_path_is_file file.rej
#
1..6

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



