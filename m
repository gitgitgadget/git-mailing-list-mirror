Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B59298990
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752831559; cv=none; b=R1FmbDexLX0uS4oI/FeMrL4sRo5iKaBlJWY0g01OEqtqR/RxWg1EbFvLemYZwE4UikkElZvPCPY6jwVAnFVE0Ythx1QAoJJ4Y4CB17kVbUo4TbKEHMbbx/f1Y2JN7FGQiVf2WpM2iSn8fr8IVT+X5H58KQryY1rcDa/RuupcVpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752831559; c=relaxed/simple;
	bh=DN+eHTwjMdOB7HbDXHtp8ruxk6jzxW3GQWlr5qAMRQw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Swhoh7Ii2k1okmMMgStyl9iGyJZmGDur53zGAgFfnbv4ZBbx92XE0ToyG2tBDLvgFuLOlXMc13e71YT+A9vdenC35fVqQWTgyHZz3zrnh+InV/jXsVHC/9AOKjGe58op6fy7TEZyUrbf0dmBRgTNksZV0T7yRjs6Zk+DGDfbhXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=r9EYEGtq; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="r9EYEGtq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752831552; x=1753436352; i=l.s.r@web.de;
	bh=TMWVNGsnw2RFSSjJ77RYMExBfgdaMHfxbVdk5oiHEYs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=r9EYEGtqfB+oQupWgPFZE+z90YlqMeVYpE5sCuHaCEg40KoQ5/QJdi6/46FfxJ/V
	 1FkonMd6znt0WxVPWiooNnoD9jjD4pPC8WSrIWIzLMhBGJHmzFyPbGvJkeFqxSyoV
	 Vog2gRZQwPKpO2YIr/4Ze1p3iL2sHn2Mom68h2EPzkV0Fq+4TdhgPaimjI0S7loR/
	 1wrnp/cVgALAK0s874EsACtqCj415i8yGx8t5tX7htUGTq/AGn5r4wqOVlUgncSCz
	 EKfdo3DsD9k5e/d2gA3/g3mVFEg0g9qjGMaa/Ohaefjt8C50Gq+FP4nim+UhZY3j0
	 E03slS7zggJS6E/x1w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N79RI-1ugEIO05nA-00vBR1; Fri, 18
 Jul 2025 11:39:12 +0200
Message-ID: <494e9686-e014-45f8-86d2-8dfcd6630f46@web.de>
Date: Fri, 18 Jul 2025 11:39:11 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 3/3] commit: use prio_queue_replace() in
 pop_most_recent_commit(),MIME-Version: 1.0
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
 Justin Tobler <jltobler@gmail.com>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
 <8ff40c56-368a-4347-aeae-2aca2cb6a5b2@web.de>
Content-Language: en-US
In-Reply-To: <8ff40c56-368a-4347-aeae-2aca2cb6a5b2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0WfHA23G8T9mBiAM/iKMWk0cBW2XdncCcrM87BV8Va8BpKjoDT6
 d7L+5BRZZpFHVdg7hk3oibIUni9hVEPG775jbhJWS9IDY0Dm55ycs5GKSFMuenUesQG+MgN
 VwlyR87nw8gfpslLJKk8owsXS5w/Gj4Rixk8ZFG8oBGCCZWWnamqhIYYvmmobU1srXEfdVd
 fHgNIbGaVQciVJtDks0KQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:26MoinDSAfw=;K/a2DcLq2ODFIOhjbq7sDE2q6MV
 RZP3/CuP+v8lz0p+qe6DcqOmIo+9naG0SpkrgMS+waQgKLMN+CJ4y/1zZyEopIOVm/9YknWp4
 lxa9jnMVNEPa8NYWGDuN8pnFdswI3Ze3YXzJl5SMYk666VMoAZukmLRoyLhpu2pnvnf9syfkI
 /4d4Fi1H9V2TwxAp1y37YpKSD/Eiq4yh12EBr7+r4SJXc1RfcXLpD8HnjFG0psxU7f7gfkuvY
 +B+QQ16Ti04NInovm7kIIn2ZI4OVpADx+K/qbiYfYXBffAXfKxVqR5Hzl3p2VhWQLe1jADpCo
 uNeO5j/CME8hQLttSIW+vr7v+4/DtqQ22xYyXsOBeODdOegq0FDUZbmJeoev84Y/BElzSA1lk
 dvMellDirklaEEkcV7CTKgCXY3FJVIH2KSmcojRtScn/WLBtLEdilhlNEaEAKoXiJkQvlEcty
 XeSz1yZjAbjCwuCd0P4eZae8Hi8cWKJUCU8wZbxMBUv+g/fiSoW5fciTrEoZtVjDdiR5Rch34
 qamAbSHFL6FXkYo3R4ZfbkmcW9W/7QVl/6ujmV583F0zL0RaFWXkOYInxg+rwmRIaGh7nqPxS
 4eQlSQeo6qFtH0HtETW0YoP0gefEOIoD9v3s0/BRRPqG+CuAjZFRk7H1LJajc0AnXLmnoj4tX
 00DIunqEBBqPoGY9+E8aurCeJi/OxZ5vaku6ihv0QpTsn+bHgd6Bd7kDLQllLoZ3XiwP4wRxe
 10F9fLjt3QCgUZzjwXr4D9lLdzejHUtCUSXCX2bqLERe1q46IyI3xeiirO+pQe98FmwB0zJK9
 68BC5pnIpjs5LPS+EpAQQNl0MZA0KI508mkP1ZRVBf32oT8+uECIoQAAnm5UHxtuVmftMS4dN
 Z1tuTQSdKgCr5wEfd12V0Y0/cdOb/prgnPIhlolwJZPB2OmSKYglQU/MVUbQ6GT+AQWNn5IiL
 X+/x6ztTrL8JKzR2JdIXPxqMM7cxD9HFxEXeRzYm8oV6CIA8a4h1Z4RM4VjiNvqGAMpPL7J/x
 5cxX5b7YTS5Bn+u0YCsX4/unNfHDMT0hRZNCHGv4F4G5ed30NQKnKvzTNQNGB/0O4SZ0hqdoB
 +xH05GXaELjMiJDybgrPt9nkYRpwj7bQcNGb3RdDATEnm3Ye+/7oB9UEUPdry2Wpkcz96xYVE
 UA1MpxG5umuxuwqz7kdVsy35EhvOHlVfpFtcaKIDdDRiKfLAqt89JiDMB8zVaW5Obb6r/o16b
 yPjjT5pIV55hRJZaNL87tT2nk1AuBpAvzqkRdIDOL5JYqjMTyEl7QaoQnCQMw5XQ0Ci4u2vxg
 5zsOs0OagfiHpYYQsM0ZmbbDS+sw0GR0FaLMUWuuaCl4iL6W5gpnvsBU2qpCLTCqv807Amukz
 RERf3JDk1Fy/7BUJM0Ec0e8amsFhjj6hY8fqgp4jHmbyHRWpmxHd2VlhmUPX07kbzmbljhdv9
 h1Fh/IxbxTmljetbj9pgnwJLYDdhgTDTLpZqjAVVFWETgabcyasCPNkrqoarsm3PMzkWmKoYp
 c7qqw4w+LjLdlCfmqMAgwpXi8BvjZszI3ZvaEIJk+Fxe+unIUwxYiQ3HgYWCJPaJK6ZZ/vRsi
 Brou68YgTFMIjK4j3rhkQAlhO79ZkFtqGMbDE8OADNg3WDMxpvNyYN4nCF4dgKRiEJ+13ihpJ
 UQIGbshCS9LN4ic6u3AQqvCS8WY6OCS/PjdoI1ErfuQoUBJOJGmhnyGvK+2PnniaD30pbVYQk
 BiqZrb4mBNfyFO+IgLD6ZUX0y4ptQgPvwMUlU+7cEU8K9JiDwQTNjDUJIYW+QX6IaeNuV1KVy
 1xcYqgcryoOBe5fB+ROPGVbg2/sURzdr8+1UDuGWK6fT5io4tOXjEMBaIC96iTj0/o9ch5ZTi
 4W/h2q98K1opTVK2tbtPDDZgmSFZrwRcIvu66TOkqwtmhI192lCbw2pJTxUJDmJNcU4CoUMT5
 0zdcjjh19l58OYbuj/pDwKyCMIu4Ub5hUcG7iIUH6UCfvO9orpf8bjcAYNQNt2MoModvD5cry
 SjH1JCWsT86/2Zl6QlX6WplZnak0k3ICSMxny51aMkLwB8j8DoUUq0mKyflfOqssQ5uXnGbmh
 Sp5Mcnd15omFX8xKYi9OrllgOXTswu5hpoeV7qj1kAgRna6IwEg2oUXSwXrWBGmS7oXHXlYUV
 +FjjpNTAukMD5HNQX+PRjSsREmqy7R7glB4YmRxquOVFvowweqejGIRQv61hrlg2gD5ShUmBr
 Wa0RxDxLZy61aU43z8JmnyN8SJ32vGsM3rf8ERdgz8G/fpeNtU75pA/t2+QGl3D456HdqQj+n
 nMXTQ1yYuEJwXthfPQU7so9eWJ7EY8ZUCplkldsb3+Nzcl0KexgmvutvvDT+p+DPFBtOW+FRQ
 o3GLOgVkB+zqvV+kcuS3mOLskZMG032rGdSz+93OfiGKwRSWKYsEnpRlsbcYckkx7FjqUM334
 3JVdO/ElCWZTKIPIwDPcQfWJLK+1Ew9mIwxlZI2q9C8UDBnLXQKydDyWjHjXioDiTK8x0wGKL
 gx6O7uVSr03Vpfs/OTXrFFYvXAvIidL7G5X38F+RRx+di6Bc8npuKEEyO/806pWqTBA2L9akQ
 CnI6t9NKlD5Ls/P7WW20e6cNQKB2e4K15mqY+9yvPTmAKdS84/SrtXFhJoSK73MR6IdGb1uQ+
 CfMCGnduohWbFOVGL9iIUpvZCBVwHrGVGn41+ZmzaIN0MJS9M91GFqbn/nrl6dFKlg+tPG1jF
 uo8yTqrhq3zZyy8DKcm2G+AEKAnm7ZzQNiPs9g7CNC7yaRvn9dUyFhwJpfiXEEBiAH+LNOodx
 dZsdPJSun9tkjrifXUUTmbeYTcTupvj3mLMVcbOtFCND3RkiP1NSjC+lQRNJddUiaEh+OQtS1
 YukkbMC6JP9W6fT3dv5K1Xvh3mYn8s240HArlwR8hlqmxdXsdPRrBOGPnDGo3NZ4r2YGmBSMe
 i2MCErMj2kHA2CrBzN4wMPYFFUuwGRAuQ3HXNux0ztQjZa3iRxVRifO9cOocZoYn8Ku1JaXpU
 RWyvMUSiVOKGZaGHmcBMsL/RrxWN+m+C0ELDwv6nELnrPTn9mI+Z0Qp7K4iXkAvDnXBNFwo6j
 DJIfUv2J2BH76mEdQEou/E/DYle4v6qvz167b69zRWG569v74fdfjzGszmTBmHEkeLJklIZfC
 ZXdO5B/RkfAI/2CtKRsyCyU80wbV85clCS3HCqQ/SyauOQvwQRr7+gSqawXx6Q2uQXeBUt0M6
 kzlhmx4UuZLKWCYZFzQTSa8wMyE+66KjUEIurcwj5LZK/yaYD8CS+5oMBDxN+9FBkd0jmqrwi
 1ZtE5Kly7amp+ob7Ox46N/8h0aAHFg+Hw9fu14Xa7aD9a9f9ld976uKVyzixabdaaubwoSuiN
 6hp9JZtS/072+qcwPwrNP05/ZP7qkJwQw+O/VSfWee5UAC8avg67OfWpFifiZbEjezdnj1nRJ
 WnKGxoPRSA/uCL3i5VvQX7e8LkW2rPP8k/rzlKzQMFROLyQ5LeB2G/S4W0AiGTC/mBQvpqIYD
 DUYwTXTA+J5QrXiZ0HblsF4klThhd4bGBmCu94uNVgtp3FeglJ+U+290dbKDLn0Ic+2+r38Qw
 rRHuQqfqTyWJmKgJG7Nv0LRizFZ5hWG+Yn8fQpYE2+4X+P4HkT6UZzN25r3hF/qKAB5QanNyC
 DCmdNh6cGIDIVtz2IpqU+L09uarcWGFieAHXmHPvMZpJBO5w==

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
index f4712ad9a7..ea84c8e7f6 100644
=2D-- a/commit.c
+++ b/commit.c
@@ -743,17 +743,24 @@ void commit_list_sort_by_date(struct commit_list **l=
ist)
 struct commit *pop_most_recent_commit(struct prio_queue *queue,
 				      unsigned int mark)
 {
-	struct commit *ret =3D prio_queue_get(queue);
+	struct commit *ret =3D prio_queue_peek(queue);
+	int get_pending =3D 1;
 	struct commit_list *parents =3D ret->parents;
=20
 	while (parents) {
 		struct commit *commit =3D parents->item;
 		if (!repo_parse_commit(the_repository, commit) && !(commit->object.flag=
s & mark)) {
 			commit->object.flags |=3D mark;
-			prio_queue_put(queue, commit);
+			if (get_pending)
+				prio_queue_replace(queue, commit);
+			else
+				prio_queue_put(queue, commit);
+			get_pending =3D 0;
 		}
 		parents =3D parents->next;
 	}
+	if (get_pending)
+		prio_queue_get(queue);
 	return ret;
 }
=20
=2D-=20
2.50.1
