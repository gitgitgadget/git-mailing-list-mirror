From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] peel_ref: use faster deref_tag_noverify
Date: Thu, 04 Oct 2012 11:24:43 -0700
Message-ID: <7vk3v6yu1g.fsf@alter.siamese.dyndns.org>
References: <20121004075609.GA1355@sigill.intra.peff.net>
 <20121004075815.GA31325@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 01:04:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtfk-00033L-74
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191Ab2JDSYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 14:24:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43804 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751899Ab2JDSYv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 14:24:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F1E18BDD;
	Thu,  4 Oct 2012 14:24:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/Z8YiOOOd3escrp7XdnSUeu0Tio=; b=MNpC+g
	LA3+WwRqsCWUQqytqBPYOwyZ+ytFGDJfhJjJYQh70WS5JBkMECX8Rov3xKuh2BnA
	3tcMqmvuL2MjNI3C6hsTHS1gOecxEdlYqNB9DUkGa94QM3FtiRXFobNuupcYDNEA
	Rd78ytP2tiGorcKnYbkTklScfG4DevDVXEYWU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e+80OYy4Qu3kEHWuDq3k+WOqYOGZ7Bau
	LipCPfTUXHVWDWTx+MQbZl77ZZYGB2B/7/GmrtPN9cx83H75XnA5jbb9ZOZO/2Ox
	4XZMNk2SSPmxx02oWguUrN7tclc/rFwhcH15xJXfwiLfuz47LLz/Rnc+xk/fH8Vz
	3DcB2ayzFp4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D50E8BDB;
	Thu,  4 Oct 2012 14:24:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0EA928BD9; Thu,  4 Oct 2012
 14:24:44 -0400 (EDT)
In-Reply-To: <20121004075815.GA31325@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 4 Oct 2012 03:58:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C5A5BACE-0E50-11E2-96A9-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207043>

Jeff King <peff@peff.net> writes:

> When we are asked to peel a ref to a sha1, we internally call
> deref_tag, which will recursively parse each tagged object
> until we reach a non-tag. This has the benefit that we will
> verify our ability to load and parse the pointed-to object.
>
> However, there is a performance downside: we may not need to
> load that object at all (e.g., if we are listing peeled
> simply listing peeled refs),...

Both correct.

I checked the existing callsites and nobody seems to assume that it
can use the pointed-to object without checking because peel_ref has
already checked, so it makes sense.
