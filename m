Received: from mailproxy06.manitu.net (mailproxy06.manitu.net [217.11.48.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1787581F
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 14:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.11.48.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191567; cv=none; b=cY5Rwgxy26/glBdebFynmkkKeo1afyyitNEQWGiBMzCAxUT/wBYt31NyniPiHdEtIawMFgLrloTZ4eHVqwj95OcaG3wtF381HtTza7ks/xWVGhhB3uDBqCDvRChmxaRiHhaTRPMLtlcxiNhucIfAvebvtilZzy8qQRVcvl8BvPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191567; c=relaxed/simple;
	bh=TPi6M9QAJtL4v5mVo6zAAl65bcw7+i5GlNcAyMy75LA=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:To:
	 Message-ID:Date; b=ZswVocgVrshCEPLRI7MfDlxzAtfV9SANfTEeo297yMFM88ZMZ4UoyWwBZ0PPBWG3tfJF0rcAwkeWxSuo22bPDag+zbfQXnWeJNpl7kjYHOJ1nsDdqHrGVyr16EjjGECxPxg3Z/aKvCH4O1uo0FXwkyoNcH6T8jJG1F06GQ6fWhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grubix.eu; spf=pass smtp.mailfrom=grubix.eu; arc=none smtp.client-ip=217.11.48.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grubix.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grubix.eu
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <bf27ed3a-dc6c-4716-95c6-9e6c60604bd3@gmail.com>
References: <CAA19uiQip=EsbT8uQCs+98brYSTbOqyHX1ZBhssi4df3dZmZ6Q@mail.gmail.com> <bf27ed3a-dc6c-4716-95c6-9e6c60604bd3@gmail.com>
Subject: Re: prepare-commit-msg hook during rebase
From: Michael J Gruber <git@grubix.eu>
To: Git List <git@vger.kernel.org>, Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk
Message-ID: <171319155563.9055.10218254775303206647.git@grubix.eu>
Date: Mon, 15 Apr 2024 16:32:35 +0200

Phillip Wood venit, vidit, dixit 2024-04-15 16:01:31:
> Hi Michael
>=20
> On 15/04/2024 11:36, Michael J Gruber wrote:
> > Hi there
> >=20
> > For a while now, I thought I was using prepare-commit-msg hook wrong
> > but finally took the time to analyse this further. Per the doc, the
> > hook receives the source of the commit message as $2
> > (message/template/merge/squash/commit or empty).
> >=20
> > I notice the following with `rebase -i`:
> > - When rb applies a patch to be edited/reworded, the hook is called
> > with `commit` as the message source.
> > - When rb applies a patch merely to be picked, the hook is called with
> > `message` as the message source.
> >=20
> > The latter also happens when non-interactive rebase applies commits.
> >=20
> > I find this confusing for two reasons:
> > - Whether edit/reword or pick, there is always a commit being applied,
> > and it's the source of the message. So why not `commit` in both cases?
> > - The doc says that `message` is for inputs from `-m` or `-F`. So,
> > certainly this should not apply when the message comes from a picked
> > commit.
> >=20
> > Also, I'm not sure whether the claim about `-m` is true, but that's
> > another issue; we even might want to distinguish between `-m` and `-F`
> > here.
> >=20
> > Does the source `message` during rb pick occur due to an
> > implementation detail, maybe since the rewrite to sequencer?
>=20
> All of the hook behavior in rebase is an accident of the implementation=20
> and stems from the scripted implementation. I'm not sure if the source=20
> passed to the hook has changed over time but it is quite possible that=20
> it has. I agree "commit" would be a more logical source. Personally I'm=20
> not sure it makes sense to run this hook for ordinary picks, though=20
> perhaps it makes sense to run it when the message is to be edited. Do=20
> you have a use for this hook while rebasing or are you just confused by=20
> the source argument?

It is run during a rebase, and I don't have a use for it there, in
particular not for picked commits which I do not amend. That is what
triggered my investigation (unintended runs).

In fact, my hook messes up commits during a rebase if I run rebase from
a subdirectory, and I am sure that it didn't (quite) some time in the
past. But this can have several reasons:

- prepare-commit-msg was not run for rebase picks at all in the past
- prepare-commit-msg was run with source "commit" in the past
- prepare-commit-msg was run from the topdir (not cwd) in the past

I can avoid the mess by detecting the rebase state in the hook (or
cd'ing to topdir before the rebase), but I'm wondering what changed and
what is the right behaviour (to which I would adjust, of course).

Also, looking at sequencer.c from line 6545, sequencer_determine_whence()
looks funny: FROM_CHERRY_PICK_MULTI from the first if will always be
overwritten by the second if/else. I'm not saying this is strictly
related, but we do have untested code paths in that area. whence is part
of what makes commit decide on hooks being run and arguments passed to
them.

Michael
