Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0130521344
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/oP4Q91"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28b79d1ebd6so382853a91.1
        for <git@vger.kernel.org>; Thu, 21 Dec 2023 02:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703155741; x=1703760541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRbSG59SLhfX8XhnS8ulSfTqfkC40+n1rUpOzRflehs=;
        b=h/oP4Q91z8ObvfS0IkByuNEFIbeXSVpS8EhV58id6mYvtVt/oyyfYotFCnWCgP8juF
         QvDRgb/ASeNMqABmmwWmLTQ7HwR67u92Xi3KeVd2ye9ZF/CNrg2Az1DDms3OCATbbpwS
         Znb1F9OTqcrtq2GPa2A6yCEuX2e65on+IaChn1AOtGV3fpuRHNaidUBXiDjrFTmSsECD
         xWUIoR0Bt8PDAovkuxZ31O/MyermldlsvFlCzyBKcEuWs0wenn6JNj1g5iZgMvVQgfeE
         ivYYG7elGQql7/xVcKATTy4IG3OoQgQQgWJTjx6yCdmX9YN+Ul/cGLPBn9YqYiYKlCza
         7/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703155741; x=1703760541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRbSG59SLhfX8XhnS8ulSfTqfkC40+n1rUpOzRflehs=;
        b=DoaxshBqc6gIDo49YKzpasihnDxdTmWnGQd668tMMNafHdS88Ct34O0oaKPtG/lwjv
         GRFhetsgk/MM2A0eItTI5P6Tp4cdMjoWGPiBnrwepdViiPUvxBfvT4b36quBYZD5Ze9p
         urg88zFlDsJu797VwUkLdnE8Gb058rF27piV8xEwk0K0ZrQbYxj180VoGVeKNN7GU4wp
         3sKcfAdHsi7bPGwoOUx1mn7att9OB6WGTxrUkQBt/wrikjdUjK5ztXGg/NpyIAs0Mo5Q
         uZZdWwrBSERDy8m/d2p3f7gLrX1HO2e9pd5DGGpRYh0pATLOGZPmz9Ax0FqLsVEOlxhW
         cWRg==
X-Gm-Message-State: AOJu0YxtQeESB54FR7y5g5YrIJCX/oPZVS+zsxf6D0wG+B/ruBgqWhLs
	tlPsG/CioDrFy0zvWzXqU0adZkpkb4PBF2pDd28=
X-Google-Smtp-Source: AGHT+IHtYt3bkaduSQC+WTZrO/dooaHwc+x+E7hYzLxD7p73upd2FHVmeFjwpMhONsGcvrIAna7oDSm69CKpPogxM/8=
X-Received: by 2002:a17:90b:3c47:b0:28b:745a:3611 with SMTP id
 pm7-20020a17090b3c4700b0028b745a3611mr3361362pjb.62.1703155741273; Thu, 21
 Dec 2023 02:49:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700549493.git.ps@pks.im> <23c060d1e21573581ca6c5db50ca756b61078e3e.1700549493.git.ps@pks.im>
In-Reply-To: <23c060d1e21573581ca6c5db50ca756b61078e3e.1700549493.git.ps@pks.im>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Thu, 21 Dec 2023 11:48:50 +0100
Message-ID: <CAOw_e7Yps5T32cAZrKO2meebEsdo4h6AWoFF3A4PCqF9AHuNxQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] reftable/merged: reuse buffer to compute record keys
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 8:07=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> When iterating over entries in the merged iterator's queue, we compute
> the key of each of the entries and write it into a buffer. We do not
> reuse the buffer though and thus re-allocate it on every iteration,
> which is wasteful given that we never transfer ownership of the
> allocated bytes outside of the loop.
>

From a brief read, change looks good.

In the C code, each key has to pass through the pqueue which is
(assuming auto-compaction) has log2(#tables) entries. The JGit code
assumes that the base table will be very large and the rest small.
This means that most keys come from the base table, and has some
special casing so those keys don't have to pass through the pqueue. If
you worry about efficiency, this might be something to look into.


--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
