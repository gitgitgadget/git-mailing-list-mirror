From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 3/9] pack-objects: Allow --max-pack-size to be used
 together with --stdout
Date: Sun, 15 May 2011 23:12:18 -0700
Message-ID: <7vsjsfmawt.fsf@alter.siamese.dyndns.org>
References: <201105151942.29219.johan@herland.net>
 <1305495440-30836-1-git-send-email-johan@herland.net>
 <1305495440-30836-4-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 16 08:12:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLr2g-0007eN-7X
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 08:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343Ab1EPGM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 02:12:29 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53557 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab1EPGM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 02:12:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 42C88373A;
	Mon, 16 May 2011 02:14:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gIkcZyfA1FPjJNCIexJTX7FxGqc=; b=cQP4uJ
	2I7mUPRMk4ITc9eiqYgPawrJAtLbzMf0bNAH/t6DFn4WBMihQ6XigwLYvXLCz0/7
	TjqRFxW12mNsjl5nYv5+qH9sXsdexlJRyXnbFaMosVNDwQuTrjhmV4Jg6qWUswhM
	8k0S7q13v4xPC67xB+hgJFuIexJvQm0NvmiPY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kBx4bB4UhamPMoP0SNGGLE0loiTR6YxK
	MHQraUMafFxqv5Z77+5PAvK/ZwPsvMnenl9GcDgX32FPvz2rBtCPWINsmolFQS6C
	dUEyzaWR8DWhN1BYW+Ba+Sb7iAVxlDa66LQvrUdrhE7sB2EI/6SwyHZii8X2a+GO
	724vpdeOMeE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 05EA03737;
	Mon, 16 May 2011 02:14:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C4F353736; Mon, 16 May 2011
 02:14:26 -0400 (EDT)
In-Reply-To: <1305495440-30836-4-git-send-email-johan@herland.net> (Johan
 Herland's message of "Sun, 15 May 2011 23:37:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C2F5D03C-7F83-11E0-A6D2-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173705>

Johan Herland <johan@herland.net> writes:

> Currently we refuse combining --max-pack-size with --stdout since there's
> no way to make multiple packs when the pack is written to stdout. However,
> we want to be able to limit the maximum size of the pack created by
> --stdout (and abort pack-objects if we are unable to meet that limit).
>
> Therefore, when used together with --stdout, we reinterpret --max-pack-size
> to indicate the maximum pack size which - if exceeded - will cause
> pack-objects to abort with an error message.

I only gave the code a cursory look, but I think your patch does more than
the above paragraphs say. I am not sure those extra change are justified.

For example,

> @@ -229,7 +229,7 @@ static unsigned long write_object(struct sha1file *f,
>  
>  	if (!entry->delta)
>  		usable_delta = 0;	/* no delta */
> -	else if (!pack_size_limit)
> +	else if (!pack_size_limit || pack_to_stdout)
>  	       usable_delta = 1;	/* unlimited packfile */

Why does this conditional have to change its behaviour when writing to the
standard output?  I thought that the only thing you are doing "earlier we
didn't allow setting size limit when writing to standard output, now we
do", and I do not see the linkage between that objective and this change.

> @@ -2315,9 +2318,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  
>  	if (!pack_to_stdout && !pack_size_limit)
>  		pack_size_limit = pack_size_limit_cfg;
> -	if (pack_to_stdout && pack_size_limit)
> -		die("--max-pack-size cannot be used to build a pack for transfer.");
> -	if (pack_size_limit && pack_size_limit < 1024*1024) {
> +	if (!pack_to_stdout && pack_size_limit && pack_size_limit < 1024*1024) {
>  		warning("minimum pack size limit is 1 MiB");
>  		pack_size_limit = 1024*1024;
>  	}

Why is the new combination "writing to the standard output, but the
maximum size is limited" does not have the same lower bound to pack size
limit while on-disk packs do?

If you have a reason to believe 1 MiB is too large for a pack size limit,
shouldn't that logic apply equally to the on-disk case?  What does this
change have to do with the interaction with --stdout option?
