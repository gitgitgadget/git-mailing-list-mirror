Received: from mail-106101.protonmail.ch (mail-106101.protonmail.ch [79.135.106.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F4D13B293
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 19:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767381424; cv=none; b=G+bw30MZe+VNlyFE2Zgj/HFbyu0Fsz+aAUgc2ymx2y/wy2KL/WDupEC40HuZnrhSqE8I63aR9lIs1kaumCgCbN1uPf7EwBwTTqppvEoYXqa+GflbCNa/EmuzniQy1icrYQF/q90k0qPYqQq22W4l7SWxqxS1q6+i0RPBleOLck0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767381424; c=relaxed/simple;
	bh=YbBQ1kQ/ZxW/2DLX7xY5iNRUAI6CxtO7q06IsVXQSd4=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=l+4ozyv2EDzHY98mofkDwcT7kwzlDJaE8Up8oxR2AggLctKszMBTM7jaEnjqWYNIJK0dCzgTfzGoYSmAjKvBJIxcSJQMRUUmNMfJj/BBCdNz0/t1+tiUnTrolWNHq6Ylxllo4GLGI8p20KT1EIQaEWUnszidrcjFUt9K7Yv/22Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=G5uj87TW; arc=none smtp.client-ip=79.135.106.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="G5uj87TW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1767381413; x=1767640613;
	bh=9dPh5SjG3YWvijJBFZ/K9SuZxWv5TOd/WZmn2kJgYUU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=G5uj87TWqgzjQ09BMcSfmRghoXO4FsQbzDrv0pgbVOskT7BPviK+UzRi4M7XRXmxU
	 uNSzd24zTPSjfVdEmm7YZPCj/KEFDz9IONAbbqWBDhur6vWmDJJZPxA/RhPofMMOat
	 9lva7rVk+47E/BJRivabD7rYifHb3y6v4DAqGzWCqr9ce8C27FMc5UZI14eqmBFiOL
	 mTILrK5oYusPQI69YsiAZtcvg2vv9ntrXUQS0Z/cl4/cCez6Y1Nl4DxoFojbZfUzKB
	 0D+gECgAWLrgz7b865AoaQWBW4YZzcduzQ+WbCOJ9NXVcO0aRGApr5dC9pWnzF693X
	 iMtdCHEAvBoiw==
Date: Fri, 02 Jan 2026 19:16:49 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: Tsahi Elkayam <Tsahi.Elkayam@protonmail.com>
Cc: "ps@pks.im" <ps@pks.im>
Subject: [PATCH] reftable/iter: fix undefined behavior in indexed_table_ref_iter_next
Message-ID: <Q0zfHYp-_TO2h_5PXPG9KjHwpMKIf2o2u2dsaoAjIsScmA3W6t7IvqIEeLfM7auEFIQyazlNnA3MGAuS4AANF0yfEBJAjkU1bWp-NH9m89U=@protonmail.com>
Feedback-ID: 35521663:user:proton
X-Pm-Message-ID: 006d852fc4fb8bbcba82f881fedac2054f082c89
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



  The indexed_table_ref_iter_next() function accesses ref->value.val2
  without first checking the ref's value_type. This is undefined behavior
  when the ref is not of type REFTABLE_REF_VAL2.

  The correct pattern is already used in filtering_ref_iterator_next()
  which checks value_type before accessing the appropriate union member.
  Apply the same pattern here:

   - Check for REFTABLE_REF_VAL2 before accessing val2 members
   - Add missing check for REFTABLE_REF_VAL1 to handle single-value refs

  This was marked with a "/* BUG */" comment indicating the issue was
  known but not yet fixed.

  Signed-off-by: Tsahi Elkayam <Tsahi.Elkayam@protonmail.com>
  ---
   reftable/iter.c | 13 ++++++++-----
   1 file changed, 8 insertions(+), 5 deletions(-)

  diff --git a/reftable/iter.c b/reftable/iter.c
  index 2ecc52b336..2eee65bb1e 100644
  --- a/reftable/iter.c
  +++ b/reftable/iter.c
  @@ -171,12 +171,15 @@ static int indexed_table_ref_iter_next(void *p, str=
uct reftable_record *rec)
   =09=09=09}
   =09=09=09continue;
   =09=09}
  -=09=09/* BUG */
  -=09=09if (!memcmp(it->oid.buf, ref->value.val2.target_value,
  -=09=09=09    it->oid.len) ||
  -=09=09    !memcmp(it->oid.buf, ref->value.val2.value, it->oid.len)) {
  +=09=09if (ref->value_type =3D=3D REFTABLE_REF_VAL2 &&
  +=09=09    (!memcmp(it->oid.buf, ref->value.val2.target_value,
  +=09=09=09     it->oid.len) ||
  +=09=09     !memcmp(it->oid.buf, ref->value.val2.value, it->oid.len)))
  +=09=09=09return 0;
  +
  +=09=09if (ref->value_type =3D=3D REFTABLE_REF_VAL1 &&
  +=09=09    !memcmp(it->oid.buf, ref->value.val1, it->oid.len))
   =09=09=09return 0;
  -=09=09}
   =09}
   }

  --=20
  2.37.1 (Apple Git-137.1)
