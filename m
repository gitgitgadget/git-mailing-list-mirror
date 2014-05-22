From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git reset for index restoration?
Date: Thu, 22 May 2014 14:58:50 -0700
Message-ID: <xmqqd2f5mq5h.fsf@gitster.dls.corp.google.com>
References: <1400775763.1933.5.camel@stross>
	<CABPp-BHtYnput7SiAbnqUjpDibTi5o_2MAXfSj17fCdKSC7Hjg@mail.gmail.com>
	<1400782642.18134.8.camel@stross>
	<20140522183930.GB1167@sigill.intra.peff.net>
	<1400785669.18134.21.camel@stross>
	<20140522190959.GA18785@sigill.intra.peff.net>
	<20140522193030.GA22383@sigill.intra.peff.net>
	<xmqqha4hmr9d.fsf@gitster.dls.corp.google.com>
	<1400795586.18134.40.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu May 22 23:59:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnb0t-0002Kz-TL
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 23:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656AbaEVV64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 17:58:56 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55621 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363AbaEVV6z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 17:58:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2DD58197C7;
	Thu, 22 May 2014 17:58:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AT/CArzV9/4q7t9OmnVTa4sPDdk=; b=TkC1hW
	5ChtuzbXm8XIfdzmnIFZtgjFAOROPY7D/PAHmnUO19nTafYgvdsoC/eCYT8u/YNA
	vy4fJUmfLGfktvFTguYBocMAOls+tKlrvuoxAwajr1JPqBJMMPpxmQtxNoTCepP3
	vK8NTQbIdgHXkx/w4fLuQ1Ni+zDVGp9dhr5xo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dj9M8ySJjtJ6/f4zSvGjpk4jZt311zrE
	/w6GEyx+PX5D+1umi2hIDvxzZldUlXnw9tN38RI6Y5OeRfwahmzICTQS+vH8Vduq
	cOtAnLw+ifKqOCHkVZsEc+/knLX3zTMfrbiuJr1ANc+IIa7yli8FlZHMJJL4kUE0
	S3JyXoL+onc=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 24416197C6;
	Thu, 22 May 2014 17:58:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C60FD197C3;
	Thu, 22 May 2014 17:58:51 -0400 (EDT)
In-Reply-To: <1400795586.18134.40.camel@stross> (David Turner's message of
	"Thu, 22 May 2014 17:53:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 42B20768-E1FC-11E3-897D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249948>

David Turner <dturner@twopensource.com> writes:

> On Thu, 2014-05-22 at 14:34 -0700, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>> 
>> > [+cc Junio for cache-tree expertise]
>> > ...
>> > We never call reset_index now, because we handle it via diff.  We could
>> > call prime_cache_tree in this case, but I'm not sure if that is a good
>> > idea, because it primes it from scratch (and so it opens up all those
>> > trees that we are trying to avoid touching). I'm not sure if there's an
>> > easy way to update it incrementally; I don't know the cache-tree code
>> > very well.
>> 
>> The cache-tree is designed to start in a well-populated state,
>> allowing you to efficiently smudge the part you touched by
>> invalidating while keeping the parts you haven't touched intact.
>
> As far as I can tell, the cache-tree does not in fact ever get into a
> well-populated state (that is, it does not exist at all) under ordinary
> git operation except by git reset --hard.  Perhaps this was already
> clear from the previous traffic on the thread, but I wanted to make sure
> Junio was also aware of this.

Yes.  As I said, that should not usually be a problem for those who
do the real work (read: commit), at which time write-tree will fully
populate the cache-tree.
