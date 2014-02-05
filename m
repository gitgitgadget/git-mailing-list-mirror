From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] reset: support "--mixed --intent-to-add" mode
Date: Wed, 05 Feb 2014 09:16:09 -0800
Message-ID: <xmqqob2l5vl2.fsf@gitster.dls.corp.google.com>
References: <CACsJy8BXGZ+1Oqrpcky5JPCtZRwvxmxhXGfuEqY9Ct4Pt8FmJg@mail.gmail.com>
	<1391480409-25727-1-git-send-email-pclouds@gmail.com>
	<1391480409-25727-2-git-send-email-pclouds@gmail.com>
	<xmqqvbwu8zjx.fsf@gitster.dls.corp.google.com>
	<xmqqeh3i7bxm.fsf@gitster.dls.corp.google.com>
	<20140205002725.GA3858@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 18:16:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB65K-0007oJ-9l
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 18:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270AbaBERQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 12:16:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58891 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752903AbaBERQV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 12:16:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8AB567750;
	Wed,  5 Feb 2014 12:16:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4Z7ET4vQeeFZWCJUblaTcxpQYHI=; b=WAE6Ac
	1nnxCPgnG43ekxaOQjrKjsxjN5vLr8c8gFI4xNuoj+CxxL5GKZtCv2xhBI7Awdlr
	r3a+65TyEBvaH3+87cJyw/agpBiti2ueDyBxFv5bHovfQiaqliqlAaZC4YYuAJUJ
	ox85i6pju/vwG9o9eHIiGME7tt0IrMUsQZ+HQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y6OAsAM+hDPfag1f/aUPzSq0drX5bxQL
	5BLGVzHsFoKyOVsvFyOFxpd1XvpqFq03+Ho2vXN+hTTKUzYDQhOl0LGekmTvasnQ
	FJhGByNCyJPd/uRRBOm3ET8lO55c3JMxlBhl4v5ZGM2mmidS3fEFmX+I46/Kw+Hy
	AOsPpDNBcYo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 327E16774D;
	Wed,  5 Feb 2014 12:16:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9DA867738;
	Wed,  5 Feb 2014 12:16:12 -0500 (EST)
In-Reply-To: <20140205002725.GA3858@lanh> (Duy Nguyen's message of "Wed, 5 Feb
	2014 07:27:26 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 36874DA2-8E89-11E3-BE72-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241611>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Feb 04, 2014 at 02:25:25PM -0800, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > While I do not have any problem with adding an optional "keep lost
>> > paths as intent-to-add entries" feature, I am not sure why this has
>> > to be so different from the usual add-cache-entry codepath.  The
>> > if/elseif chain you are touching inside this loop does:
>> >
>> >  - If the tree you are resetting to has something at the path
>> >    (which is different from the current index, obviously), create
>> >    a cache entry to represent that state from the tree and stuff
>> >    it in the index;
>> >
>> >  - Otherwise, the tree you are resetting to does not have that
>> >    path.  We used to say "remove it from the index", but now we have
>> >    an option to instead add it as an intent-to-add entry.
>> >
>> > So, why doesn't the new codepath do exactly the same thing as the
>> > first branch of the if/else chain and call add_cache_entry but with
>> > a ce marked with CE_INTENT_TO_ADD?  That would parallel what happens
>> > in "git add -N" better, I would think, no?
>> 
>> In other words, something along this line, perhaps?
>
> <snip>
>
> Yes. But you need something like this on top to actually set
> CE_INTENT_TO_ADD

Yes, indeed.  I wonder why your new test did not notice it, though
;-)


>
> -- 8< --
> diff --git a/read-cache.c b/read-cache.c
> index 325d193..87f1367 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -585,6 +585,7 @@ void mark_intent_to_add(struct cache_entry *ce)
>  	if (write_sha1_file("", 0, blob_type, sha1))
>  		die("cannot create an empty blob in the object database");
>  	hashcpy(ce->sha1, sha1);
> +	ce->ce_flags |= CE_INTENT_TO_ADD;
>  }
>  
>  int add_to_index(struct index_state *istate, const char *path, struct stat *st, int flags)
> -- 8< --
