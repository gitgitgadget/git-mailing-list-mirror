Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B45B331EB4
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 18:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789842790; cv=none; b=rZu1BmGGo+3MEkyQmO1YDB1cZKGoFxav0jgfRqRQzOB4A+Dos7H6d0pnTGNr2q3S5/wsq2vaFXzA22nxEZ+wGCuj/WzhipBAVc4eWGh44x2CdgZopRxAJL0sHKepVISpSU254dcfAORCcGb2pZQK5l7eR6XDlgEP4nqjIZ5d8QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789842790; c=relaxed/simple;
	bh=IUsKpxCNF7AqDzeER42qMgcXBcrlnCBo5TXe4xqm2UM=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=acvcecXGV+l5NkuWilZt8pcxTE8+G//jpTzmW4r2CIEQF2Lr/xMEpSTV6lEefxBeNxxV0I/3sszbeWcucueZcBRUOYsp8CJEL2KyRvRy94kqbghb+FdjA7KzQHVVqar5K1WCt8KrFIq57Wv+Hrn/aYeU+Aa3zQ5MRCgDfe2vyWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=csQprD7L; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="csQprD7L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789842779; x=1790101979;
	bh=jN0klxuN514uzyYu+Ey0ic+WwXM5y8aCOCVG7gGa1rs=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=csQprD7LbmL0pbZbc2s/vxRf9NIdlxNwmK1u3IPD98LPRXJf8lSETprlzqUGM/gmn
	 HMDAkgjUmxAkSLSU1H+xezaMxQtwosZLz9wjJPI1rFksjXcU2UkAwLx7twjPfuxjwz
	 8qLsC2Dv2K75sxK6JnyudzvKQ3Cnw8yj+ZIsV3HqkclmoM6MAvmMidIRSPTTnG0uVF
	 YqvCdZmBNpdQlMmMDnUP8/lkqyfjFo6BR60N/vg+zw8U85kDnIS7WAxs7rY8YLp7qh
	 EH14anYqCi7QXEynZt+h8uCXOii5WLVUSRDqoc9/Y8opSoYjsqMxFXaX8oS6IzcNzT
	 xWiBFVxKBJx/Q==
Date: Sat, 19 Sep 2026 18:32:55 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: "r.norouzi" <r.norouzi@proton.me>
Subject: reflog expire: default expiry times swapped since 2.50
Message-ID: <GZicFFe4cqB928v52ERTcEFaAFtAwL0rp8VaCKSMyYzJ48XbQ9XoduiDtsou0Qp4N2CGmCS49uRbxi9dUWwlFzgzlt0PkGzR7IkqysP9tVQ=@proton.me>
Feedback-ID: 181899255:user:proton
X-Pm-Message-ID: 3f6adea54d4e657cb44b9469c6ad9a52193840d5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

What did you do before the bug happened? (Steps to reproduce your issue)

I made a reflog entry 60 days old on a branch that still contains the
commit, then i asked what "git reflog expire" would prune, with no
gc.reflogExpire or gc.reflogExpireUnreachable configured:

    git init -q -b main repro && cd repro
    t=3D$(date -d '60 days ago' +%s)
    GIT_COMMITTER_DATE=3D"@$t +0000" GIT_AUTHOR_DATE=3D"@$t +0000" \
            git commit -q --allow-empty -m old
    git commit -q --allow-empty -m new
    git reflog expire --dry-run --verbose main

What did you expect to happen? (Expected behavior)

The entry for "old" to be kept. The documentation of gc.reflogExpire says
it defaults to 90 days, and gc.reflogExpireUnreachable to 30 days.

What happened instead? (Actual behavior)

    prune commit (initial): old
    keep commit: new

With -c gc.reflogExpire=3D90.days.ago the entry is kept.

What's different between what you expected and what actually happened?

Reachable entries expire after 30 days instead of 90. Since the total
cut-off is checked first, every entry older than 30 days is now pruned,
and the unreachable cut-off never matters.

Anything else you want to add:

The defaults look swapped in 85658275702b (builtin/reflog: stop storing
default reflog expiry dates globaly), first released in 2.50.0. Before
it, builtin/reflog.c had

    default_reflog_expire_unreachable =3D now - 30 * 24 * 3600;
    default_reflog_expire =3D now - 90 * 24 * 3600;

and reflog.h now has

    .default_expire_total =3D now - 30 * 24 * 3600, \
    .default_expire_unreachable =3D now - 90 * 24 * 3600, \

master still has the reflog.h version. Seen with 2.55.0 (Git for
Windows 2.55.0.windows.5); the code in question is not platform
specific.

