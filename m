From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unpack-trees: fix accidentally quadratic behavior
Date: Thu, 21 Jan 2016 11:51:50 -0800
Message-ID: <xmqqpowuyall.fsf@gitster.mtv.corp.google.com>
References: <1453349156-12553-1-git-send-email-dturner@twopensource.com>
	<xmqq60ynzfyq.fsf@gitster.mtv.corp.google.com>
	<1453403398.16226.40.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 20:52:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMLH1-0003wG-AX
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 20:52:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbcAUTwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 14:52:00 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58222 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751307AbcAUTv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 14:51:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6F48F3B11B;
	Thu, 21 Jan 2016 14:51:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U/8Ag5UQ6YSwyeQ3UuNLiG4INQE=; b=iGSv29
	j7TxGt6wsLn87sXHN+5ylvTuiI9glg4SOdiJpa7s7aJvp/RmQR2/9b1wli2ONzKg
	lUdC2Nh/TAQcDmvtak0wQ+DFetAzAzHqxSvlEIEe/ibQRj79ljjsQPNbr3BjPUX5
	9DCd0hAEiL0EZnWvLSRo8lN2Ku3xjoAu+z9dE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eyyPUSieoWD7l36zFzlpaVwQXyYFu2ud
	X/weIgSqJXfnXsBdIKnu12iwKj5M0l3jG90BzpMe/kgEXBvi93k3Rs5/oo1jAOB5
	CJJ3j2AoZzsJTStzY9JQCTmLgcfbVR2oJyGFrQB7gMPKHLbE4ispkmlo4mTOazu7
	2Oda2hP7+3g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 668FD3B119;
	Thu, 21 Jan 2016 14:51:52 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E345A3B118;
	Thu, 21 Jan 2016 14:51:51 -0500 (EST)
In-Reply-To: <1453403398.16226.40.camel@twopensource.com> (David Turner's
	message of "Thu, 21 Jan 2016 14:09:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6A767D72-C078-11E5-830E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284522>

David Turner <dturner@twopensource.com> writes:

> On Wed, 2016-01-20 at 20:58 -0800, Junio C Hamano wrote:
>> David Turner <dturner@twopensource.com> writes:
>> 
>> > While unpacking trees (e.g. during git checkout), when we hit a
>> > cache
>> > entry that's past and outside our path, we cut off iteration.
>> > 
>> > This provides about a 45% speedup on git checkout between master
>> > and
>> > master^20000 on Twitter's monorepo.  Speedup in general will depend
>> > on
>> > repostitory structure, number of changes, and packfile packing
>> > decisions.
>> > 
>> > Signed-off-by: David Turner <dturner@twopensource.com>
>> > ---
>> 
>> I haven't thought things through, but does this get fooled by the
>> somewhat strange ordering rules of tree entries (i.e. a subtree
>> sorts as if its name is suffixed with a '/' in a tree object)?
>> 
>> Other than that, I like this.  "We know the list is sorted, and
>> after seeing this entry we know there is nothing that will match" is
>> an obvious optimization that we already use elsewhere.
>> 
>> Thanks.
>
> I think this is correct, because we first do the more complicated check
> (ce_in_traverse_path), and only check the ordering once that has
> failed.  

But the patch does this:

> +			if (info->prev && info->traverse_path) {
> +				int prefix_cmp = strncmp(ce->name, info->traverse_path, info->pathlen);
> +				if (prefix_cmp > 0)
> +					break;
> +				else if (prefix_cmp == 0 &&
> +					 ce_namelen(ce) >= info->pathlen &&
> +					 strcmp(ce->name + info->pathlen,
> +						 info->name.path) > 0) {
> +					break;
> +				}
> +			}
>  			continue;

The first break is correct, but I am not sure about the "else if"
part.  Shouldn't it be doing something similar to the logic to "keep
looking" that talks about "t-i", "t" and "t/a" at the end of the
loop?

> The tests all pass, so this should be good.

Please don't ever say that again.  The existing tests do not cover
all corner cases, and they fundamentally cannot cover the corner
cases future changes may introduce.

Saying "Even test X breaks, so it is clearly broken.  Why did you
send it out without testing?" is OK, though.
