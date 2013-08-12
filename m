From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: remove ternary operator evaluating always to true
Date: Sun, 11 Aug 2013 22:46:01 -0700
Message-ID: <7vli471mxy.fsf@alter.siamese.dyndns.org>
References: <1375986704-11441-1-git-send-email-stefanbeller@googlemail.com>
	<20130810072114.GD30185@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@googlemail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 12 07:46:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8kxI-0003JK-EX
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 07:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755493Ab3HLFqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 01:46:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47148 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755457Ab3HLFqG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 01:46:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64FCC33F78;
	Mon, 12 Aug 2013 05:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GJOTtBWLnfLuhonP5ek8I5Pt8OU=; b=ntTuHY
	amrKmMfWM+yuR9K4yXArK4Bt3Iq0W+9qUTIH2gHGrqFU0xgpEwfRc4P+bXorSlC0
	jFFzvW+d++KTmRE0iqjhHIK8OP25cY7ETPsux5CJ3LZexqyyPLv/lrAhyDlWhHIF
	Ws0GcaJzdpXlizYh2/5Ksr2QaU/Rt5IUCOIng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IO5IzXcmbZ2gMgr7whkcFAyI8wolwxOh
	fSCfZJGWt3alpWy0sz+VxnGI/8TBWBcR7WOlU4J+pUiUXNPyiQuJNqTlciLN9+u+
	vHDIRxgVXEC3WPtffcBcTrSvXzUYkw3MEbIUKlbKGJPxFgmyZFjQPgHqZDn1pxSo
	5+tMAuX8SYI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E9FE33F77;
	Mon, 12 Aug 2013 05:46:05 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A02733F6D;
	Mon, 12 Aug 2013 05:46:03 +0000 (UTC)
In-Reply-To: <20130810072114.GD30185@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 10 Aug 2013 03:21:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 79734330-0312-11E3-9AB2-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232152>

Jeff King <peff@peff.net> writes:

> On Thu, Aug 08, 2013 at 08:31:44PM +0200, Stefan Beller wrote:
>
>> The next occurrences are at:
>> 	/* Never use a non-valid filename anywhere if at all possible */
>> 	name_a = DIFF_FILE_VALID(one) ? name_a : name_b;
>> 	name_b = DIFF_FILE_VALID(two) ? name_b : name_a;
>> 
>> 	a_one = quote_two(a_prefix, name_a + (*name_a == '/'));
>> 	b_two = quote_two(b_prefix, name_b + (*name_b == '/'));
>> 
>> In the last line of this block 'name_b' is dereferenced and compared
>> to '/'. This would crash if name_b was NULL. Hence in the following code
>> we can assume name_b being non-null.
>
> I think your change is correct, but I find the reasoning above a little
> suspect. It assumes that the second chunk of code (accessing name_a and
> name_b) is correct, and pins the correctness of the code you are
> changing to it. If the second chunk is buggy, then you are actually
> making the code worse.

True.  I think the original code structure design is name_a should
always exist but name_b may not (the caller of run_diff_cmd() that
eventually calls this call these "name" and "other", and the intent
is renaming filepair is what needs "other").

> I wonder if the implicit expectation of the function to take at least
> one non-NULL name would be more obvious if the first few lines were
> written as:
>
>   if (DIFF_FILE_VALID(one)) {
>           if (!DIFF_FILE_VALID(two))
>                   name_b = name_a;
>   } else if (DIFF_FILE_VALID(two))
>           name_a = name_b;
>   else
>           die("BUG: two invalid files to diff");
>
> That covers all of the cases explicitly, though it is IMHO uglier to
> read (and there is still an implicit assumption that the name is
> non-NULL if DIFF_FILE_VALID() is true).

I think that is an overall improvement, especially if we also update
the checks of {one,two}->mode made for the block that deals with
submodules to use DIFF_FILE_VALID().

Thanks.
