From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] cache-tree: invalidate i-t-a paths after generating
 trees
Date: Mon, 10 Dec 2012 09:22:40 -0800
Message-ID: <7vip89bz4v.fsf@alter.siamese.dyndns.org>
References: <1352459040-14452-1-git-send-email-pclouds@gmail.com>
 <1354939803-8466-1-git-send-email-pclouds@gmail.com>
 <7v7goqcsdy.fsf@alter.siamese.dyndns.org>
 <CACsJy8CW1UGgQcgHa11XP71XZGaTxytrGmJmrtdNvy=N7cUyMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathon Mah <me@jonathonmah.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 18:23:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ti74H-0002yR-PP
	for gcvg-git-2@plane.gmane.org; Mon, 10 Dec 2012 18:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466Ab2LJRWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2012 12:22:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44838 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750900Ab2LJRWo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2012 12:22:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EEC784EC;
	Mon, 10 Dec 2012 12:22:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tJKj4bdYIT+Xn9P2ij+dQnANPuQ=; b=xnETHn
	vrcq/qCR2xm2sOI0cnaDUac0gHOZrEFoaHerlIYLRg+Jvp7PJ+6q9imC0mPs7KaV
	WR/TfjHYECYJ/0sKWuocv+oJkCl/l8DTXH3VBV+Aj19PPTHgD7IavY7uXTbrCE7g
	y8jyoPvPAED/pplsuCBRfGZCFtnH5n7mbraZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SCpcRGdx4EkfO1VBqv6Svbeys93M0HV/
	GxEO4Muov9HyQcDMzlTelHM1+cgYW9WP72ahoWEBfVzqgME8HKYlkQV2qiHxKDPx
	rkdakuGPGXeNRvqHUlgywN2EYOvP02eT5NxMQXCce9ioSC/KI4fjyiPQDNmbzuWN
	7w3TPSKs1AI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AA7584EA;
	Mon, 10 Dec 2012 12:22:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 430DD84E8; Mon, 10 Dec 2012
 12:22:42 -0500 (EST)
In-Reply-To: <CACsJy8CW1UGgQcgHa11XP71XZGaTxytrGmJmrtdNvy=N7cUyMw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Mon, 10 Dec 2012 18:53:02 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 345F0962-42EE-11E2-9E8F-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211262>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Yeah I use entry_count for two different things here. In the previous
> (unsent) version of the patch I had "entry_count = -1" right after "i
> -= entry_count"
>
>>> +                     if (sub->cache_tree->entry_count < 0) {
>>> +                             i -= sub->cache_tree->entry_count;
>>> +                             sub->cache_tree->entry_count = -1;
>>> +                             to_invalidate = 1;
>>> +                     }
>
>
> which makes it clearer that the use of negative entry count is only
> valid within update_one. Then I changed my mind because it says
> 'negative means "invalid"' in cache-tree.h.

But you make it to mean not just 'negative means invalid' but
'negate it and you can learn how many index entries to skip to reach
the entry outside the subtree'.  That is what I was wondering about.

I do not think that new invariant does not hold in general; it may
hold true while inside this function, but immediately after somebody
else calls cache_tree_invalidate_path() it won't be true anymore.
Leaking the information to outside callers that can easily be
mistaken as if it may mean something without any comment looks like
we are asking for trouble.

> So, put "entry_count = -1"
> back or just add another field  to struct cache_tree for this?

As long as it is made clear with in-code comment that says "negative
entry count, when negated, will give us how many index entries are
covered by this invalid cache tree, only inside this function", and
such a negative entry_count is reset to -1 to avoid leaking out the
value that will soon go stale to the outside world in the "write
this tree out" loop, I think the v2 patch is OK, if not ideal.

If we were to commit to keep the new invariant true throughout the
system, on the other hand, I suspect that a boolean flag "valid" may
help people who keep i-t-a entries around across write-tree calls.
The first if () statement in the update_one() function can check the
validity, and you can say the cache tree is valid even if the
section in the index that is covered by the cache-tree contains
i-t-a entries _after_ you wrote it out as a tree, no?  That may make
the semantics a lot cleaner, I suspect.

The new semantics might be:

 * update_one() returns negative only when the section of the index
   given to it cannot be written out as a tree (i.e. not merged, or
   corrupt index);

 * update_one() returns the number of entries in the index covered
   by the tree, including i-t-a entries (but not REMOVED, as these
   entries will not be in the index after the cache-tree has been
   written out);

 * cache_tree->valid tells if the cache_tree->sha1 is valid; the
   section of the index the tree covers may or may not have i-t-a
   entries in it;

 * cache_tree->entry_count holds the number of index entries the
   tree covers, couting i-t-a entries. This field is only meaningful
   when cache_tree->valid is true.

or something like that.

I noticed that the recent "ignore i-t-a only while writing trees
instead of erroring out" broke 331fcb5 (git add --intent-to-add: do
not let an empty blob be committed by accident, 2008-11-28) in
another way, by the way.  In verify_cache(), there is an unreachable
else clause to warn about "not added yet" entries that should have
been removed but is left behind.
