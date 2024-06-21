Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3788138FB9
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 23:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719011911; cv=none; b=nwjUPzhXNMiR2Qmr/1iXTnw5zyQJlW/Q7XGdHMYdeXN7j5D4bPVYlUMfYzOGBH0Qg0F+PJ+Mty1DN7gI5+WRzajrq/zyxdDBYIcrXnUX1rWhbqXa17zYTJl79dSkJbvN8ogLnZlyGy8tvGTU7KfAaJ/7rdhQMYBtb8hwjeNcVPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719011911; c=relaxed/simple;
	bh=Wq9L7PUzg9E6XqjA72T0DgG6qTy+czCt0GAE+qMpv9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RmrBxLXMDGst446eoEMhGYkRKy+NvyPp/+GJ1WkDoNXVmo1DXQLVDa2pwTnxw5DCa90PS4mtwxJL6zpfE1k2961DbFvkYhZndGfGfazxIEjqZsWMGCcn08WX85QI+A+M/WeXuDc6VyNtEpvPntqmFGCq9oHMgqvaDnibOGZWFlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vtq/kFBb; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vtq/kFBb"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0601D27E23;
	Fri, 21 Jun 2024 19:18:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=Wq9L7PUzg9E6XqjA72T0DgG6qTy+czCt0GAE+qMpv9E=; b=vtq/
	kFBbJYPcNmxUAymIYjlLmOvkGDnr2MYXQEx75r5VOsGGc99ldESvuyWNePzjBQLq
	cusX2+48ZChi2/CGGN4w64jND+JvuTJt5mhWQVMbz0/Ve29WkZxuWmPwAK8Ew6Hn
	a1z6PwwzLy67Umbe16ILz49vhs157noDgZ2kydg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F291327E22;
	Fri, 21 Jun 2024 19:18:27 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7060527E21;
	Fri, 21 Jun 2024 19:18:27 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Rob Linden <rlinden@redhat.com>
Subject: [PATCH 0/5] Tighten patch header parsing in patch-id
Date: Fri, 21 Jun 2024 16:18:21 -0700
Message-ID: <20240621231826.3280338-1-gitster@pobox.com>
X-Mailer: git-send-email 2.45.2-786-g49444cbe9a
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 909A349C-3024-11EF-9A2B-5B6DE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

The patch-id command loops over a series of patches, picking up the
origin commit object name (which is on the "patch header" line) and
then computing the patch identifier out of the "patch" (series of
"diff") that follows the "patch header".

The parser is structured in a bit "strange" way.  It repeatedly
calls a single helper function get_one_patchid() that returns when a
patch header is recognised, or skips until the "patch" part begins
and then computes the "patch id" over the "patch" part, until it
sees a patch header.  The caller knows that it gets just the "patch
header" for the first patch with its first call, and the second call
is about computing the patch id for the first patch, whose
originating commit was obtained from the first call, etc.

During the second and subsequent call (i.e. after finding a patch
header which caused the get_one_patchid() to return, calling the
helper again, expecting it to skip the commit log and find the patch
for which we are asked to compute the patch id), we shouldn't look
for the patch header at all.  Otherwise, a line that looks like a
patch header in the log message can easily be mistaken to be the
beginning of a new patch header, as if the current message did not
have any patch text.

This 5-patch series is organized as follows:

 - patch 1 is about setting the baseline.  We need to recognise the
   patch header produced by format-patch, log, and diff-tree --stdin.

 - patch 2 to patch 4 are bit of code restructuring without changing
   the behaviour.

 - patch 5 stops looking for a patch header when we shouldn't, and
   adds tests.

Junio C Hamano (5):
  t4204: patch-id supports various input format
  patch-id: call flush_current_id() only when needed
  patch-id: make get_one_patchid() more extensible
  patch-id: rewrite code that detects the beginning of a patch
  patch-id: tighten code to detect the patch header

 builtin/patch-id.c  | 82 +++++++++++++++++++++++++++++++++------------
 t/t4204-patch-id.sh | 40 ++++++++++++++++++++++
 2 files changed, 101 insertions(+), 21 deletions(-)

--=20
2.45.2-786-g49444cbe9a

