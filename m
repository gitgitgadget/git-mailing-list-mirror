From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] lookup_object: remove hashtable_index() and optimize
 hash_obj()
Date: Wed, 11 Sep 2013 14:48:45 -0400
Message-ID: <20130911184845.GA25386@sigill.intra.peff.net>
References: <alpine.LFD.2.03.1309101811510.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Sep 11 20:48:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJpTB-0003xV-Dt
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 20:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756955Ab3IKSst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 14:48:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:47645 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756940Ab3IKSsr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 14:48:47 -0400
Received: (qmail 32223 invoked by uid 102); 11 Sep 2013 18:48:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 11 Sep 2013 13:48:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Sep 2013 14:48:45 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.03.1309101811510.20709@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234598>

On Tue, Sep 10, 2013 at 06:17:12PM -0400, Nicolas Pitre wrote:

> hashtable_index() appears to be a close duplicate of hash_obj().
> Keep only the later and make it usable for all cases.

Thanks. This duplication has often bugged me when looking at that
hash table, but I just never actually wrote the patch.

> Also remove the modulus as this is an expansive operation.
> The size argument is always a power of 2 anyway, so a simple
> mask operation provides the same result.
> 
> On a 'git rev-list --all --objects' run this decreased the time spent
> in lookup_object from 27.5% to 24.1%.

Nice. This is a tiny bit subtle, though, as the power-of-2 growth
happens elsewhere, and we may want to tweak it later (the decorate.c
hash, for example, grows by 3/2).

Maybe it's worth squashing in one or both of the comments below as a
warning to anybody who tries to tweak it.

---
diff --git a/object.c b/object.c
index e2dae22..5f792cb 100644
--- a/object.c
+++ b/object.c
@@ -47,6 +47,7 @@ static unsigned int hash_obj(const unsigned char *sha1, unsigned int n)
 {
 	unsigned int hash;
 	memcpy(&hash, sha1, sizeof(unsigned int));
+	/* Assumes power-of-2 hash sizes in grow_object_hash */
 	return hash & (n - 1);
 }
 
@@ -94,6 +95,10 @@ static void grow_object_hash(void)
 static void grow_object_hash(void)
 {
 	int i;
+	/*
+	 * Note that this size must always be power-of-2 to match hash_obj
+	 * above.
+	 */
 	int new_hash_size = obj_hash_size < 32 ? 32 : 2 * obj_hash_size;
 	struct object **new_hash;
 
