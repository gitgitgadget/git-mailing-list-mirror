From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rev-list: preallocate object hash table in --all
 --objects
Date: Mon, 1 Apr 2013 14:33:45 -0400
Message-ID: <20130401183345.GA2779@sigill.intra.peff.net>
References: <1364563210-28813-1-git-send-email-pclouds@gmail.com>
 <20130329151208.GA22744@sigill.intra.peff.net>
 <CACsJy8AXUUz3=-pWeK-y0va-=d_-aCeNgH8rAtMZdq0PE+X97g@mail.gmail.com>
 <20130329203200.GA32155@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 20:34:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMjYj-0006VO-Ea
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 20:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759023Ab3DASdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 14:33:49 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51114 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757846Ab3DASds (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 14:33:48 -0400
Received: (qmail 1306 invoked by uid 107); 1 Apr 2013 18:35:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 01 Apr 2013 14:35:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Apr 2013 14:33:45 -0400
Content-Disposition: inline
In-Reply-To: <20130329203200.GA32155@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219699>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Mar 29, 2013 at 04:32:00PM -0400, Jeff King wrote:

> > Agreed. Although I think it's getting out of my domain. I'm not even
> > sure how many factors are involved.
> 
> There's the load factor that causes us to grow, and the growth factor of
> how aggressively we expand when we do need to grow. I fooled around with
> a few numbers and the patch below seemed to give good results. Probably
> varying both numbers over a range and graphing the result would make
> sense, but I don't have time to do it at the moment (each run takes a
> while, if I do best-of-five).

So I did that. I'm still not quite sure what it means, but here's the
data (all times are best-of-five wall-clock times to complete `git
rev-list --objects --all` on linux-2.6, in seconds).

 Load  | Growth |
Factor | Factor | Time
-------+--------+--------
 0.17  |  1.50  |  44.104
 0.17  |  2.00  |  43.373
 0.17  |  2.50  |  45.662
 0.17  |  3.00  |  44.909
 0.17  |  3.50  |  42.733
 0.17  |  4.00  |  42.659
 0.33  |  1.50  |  44.806
 0.33  |  2.00  |  44.876
 0.33  |  2.50  |  47.991
 0.33  |  3.00  |  44.940
 0.33  |  3.50  |  43.615
 0.33  |  4.00  |  43.707
 0.50  |  1.50  |  46.459
 0.50  |  2.00  |  45.872
 0.50  |  2.50  |  47.844
 0.50  |  3.00  |  47.466
 0.50  |  3.50  |  44.063
 0.50  |  4.00  |  43.807
 0.67  |  1.50  |  50.178
 0.67  |  2.00  |  48.692
 0.67  |  2.50  |  50.458
 0.67  |  3.00  |  47.307
 0.67  |  3.50  |  45.114
 0.67  |  4.00  |  45.114
 0.83  |  1.50  |  54.337
 0.83  |  2.00  |  51.286
 0.83  |  2.50  |  50.110
 0.83  |  3.00  |  47.736
 0.83  |  3.50  |  47.617
 0.83  |  4.00  |  47.282

I'm attaching a graph of the results, too, which I think makes it easier
to look at (and you probably want to look at it now, or the rest of this
won't make any sense). The interesting things I see are:

  1. The benefits of increasing the growth factor flatten out around
     3x-4x.

  2. Obviously having a smaller load factor increases efficiency.

  3. Increasing the growth factor compensates for a worse load factor
     (e.g., a growth rate of 3 performs about the same with a load
     factor of 1/2 to 5/6).

It makes sense that one could compensate for the other. Our pattern of
growth for the hash is to add a lot at first, and then more and more
frequently hit objects that we have already seen (because the number we
have seen is going up). So we do many more queries on the hash when it
is at size X than when it is at X/2.

Or another way of thinking about it is: it doesn't matter that much how
we get there, but when we reach our final size (where most of our
lookups are going to happen), how crowded is the hash table (i.e., how
many times are we going to see collisions and have to do extra
hashcmps?).

With a load factor of 0.17, we know it never goes over that. But with a
configured max load factor of 0.5, right after we double, we know the
load factor is now only 0.25; it will rise again from there, but not
necessarily even back up to 0.5 (if we never allocate again).

And I think that explains the weird spikes. Why, when we have a load
factor of 0.33, do we perform worse with a growth factor of 2.5 than
with 2? The hash should be more sparse. And I think the answer is: for
the number of objects we have, it so happens that the growth factor of 2
causes us to end up with a more sparsely populated table, and we see
a lot of queries on the table in that state. Whereas with 2.5, we do
fewer growth iterations, but end in a state that is slightly less
optimal.

Given this conjecture, I added an atexit() to determine the final state
of the hash. Here are the final states for a max load factor of 0.33,
and a few growth rates:

grow | objects | objects  | final
rate | used    | alloc    | load
-----+---------+----------+------
2    | 3005531 | 16777216 | 0.179
2.5  | 3005531 | 11920105 | 0.252
3    | 3005531 | 17006112 | 0.177

I think that supports the conjecture; the final load factor is much
worse with 2.5 than with 2 or 3. Not for any good reason; it just
happens to match the growth pattern we see given the number of objects
we have. Of course the tradeoff is that we waste more memory (37M with
8-byte pointers).

So what should we do? I don't think increasing the growth rate makes
sense. Whether we end up helping or hurting is somewhat random, as it is
really all about where we end up in terms of the final load factor,
where most of our queries happen.

We would do much better to tweak the max load factor, which ensures that
the final load factor (and the intermediate ones) is below a certain
value. Of course that comes at the cost of wasted memory. Moving from
the current load factor of 0.5 to 0.33 saves us about 1 second
processing time. But it means our memory usage jumps (in this case, it
doubles from 64M to 128M). So there are small savings to be had, but
bigger memory losses; I guess the question is how much we would care
about those memory losses (on a modern machine, using an extra 64M for
the kernel repo is not that big a deal).

And of course the other thing to do is to use a slotting mechanism that
reduces conflicts. Junio experimented with cuckoo hashing, and after
reading his attempt, I tried quadratic stepping. As I recall, neither
experiment yielded anything impressive (though I may simply have looked
at 1s speedup and considered it "not impressive"; I don't remember).

So I dunno. We are close to as good as it will get, I think. We might
steal a few percent by making a memory tradeoff, or doing something
clever with the hash stepping (cuckoo, quadratic, etc). But those are
big-ish jumps in complexity or memory use for not much gain.

My test harness patch is below in case anybody wants to play with.

-Peff

---
diff --git a/object.c b/object.c
index 20703f5..dd04009 100644
--- a/object.c
+++ b/object.c
@@ -88,12 +88,26 @@ static void grow_object_hash(void)
 	return obj;
 }
 
+static void print_hash_size(void)
+{
+	fprintf(stderr, "final hash size is %d/%d = %f\n",
+		nr_objs, obj_hash_size, ((double)nr_objs)/obj_hash_size);
+}
+
 static void grow_object_hash(void)
 {
+	static int rate;
 	int i;
-	int new_hash_size = obj_hash_size < 32 ? 32 : 2 * obj_hash_size;
+	int new_hash_size;
 	struct object **new_hash;
 
+	if (!rate) {
+		/* in units of 1/2 to give more resolution and avoid floats */
+		rate = atoi(getenv("GIT_GROW_RATE"));
+		atexit(print_hash_size);
+	}
+
+	new_hash_size = obj_hash_size < 32 ? 32 : obj_hash_size * rate / 2;
 	new_hash = xcalloc(new_hash_size, sizeof(struct object *));
 	for (i = 0; i < obj_hash_size; i++) {
 		struct object *obj = obj_hash[i];
@@ -109,6 +123,7 @@ void *create_object(const unsigned char *sha1, int type, void *o)
 void *create_object(const unsigned char *sha1, int type, void *o)
 {
 	struct object *obj = o;
+	static int factor;
 
 	obj->parsed = 0;
 	obj->used = 0;
@@ -116,7 +131,11 @@ void *create_object(const unsigned char *sha1, int type, void *o)
 	obj->flags = 0;
 	hashcpy(obj->sha1, sha1);
 
-	if (obj_hash_size - 1 <= nr_objs * 2)
+	/* in units of 1/6 to give more resolution and avoid floats */
+	if (!factor)
+		factor = atoi(getenv("GIT_LOAD_FACTOR"));
+
+	if (nr_objs + 1 > obj_hash_size * factor / 6)
 		grow_object_hash();
 
 	insert_obj_hash(obj, obj_hash, obj_hash_size);

--ew6BAiZeqk4r7MaW
Content-Type: image/png
Content-Disposition: attachment; filename="load-growth.png"
Content-Transfer-Encoding: base64

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
PS7kWwNYFfB/Fwl2ZGSjP9q0yQYmwsqDl2EVWMMceM0scQshqsB0CdiCXkPSlHD06NGivefO
nQsLC3NycnJ2dh4+fPiFCxfKqc4PhgMwVXqeRXVQ8NrCFD92NOOyGysiGHEIew2/tCS6ER2g
LUyBHyAJokv7kwzYQjy8DfdhMkyDArXvSwihEsuaCWvcuHETJkwo2mzbtq3uQ05Ojr+/v52d
XXx8PBAVFRUQEHDo0CF7e3tD1c0HwA1aA1DrmvrCTPLgc5gPpwDwwPUdxrzIGMeHBm2dLpxp
y+APJVhBLHSHcRALh2C1LN4kRF1kWQnY09NTq9WWLI+Li0tPT09LS/P29gY6derUrl27JUuW
TJ482VB1I2AxUDiK5jNwhjHQpNoDF7VUHiyH2YWptwW8DhHQ8Pf9doXzS38Ku2AjbNIbPm3I
CHCHYbAd/GETtDTRPQghLJQFdUEbkJCQoNVqddkX8Pb21mq1GzduNHROMvwAwBvwKADX4E1w
gyBYC/dNGrKo4a7Du+AGf4ZT0A02wVl444/sq88WBsFiuAQvVvASveEQPAmHoGsZz42FELVX
+QlYUZQjR44sW7Zs5syZMTExy5cvP378uImiWbRokY2NjYODQ79+/X788cei8mPHjnXq1En/
yI4dO5YTxp7CsdAxhS3gCIgAe9gJz4AXvCtzBIoSzsEU8IJP4CYEw17YDyEV+n3VquymbCk/
r56wB4ZCJvSHZVUKXAhRsxjqgr5y5cpnn30WFxd36dKlYrtatmw5fvz4CRMmNGvWrLpCCQ8P
Dw4O9vDwSE9Pj42N9ff337VrV+/evYGsrCwXFxf9g11dXTMzM0uvyE/vczRM1yv3g9nwFcTD
j/AJzIIAiIAhMkVRnXccYuBryAcNjIB34Ylqq34t+MHn0E6/1AG+KRym9SIcgn/UlJ4pIUTV
KGWYOXOmo6Ojl5fXtGnTNm/efO7cuTt37ty5c+fcuXObN2+eNm2al5eXo6PjzJkzy6qhKrKz
sz09Pf38/HSb9evXnzZtmv4B06ZNa9CgQbn1GLrxY4oyTVFcFQVFQVHcFWWaopw0xd0Ii/eT
ogQrikZRUJT6ijJaUY4YX9n0wp+pYn8cFQVFsVOU6Ypyt+RpXymKraKgKE8ryg3jry6EMI4R
ibKKyny96cknn/zwww8HDhyo0WjKCmjr1q3vv//+gQMHKp7vKy4iImLVqlW3b98G3NzchgwZ
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

--ew6BAiZeqk4r7MaW--
