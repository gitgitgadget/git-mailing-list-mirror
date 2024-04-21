Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D99524C
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713724369; cv=none; b=CyCsvs1W6dFXun/rAH3uOIElR048/xMBrDWNLUi9vusXW2bFlS1gF6ZJqi75Gq1ruLqdX/752aMcjpwI+OKBHssZ1KLdHQOQE+FpZwojatXwllp6p99j1MzpoV8OQJNYQgHpsHUxmKBNEn4VRbKIbKK1tpx0vj+sugtiFslqzWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713724369; c=relaxed/simple;
	bh=Kl3pIY2u4XtxEVMDvQg3H22hmdZlUqF+6vstX4wqt6s=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=J/QnKIBblbgImVBujzuuOg2hbvE38FolMOIJOM+F6ElU0E2GFq7SDmX6QAPgdDNexlyg/G/sy9zIAXrxnB4VYz9CT8VNjuV3EYlXj8qIuO1TuApqkOK++UNiZvcMupOpK5HIoLekfa18YWCk0lmx0vaUW362AO6ZOyuv1mCgOaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-251-108.cpe.net.cable.rogers.com [99.228.251.108])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 43LIWa8Z2891240
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Apr 2024 18:32:37 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "=?utf-8?Q?'Ren=C3=A9_Scharfe'?=" <l.s.r@web.de>
Cc: "'German Lashevich'" <german.lashevich@gmail.com>, <git@vger.kernel.org>
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>	<82561c70-ec33-41bf-b036-52310ffc1926@web.de> <xmqqy1961sxf.fsf@gitster.g>
In-Reply-To: <xmqqy1961sxf.fsf@gitster.g>
Subject: RE: Possible git-diff bug when using exit-code with diff filters
Date: Sun, 21 Apr 2024 14:32:30 -0400
Organization: Nexbridge Inc.
Message-ID: <03b501da941a$4896bdb0$d9c43910$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQD6IN/EEUg+Pj6GO/QRv1Zk76ONSAGHpshHAXuYpruzG9VaoA==
Content-Language: en-ca

On Sunday, April 21, 2024 2:18 PM, Junio C Hamano wrote:
>Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> You can more easily reproduce it by setting the environment variable
>> GIT_EXTERNAL_DIFF or the configuration setting diff.external -- no
>> attributes needed.
>
>Indeed.
>
>A much simpler fix may be to declare that these two features are =
imcompatible and
>fail the execution upfront, instead of just silently ignoring one of =
the two options.
>
>As a person who is very much used to the external diff not contributing =
to the exit
>status (who also invented the external diff driver interface), I would =
be a wrong
>person to judge if such a simplified approach is desirable, of course, =
but just
>throwing it out as a food for thought.

My suggestion would be to keep with a priority approach, where =
GIT_EXTERNAL_DIFF overrides diff.external, assuming they set hold to the =
same specification (the git-config page implies they do) and =
GIT_EXTERNAL_DIFF overrides diff.external as I would expect. The =
behaviour of the two should be identical and definitely not in conflict. =
From my experience with this feature, and what I would prefer to =
preserve, is a formal separation between the diff engine and the =
underlying textconv. If the textconv processor fails in some way, the =
git diff should also fail, but the exit code should reflect that git =
diff failed, not the status of the textconv processor. If the external =
diff wrapper fails, the completion should be passed up since git =
would/should/could delegate the diff processing to the external engine. =
The only real completion code requirement I see is that 0 =3D no =
difference, 1 =3D difference exists, other is an indeterminate failure.

I might be restating the obvious, but this is an important capability, =
at least to me and my teams. We use this extensively for binary content =
diffs. It is also pretty important for structured document (e.g., =
MS-Word, RTF, PDF) and executable diffs that git does not handle out of =
the box.
--Randall

