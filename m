Received: from smtpcmd01-g.aruba.it (smtpcmd01-g.aruba.it [62.149.158.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5064756B6
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 06:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790836584; cv=none; b=arsT8Aaht3goynsVYJFsUZ0FhjhkdXvUkM51IKgVid0tef0UcaI3SP0ecZQ6UaRxXBO7g07xw9kjxGI0REA1IMmFQ17VsHHIIjnuzL84jdCcbQnLTwJh6+q/qjUdEJcWtqA6O5e3IQMnxx54YcVF655RaS4QBdd3+pd1NIne6YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790836584; c=relaxed/simple;
	bh=uPkV9jFXIWVcAJLiJeNOEYZb7sgQQ3BfTH6IG6/wMTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPuGO/XK+lI2wvzSndP0G+0RffFvZaLTZqvgqxV6MRLTMASBUWtPhHcXN1zQA8NrQoMMf2noTl9ZrObVmlVpooNBdPGVSrFlZmS9vzlXC93QJy1g2qMk68apBFgd3NOMDIcP0WU67prmMT/HBMJI+BBgJqiK+G0MpohZxHZC9AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=locati.it; spf=pass smtp.mailfrom=locati.it; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=YxaeHvZg; arc=none smtp.client-ip=62.149.158.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=locati.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=locati.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="YxaeHvZg"
Received: from HP-PCD-007.progesoft.local ([95.227.74.73])
	by Aruba SMTP with ESMTPSA
	id CALsxMCf3XmotCALuxu4RX; Thu, 01 Oct 2026 08:33:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1790836391; bh=uPkV9jFXIWVcAJLiJeNOEYZb7sgQQ3BfTH6IG6/wMTk=;
	h=From:To:Subject:Date:MIME-Version;
	b=YxaeHvZgtXrxtc+M5kPWoDUiV1OAasrv5ooF3apQoZgUIrZPxSBSfskYNe3rQCGfA
	 V7WWhLKlxbUinn69KxJamV8D68hxMPUKdJBA4P8o6+0Yii01jevr7X6s/Bz70qFVQp
	 fNZVnZYjMlkaa38syNLoLJ6TDG6bNZOOTc04gpXlBm9Zq3FUi5ug3APmbdokR3EhZL
	 E1BF9CANpjNKfSnzEf7BoOARaQTJODEnzD2RfLlc0TQcXRZxS/VZ9LbdCs1mQX7yMA
	 tXZwvOIoQ5cvTv2TPzI9CfWlZxnyJNGIyjnJFcf7HQXKiE18dkCDMQ/DqOqP9G/d0i
	 0GIRxfdpDxAdQ==
From: Michele Locati <michele@locati.it>
To: Patrick Steinhardt <ps@pks.im>
Cc: Grant Moyer <dev@grantmoyer.com>,
	git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] filter-branch: fix commit map init from state branch
Date: Thu,  1 Oct 2026 08:33:06 +0200
Message-ID: <20261001063306.616-1-michele@locati.it>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ar3xSurCd0-yDruA@pks.im>
References: <ar3xSurCd0-yDruA@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNPpTZNlwndfIZHTlncaKPNH3UiyCMvBMh12e3FPGDQZHWoOGjGuEcTWKnBfhRmam8dyyiR51vDx3BVZk82mb3Y26pzmzNQYm9GFQPr2Nh039C3mZa/W
 mCvfqV7oHwlDW21fcSBrlp7VNyghyd5cfBpNsUB4/4I46F5rmv54+p16YIM1lKaZmrRTQgxKvogcnbKWCijjTEaKwO/BPe8fBJF2CpRcEau/7EOjhkWeuZj2
 ZN2tElnJt1hs+TOaiev8L2x/Of8ftAz7E8d85d0f51bsIF0FG0WiSa3d4OEAKLly

Hi Patrick,

> simple blob stored in "$state_branch:filter.map" with the format
> "$to_commit:$from_commit".

Small correction: the format is "$from_commit:$to_commit" (the original
commit first, then the rewritten one), that's what the fix restores.

The test_when_finished cleanup sounds good to me.

Since I'm listed as co-author:

Signed-off-by: Michele Locati <michele@locati.it>

Thanks,
Michele
