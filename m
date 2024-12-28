Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBFF635
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735379029; cv=none; b=HjOtukMoeUKPiqo4mFhijHF6vE97s6J/m6FIIJRiOUX9q/Rnmg2S14b18mB7+Luz7SxmSz0BNKwE0cCPzeIzHM1pvAFJtsH8isLmuEZay7bX4xqUGkSHvae48ut0Elhh5tbaoUcCU7Tp4zBH9oBGAIFgXHF6QNVqyUYgP5YJIYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735379029; c=relaxed/simple;
	bh=h8xhGxgkC25Ypasq04KsyChz8Nki7rcTqdKzylahrhU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cES1hinugGqxlj1NJ4MWBYMrMGWZ3ERJG7Q4YucJdDQEWpHYB2Lb5ciENYOBc/IpGdeD6c+r3soZxwjI2HcyDpoPM+QHQwjIlGwWx+NvYKjXSjZbUNGjQ8JTg0GBIqePMO7mYsvwEy6m1zhASlYbz7wykBC0DTYP25lYhNlH8og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=l2gKhMue; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="l2gKhMue"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1735379021; x=1735983821; i=l.s.r@web.de;
	bh=Ty2EktHQsAocKN80L7uv3IsK19zXhH8dHKbhzqnnBVU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=l2gKhMueh4rn1np2plzlhX3UbiqxLgVtc0828hLZT6v4KcjdFP3EWvSKZ1F3uFOd
	 f6qtyaCDTHVn9w6Delxmx9vVs7YHMeAioGaZQCcI6h+igmukxaReNM2oG283VJ3gE
	 9t/L/MiSDcw6CeIi8RLUkG1RIPVQ6hFQWcOGMiTZiZiuQQo51LCmfD4P1BQ5DJhoE
	 grh8ZABqB0ism8EJs0yo1EqzpNOTjBD4H2GIuPykRGAQHFyALCpeoeUNt74KoxEcb
	 I3ZigkIVI08g1RG8k9Bm1+s4zoDOsCtYM6YsAS4yeaDmU6/L2E5tWvRZEpEv8Rahs
	 otjhMt15URz1Wf2FKg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.20.45]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3ouq-1ta6I93M2a-012Oqw; Sat, 28
 Dec 2024 10:43:41 +0100
Message-ID: <f4677194-0a3a-4f07-b003-c0295b51c100@web.de>
Date: Sat, 28 Dec 2024 10:43:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 0/4] reftable: fix realloc error handling
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
References: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
Content-Language: en-US
In-Reply-To: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7c7L4xaN0j/HEhUZuaBQnLlodIESciXrujRGjPnMRz8MbpiuuZm
 zV9ory61WF7L+EKGL+q1rrcxz6GIAV2iXP0fcRO5soxA26uFDPQmjnKXJamhLK4/+JuDxTw
 C7kRLNQgmRwduiWcDa0rfDTaw7J8CQLPqisLf8zrGE3VvLAPzAGEgRnAVGjXUiuuQKGoQck
 4uF3D6St78W6RlKi0u5tQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uQ3HAywTxRQ=;nOxMeU8eW+6g2DUByT5NnAl+deU
 nbwR6bMjZKOppIskValUcwqlHvPgPL4ml5pKaytVvR35wE4P2lNcJzWXaYStT/zGFOXoRX+gm
 0qhncZJOLdMzC4hGHRtNw39Id4LHJuImvgOdXsoOxaihDka2owa0GsVIogzvJQaxOD0onXcgi
 61tWLf4FBa8p3ge+Y/vDgFcs6N3AL6GL6jzG/ApTExUvDMT9Ne1pBDXE78SWN1+VxHKr5+uFv
 OBpIV0GrCl+vm581H0w1LzV9Dla6GCjVIUflL7zvtpPXYRVSDWR7N9GSQ+wHwI2/8aRB5rZfi
 fLqVRYn6Eq5GSA+16LTub9tzO1goJM8ku0cYOxmqdWaE3AGraSZDAf5jjvBYDeZvFr7RSgdV1
 sNCGKnYEgs9lR/ZyN5EhQjowd6xXvPG75bvRUUSoZdh5N5iXDqbchZJOqjcOfYMKw40js2mgd
 9ETVRZ6PFnJwV26icarjml/B1YPLv9e6cMIEqdeWrA9q6sf1shuUq6PrjUD938WGm4wUCebtV
 AnxXsFVmRHvvQZawR+chFqfyo4S+C9Ht+Ubq6BoxFWRjPPUpNgxYXPG1GjrUwQ51w1A5pfhTB
 Fmk1I8lodAxRdl0SOPjEXacIBW2AHnC9ogKs5cKIWBSXgC31EY4KDgLBjEk9MtwXfx8pZwLUA
 nE7CkqQSaMdDZWU48PPwkmEt6Djmfxrmh1IZKdmdQyc6VY1sdh3QtfVSzMLhtV2Vg0OCy7fuK
 aWpGnX+qgWcFYzfMD9wGhsSe3X1c4jP4A7tpeDPYggorXIc+V0ha9RsxOJgEjTCeRMhMh81n7
 QMoFHQQANXtBFAJBsW9TSK4cDqxuBlZxdDqRSj/NsvU3gn4X/yX2inZyi6HV5KPqtJcepWlX9
 p2wegG7PYMaHq8v4W96ezwJzmTdHIquCL7usgkqGrEZsqVTXfbcHskak8CafaRcq/Pu38T5RT
 Cxfa7F1VQ7qUfx8b9cWMIBvE5IK4d/8ygS0VKZrOVc1z5wUGO4V41fCCswCv02Tf0eV47NxSc
 3q9FIspbaDETf3oV6y2qORvEj/PXO0oolVyuxVqffP9JYIMhGg1h9VIOUzoTWDljqZ6W7vSmM
 ikA0CQi3A=

Changes since v1:
- added unit tests
- explicitly set pointer to NULL on REFTABLE_ALLOC_GROW_OR_NULL failure
  in patch 2; omission found by unit test

  reftable: avoid leaks on realloc error
  reftable: fix allocation count on realloc error
  reftable: handle realloc error in parse_names()
  t-reftable-merged: handle realloc errors

 reftable/basics.c                | 14 +++-----
 reftable/basics.h                | 41 ++++++++++++++++++-----
 reftable/block.c                 | 10 +++---
 reftable/pq.c                    |  2 +-
 reftable/record.c                | 12 +++----
 reftable/stack.c                 |  8 +++--
 reftable/writer.c                |  5 +--
 t/unit-tests/t-reftable-basics.c | 56 ++++++++++++++++++++++++++++++++
 t/unit-tests/t-reftable-merged.c |  4 +--
 9 files changed, 116 insertions(+), 36 deletions(-)

Range-diff against v1:
1:  b41547720d ! 1:  b3cad92038 reftable: avoid leaks on realloc error
    @@ reftable/writer.c: static int writer_flush_nonempty_block(struct re=
ftable_writer
      	if (!w->index)
      		return REFTABLE_OUT_OF_MEMORY_ERROR;

    +
    + ## t/unit-tests/t-reftable-basics.c ##
    +@@ t/unit-tests/t-reftable-basics.c: static int integer_needle_lesseq=
(size_t i, void *_args)
    + 	return args->needle <=3D args->haystack[i];
    + }
    +
    ++static void *realloc_stub(void *p UNUSED, size_t size UNUSED)
    ++{
    ++	return NULL;
    ++}
    ++
    + int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
    + {
    + 	if_test ("binary search with binsearch works") {
    +@@ t/unit-tests/t-reftable-basics.c: int cmd_main(int argc UNUSED, co=
nst char *argv[] UNUSED)
    + 		check_int(in, =3D=3D, out);
    + 	}
    +
    ++	if_test ("REFTABLE_ALLOC_GROW_OR_NULL works") {
    ++		int *arr =3D NULL;
    ++		size_t alloc =3D 0, old_alloc;
    ++
    ++		REFTABLE_ALLOC_GROW_OR_NULL(arr, 1, alloc);
    ++		check(arr !=3D NULL);
    ++		check_uint(alloc, >=3D, 1);
    ++		arr[0] =3D 42;
    ++
    ++		old_alloc =3D alloc;
    ++		REFTABLE_ALLOC_GROW_OR_NULL(arr, old_alloc + 1, alloc);
    ++		check(arr !=3D NULL);
    ++		check_uint(alloc, >, old_alloc);
    ++		arr[alloc - 1] =3D 42;
    ++
    ++		old_alloc =3D alloc;
    ++		reftable_set_alloc(malloc, realloc_stub, free);
    ++		REFTABLE_ALLOC_GROW_OR_NULL(arr, old_alloc + 1, alloc);
    ++		check(arr =3D=3D NULL);
    ++		check_uint(alloc, =3D=3D, 0);
    ++		reftable_set_alloc(malloc, realloc, free);
    ++
    ++		reftable_free(arr);
    ++	}
    ++
    + 	return test_done();
    + }
2:  bde2f0e4a5 ! 2:  62a1042825 reftable: fix allocation count on realloc =
error
    @@ reftable/basics.h: char *reftable_strdup(const char *str);
     -		reftable_free(reftable_alloc_grow_or_null_orig_ptr); \
     +	size_t reftable_alloc_grow_or_null_alloc =3D alloc; \
     +	if (REFTABLE_ALLOC_GROW((x), (nr), reftable_alloc_grow_or_null_allo=
c)) { \
    -+		reftable_free(x); \
    ++		REFTABLE_FREE_AND_NULL(x); \
      		alloc =3D 0; \
     +	} else { \
     +		alloc =3D reftable_alloc_grow_or_null_alloc; \
      	} \
      } while (0)

    +
    + ## t/unit-tests/t-reftable-basics.c ##
    +@@ t/unit-tests/t-reftable-basics.c: int cmd_main(int argc UNUSED, co=
nst char *argv[] UNUSED)
    + 		check_int(in, =3D=3D, out);
    + 	}
    +
    ++	if_test ("REFTABLE_ALLOC_GROW works") {
    ++		int *arr =3D NULL, *old_arr;
    ++		size_t alloc =3D 0, old_alloc;
    ++
    ++		check(!REFTABLE_ALLOC_GROW(arr, 1, alloc));
    ++		check(arr !=3D NULL);
    ++		check_uint(alloc, >=3D, 1);
    ++		arr[0] =3D 42;
    ++
    ++		old_alloc =3D alloc;
    ++		old_arr =3D arr;
    ++		reftable_set_alloc(malloc, realloc_stub, free);
    ++		check(REFTABLE_ALLOC_GROW(arr, old_alloc + 1, alloc));
    ++		check(arr =3D=3D old_arr);
    ++		check_uint(alloc, =3D=3D, old_alloc);
    ++
    ++		old_alloc =3D alloc;
    ++		reftable_set_alloc(malloc, realloc, free);
    ++		check(!REFTABLE_ALLOC_GROW(arr, old_alloc + 1, alloc));
    ++		check(arr !=3D NULL);
    ++		check_uint(alloc, >, old_alloc);
    ++		arr[alloc - 1] =3D 42;
    ++
    ++		reftable_free(arr);
    ++	}
    ++
    + 	if_test ("REFTABLE_ALLOC_GROW_OR_NULL works") {
    + 		int *arr =3D NULL;
    + 		size_t alloc =3D 0, old_alloc;
3:  7c9f044813 =3D 3:  ed1a292622 reftable: handle realloc error in parse_=
names()
4:  3d9493f48a =3D 4:  916032657e t-reftable-merged: handle realloc errors
=2D-
2.47.1

