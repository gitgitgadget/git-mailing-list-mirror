Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9442A28F4
	for <git@vger.kernel.org>; Sun, 23 Feb 2025 08:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740299175; cv=none; b=P9j97V3E36QtgvuyOviTPzi9OWkduWV0dSKvHpRPRfWnl9WWYXn78sb3ElnIrVm25QEUHj+aBmP0UkUHuMzsVnWmmfqH+DID5w0XtfyJcRzudK3AAf9dsxVMMeYyO7umBmVf+fGuK3Fu0nLnmpxcUeWx53wt/WK5EboJoNrVbOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740299175; c=relaxed/simple;
	bh=VqA5cZaHKEqYrfmeZNfPXGCeICwWC9mWSpYtBgY6jWA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=PpeUZpQiEknnawHtR2t2uS6sF8HJUkhRkHYr9sQ4x+as9yyVNj3m8quJBAzgyBAI4OeP4kEo1Vwv4s8WSG+2uF7RBdEAzdkpD08HFKsno98jT50y2G+kyG26rgLvMYvBGBoYZwdftseFrgwhHpj8bTQzHuNkGX5JNpni9txOuho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=PNAD2YUS; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="PNAD2YUS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740299164; x=1740903964; i=l.s.r@web.de;
	bh=86wD+x6DJAGgUe+r2MxCqzSTdr3wdlCEVe4L36uELkk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PNAD2YUSFFTmbfPBnBrsR3dfrO3sSKLXVtilc3oVGqGhTmba8lLzVC6QcZQqBg5s
	 2ecaejijgOCN0c6wJsNNtoLn2IHWykDiHKINwcS5vMpsBZF9YjpVRpfMQcQm4vL/I
	 BAbF13pEgFFmxoxstRPQLlRhri1cStVbYoa/7Y6uxTRpNRR2p13z//4GzSQuqJJ1N
	 cPitkZ17vp30cwWLLICZt7tRC45hhpgK7uzqdFf14HMTH75r0ZbYR8+0XN7iJhQBs
	 dGbU78rATcYTgL9lzbL/OuLdgmeiJey7x+Jan6Vzg4r3fPQkZlGQo7mEHYXnN1VbN
	 pisP6a4zUSufj4P18Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.28.180]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsaW1-1tRpCh34O3-00rriW; Sun, 23
 Feb 2025 09:26:04 +0100
Message-ID: <2bd2d71f-0ee6-405f-bec8-368406ca53c8@web.de>
Date: Sun, 23 Feb 2025 09:26:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH resend] commit: avoid parent list buildup in
 clear_commit_marks_many()
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
References: <16a7b572-0a3d-4707-9034-0dac69ea99ac@web.de>
Content-Language: en-US
Cc: Junio C Hamano <gitster@pobox.com>
In-Reply-To: <16a7b572-0a3d-4707-9034-0dac69ea99ac@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X92qCMQoa3nINuugr4Qj7DZHy4fPzCQ2mpNVqM22H6MUXAgMZoj
 VXv6OaoS8tpQ4T0ebLz00tqMnRWj56o5VulGK8tIyv53Ro182LnzXC24q0vFMsYnhZnFarZ
 FD3g3kP5PB7jdo3kmBTucNDitpkoXaU47IE14U4MAK+gNAwDE+Km5NirYxQTkMnn7r4d2jS
 64dNueVQmoEzXtGcb/AWA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IihQpEv8gvc=;bTWsbykxdc+QLJ7SRkEdnsky24t
 MfeGz5KMWaoHk2d8aefF//7SHXuL29EVsyT9A2OnE+SRdj7wK7HLuxK4N1t2g//CU5edwpX8Q
 pNmFu/E0Z/5H8W11lZhLf3UsvHxweyPAaC3RH8hzFgjyaP/b6NYN7BKkhyUGxbto2CD/tQKnW
 qtEBZjH0bXPljYffXpoGkEcEh22A2sP8ZLu+iHhj+ADQ571MLC9ojoJlt1Ey9lPYMKNo35m0B
 v1UUF5GLbmJx8FL4eL7oQk3DKzOUxdurHypVhFt9snN4HQhvxF5q/LV0vp08LAWtnZEvEuyy1
 nWOl/hkXefQlxtnqDMXMxunBZ7giEEXFBjcw/NljavY3uv41QV/vkS591qTcf8GN/BC+gc+QO
 CWe2WEVsWIISIxmUCDgGiT59FQpvgnF5JYMJvpymHvmiXiYTyysbeu2fG5u4hMNr/ZPqyCFyx
 OemauSdIIg4WXkRR5wYYV/05j34m5+9nXTXzZuoMSOUmFpKoWJQUfomQF5amdpRG8JRTL6Fvg
 BKLHOLt2Q63gjJZXzxIakCk8K/RXz8aWWzveki3FJ7otTuSr9nqvdmLu2I6+ODf+8IdPgytuM
 GJvZoZjV0sh78G/pExcR1I9oTJE+agIEhMxfbGvPluLLzn2FP1Fq+zy8DEGEKMiOGrtzujJU9
 M78LpxQ4Cj78aNAP+TkFLcuyV4UfbPswN7b3JiXpZfzcQSbLR627LQNW5ZIXd0Qg9CrQBkaUm
 jJ0iFotCAC3m77EsSTaf64MNSkz9XSXQW7nFdL3k8EZDhJjABfDjKQJlrVGp9gvQZpUpogouc
 sPrHMXT5pDh5q10/tZW0Pv5hRbkcBw6fesv80v9EZs9rZ8eLAuW1IT0oM3KvrIVui35/Rq4X9
 bsAykf79CQMU8rQTgKFiNbghyCGldqSBMdgBq5f0q2zXKA7O58naXZh0zyS3IeMVhMEu6TJcD
 9gxNkjvbKiEccAqNpgsU0Weta01BAHCey8c43TTRBhpEcahTJ5yEarxT+cernaUt2x6Y3/uR6
 8BfQQMrFea7U7RwfAckpatxCwnV36chqQ8+y2hgGMUbemLdhgFWyqamFzr0869MIKDWW3CB9q
 erdBAJpLsshO9/Hci9T360SKF2oOPSCTVYdS4YxVE06YRoS1N1ARvN0qBX8olnzm+nkLxeMnf
 LxAb22Fu4OnHU3qrmbYYwjLRUyYXPbOiUqT/7Zydq/9/6zFpkTjhcUZY/oC6/qk/JRFA4sHqZ
 ivoqoXKx0DW37lyrqzx5kSUKPznB2zkwEtv4PiuSdAb8q2+V69l7UFJdkDraMVUxWZeqF/ZSo
 PRbutbnVo3v8Q1uO9+WhOwjMhxlpG5x+KgKZlwbVXCwW7BstPZVrKjdU0qVcK3o3V6lmAwG+U
 G+Ru7EIQhpfiBTObxvULlOrZzkR/lvFXQ2VTtV5vx8gMx2n9emkyL+N+g3

clear_commit_marks_1() clears the marks of the first parent and its
first parent and so on, and saves the higher numbered parents in a list
for later.  There is no benefit in keeping that list growing with each
handled commit.  Clear it after each run to reduce peak memory usage.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 commit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 540660359d..6efdb03997 100644
=2D-- a/commit.c
+++ b/commit.c
@@ -780,14 +780,14 @@ static void clear_commit_marks_1(struct commit_list =
**plist,

 void clear_commit_marks_many(size_t nr, struct commit **commit, unsigned =
int mark)
 {
-	struct commit_list *list =3D NULL;
-
 	for (size_t i =3D 0; i < nr; i++) {
+		struct commit_list *list =3D NULL;
+
 		clear_commit_marks_1(&list, *commit, mark);
+		while (list)
+			clear_commit_marks_1(&list, pop_commit(&list), mark);
 		commit++;
 	}
-	while (list)
-		clear_commit_marks_1(&list, pop_commit(&list), mark);
 }

 void clear_commit_marks(struct commit *commit, unsigned int mark)
=2D-
2.48.1
