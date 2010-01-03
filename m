From: Junio C Hamano <gitster@pobox.com>
Subject: Re: suppress fatal pathspec errors from "git add"?
Date: Sun, 03 Jan 2010 00:12:19 -0800
Message-ID: <7vk4vz38v0.fsf@alter.siamese.dyndns.org>
References: <d7ac1a680912311324i85b7a5anadaf2ac13f215873@mail.gmail.com>
 <20100103074058.GB23031@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: aaron smith <beingthexemplarylists@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 03 09:13:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRLaz-0000px-4h
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jan 2010 09:13:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269Ab0ACIMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jan 2010 03:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038Ab0ACIMb
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jan 2010 03:12:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33591 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954Ab0ACIMa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jan 2010 03:12:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 635F78DD34;
	Sun,  3 Jan 2010 03:12:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hrscTeoA2JYUH5tFw7GXBDCmuM4=; b=RxXLc7
	hpZpVaJIkqm/PlxQF5ap3AxyYNtzpFTmSw2U9LRIG2f/DkkCV2p9LrHPXe0hdc0j
	EOMONwxvOXlp92RARK5KozRu8PiI/qHuGkgv4OAshMKtr2wSubLCrbKfpLhd52u4
	ZSYqfJe9mh8MRjTkCEMppuLczKHKCEHgAzl+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pcXcYKusj1bAy3W31lKF2vDKDFzcJV7s
	LLWODQnJmbkhnZ1/Ofbz1NfrZT5llvXR5TEpnbqJQvYGEkYSOK4h/PXUm6WpxxLm
	7k4GUsO3KkGU9cgrSWHL5d8LVVrPAgwLLozeHccGFj5Zq/Tmc+uTOUE7toxve1m7
	mj/5knikrjI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C8338DD32;
	Sun,  3 Jan 2010 03:12:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6453C8DD31; Sun,  3 Jan
 2010 03:12:21 -0500 (EST)
In-Reply-To: <20100103074058.GB23031@sigill.intra.peff.net> (Jeff King's
 message of "Sun\, 3 Jan 2010 02\:40\:59 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B9CCACF0-F83F-11DE-8D25-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136070>

Jeff King <peff@peff.net> writes:

> ... I could see it
> if your workflow were something like "in a script, add these N files if
> they exist, but it is not an error if they don't". But I still don't
> think you would want to ignore all errors; you would want to do
> something like:
>
>   $ git add $(for i in foo bar baz; do test -e $i && echo $i; done)
>
> instead. Am I missing something?

If your primary activity that happens in the work tree were:

	while :
        do
        	file=$(date +"random-%H%M%S")
                >"$file"
                rm -f "$file"
	done

and your add were done in

	while sleep 3600
        do
		git add $(for i in *; do test -e $i && echo $i; done)
                git commit -m "hourly snapshot"
	done

totally asynchronously without coordinating with what the primary activity
is doing, your "test -e && echo" can race with a concurrent "rm".

Even though I think it is an insane use pattern that we shouldn't bother
to bend too much backwards to support it, --ignore-errors were added
primarily for a similar use case (i.e. by the time we try to read it, it
is either gone or it cannot be read by the user who runs "git add"), so in
that sense it _might_ make sense to ignore all errors with the option.  If
we choose to go in that direction, it would also make tons of sense to
update the documentation of the option to caution more strongly that its
use is a sign of insanity and is discouraged at the same time.
