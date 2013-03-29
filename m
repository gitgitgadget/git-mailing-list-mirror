From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] dir.c::match_pathname(): pay attention to the length
 of string parameters
Date: Fri, 29 Mar 2013 10:35:17 -0700
Message-ID: <7vzjxmnm7e.fsf@alter.siamese.dyndns.org>
References: <20130328214358.GA10685@sigill.intra.peff.net>
 <20130328214821.GD10936@sigill.intra.peff.net>
 <CACsJy8DisE8UNZzqmOFxPqw=bmFiHgE5-ao83ciGNUV9Sc9-gA@mail.gmail.com>
 <20130329120539.GA20711@sigill.intra.peff.net> <20130329130230.GA25861@lanh>
 <7vli96p34f.fsf@alter.siamese.dyndns.org>
 <20130329170459.GB3552@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
	avila.jn@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 29 18:35:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULdDR-0000bZ-1f
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 18:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756262Ab3C2RfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 13:35:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36418 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756234Ab3C2RfU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 13:35:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B1ADF232;
	Fri, 29 Mar 2013 17:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CwcTlqSIeEhfIh870JBbCpmG0Kw=; b=J/uXxA
	IBZauan+l+Orz2ExVzSIAiaXTbwFQAANKgrpQdSk+och5cc06dIPXM03DfnFtdUQ
	LeFbCD1YhAh+sNw0fUYdva34cReRAznChZNWDJOIqhEAMAvbyRir+MooZt7qJFEJ
	x/u4/zbKUOrQEyoteauf7zc6g7L/TPDts0IJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xxTX995y9kCWXUIuM3RDXIKRS9DNYkf9
	WIp/7O3HMpIgThfUHiJXo8JupeqAwBU5HTfArkF1IWHCGR7gycu8WmUBclr7BPtr
	lL39g7RQBdKwgSJUDUP8XknHFrGZBNrPX/rY1CkJy+LLeORa33WeI4/NR5/wFeA9
	6gQk0HnpkQQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F1A9F230;
	Fri, 29 Mar 2013 17:35:19 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5B29F22F; Fri, 29 Mar 2013
 17:35:18 +0000 (UTC)
In-Reply-To: <20130329170459.GB3552@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 29 Mar 2013 13:04:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 065E140A-9897-11E2-8281-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219514>

Jeff King <peff@peff.net> writes:

> On Fri, Mar 29, 2013 at 09:44:32AM -0700, Junio C Hamano wrote:
> ...
>> With the merge-fix, fnmatch_icase_mem() calls into wildmatch(), but
>> fnmatch_icase() still calls into fnmatch().
>> 
>> The latter's flags are meant to be taken from FNM_* family, but the
>> former takes flags from WM_* family of bits, no?
>
> Yeah, that does not seem right. If match_pathname has learned to call
> into wildmatch instead of fnmatch_icase in the interim, then the right
> resolution is to convert its call to fnmatch_icase_mem to a new
> wildmatch_mem.  Presumably that can be done by either tweaking
> fnmatch_icase_mem, or, if wildmatch is ready to take counted strings,
> calling into it with the right options.
>
>> I think you are running with USE_WILDMATCH which may make the
>> differences harder to notice, but the name fnmatch_icase_mem() that is
>> not in the same family as fnmatch but is from the wildmatch() family
>> smells like an accident waiting to happen.
>
> Agreed.

This may be just the matter of naming.

It smelled wrong to me only because the "fnmatch" in the helper
fnmatch_icase_mem() told me that it should forever use fnmatch
semantics.  After reading its (only) two callsites, they are both
"the caller has transformed the inputs to this lowest level pathname
vs pattern matching function in order to reduce the cost of
matching, and now it is time to exercise the matcher".  The only
thing they care about is that they are calling "the lowest level
pathname vs pattern matching function."

If we pronounce "fnmatch_icase_mem()" as "match_path_with_pattern()"
or something in the original series, the problem may go away ;-)

Does any caller pass FNM_* bits to a callchain that reach the new *_mem()
function?
