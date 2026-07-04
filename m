Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB552E2EF9
	for <git@vger.kernel.org>; Sat,  4 Jul 2026 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783155535; cv=none; b=jh1w+UYifxoCqy98AZPnAkb/UjaJbwDH1KohAyQgjgfw/zwKpKOktCZymjwohOnvA2BL3fKeWNEhvMaai/xcPe3uyte1jWDZVwNFb9ymmxFq/NKesPeFKUktm3V0K58GBx7lEBSYVvxAR7V4u5BKFP+/+P9bGnzZc7sbtc7ouDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783155535; c=relaxed/simple;
	bh=zXCRwQ9Js1XGQgJ1fYFEtg+xRuedl705N847uflUdC8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pwO0p907jSKO5bPvwpiCDepMzmA0UzpE2MY6d3vVGvzZI2wL2OG0YNhwgrY+c+5FL+99br/NU6438AifR5/VzvJvsRc+UT7OCUWfEanRet+cjU1v6JnHseGCCBOkDM8MJe6POdIYlt372VGAiCRYVkbD0kdTBGBp5iMIZYS8VJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=TNLXVN05; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="TNLXVN05"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783155529; x=1783760329;
	i=johannes.schindelin@gmx.de;
	bh=di8vL3Mx+FoU901xP6U6QEmEPy1T99C7K9OIZvcXj/M=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TNLXVN05B2RLWBSwrI/A6ozW8E/ciAEs3rKbdzXXGgZm3bFL9IYXMbA3cH3OkLpr
	 GaS7Lj/dke1ULloY6brSYxyAj61B1RxW9bh7nLx4m9OGRYlM9gaUYduon6QfIFHja
	 XTde/FoDUkURugUY399ZIGtOyH6Hw1sHZi3Cex8cczWRSVvaCosGRxK++NnwicDDL
	 osI2eug6n4D58+Wd18kkvvOt0UX3PxT36tIeXu7/yA1NOpPuywEn+1OoiG+Os2Kxr
	 bgCnl/JKEunZKILel4MbMY7TJUtmHiHR+RPOMnvdDwKbdtwO899vl9G+xY+iaoWlv
	 cum+WfOo/FJvP3u8wQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVN6j-1wZ1up40Mp-00Ki9R; Sat, 04
 Jul 2026 10:58:49 +0200
Date: Sat, 4 Jul 2026 10:58:51 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 05/13] run_diff_files: avoid memory leak
In-Reply-To: <akTIMM6qLfDNdg-a@pks.im>
Message-ID: <ac7844ee-a401-76b7-56aa-6318e2bdcc4a@gmx.de>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com> <860bc8f52dc9be8bbfafcda296be831a1ffaf1c2.1782889472.git.gitgitgadget@gmail.com> <akTIMM6qLfDNdg-a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:7yF4fQ8lzEditV5C/KOK/FZp9Nn/a4a1lSv5p9l0spqteS3WUTY
 JAHWEebqxtG/0CTjwd7I/D8uibylz7fbtiSsSQPvX5hAClDEWpyUYQETJd39GDRjnclER2c
 so2r9xGGUkHGJhVMNzm69EIqY5A8SJIjayoy2obh3+FPRLItTWeqe3OEhPwdli+jCqMKGJM
 NzcbsviY0+efevijHkgrA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NhwrYRLvasQ=;xG/LdYWBB4wqAQ6Zmlhn+cdclmG
 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
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Wed, 1 Jul 2026, Patrick Steinhardt wrote:

> On Wed, Jul 01, 2026 at 07:04:23AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > diff --git a/diff-lib.c b/diff-lib.c
> > index ae91027a02..7ba839b4a8 100644
> > --- a/diff-lib.c
> > +++ b/diff-lib.c
> > @@ -152,7 +152,7 @@ void run_diff_files(struct rev_info *revs, unsigne=
d int option)
> >  			continue;
> > =20
> >  		if (ce_stage(ce)) {
> > -			struct combine_diff_path *dpath;
> > +			struct combine_diff_path *dpath =3D NULL;
> >  			struct diff_filepair *pair;
> >  			unsigned int wt_mode =3D 0;
> >  			int num_compare_stages =3D 0;
> > @@ -164,6 +164,7 @@ void run_diff_files(struct rev_info *revs, unsigne=
d int option)
> >  			else {
> >  				if (changed < 0) {
> >  					perror(ce->name);
> > +					free(dpath);
> >  					continue;
> >  				}
> >  				wt_mode =3D 0;
>=20
> Huh. There is no assignment between the variable declaration and this
> call to `continue`, so how could this ever plug a memory leak? None of
> the other paths seem to leak the variable, either.

You are right; the patch as posted plugs nothing.

The reason it looks pointless is that the leak it was written against was
fixed independently in the meantime by 949bb8f74f4a (run_diff_files():
delay allocation of combine_diff_path, 2025-01-09), which moved the `dpath
=3D xmalloc(...)` to after the `check_removed()` call. Before that
reordering, the two `continue` statements did leak the just-allocated
`dpath` (originally introduced by 4fc970c43884, 2007-02-25).

I had missed that when picking back up the work on addressing Coverity
reports, sorry! I will drop this patch from v2.

Ciao,
Johannes
