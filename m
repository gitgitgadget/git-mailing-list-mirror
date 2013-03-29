From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rev-list: preallocate object hash table in --all
 --objects
Date: Fri, 29 Mar 2013 16:32:00 -0400
Message-ID: <20130329203200.GA32155@sigill.intra.peff.net>
References: <1364563210-28813-1-git-send-email-pclouds@gmail.com>
 <20130329151208.GA22744@sigill.intra.peff.net>
 <CACsJy8AXUUz3=-pWeK-y0va-=d_-aCeNgH8rAtMZdq0PE+X97g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 29 21:32:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULfyU-0003Jo-Ay
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 21:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756720Ab3C2UcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 16:32:05 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48568 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756620Ab3C2UcD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 16:32:03 -0400
Received: (qmail 10361 invoked by uid 107); 29 Mar 2013 20:33:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Mar 2013 16:33:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Mar 2013 16:32:00 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8AXUUz3=-pWeK-y0va-=d_-aCeNgH8rAtMZdq0PE+X97g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219527>

On Fri, Mar 29, 2013 at 10:29:52PM +0700, Nguyen Thai Ngoc Duy wrote:

> On Fri, Mar 29, 2013 at 10:12 PM, Jeff King <peff@peff.net> wrote:
> > This feels weirdly specific, and like we should just be tuning our hash
> > table growth better. You show a 3.2% speedup here. I was able to get a
> > 2.8% speedup just by doing this:
> 
> It also uses a lot more memory. 5.8m entries for ".. * 2" and 8.8m for
> "... * 3". Probably no big deal for modern machines..

Yeah, it will use more, but it's not going to waste more than half again
more than we already were.

> > It might be worth trying to figure out what the optimium growth rate is
> > first, which would help this use case and others. With less fragile
> > code.
> 
> Agreed. Although I think it's getting out of my domain. I'm not even
> sure how many factors are involved.

There's the load factor that causes us to grow, and the growth factor of
how aggressively we expand when we do need to grow. I fooled around with
a few numbers and the patch below seemed to give good results. Probably
varying both numbers over a range and graphing the result would make
sense, but I don't have time to do it at the moment (each run takes a
while, if I do best-of-five).

[before]
real    0m46.255s
user    0m45.812s
sys     0m0.276s

[after]
real    0m43.729s
user    0m43.204s
sys     0m0.356s

diff --git a/object.c b/object.c
index 20703f5..c3be886 100644
--- a/object.c
+++ b/object.c
@@ -91,7 +91,7 @@ static void grow_object_hash(void)
 static void grow_object_hash(void)
 {
 	int i;
-	int new_hash_size = obj_hash_size < 32 ? 32 : 2 * obj_hash_size;
+	int new_hash_size = obj_hash_size < 32 ? 32 : obj_hash_size * 5/2;
 	struct object **new_hash;
 
 	new_hash = xcalloc(new_hash_size, sizeof(struct object *));
@@ -116,7 +116,7 @@ void *create_object(const unsigned char *sha1, int type, void *o)
 	obj->flags = 0;
 	hashcpy(obj->sha1, sha1);
 
-	if (obj_hash_size - 1 <= nr_objs * 2)
+	if (nr_objs + 1 > obj_hash_size * 1/3)
 		grow_object_hash();
 
 	insert_obj_hash(obj, obj_hash, obj_hash_size);
