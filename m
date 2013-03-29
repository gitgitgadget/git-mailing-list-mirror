From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rev-list: preallocate object hash table in --all
 --objects
Date: Fri, 29 Mar 2013 11:12:08 -0400
Message-ID: <20130329151208.GA22744@sigill.intra.peff.net>
References: <1364563210-28813-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 29 16:12:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULayy-00079r-72
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 16:12:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754712Ab3C2PMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 11:12:16 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48364 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754487Ab3C2PMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 11:12:16 -0400
Received: (qmail 6055 invoked by uid 107); 29 Mar 2013 15:14:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Mar 2013 11:14:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Mar 2013 11:12:08 -0400
Content-Disposition: inline
In-Reply-To: <1364563210-28813-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219501>

On Fri, Mar 29, 2013 at 08:20:10PM +0700, Nguyen Thai Ngoc Duy wrote:

> Every time the object hash table grows, all entries must be
> rearranged. The few last times could be really expensive when the
> table contains a lot of entries.
> 
> When we do "--all --objects" we know in advance we may need to hash
> all objects. Just prepare the hash table big enough, so there won't be
> any resizing later on. The hash table is resized a couple times before
> prehash_objects() is called. But that's ok because there aren't many
> objects by that time (unless you have tons of refs, likely tags..)
> 
> On linux-2.6.git:
> 
>         before       after
> real    0m34.402s    0m33.288s
> user    0m34.111s    0m32.863s
> sys     0m0.205s     0m0.352s

This feels weirdly specific, and like we should just be tuning our hash
table growth better. You show a 3.2% speedup here. I was able to get a
2.8% speedup just by doing this:

diff --git a/object.c b/object.c
index 20703f5..8e5e12c 100644
--- a/object.c
+++ b/object.c
@@ -91,7 +91,7 @@ static void grow_object_hash(void)
 static void grow_object_hash(void)
 {
 	int i;
-	int new_hash_size = obj_hash_size < 32 ? 32 : 2 * obj_hash_size;
+	int new_hash_size = obj_hash_size < 32 ? 32 : 3 * obj_hash_size;
 	struct object **new_hash;
 
 	new_hash = xcalloc(new_hash_size, sizeof(struct object *));

It might be worth trying to figure out what the optimium growth rate is
first, which would help this use case and others. With less fragile
code.

-Peff
