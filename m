From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] tag: support configuring --sort via .gitconfig
Date: Fri, 11 Jul 2014 15:17:21 -0700
Message-ID: <xmqqha2n35hq.fsf@gitster.dls.corp.google.com>
References: <1405111895-17451-1-git-send-email-jacob.e.keller@intel.com>
	<1405111895-17451-3-git-send-email-jacob.e.keller@intel.com>
	<20140711210633.GA12546@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 12 00:17:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5j8H-0004bU-GH
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 00:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325AbaGKWRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 18:17:30 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55917 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753249AbaGKWR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 18:17:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 793F828463;
	Fri, 11 Jul 2014 18:17:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gEURdYHI3dQ7bzUnPIXTKtbrV9s=; b=UTWBTp
	DGjJM98D02JPJGc3FNEtE7q7wi+5ol4yJPARnMVuIb74neq1xutdKTuS9Kr7nr1s
	IjJeS+hYcvlXRZ6qDN7acOvJXOWyAxL2Q5Z1fhNLkeU0OGRds6A9ee2D4Lwpa59t
	eK/CUcESaGIlKfj2pprGp2Rv1WCt+xDmUSgcA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qpEeW2UO0XsP3HrbXO3SMe4D4dP+gKzc
	5VVNDhJFzrcR5Wbhc5NnLNmwNU8x3L65Y9ClZ2YDx1aalFgkaPJ4P+M+PBjmMpOW
	0GW15o9JbQR0uRvzJOxmS0RA7Qxy8cYmFjTe96dgW9skCaXAqyBhFSTtkzQDJUBD
	zIMmKW+sGSo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2DD1928462;
	Fri, 11 Jul 2014 18:17:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 645E928450;
	Fri, 11 Jul 2014 18:17:07 -0400 (EDT)
In-Reply-To: <20140711210633.GA12546@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 11 Jul 2014 17:06:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1860B350-0949-11E4-9127-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253334>

Jeff King <peff@peff.net> writes:

> On Fri, Jul 11, 2014 at 01:51:35PM -0700, Jacob Keller wrote:
>
>> +	if (!strcmp(var, "tag.sort")) {
>> +		if (!value)
>> +			return config_error_nonbool(var);
>> +		status = parse_sort_string(value, &tag_sort);
>> +		if (status) {
>> +			warning("using default lexicographic sort order");
>> +			tag_sort = STRCMP_SORT;
>> +		}
>
> I think this is a good compromise of the issues we discussed earlier. As
> you noted, it should probably be marked for translation. I'm also not
> sure the message content is clear in all situations. If I have a broken
> tag.sort, I get:
>
>   $ git config tag.sort bogus
>   $ git tag >/dev/null
>   error: unsupported sort specification bogus
>   warning: using default lexicographic sort order
>
> Not too bad, though reminding me that the value "bogus" came from
> tag.sort would be nice. But what if I override it:
>
>   $ git tag --sort=v:refname >/dev/null
>   error: unsupported sort specification bogus
>   warning: using default lexicographic sort order
>
> That's actively wrong, because we are using v:refname from the
> command-line.  Perhaps we could phrase it like:
>
>   warning: ignoring invalid config option tag.sort
>
> or similar, which helps both cases.

Hmph.  Looks like a mild-enough middle ground, I guess.  As
parse_sort_string() is private for "git tag" implementation, I
actually would not mind if we taught a bit more context to it and
phrase its messages differently.  Perhaps something like this, where
the config parser will tell what variable it came from with "var"
and the command line parser will pass NULL there.

static int parse_sort_string(const char *var, const char *value, int *sort)
{
	...
	if (strcmp(value, "refname")) {
		if (!var)
                	return error(_("unsupported sort specification '%s'"), value);
		else {
                	warning(_("unsupported sort specification '%s' in variable '%s'"),
                        	var, value);
			return -1;
		}
	}

	*sort = (type | flags);

	return 0;
}

> As an aside, I also think the error line could more clearly mark the
> literal contents of the variable. E.g., one of:
>
>   error: unsupported sort specification: bogus
>
> or
>
>   error: unsupported sort specification 'bogus'

Yup.
