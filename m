Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48A4188000
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591097; cv=none; b=mcWKVBsHiHazloZ+eoO4lQQuW2AxNVAAsK7N82Mu/343rIB8CWhCcRK94pUGBTwENHmG/RtUwlN4IUTQS5zZrdIm2Ex6deHZL1Orak3jJMjWXZymhkdQVIkfahnya1EdahKKszB6JMjJ9hNVnbQQV47N3RttHv3vRisSTb7vYRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591097; c=relaxed/simple;
	bh=3/7LtzZ4YdVbTDvlLtWYN9lxK+Ort/5C8XySqlR3OgM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WJaHjxxsuQMupiXr9RoADFJhfT6eiXi1OMuEJEMd2DvZf7woZ2ISE4H9agiU9gA4GEzJzvizStij2c5eBJAp7DOY8BtmYJecimnr/R/b+8h/xk4mg+udx0OQxr3u7hM3+WhK37CMzUfWH0RsojZTAhsK8q/WLD9cYyp9ksr7zas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=A8uJCHOz; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="A8uJCHOz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752591084; x=1753195884; i=l.s.r@web.de;
	bh=iwjisAsH9zXLF+JLITQGW1vRxfI77fgKehMr0LHu0ro=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=A8uJCHOz7d6MJJ7+5cfTjvnbpfnMRkwrSNM6EsIeA3lZI1nNUOX7LfNdKCjTPhnQ
	 NiCdTZwKtiWHFM5GYuys+kPb+w6croha40Alud53gHCSVaGSFFzcDmvWgbv/I3yBW
	 qkx9wX0uodokaRHoCmzsxk2AheST55VsEy728fXxzxgUxPPcEAQM2mlPSGVM329Lp
	 EUbDQMl5pisWw/1ItZpDGDHDbJzWXS4HVE7M21wfCS5rJ8mtQ419QWecmBvLakyX0
	 IWRbEewGn+g+Tp/KjCZGe0W42PebIpjfQcc/+yX+D2dC7Zvq0f/eKv9VDeVj8OFlt
	 YpTmjKnmC0LTaHjrkQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjxiM-1v4Nu62zma-00ZdlP; Tue, 15
 Jul 2025 16:51:22 +0200
Message-ID: <cbabed69-b44a-4920-9a56-e81b404be2de@web.de>
Date: Tue, 15 Jul 2025 16:51:22 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/3] prio-queue: add prio_queue_replace()
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
Content-Language: en-US
In-Reply-To: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:comzHgZjlyLgk8Lyj0Pe3MynIeiFZa3PlYNDsxmEV6ZUggDYdEL
 yXlgvqlFtTNInCALIbvpv7Nq06lPwt2q/3kaAg/EvxceAf9M0toTjiSONvGHhO0F+lu3ve8
 c8seOGQJm5u9XirzOCDlXM9bXVGpFkSnbQEuO0PXMMr41JwjrOjJs05ipzJESpThJH2tzsw
 hOP5pCTdlhjAnb1LYIfkQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LSWv1AqHHPM=;jpEih7pNz4RfyLH089//rbIGCeh
 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
 VanSyyqReN0gTaW9Ewa81xGnX8l30eyI=

Add a function to replace the top element of the queue that basically
does the same as prio_queue_get() followed by prio_queue_put(), but
without the work by prio_queue_get() to rebalance the heap.  It can be
used to optimize loops that get one element and then immediately add
another one.  That's common e.g., with commit history traversal, where
we get out a commit and then put in its parents.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 prio-queue.c                | 45 ++++++++++++++++++++++++++-----------
 prio-queue.h                |  8 +++++++
 t/unit-tests/u-prio-queue.c | 23 +++++++++++++++++++
 3 files changed, 63 insertions(+), 13 deletions(-)

diff --git a/prio-queue.c b/prio-queue.c
index ec33ac27db..9748528ce6 100644
=2D-- a/prio-queue.c
+++ b/prio-queue.c
@@ -58,22 +58,10 @@ void prio_queue_put(struct prio_queue *queue, void *th=
ing)
 	}
 }
=20
-void *prio_queue_get(struct prio_queue *queue)
+static void sift_down_root(struct prio_queue *queue)
 {
-	void *result;
 	size_t ix, child;
=20
-	if (!queue->nr)
-		return NULL;
-	if (!queue->compare)
-		return queue->array[--queue->nr].data; /* LIFO */
-
-	result =3D queue->array[0].data;
-	if (!--queue->nr)
-		return result;
-
-	queue->array[0] =3D queue->array[queue->nr];
-
 	/* Push down the one at the root */
 	for (ix =3D 0; ix * 2 + 1 < queue->nr; ix =3D child) {
 		child =3D ix * 2 + 1; /* left */
@@ -86,6 +74,23 @@ void *prio_queue_get(struct prio_queue *queue)
=20
 		swap(queue, child, ix);
 	}
+}
+
+void *prio_queue_get(struct prio_queue *queue)
+{
+	void *result;
+
+	if (!queue->nr)
+		return NULL;
+	if (!queue->compare)
+		return queue->array[--queue->nr].data; /* LIFO */
+
+	result =3D queue->array[0].data;
+	if (!--queue->nr)
+		return result;
+
+	queue->array[0] =3D queue->array[queue->nr];
+	sift_down_root(queue);
 	return result;
 }
=20
@@ -97,3 +102,17 @@ void *prio_queue_peek(struct prio_queue *queue)
 		return queue->array[queue->nr - 1].data;
 	return queue->array[0].data;
 }
+
+void prio_queue_replace(struct prio_queue *queue, void *thing)
+{
+	if (!queue->nr) {
+		prio_queue_put(queue, thing);
+	} else if (!queue->compare) {
+		queue->array[queue->nr - 1].ctr =3D queue->insertion_ctr++;
+		queue->array[queue->nr - 1].data =3D thing;
+	} else {
+		queue->array[0].ctr =3D queue->insertion_ctr++;
+		queue->array[0].data =3D thing;
+		sift_down_root(queue);
+	}
+}
diff --git a/prio-queue.h b/prio-queue.h
index 38d032636d..da7fad2f1f 100644
=2D-- a/prio-queue.h
+++ b/prio-queue.h
@@ -52,6 +52,14 @@ void *prio_queue_get(struct prio_queue *);
  */
 void *prio_queue_peek(struct prio_queue *);
=20
+/*
+ * Replace the "thing" that compares the smallest with a new "thing",
+ * like prio_queue_get()+prio_queue_put() would do, but in a more
+ * efficient way.  Does the same as prio_queue_put() if the queue is
+ * empty.
+ */
+void prio_queue_replace(struct prio_queue *queue, void *thing);
+
 void clear_prio_queue(struct prio_queue *);
=20
 /* Reverse the LIFO elements */
diff --git a/t/unit-tests/u-prio-queue.c b/t/unit-tests/u-prio-queue.c
index 145e689c9c..63e58114ae 100644
=2D-- a/t/unit-tests/u-prio-queue.c
+++ b/t/unit-tests/u-prio-queue.c
@@ -13,6 +13,7 @@ static int intcmp(const void *va, const void *vb, void *=
data UNUSED)
 #define STACK	 -3
 #define GET	 -4
 #define REVERSE  -5
+#define REPLACE  -6
=20
 static int show(int *v)
 {
@@ -51,6 +52,15 @@ static void test_prio_queue(int *input, size_t input_si=
ze,
 		case REVERSE:
 			prio_queue_reverse(&pq);
 			break;
+		case REPLACE:
+			peek =3D prio_queue_peek(&pq);
+			cl_assert(i + 1 < input_size);
+			cl_assert(input[i + 1] >=3D 0);
+			cl_assert(j < result_size);
+			cl_assert_equal_i(result[j], show(peek));
+			j++;
+			prio_queue_replace(&pq, &input[++i]);
+			break;
 		default:
 			prio_queue_put(&pq, &input[i]);
 			break;
@@ -81,6 +91,13 @@ void test_prio_queue__empty(void)
 		   ((int []){ 1, 2, MISSING, 1, 2, MISSING }));
 }
=20
+void test_prio_queue__replace(void)
+{
+	TEST_INPUT(((int []){ REPLACE, 6, 2, 4, REPLACE, 5, 7, GET,
+			      REPLACE, 1, DUMP }),
+		   ((int []){ MISSING, 2, 4, 5, 1, 6, 7 }));
+}
+
 void test_prio_queue__stack(void)
 {
 	TEST_INPUT(((int []){ STACK, 8, 1, 5, 4, 6, 2, 3, DUMP }),
@@ -92,3 +109,9 @@ void test_prio_queue__reverse_stack(void)
 	TEST_INPUT(((int []){ STACK, 1, 2, 3, 4, 5, 6, REVERSE, DUMP }),
 		   ((int []){ 1, 2, 3, 4, 5, 6 }));
 }
+
+void test_prio_queue__replace_stack(void)
+{
+	TEST_INPUT(((int []){ STACK, 8, 1, 5, REPLACE, 4, 6, 2, 3, DUMP }),
+		   ((int []){ 5, 3, 2, 6, 4, 1, 8 }));
+}
=2D-=20
2.50.1
