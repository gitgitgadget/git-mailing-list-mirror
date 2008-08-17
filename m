From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/9] Narrow/Sparse checkout round 3: "easy mode"
Date: Sat, 16 Aug 2008 23:10:27 -0700
Message-ID: <7v3al49nos.fsf@gitster.siamese.dyndns.org>
References: <20080815142439.GA10609@laptop>
 <7v1w0pdze0.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0808162212y756465a5ib7ce3a8849765033@mail.gmail.com>
 <7vbpzs9om7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 08:12:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUbUf-0007pM-68
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 08:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbYHQGKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 02:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbYHQGKg
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 02:10:36 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41011 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbYHQGKg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 02:10:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DC6E75CF3A;
	Sun, 17 Aug 2008 02:10:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E23505CF39; Sun, 17 Aug 2008 02:10:29 -0400 (EDT)
In-Reply-To: <7vbpzs9om7.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 16 Aug 2008 22:50:24 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3325E6D4-6C23-11DD-844C-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92581>

Junio C Hamano <gitster@pobox.com> writes:

> "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
> ...
>> The problem is "narrow rules" may change over time in a way that git
>> may handle it wrong. Assume that you have a directory with two files:
>> a and b. You first narrow checkout a (which would save the rule
>> "checkout a"). Then you do "git checkout b". When you update HEAD,
>> what should happen?
>
> I'd expect that this sequence:
> ...
> you can record list of pathspecs (with positive and negative) to implement
> that semantics, no?

By the way, I was just mentioning the index extension area as a means to
store the rules if _you wanted to_.  I do not insist you to actually store
the rules, and in fact, I do not know if it is even a good idea to do so.

> Ok.  We would need to use an extra bit for this.
>
> The bit 0x4000 is the last one available, so we would want to use it as
> "this index entry uses more bits than the traditional format" bit, and
> define a backward incompatible on-disk index entry format to actually
> record CE_NO_CHECKOUT and other flags we will invent in the future.
>
> Perhaps ondisk_cache_entry structure will have an extra "unsigned int
> flags2" after "flags" when that bit is on, and we can have 31 more bits in
> flags2, with the highest bit of flags2 signalling the presense of flags3
> word in the future, or something like that.

It might make sense to do this first as a futureproof, if we really want
to go this route.  We can ensure that an index that does use the new flag
bits won't be misinterpreted by older git.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Sat, 16 Aug 2008 23:02:08 -0700
Subject: [PATCH] index: future proof for "extended" index entries

We do not have any more bits in the on-disk index flags word, but we would
need to have more in the future.  Use the last remaining bits as a signal
to tell us that the index entry we are looking at is an extended one.

Since we do not understand the extended format yet, we will just error out
when we see it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h      |    1 +
 read-cache.c |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 2475de9..7b5cc83 100644
--- a/cache.h
+++ b/cache.h
@@ -126,6 +126,7 @@ struct cache_entry {
 
 #define CE_NAMEMASK  (0x0fff)
 #define CE_STAGEMASK (0x3000)
+#define CE_EXTENDED  (0x4000)
 #define CE_VALID     (0x8000)
 #define CE_STAGESHIFT 12
 
diff --git a/read-cache.c b/read-cache.c
index 2c03ec3..f0ba224 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1118,6 +1118,10 @@ static void convert_from_disk(struct ondisk_cache_entry *ondisk, struct cache_en
 	ce->ce_size  = ntohl(ondisk->size);
 	/* On-disk flags are just 16 bits */
 	ce->ce_flags = ntohs(ondisk->flags);
+
+	/* For future extension: we do not understand this entry yet */
+	if (ce->ce_flags & CE_EXTENDED)
+		die("Unknown index entry format");
 	hashcpy(ce->sha1, ondisk->sha1);
 
 	len = ce->ce_flags & CE_NAMEMASK;
-- 
1.6.0.rc3.18.g20157
