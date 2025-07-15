Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270BC1E1DEC
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591099; cv=none; b=ZDygOV0ZV3dFKLbv3dH/yiNrjYhNDuABhk83ozaiR93069ZYX9j4eF6A0I5wCAuDAVGy0TRrrQ0s4hlvkfNSq20HKCz9VNw694wfgTWfGPWrMPXX6/YD5mQ7kWJeWBL/+MTinig/u0YKLMmP1+qFGQYvFke/B1Z20pLdTJ/0JT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591099; c=relaxed/simple;
	bh=HV/xclL31gdYsHnk/7dXh4d9pzFyVQoEtmPzLSoVbcc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GeBIWH9LEptBo5yGLMcoyOtbZCAaeL3kLfvYPgLT9OhWYBWagObVdmNR6NFCC9X0tPQQKeVyRUwaVe9u97PMApDIu711hwMH30AeN6IRjYMZpbxzx6h4eAlz1v0I7/VLqWdI0NaF/QmH8YkUwuuVZVnDnKqiQxCRVK/kzZAWN/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=CgtMDyTl; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="CgtMDyTl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752591088; x=1753195888; i=l.s.r@web.de;
	bh=jY2AoHeMKB++GO9tiiJA5oa+HnwuTxVxFxHBLJO39I8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CgtMDyTlMJPdejnCcPL5cQVxEKiyB5TlS43/xp0vNbVwu2ku/uMADJ4vOjkUfmgW
	 loen0fGv7/v3EOay64qiZOuAxMHmzUI4i9CKHZptRqsJpHb7BM7gL0KO8H4ckOQRH
	 Oo49Xya7n9VkXLl34T7yRCpPkqjsaUJN2TMBTUzlQYUGCBoiQVqJpZWAjaO3ybLqG
	 mvMWkcDeRoC5xxb+f30AruAkFpsU30/uuJdbp+7wGWWVSem4DwHzPQp+Xmlrt0DZz
	 eDNbOEIYTPAaTTWWGQgnMfShuSoY6Zan3qS6mtZxGXPG//8lPdZoCMNPWj9cfm4p0
	 N3i10H9RIMGyxe9SIg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MT7WH-1uC0hr2Dx1-00JLZA; Tue, 15
 Jul 2025 16:51:28 +0200
Message-ID: <aa89082f-34ab-4ec7-bdce-70f0a33815e6@web.de>
Date: Tue, 15 Jul 2025 16:51:28 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/3] commit: use prio_queue_replace() in
 pop_most_recent_commit()
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
Content-Language: en-US
In-Reply-To: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8J3PREQyganM/d+z7OOlKtMD69o6mUMVPxASgiM5BCOgwmBnp/n
 f2IKy3R/Y3pjUKfZQCz4+40iDXLEJJiyimU/ZWlii018GMUn8YvN5e7b+oCqiZjNWkk9DUp
 CFE4007lHI6Ovecg0nzhCiWc+fghIAljva5FjNjBnLUshFlcb78XOSyD40PxjPbcEvpH0uv
 QLgYVyWEHtQE5h4oWBCDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/uziM4vAfNg=;lWAOO1JAmlXYKtnjS8e10/S20GT
 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
 MbxgrOT7X1tXjWoqRTxChdrMhq0c3NeCQkF

Optimize pop_most_recent_commit() by adding the first parent using the
more efficient prio_queue_peek() and prio_queue_replace() instead of
prio_queue_get() and prio_queue_put().

On my machine this neutralizes the performance hit it took in Git's own
repository when we converted it to prio_queue two patches ago (git_pq):

   $ hyperfine -w3 -L git ./git_2.50.1,./git_pq,./git '{git} rev-parse :/^=
Initial.revision'
   Benchmark 1: ./git_2.50.1 rev-parse :/^Initial.revision
     Time (mean =C2=B1 =CF=83):      1.073 s =C2=B1  0.003 s    [User: 1.0=
53 s, System: 0.019 s]
     Range (min =E2=80=A6 max):    1.069 s =E2=80=A6  1.078 s    10 runs

   Benchmark 2: ./git_pq rev-parse :/^Initial.revision
     Time (mean =C2=B1 =CF=83):      1.077 s =C2=B1  0.002 s    [User: 1.0=
57 s, System: 0.018 s]
     Range (min =E2=80=A6 max):    1.072 s =E2=80=A6  1.079 s    10 runs

   Benchmark 3: ./git rev-parse :/^Initial.revision
     Time (mean =C2=B1 =CF=83):      1.069 s =C2=B1  0.003 s    [User: 1.0=
49 s, System: 0.018 s]
     Range (min =E2=80=A6 max):    1.065 s =E2=80=A6  1.074 s    10 runs

   Summary
     ./git rev-parse :/^Initial.revision ran
       1.00 =C2=B1 0.00 times faster than ./git_2.50.1 rev-parse :/^Initia=
l.revision
       1.01 =C2=B1 0.00 times faster than ./git_pq rev-parse :/^Initial.re=
vision

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 commit.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 0200759aaa..8244221b30 100644
=2D-- a/commit.c
+++ b/commit.c
@@ -742,17 +742,24 @@ void commit_list_sort_by_date(struct commit_list **l=
ist)
 struct commit *pop_most_recent_commit(struct prio_queue *queue,
 				      unsigned int mark)
 {
-	struct commit *ret =3D prio_queue_get(queue);
+	struct commit *ret =3D prio_queue_peek(queue);
+	int delete_pending =3D 1;
 	struct commit_list *parents =3D ret->parents;
=20
 	while (parents) {
 		struct commit *commit =3D parents->item;
 		if (!repo_parse_commit(the_repository, commit) && !(commit->object.flag=
s & mark)) {
 			commit->object.flags |=3D mark;
-			prio_queue_put(queue, commit);
+			if (delete_pending)
+				prio_queue_replace(queue, commit);
+			else
+				prio_queue_put(queue, commit);
+			delete_pending =3D 0;
 		}
 		parents =3D parents->next;
 	}
+	if (delete_pending)
+		prio_queue_get(queue);
 	return ret;
 }
=20
=2D-=20
2.50.1
