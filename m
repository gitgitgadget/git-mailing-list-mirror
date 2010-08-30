From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3?] Add global and system-wide gitattributes
Date: Mon, 30 Aug 2010 14:11:53 -0700
Message-ID: <7vbp8jerfq.fsf@alter.siamese.dyndns.org>
References: <vpqy6bqr3ep.fsf@bauges.imag.fr>
 <1283020870-24888-1-git-send-email-Matthieu.Moy@imag.fr>
 <87fwxxhfpp.fsf_-_@gmail.com> <7vzkw4edc5.fsf@alter.siamese.dyndns.org>
 <vpqvd6sik0n.fsf@bauges.imag.fr> <7voccjesk7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>,
	git@vger.kernel.org, Petr Onderka <gsvick@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 30 23:12:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqBeO-0006XO-9H
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 23:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185Ab0H3VMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 17:12:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59152 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590Ab0H3VMG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 17:12:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7ED64D2ADF;
	Mon, 30 Aug 2010 17:12:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zoK+5TUUcaVAxLyRhH49dQTLi/M=; b=KmmtuZ
	fXj8fNfKS/TgGw3lxYGdvvT1cbXWyQnOkhSTjpEgMJJ3wXw7V7OeEEpyPNKQFlh2
	2bCXWlSH0sgW+e1GJJi47pL9hv/4swWtsbVI5vT6ZC4maz+OH4ToW099WOOS5/mi
	Tn+o/jFH/zkY46TPA8qYzIdrKxBvNtohiJK1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lOxIkFgec3wrk916v/eaW7LuYYIWmiVc
	XzYE832IIBcqhGlz7iqJAzB6JyOhBEg0dLMFYn1rLxMaKbtKra+DOAwr1cs2SOXj
	WEshRkbWos3wa6RzAJ4YkgLSdxKTSzwqNVfoHY4kgB9H6kwhzBMid5czaSLbtUNX
	PrurxlMuH6g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 36184D2ADB;
	Mon, 30 Aug 2010 17:12:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FF19D2AD8; Mon, 30 Aug
 2010 17:11:54 -0400 (EDT)
In-Reply-To: <7voccjesk7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 30 Aug 2010 13\:47\:36 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3A9F73B0-B47B-11DF-8A19-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154845>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> I don't understand why this breaks the test. It seems blame
>> --encoding=UTF-8 relies on the fact that the i18n section of the
>> configuration is not loaded.
>
> That's interesting; I haven't traced the codepath involved, but I do not
> think "configuration is not loaded" is the issue. "Reading either before
> the main codepath is ready, or more likely overwriting/destroying what the
> main codepath has read it by re-reading the configuration" may be.

I think that hunch is correct.  A typical way we default to hardcoded
value, overridable by configuration file, and then further use command
line to override that, is for the main codepath to do the following in
this order:

 - call git_config(git_appropriate_config); this changes the variables
   (with possibly hardcoded default) defined in environment.c;

 - parse command line options and override the variable;

 - use the variable at runtime.

This obviously relies on the main codepath having _total_ control of the
calls made to git_config().  If you call git_config(git_default_config)
when an attribute is asked for for the first time (which would be way
after all of the above happened) behind the main codepath's back, you will
of course break things.  In the "blame" case, aren't you stomping on
git_log_output_encoding?

The correct solution would be twofold, but the latter is rather painful:

 - The call from the bootstrap_attr_stack should use a callback that reads
   only the attribute file location configuration and _nothing else_.

   Also I do not think the parsing of this configuration variable needs to
   be in git_default_config() to begin with, if you are reading it from
   the bootstrap codepath on demand anyway, and not relying on the main
   codepath of any particular program to be calling on git_config().

 - The way programs (this is not limited to blame and other rev-list
   machinery users) implement the "use configured values but let command
   line override them" need to be changed.
   
   One possibility is to copy the values determined by reading the config
   and the command line to their own variables, so that later random call
   to git_config() won't stomp on the actual values to be used.  This is
   painful as environment.c variables are _meant_ to be easily usable as
   global variables and copying them away (which means they now need to be
   passed around throughout the callchain in the various APIs) defeats
   the whole point of having them.
