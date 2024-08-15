Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809E41AC8BE
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723733572; cv=none; b=XQ6TrqrKOokp9Pu4nODLENgBs4Vda6XdJPyW8Wer9b4zTTrYbH8D1WbT6qa6H1gA8lYNwI6dibLOyrxRwDkjRmQ4WGwaIoc2Egcr63b2aZ/XDTSR0/hamjr2343UH5JynwCgucb4lb7vnOpgHxT+yQ1GX29ko+hs6b+TxpaOBu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723733572; c=relaxed/simple;
	bh=0bI3u2zj9q/tiRt53XhlxjLIkrxg1Ggb/cs+vktGZ/c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m4eITocN5iEFpV8M+l8bHBo17/5JxshuUL5XfnTrPRVmeYJUzOyUWYGPBStipKEaRag7VNOwT4zIwHV0zWVEIb5s5N5yN7/GX+hOxUQA5bk609ZSZP6OViAgHFiFcx9/guHSq9Oxtv3nlR/mbVcFIxpNx2J9jQO5BwOcaIFA3Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ycIONECv; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ycIONECv"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D63E1E0C3;
	Thu, 15 Aug 2024 10:52:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0bI3u2zj9q/tiRt53XhlxjLIkrxg1Ggb/cs+vk
	tGZ/c=; b=ycIONECv2LL8S9r8u0QIIlEChKTcAc9rO/oSvsc2ApZwrrc5N+ly4u
	XVQ05kt3dtHRR8Eryo2w/IPK174F50v/4OBr0vzqsVswDcvdx7r+6RgQ75NFtJXl
	2pPNJBLX/K1TdnDQiGdugRkCrfRqhESkxyhprceVcqjtMKwzSmfGM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 430D51E0C2;
	Thu, 15 Aug 2024 10:52:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A73401E0C0;
	Thu, 15 Aug 2024 10:52:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] apply: canonicalize modes read from patches
In-Reply-To: <20240805060010.GA120016@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 5 Aug 2024 02:00:10 -0400")
References: <20240801155702.70242c31d476c46c84ee11a3@linux-foundation.org>
	<xmqqed77hifn.fsf@gitster.g>
	<20240801180706.933d797b0ae5744fdcdf47d2@linux-foundation.org>
	<20240802035121.GB1246312@coredump.intra.peff.net>
	<xmqq7cczgefh.fsf@gitster.g>
	<20240805060010.GA120016@coredump.intra.peff.net>
Date: Thu, 15 Aug 2024 07:52:47 -0700
Message-ID: <xmqqcym9vnwg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0A008F9A-5B16-11EF-9608-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> +test_expect_success POSIXPERM 'patch mode for deleted file is canonicalized' '

This test seems to fail under "--stress" and I need to borrow a
brain better clued than mine.  It appears to be fooled by mtime that
is not updated immediately and failing match_stat check, but since
the index file is written on the other side of the second resolution
boundary, racy-git double-checking code does not trigger, or
something like that.

Here is how it fails:

expecting success of 4129.13 'patch mode for deleted file is canonicalized':
        test_when_finished "git reset --hard" &&
        echo content >non-canon &&
        git add non-canon &&
        chmod 666 non-canon &&

        cat >patch <<-\EOF &&
        diff --git a/non-canon b/non-canon
        deleted file mode 100660
        --- a/non-canon
        +++ /dev/null
        @@ -1 +0,0 @@
        -content
        EOF
        git apply --index patch 2>err &&
        test_must_be_empty err &&
        git ls-files -- non-canon >staged &&
        test_must_be_empty staged &&
        test_path_is_missing non-canon

++ test_when_finished 'git reset --hard'
++ test 0 = 0
++ test_cleanup='{ git reset --hard
                } && (exit "$eval_ret"); eval_ret=$?; :'
++ echo content
++ git add non-canon
++ chmod 666 non-canon
++ cat
++ git apply --index patch
error: last command exited with $?=1
not ok 13 - patch mode for deleted file is canonicalized
#
#               test_when_finished "git reset --hard" &&
#               echo content >non-canon &&
#               git add non-canon &&
#               chmod 666 non-canon &&
#
#               cat >patch <<-\EOF &&
#               diff --git a/non-canon b/non-canon
#               deleted file mode 100660
#               --- a/non-canon
#               +++ /dev/null
#               @@ -1 +0,0 @@
#               -content
#               EOF
#               git apply --index patch 2>err &&
#               test_must_be_empty err &&
#               git ls-files -- non-canon >staged &&
#               test_must_be_empty staged &&
#               test_path_is_missing non-canon
#
1..13
$ echo $?
1
$ git -C trash\ directory.t4129-apply-samemode.stress-failed/.git ls-files --debug non-canon
non-canon
  ctime: 1723701364:980719772
  mtime: 1723701364:980719772
  dev: 65024    ino: 1980747
  uid: 110493   gid: 89939
  size: 8       flags: 0
: git t/master; stat trash\ directory.t4129-apply-samemode.stress-failed/non-canon
  File: trash directory.t4129-apply-samemode.stress-failed/non-canon
  Size: 8               Blocks: 8          IO Block: 4096   regular file
Device: 254,0   Inode: 1980747     Links: 1
Access: (0666/-rw-rw-rw-)  Uid: (110493/     jch)   Gid: (89939/primarygroup)
Access: 2024-08-15 06:54:43.808293635 -0700
Modify: 2024-08-14 22:56:04.980719772 -0700
Change: 2024-08-14 22:56:05.020719706 -0700
 Birth: 2024-08-14 22:56:04.980719772 -0700
$ stat trash\ directory.t4129-apply-samemode.stress-failed/.git/index
  File: trash directory.t4129-apply-samemode.stress-failed/.git/index
  Size: 432             Blocks: 8          IO Block: 4096   regular file
Device: 254,0   Inode: 1980724     Links: 1
Access: (0600/-rw-------)  Uid: (110493/     jch)   Gid: (89939/primarygroup)
Access: 2024-08-14 22:56:05.044719667 -0700
Modify: 2024-08-14 22:56:05.008719726 -0700
Change: 2024-08-14 22:56:05.016719713 -0700
 Birth: 2024-08-14 22:56:04.996719746 -0700

