Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD143E8695
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773937498; cv=none; b=oo8SFfsq7pMi75dko4klVhAfyt+25odKNAwuQYv6bZo9EjyAptoZD+IVRT5tezjimRRe8otovVuth5EHJYGj+TqQxZgFXHTsZvPMf5FFuqDKCXpnlkpXu2M8Wthd8xG5wE8MGlgghlWf4JP4k/959CtROp0lxGkZakR7KrQZzKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773937498; c=relaxed/simple;
	bh=7a3BdHFpuVelQsPgk7AqUz8OEzY+RcapfhJo6/7gp4A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PRy4dNJAncblTGS9UoYhzgLgs9i3iCbk0MEbrEShveiyI6ef2zBsU9mVku6VP6khDHVSvgnVS+/s4OJ+50NwjpBiztIZO7YThgyUxYSlKbqqmMsp4yZUwfx+Vum+LCE/+TXyzUokO3wRvKN1vlbbLb3tDSoYWd3N58otr2Ew6xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=gs9J/6tc; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="gs9J/6tc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773937481; x=1774542281; i=l.s.r@web.de;
	bh=Awg37dIdQ5npS66xSe/Rd45IvOYzopIOuDcT13u9bvo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gs9J/6tcHRVypaVEPHhwAj2H9+VJjlwQw0aZ91Boik0r5tlcIfpJf4sHf+j7M6Xs
	 m9CD2ahvROnfChNorqL5yBmnDCcS5LSXeECprJyxjUrRheienyuN2KB1ksH23EPQ6
	 QgZ+HQA/fV5xomXnrraUBK0LbCSqaL8XX27N+xL5+w9Penh7z/DQcJpUraX/0pi4T
	 nUjjdLiaF3zOw4d/wUcEUvve9aGNwdP2/3BK8aaSHBF2tr04cQqoIY44WwaDhXMwE
	 9Ev8+/QIkjVRg1IfC/HxITnsXG2IALllsKl1pwGpeNbcFueAgVmXqLPTPcr9lLiI9
	 yFl57Q4beIj8UMwYEA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQxo5-1wGGr93hBP-00In86; Thu, 19
 Mar 2026 17:24:40 +0100
Message-ID: <21adf042-2bd1-4022-8822-9ed4985122a4@web.de>
Date: Thu, 19 Mar 2026 17:24:40 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] commit-reach: simplify cleanup of remaining bitmaps in
 ahead_behind()
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Derrick Stolee <stolee@gmail.com>
References: <06000e28-c1b1-472f-bd6b-367b6c8d208d@web.de>
Content-Language: en-US
In-Reply-To: <06000e28-c1b1-472f-bd6b-367b6c8d208d@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6MWyu5F34u+xXDsw3w1HuxnDJso+NDXDqBexZ4D8pmbQIM9IJE5
 IAjkpm8IuoQ2WtQK+9rU3qLhmTxvtvHxW0YKcduiBuSY94aY/ees4LOYkCvnk+l2rP+a/oo
 l1p8zaVzP3oMHQJBjiD6VFx6QcX/OalNoAaovDG8ijDVtRsRREhuY1Gtz2zEq0AA/yuAcUU
 WXwB7aXfQZS3Eh6jqDbPA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4ex0gD8d9rs=;lHZR1vqC1qFy56GM4LrN08AtQqm
 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

Don't bother extracting the last few remaining prio_queue items in
order when we only want to free their associated bitmaps; just iterate
over the item array.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 commit-reach.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 9604bbdcce..d3a9b3ed6f 100644
=2D-- a/commit-reach.c
+++ b/commit-reach.c
@@ -1117,10 +1117,8 @@ void ahead_behind(struct repository *r,
=20
 	/* STALE is used here, PARENT2 is used by insert_no_dup(). */
 	repo_clear_commit_marks(r, PARENT2 | STALE);
-	while (prio_queue_peek(&queue)) {
-		struct commit *c =3D prio_queue_get(&queue);
-		free_bit_array(c);
-	}
+	for (size_t i =3D 0; i < queue.nr; i++)
+		free_bit_array(queue.array[i].data);
 	clear_bit_arrays(&bit_arrays);
 	clear_prio_queue(&queue);
 }
=2D-=20
2.53.0
