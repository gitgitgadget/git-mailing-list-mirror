From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 2/4] basic priority queue implementation
Date: Thu, 19 May 2011 21:47:38 -0300
Message-ID: <BANLkTikLSwWanxUksf3Ezx7uhaTR4mMiWw@mail.gmail.com>
References: <20110519212349.GA28589@sigill.intra.peff.net>
	<20110519212448.GB29584@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 20 02:47:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNDsZ-0003Qh-9r
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 02:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756809Ab1ETArl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2011 20:47:41 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55272 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053Ab1ETArk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 20:47:40 -0400
Received: by gxk21 with SMTP id 21so1144854gxk.19
        for <git@vger.kernel.org>; Thu, 19 May 2011 17:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YMMPUhTFgubmWH43NiArHB7qeutR2voO3NtCozxUI74=;
        b=h87ePGBHt/l2GCnyoy+RFWIlP4oBOCapvWdvfG6y2MrFcSRrtQDpkAoT5eBMe8FG5F
         9k6neBTk6xQYnZCy57IFMylcn/jG2XDRY4vl+ogOykiD5cUsCV7SKt6ahaZ6VWzvDBN0
         5zczz2pli4XXQpOGYrD6SVSG9VYqM013pHpaw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SZv7goidqoN6egEBB+NTXxt2WeaiHDI4q5u8Zqs5FvXDU+gpVwuM4TqLdqXWMw6d8T
         QIyN1u5Oj2jvXs/xtrGdT6h+GXn6OUr3IVBGlkp68CjtlVqJ+Qj2XmY83meruJyBkCg6
         fRpJ6UD/N/NiGqDCubbrTQw04fs3M9FkuHEzs=
Received: by 10.150.69.27 with SMTP id r27mr62137yba.114.1305852458558; Thu,
 19 May 2011 17:47:38 -0700 (PDT)
Received: by 10.151.82.7 with HTTP; Thu, 19 May 2011 17:47:38 -0700 (PDT)
In-Reply-To: <20110519212448.GB29584@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174029>

On Thu, May 19, 2011 at 6:24 PM, Jeff King <peff@peff.net> wrote:
> This can provide better algorithmic complexity for some of
> the date-sorted commit list uses, among other things.
>
> The queue is stored as a heap, allowing O(log) insertion and
> top-element removal, and O(1) peeking at the top element.
> Current commit lists are sorted linked lists, giving O(1)
> peeking and top-element removal, but O(n^2) insertion.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> =C2=A0.gitignore =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +
> =C2=A0Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A03 ++
> =C2=A0queue.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 70 +++++++++=
+++++++++++++++++++++++++++++++++++++++++++++
> =C2=A0queue.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 17 +++++++++=
++++
> =C2=A0t/t0007-queue.sh | =C2=A0 50 ++++++++++++++++++++++++++++++++++=
++++
> =C2=A0test-queue.c =C2=A0 =C2=A0 | =C2=A0 39 ++++++++++++++++++++++++=
++++++
> =C2=A06 files changed, 180 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 queue.c
> =C2=A0create mode 100644 queue.h
> =C2=A0create mode 100755 t/t0007-queue.sh
> =C2=A0create mode 100644 test-queue.c
>
> diff --git a/.gitignore b/.gitignore
> index 711fce7..179483a 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -174,6 +174,7 @@
> =C2=A0/test-obj-pool
> =C2=A0/test-parse-options
> =C2=A0/test-path-utils
> +/test-queue
> =C2=A0/test-run-command
> =C2=A0/test-sha1
> =C2=A0/test-sigchain
> diff --git a/Makefile b/Makefile
> index d09ee70..737b2d5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -422,6 +422,7 @@ TEST_PROGRAMS_NEED_X +=3D test-mktemp
> =C2=A0TEST_PROGRAMS_NEED_X +=3D test-obj-pool
> =C2=A0TEST_PROGRAMS_NEED_X +=3D test-parse-options
> =C2=A0TEST_PROGRAMS_NEED_X +=3D test-path-utils
> +TEST_PROGRAMS_NEED_X +=3D test-queue
> =C2=A0TEST_PROGRAMS_NEED_X +=3D test-run-command
> =C2=A0TEST_PROGRAMS_NEED_X +=3D test-sha1
> =C2=A0TEST_PROGRAMS_NEED_X +=3D test-sigchain
> @@ -532,6 +533,7 @@ LIB_H +=3D parse-options.h
> =C2=A0LIB_H +=3D patch-ids.h
> =C2=A0LIB_H +=3D pkt-line.h
> =C2=A0LIB_H +=3D progress.h
> +LIB_H +=3D queue.h
> =C2=A0LIB_H +=3D quote.h
> =C2=A0LIB_H +=3D reflog-walk.h
> =C2=A0LIB_H +=3D refs.h
> @@ -629,6 +631,7 @@ LIB_OBJS +=3D pkt-line.o
> =C2=A0LIB_OBJS +=3D preload-index.o
> =C2=A0LIB_OBJS +=3D pretty.o
> =C2=A0LIB_OBJS +=3D progress.o
> +LIB_OBJS +=3D queue.o
> =C2=A0LIB_OBJS +=3D quote.o
> =C2=A0LIB_OBJS +=3D reachable.o
> =C2=A0LIB_OBJS +=3D read-cache.o
> diff --git a/queue.c b/queue.c
> new file mode 100644
> index 0000000..068b559
> --- /dev/null
> +++ b/queue.c
> @@ -0,0 +1,70 @@
> +#include "queue.h"
> +#include "cache.h"
> +
> +static inline void queue_swap(struct queue *pq, unsigned i, unsigned=
 j)
> +{
> + =C2=A0 =C2=A0 =C2=A0 void *tmp =3D pq->items[i];
> + =C2=A0 =C2=A0 =C2=A0 pq->items[i] =3D pq->items[j];
> + =C2=A0 =C2=A0 =C2=A0 pq->items[j] =3D tmp;
> +}
> +
> +static void queue_heapify_up(struct queue *pq)
> +{
> + =C2=A0 =C2=A0 =C2=A0 unsigned i =3D pq->nr - 1;
> + =C2=A0 =C2=A0 =C2=A0 while (i > 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int parent =3D (i-=
1)/2;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pq->cmp(pq->it=
ems[i], pq->items[parent]) <=3D 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_swap(pq, i, =
parent);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i =3D parent;
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> +
> +void queue_insert(struct queue *pq, void *item)
> +{
> + =C2=A0 =C2=A0 =C2=A0 ALLOC_GROW(pq->items, pq->nr + 1, pq->alloc);
> + =C2=A0 =C2=A0 =C2=A0 pq->items[pq->nr++] =3D item;
> + =C2=A0 =C2=A0 =C2=A0 queue_heapify_up(pq);
> +}
> +
> +static void queue_heapify_down(struct queue *pq)
> +{
> + =C2=A0 =C2=A0 =C2=A0 unsigned i =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 while (1) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int largest =3D i,=
 left =3D 2*i + 1, right =3D 2*i + 2;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (left < pq->nr =
&&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pq->=
cmp(pq->items[left], pq->items[largest]) > 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 largest =3D left;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (right < pq->nr=
 &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pq->=
cmp(pq->items[right], pq->items[largest]) > 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 largest =3D right;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (largest =3D=3D=
 i)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_swap(pq, i, =
largest);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i =3D largest;
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> +
> +void *queue_peek(struct queue *pq)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return pq->nr ? pq->items[0] : NULL;
> +}
> +
> +void *queue_pop(struct queue *pq)
> +{
> + =C2=A0 =C2=A0 =C2=A0 void *ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!pq->nr)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
> + =C2=A0 =C2=A0 =C2=A0 ret =3D pq->items[0];
> +
> + =C2=A0 =C2=A0 =C2=A0 pq->items[0] =3D pq->items[--pq->nr];
> + =C2=A0 =C2=A0 =C2=A0 queue_heapify_down(pq);
> +
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> diff --git a/queue.h b/queue.h
> new file mode 100644
> index 0000000..fee5a51
> --- /dev/null
> +++ b/queue.h
> @@ -0,0 +1,17 @@
> +#ifndef QUEUE_H
> +#define QUEUE_H
> +
> +typedef int (*queue_comparison_func_t)(const void *, const void *);
> +
> +struct queue {
> + =C2=A0 =C2=A0 =C2=A0 queue_comparison_func_t cmp;
> + =C2=A0 =C2=A0 =C2=A0 void **items;
> + =C2=A0 =C2=A0 =C2=A0 unsigned nr;
> + =C2=A0 =C2=A0 =C2=A0 unsigned alloc;
> +};
> +
> +void queue_insert(struct queue *pq, void *item);
I'd rename this to queue_append as we add |item| to the end of the
array (like you did for sha1_array_append), opposed of inserting it at
some position/index.

> +void *queue_peek(struct queue *pq);
> +void *queue_pop(struct queue *pq);
> +
> +#endif /* QUEUE_H */
> diff --git a/t/t0007-queue.sh b/t/t0007-queue.sh
> new file mode 100755
> index 0000000..ee357bb
> --- /dev/null
> +++ b/t/t0007-queue.sh
> @@ -0,0 +1,50 @@
> +#!/bin/sh
> +
> +test_description=3D'basic tests for priority queue implementation'
> +. ./test-lib.sh
> +
> +cat >expect <<'EOF'
> +10
> +9
> +8
> +7
> +6
> +5
> +5
> +4
> +3
> +2
> +1
> +EOF
> +test_expect_success 'basic ordering' '
> + =C2=A0 =C2=A0 =C2=A0 test-queue 2 6 3 10 9 5 7 4 5 8 1 dump >actual=
 &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expect actual
> +'
> +
> +cat >expect <<'EOF'
> +3
> +5
> +4
> +6
> +2
> +1
> +EOF
> +test_expect_success 'mixed insert and pop' '
> + =C2=A0 =C2=A0 =C2=A0 test-queue 1 2 3 pop 4 5 pop pop 6 dump >actua=
l &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expect actual
> +'
> +
> +cat >expect <<'EOF'
> +2
> +1
> +NULL
> +2
> +1
> +NULL
> +EOF
> +test_expect_success 'notice empty queue' '
> + =C2=A0 =C2=A0 =C2=A0 test-queue 1 2 pop pop pop 1 2 pop pop pop >ac=
tual &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expect actual
> +'
> +
> +test_done
> diff --git a/test-queue.c b/test-queue.c
> new file mode 100644
> index 0000000..a1e92e2
> --- /dev/null
> +++ b/test-queue.c
> @@ -0,0 +1,39 @@
> +#include "cache.h"
> +#include "queue.h"
> +
> +static int intcmp(const void *va, const void *vb)
> +{
> + =C2=A0 =C2=A0 =C2=A0 const int *a =3D va, *b =3D vb;
> + =C2=A0 =C2=A0 =C2=A0 return *a - *b;
> +}
> +
> +static void show(int *v)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (!v)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf("NULL\n");
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf("%d\n", *v)=
;
> + =C2=A0 =C2=A0 =C2=A0 free(v);
> +}
> +
> +int main(int argc, char **argv)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct queue pq =3D { intcmp };
> +
> + =C2=A0 =C2=A0 =C2=A0 while (*++argv) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!strcmp(*argv,=
 "pop"))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 show(queue_pop(&pq));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (!strcmp(*=
argv, "dump")) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 int *v;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 while ((v =3D queue_pop(&pq)))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0show(v);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 int *v =3D malloc(sizeof(*v));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 *v =3D atoi(*argv);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 queue_insert(&pq, v);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> --
> 1.7.5.8.ga95ab
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
