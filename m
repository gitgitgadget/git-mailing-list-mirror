From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 06/10] fast-export: add new --refspec option
Date: Wed, 06 Nov 2013 14:31:47 -0800
Message-ID: <xmqqr4at6u24.fsf@gitster.dls.corp.google.com>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
	<1383212197-14259-6-git-send-email-felipe.contreras@gmail.com>
	<xmqq61sd70vw.fsf@gitster.dls.corp.google.com>
	<CAMP44s246M5DaeX80tqzfjRWnbE4vKh-vp_tLW-qAQUFFPsP0Q@mail.gmail.com>
	<xmqq38n98cud.fsf@gitster.dls.corp.google.com>
	<20131106221427.GB13258@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 06 23:32:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeBdl-00070Q-5M
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 23:31:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591Ab3KFWbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Nov 2013 17:31:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62171 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869Ab3KFWbw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 17:31:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96B33505FE;
	Wed,  6 Nov 2013 17:31:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S4HUrACqx4Yfl3g54lAIA2QzSgo=; b=S/TGqQ
	sApTnx343d/PlHns6C3RaG+jlXFYk9qurb7L86cGnppd0TFBLLajoB1+4HuL8ztW
	Nt697D/Q8f8E7F9SDFy4tERuA2wj0gRi7BnQUxeFK0gt/if8e13L2RZJ1j7gF//u
	8qGpTjw3NuYLJmM064+aa9p/rIcAu+enW5+HM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KLv0w3orqroF9ru6GGTbmZ5Gx4VCNV8f
	KBbVUOjSi22JUYpD9fgKkYFJjyp5BxpUjdF0folMURIvmQHBVDJqQIZn5J/CI7eV
	//o2OEpNIWPCgLkJrHKRVE1tZxMTvSOX/IND+ZCtAfVGPbiKJ5OPSVaSCuLHXdmL
	fWVEGGNYKAE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89142505FC;
	Wed,  6 Nov 2013 17:31:51 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CCDA4505F9;
	Wed,  6 Nov 2013 17:31:50 -0500 (EST)
In-Reply-To: <20131106221427.GB13258@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 6 Nov 2013 14:14:27 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3AE8DAC0-4733-11E3-9915-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237376>

Jeff King <peff@peff.net> writes:

> I think that is much nicer for the simple cases, but how do we handle
> more complex rev expressions? One can say:
>
>   git fast-export master ^origin
>
> or even:
>
>   git fast-export origin..master
>
> The "^origin" is not a refspec, and finding the refspec in the
> dot-expression would involve parsing it into two components. I think you
> can come up with a workable system by parsing the arguments as revision
> specifiers and then applying some rules. E.g., a positive ref "foo" is a
> refspec "foo:foo", but negative "^bar" does not impact refspecs at all,
> and the same rules are applied for "bar..foo". There is a syntactic
> conflict where "foo:bar" would be interpreted as a tree:path by the
> revision code, though, whereas in this context it means a refspec.
>
> So I think it is possible to go that route (and perhaps preferable,
> even, because it keeps the simple and common cases easy for the user),
> but the implementation is not as simple as just treating the arguments
> as refspecs.

I forgot about the ranges, but thinking about it further, I think
what we really need to worry about is the positive end.

	git fast-export origin..master

is (by the usual definition of A..B range) the same as

	git fast-export ^origin master

If we realize that the bottom ends of ranges do not participate in
the "update the ref at the receiving end" phase of object/history
transfer at all, that command line can still be thought of as a
short-hand for

	git fast-export ^origin refs/heads/master:refs/heads/master

That is, anything negative is used only to specify the bottom of the
range, and positive ones (e.g. 'master' in both of your examples) tell
us what ref to update in addition to where the history ends.
