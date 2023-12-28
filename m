Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3656F10787
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 19:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="H8gC5d6x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703791147; x=1704395947; i=l.s.r@web.de;
	bh=XBP6ydNjBiKyA4hhIJ9aOneZj9ZiiAvvExpthEh66CE=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=H8gC5d6xejB9Ew3lfcDZTc6aj4dCrkNZOVu9fzZA8L1meGVJkTIMT2bXLcuRl87x
	 QxV8NaMCIsINkKAqiBRWVfD6LuPwydTyQomg24P+vM6BFmgs4LoS68kwy3JrHZ/Qg
	 +DnfNDYM9yvFWJOd3lZ1BBoFVSRcg5AC8bVzrWRhhzhecEykKfwBLg97oxz3euVrN
	 omIo2V72kxZXqwPFfNQexu905kcKrFKYBJVkv+O1yHEfQ1nm+ukcl6CTUDDVO/vvP
	 rQirg7fO238oYNK6h37T38m53qIvW6sco8taauIWriTwCr1ajWEzYaJpM8qsAbQAP
	 bc1Gu3Gie5XHmAEd9Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mq1CC-1qxOf31xWE-00nIRs; Thu, 28
 Dec 2023 20:19:07 +0100
Message-ID: <1c39c0e7-05b2-4726-a90c-f78df4356a41@web.de>
Date: Thu, 28 Dec 2023 20:19:06 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] mem-pool: fix big allocations
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Jameson Miller <jamill@microsoft.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Elijah Newren <newren@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <fa89d269-1a23-4ed6-bebc-30c0b629f444@web.de>
In-Reply-To: <fa89d269-1a23-4ed6-bebc-30c0b629f444@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ogzzd3bSDM8opK6rWAlwY6hJCaZRXjAnnD5vmOuOkTl1jbPjEql
 ATt2RiWrQiiR9aPJXkB+j1FPqZ8mds4E7OCAk1XBd8Fsf82AliKPdyqIBwBAXR6BIRpztMK
 rt2bz33Ho2VT0EhfKpUiwCBU4dOPhds1ro4cuHq7Fy8qPdZttlTJvdFQ/6221LZAvqj85Zr
 CmzJrB44YUZ2bUNvhmh0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IkBQqzJw+Ck=;JmAT1caCHZkh9F/A+vMv7TasTzh
 UXhQSLTftpgBkTZUsNG6wXhywGcY0ggQfczM9xSRmrQ+yKy7PY9up+KuzaLwB8AQ0dEGmql26
 7yqXgTvXlaZxKaPnxAgxhMH2BxoctKOCYCE2mpfa1jq8hxHdrk04wuwa3PqY03kY04ebsHOik
 EpGoBlGqj3rZZpr5dlaOQ6VDL4zBIbK54ibFU7mxYzLmCse4h6kga45QouAGvzYM4vFikasmv
 k96KhKiT8E+44HN4H+cCxo4gsTkFevGZV2iwyk62pQmOrJkz2rv39Agn6qUl5bJSMaj8C2wdu
 XXXsm6G1fDhs/I0TmXrDKpTx3LMHBVBpazpZ8ouTWx6NEajT+qiAK3NvRZ1x2TPZGJO5Rw5bU
 RiJ/sv5UqlFXVJWMEjXCFf3tF4BjCUQ5OLutQ+xWagTwvedK+W/75hnFZ8JnX7WVekA4+GRTb
 TIPE72mzZN+7ir4d74TK8MYgnXNJCzduhTqNU5eoyJMYi2/v1xuZAfgtOtFytFEkHAIZCzLJT
 X7R8tJl7wzG5N3vEY+KQFEU4NI5t8Hqov5I2FUqOkOnqXmNZ2cceh1fkKKTAXBBMcyfjCP6o/
 +lh3BF6535h7KE7oC5TarIcaVJTuIyGgxqQF9FD+AdZrJwg9EzjJBq7XkAv2NOAaXQiKzz580
 XTYN6rc4VtTFniINYxz74rvI5gS1w4tnlZ5l3PXq5WlZ2cdrVvedn/Q6dZ+8fRE/tMnbEl7oW
 b3F3mPHmfDvz8SJk2hwv3miqJjU3b7U+dYKO26ZEoe35gQ8AJJQNrmuADaqa/G1cP0+nY4An0
 Hu+X6QxJ1QI37sNsKLL3rxOcr3eMv/UCWJWh+qxzKAPJCru1WSj4b7sajPLHS3D2sJpvO5ny1
 e/Jx4IGOKvAcp8PJ4XQL3kuQMVURW7JA2A/fJU6Hdvr+wrEEYvDLcggk92IgblhYBmPudZHWg
 ZI1g/w==

Memory pool allocations that require a new block and would fill at
least half of it are handled specially.  Before 158dfeff3d (mem-pool:
add life cycle management functions, 2018-07-02) they used to be
allocated outside of the pool.  This patch made mem_pool_alloc() create
a bespoke block instead, to allow releasing it when the pool gets
discarded.

Unfortunately mem_pool_alloc() returns a pointer to the start of such a
bespoke block, i.e. to the struct mp_block at its top.  When the caller
writes to it, the management information gets corrupted.  This affects
mem_pool_discard() and -- if there are no other blocks in the pool --
also mem_pool_alloc().

Return the payload pointer of bespoke blocks, just like for smaller
allocations, to protect the management struct.

Also update next_free to mark the block as full.  This is only strictly
necessary for the first allocated block, because subsequent ones are
inserted after the current block and never considered for further
allocations, but it's easier to just do it in all cases.

Add a basic unit test to demonstrate the issue by using
mem_pool_calloc() with a tiny block size, which forces the creation of a
bespoke block.

Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Changes since v1:
- simply use check() instead of a custom check_ptr() macro
- drop unnecessary comparison of next_free and end pointers

Interdiff against v1:
  diff --git a/t/unit-tests/t-mem-pool.c b/t/unit-tests/t-mem-pool.c
  index 2295779b0b..a0d57df761 100644
  --- a/t/unit-tests/t-mem-pool.c
  +++ b/t/unit-tests/t-mem-pool.c
  @@ -1,8 +1,6 @@
   #include "test-lib.h"
   #include "mem-pool.h"

  -#define check_ptr(a, op, b) check_int(((a) op (b)), =3D=3D, 1)
  -
   static void setup_static(void (*f)(struct mem_pool *), size_t block_all=
oc)
   {
   	struct mem_pool pool =3D { .block_alloc =3D block_alloc };
  @@ -16,11 +14,10 @@ static void t_calloc_100(struct mem_pool *pool)
   	char *buffer =3D mem_pool_calloc(pool, 1, size);
   	for (size_t i =3D 0; i < size; i++)
   		check_int(buffer[i], =3D=3D, 0);
  -	if (!check_ptr(pool->mp_block, !=3D, NULL))
  +	if (!check(pool->mp_block !=3D NULL))
   		return;
  -	check_ptr(pool->mp_block->next_free, <=3D, pool->mp_block->end);
  -	check_ptr(pool->mp_block->next_free, !=3D, NULL);
  -	check_ptr(pool->mp_block->end, !=3D, NULL);
  +	check(pool->mp_block->next_free !=3D NULL);
  +	check(pool->mp_block->end !=3D NULL);
   }

   int cmd_main(int argc, const char **argv)

 Makefile                  |  1 +
 mem-pool.c                |  6 +++---
 t/unit-tests/t-mem-pool.c | 31 +++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 3 deletions(-)
 create mode 100644 t/unit-tests/t-mem-pool.c

diff --git a/Makefile b/Makefile
index 88ba7a3c51..15990ff312 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -1340,6 +1340,7 @@ THIRD_PARTY_SOURCES +=3D sha1collisiondetection/%
 THIRD_PARTY_SOURCES +=3D sha1dc/%

 UNIT_TEST_PROGRAMS +=3D t-basic
+UNIT_TEST_PROGRAMS +=3D t-mem-pool
 UNIT_TEST_PROGRAMS +=3D t-strbuf
 UNIT_TEST_PROGS =3D $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAM=
S))
 UNIT_TEST_OBJS =3D $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS=
))
diff --git a/mem-pool.c b/mem-pool.c
index c34846d176..e8d976c3ee 100644
=2D-- a/mem-pool.c
+++ b/mem-pool.c
@@ -99,9 +99,9 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t len)

 	if (!p) {
 		if (len >=3D (pool->block_alloc / 2))
-			return mem_pool_alloc_block(pool, len, pool->mp_block);
-
-		p =3D mem_pool_alloc_block(pool, pool->block_alloc, NULL);
+			p =3D mem_pool_alloc_block(pool, len, pool->mp_block);
+		else
+			p =3D mem_pool_alloc_block(pool, pool->block_alloc, NULL);
 	}

 	r =3D p->next_free;
diff --git a/t/unit-tests/t-mem-pool.c b/t/unit-tests/t-mem-pool.c
new file mode 100644
index 0000000000..a0d57df761
=2D-- /dev/null
+++ b/t/unit-tests/t-mem-pool.c
@@ -0,0 +1,31 @@
+#include "test-lib.h"
+#include "mem-pool.h"
+
+static void setup_static(void (*f)(struct mem_pool *), size_t block_alloc=
)
+{
+	struct mem_pool pool =3D { .block_alloc =3D block_alloc };
+	f(&pool);
+	mem_pool_discard(&pool, 0);
+}
+
+static void t_calloc_100(struct mem_pool *pool)
+{
+	size_t size =3D 100;
+	char *buffer =3D mem_pool_calloc(pool, 1, size);
+	for (size_t i =3D 0; i < size; i++)
+		check_int(buffer[i], =3D=3D, 0);
+	if (!check(pool->mp_block !=3D NULL))
+		return;
+	check(pool->mp_block->next_free !=3D NULL);
+	check(pool->mp_block->end !=3D NULL);
+}
+
+int cmd_main(int argc, const char **argv)
+{
+	TEST(setup_static(t_calloc_100, 1024 * 1024),
+	     "mem_pool_calloc returns 100 zeroed bytes with big block");
+	TEST(setup_static(t_calloc_100, 1),
+	     "mem_pool_calloc returns 100 zeroed bytes with tiny block");
+
+	return test_done();
+}
=2D-
2.43.0
