Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F0E29993A
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752831562; cv=none; b=DZrM1KfjCvG7qz5d+2wpFfrUvN5WC34FpZ1lQnF9TV2kE3KN0rt3nFFpVXAPSQIuZfgOXZglnmKSJBt2M8w0x1zBc2s/RpdNuwl8WSzN02ju8fZbI7UQeyv5ufDIHrXE8DY61uLDm5zdYtyx6wHIdObUxVXo+007Q+700TlwWMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752831562; c=relaxed/simple;
	bh=3/7LtzZ4YdVbTDvlLtWYN9lxK+Ort/5C8XySqlR3OgM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gt7xzzsvVk9571mdTt0lnzHKIy/nZbfRKV762bm4hTzGtn2L4YbzSs0tgfol0hYwtn8fPsTCDHum/Srsu8U01dNRh5Wn9wNcnOukgpFEBT+2Z6MbPpX1A8HkTDcCA80ZO3m8U3sF89BtdZRYChwi8hicV9Sq8/3g14iHiQhN0UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=WOtrWFTq; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="WOtrWFTq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752831555; x=1753436355; i=l.s.r@web.de;
	bh=iwjisAsH9zXLF+JLITQGW1vRxfI77fgKehMr0LHu0ro=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WOtrWFTqhM2ONbFI7A1mQUVF/daM6nBi+54N09EWfVI5ix/sIpWXF4QmWBCqJQvt
	 SeO7hdzPB4UYEeFIXAMZIwqOgV1TrVQgqNOaZs3/QUsw4owRdUV+QYvzuTD7lT5O+
	 v4e4u4E2UqQ5UnusIDzUtf8+ilblFAru4odPtUL9A44Y5f7tSjaHscz5xwFzYAOFP
	 U1gWTaDwDfeF0LfUfnH8oSbX/zK9AU0TR2W4TlsyeEw6LvDLwMno4mBTR8Abh3iSm
	 tAZISUHy93hEya7/0nYsMO5BYRLCLA6zX+/5puUHvDzNs+s2HLlwfF3dBCdfXdBki
	 Drsao7NTdV2hnGai9Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjxiW-1v155u3DR2-00gnHf; Fri, 18
 Jul 2025 11:39:14 +0200
Message-ID: <67346fb7-36eb-4682-ade1-4baee8c026e3@web.de>
Date: Fri, 18 Jul 2025 11:39:14 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/3] prio-queue: add prio_queue_replace()
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
X-Provags-ID: V03:K1:g2uw+BcP3pvoj1KA/HTdhD8m+F/AG/pTRgzSZj8i4tFvCw3kqwR
 I1UUYrZwlI8r8tkPPvXU0PJAJgWITJCMEBcVudQMkYVqdfxQNn7DXN3xPFnZfUaPCAAIYSI
 W5TFhfrqV909KtSYyPySZH0kmsR+J9sUQBHgpPzvRehjsa0UBK0osuz0JXG+q386E403ALL
 DMQAHvSFeWjEMy29raM9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MaFXr2qdtgE=;QkLcaAzFId0Sdg5Q390q2MyHHOV
 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
 EwuiOniAyKHEd7Jvubi12nVcSx4q93w5dfn

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
