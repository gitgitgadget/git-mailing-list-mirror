From: Junio C Hamano <gitster@pobox.com>
Subject: Re: textconv not invoked when viewing merge commit
Date: Thu, 14 Apr 2011 13:06:19 -0700
Message-ID: <7v8vvcha2s.fsf@alter.siamese.dyndns.org>
References: <201104111912.47547.kumbayo84@arcor.de>
 <4DA415AB.9020008@drmicha.warpmail.net>
 <20110414190901.GA1184@sigill.intra.peff.net>
 <7vipughbxh.fsf@alter.siamese.dyndns.org>
 <7vd3kohb5n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Peter Oberndorfer <kumbayo84@arcor.de>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 22:06:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QASoK-0004uC-IY
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 22:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380Ab1DNUGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 16:06:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49190 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997Ab1DNUGd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 16:06:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D12274D19;
	Thu, 14 Apr 2011 16:08:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J94Cn45+EV33RmA7HXwinRXXzh0=; b=E3uSkK
	XIWUO9WxeT0j04TY8pfBft7gBRS6oW73ctryz//hXJ8zYv4ZlGsgsOtG17SR3ih4
	DDcA9+qipnZKPc7ZBpi3SUw/3cr3OOTQO7MnN8sAkVhTeRKzDO8t1ftPU1fPKEO0
	W7zQuBS9gj/KjDl8tDQHPQ9v72zjKoHnuqwkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PCFwrdZCJJ3oJ5fvFUVDR4ko4q/2RwlO
	AYX6O5a4yyxetdVsuk7nQ/SaYdm4voHFCD0RE6XjpkLwQYR0VvAzET3MtHLez9H0
	YUUkHhnbcmp5r6RnwFkvZfmhzygklgRBh3HvDgTQHW8e4wJOxQ1EoSuBxYG5mjey
	GGE/p6+L1oE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8EF8E4D18;
	Thu, 14 Apr 2011 16:08:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2D4AB4D16; Thu, 14 Apr 2011
 16:08:19 -0400 (EDT)
In-Reply-To: <7vd3kohb5n.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 14 Apr 2011 12:43:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F4A9B59A-66D2-11E0-8EFB-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171543>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jeff King <peff@peff.net> writes:
>>
>>> We just dump the binary goo all over the terminal. So I think the whole
>>> combined-diff code path needs to learn how to handle binaries properly.
>>
>> How would you show multi-way diffs for binary files?
>>
>> It would probably be sufficient to say "binary files differ" at the
>> beginning of the patch-combining codepath of the combined diff, which
>> would at least keep the --raw -c/--cc output working.
>
> In other words, I suspect that the only places you need to touch in the
> existing codepath would be these places.


In the "here are the places" patch, I changed combine_diff() to return "is
this binary?" and made show_patch_diff() to give just a single "path is
binary", but I suspect that it would be simpler not try to be too nice
about binary like that.

Instead, I think we should just use "Binary blob $SHA-1\n" as if that is
the textconv of a binary file without textconv filter.  That would
certainly make the code much simpler, and more importantly, the output
would become more pleasant. We would show something like:

    - Binary blob bc3c57058faba66f6a7a947e1e9642f47053b5bb
     -Binary blob 536e55524db72bd2acf175208aef4f3dfc148d42
    ++Binary blob 67cfeb2016b24df1cb406c18145efd399f6a1792

if we did so.

When showing the working-tree version, we obviously do not have the blob
object name yet, so in such a case, we can say "Binary blob", or just
"Binary".
