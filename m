From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/29] ref_transaction_create(): disallow recursive pruning
Date: Wed, 27 Apr 2016 13:45:07 -0700
Message-ID: <xmqqh9em93xo.fsf@gitster.mtv.corp.google.com>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
	<615204c877610855b02b21ce14efa5b7342182bc.1461768689.git.mhagger@alum.mit.edu>
	<xmqq60v2anyo.fsf@gitster.mtv.corp.google.com>
	<1461788637.11504.3.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 22:45:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avWKl-0007MG-0Y
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 22:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbcD0UpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 16:45:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57656 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752227AbcD0UpL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 16:45:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B0ED216295;
	Wed, 27 Apr 2016 16:45:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s19d5yqJF+OQNDn06cYP89cMkcE=; b=sEc6PD
	BzTqzpXusadZ2uOh2MAVH27ZXgmXnzpVwIK/8LBqOcU8yRBMT1ll5bFIc5txqcd3
	YgT3+da3RTbF+qT1C7izHjsU+nuA8LAnNGmuZa0OKEq3RaZDHaK0ZzUY100M3Guq
	y62s9XmATFJPQngqOHD9iAYoSor5v9B9kkl18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xhyB1omDSrL6VXAzaNVG8sw0qkz96YY+
	KtCu7w7yQL9uU562BRafU9EvVvilhBHruJl45uK0d/7XG5KzJD6tVE2+0AQgzWbw
	MkggXuMxS48S8Pb4eCKSlSK4QF/l4LgbpwMjOTNe6/X9Fud2+bVsqdaH06Wx1jUy
	iHknMADyZ9g=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A410816294;
	Wed, 27 Apr 2016 16:45:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0067616293;
	Wed, 27 Apr 2016 16:45:08 -0400 (EDT)
In-Reply-To: <1461788637.11504.3.camel@twopensource.com> (David Turner's
	message of "Wed, 27 Apr 2016 16:23:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EE233570-0CB8-11E6-A35F-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292820>

David Turner <dturner@twopensource.com> writes:

> On Wed, 2016-04-27 at 11:47 -0700, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> 
>> > It is nonsensical (and a little bit dangerous) to use REF_ISPRUNING
>> > without REF_NODEREF. Forbid it explicitly. Change the one
>> > REF_ISPRUNING
>> > caller to pass REF_NODEREF too.
>> > 
>> > Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> > ---
>> > This also makes later patches a bit clearer.
>> 
>> I wonder if it is more future-proof to solve this by doing
>> 
>>     -#define REF_ISPRUNING	0x04
>>     +#define REF_ISPRUNING	(0x04 | REF_NODEREF)
>> 
>> instead.  It makes the intention clear that pruning is always about
>> the single level (i.e. no-deref).
>
> I think the approach in Michael's patch might be clearer than yours,
> since someone reading the code doesn't have to look at the definition
> of REF_ISPRUNING to understand what is going on.

I have to strongly disagree, assuming that my understanding of the
point of this patch correctly.

If a casual reader sees this code:

    ref_transaction_delete(transaction, r->name, r->sha1,
			   REF_ISPRUNING | REF_NODEREF, NULL, &err)

it gives an incorrect impression that there may also be a valid case
to make a "delete" call with ISPRUNING alone without NODEREF, in
other codepaths and under certain conditions, and write an incorrect

    ref_transaction_delete(transaction, refname, sha1,
			   REF_ISPRUNING, NULL, &err)

in her new code.  Or a careless programmer and reviewer may not even
memorize and remember what the new world order is when they see such
a code and let it pass.

As I understand that we declare that "to prune a ref from set of
loose refs is to prune the named one, never following a symbolic
ref" is the new world order with this patch, making sure that
ISPRUNING automatically and always mean NODEREF will eliminate the
possibility that any new code makes an incorrect call to "delete",
which I think is much better.
