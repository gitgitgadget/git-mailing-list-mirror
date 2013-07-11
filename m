From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/10] cat-file: split --batch input lines on whitespace
Date: Thu, 11 Jul 2013 10:42:07 -0700
Message-ID: <7vvc4hq9hs.fsf@alter.siamese.dyndns.org>
References: <20130710113447.GA20113@sigill.intra.peff.net>
	<20130710114828.GH21963@sigill.intra.peff.net>
	<CALkWK0mGMZPWowZ0ULNuGKD8w2Q=kN0nEGaOkuWoYKmzD5zGrw@mail.gmail.com>
	<20130711113653.GD6015@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Duy Nguyen <pclouds@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 11 19:42:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxKsi-0005Hh-5M
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 19:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755885Ab3GKRmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 13:42:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43695 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751918Ab3GKRmL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 13:42:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2A512FCE4;
	Thu, 11 Jul 2013 17:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0FE60rt/JdddPQIqeTrWxK4pBhg=; b=oLUV0y
	XucZ+4gtmy9yZVAjuHzGb8bR3o8xOQUWF0mZIOOE5QFEcqc/FwLc/1OWiczKRBgf
	V2TAaoC/Azp0ZN6vKO4KITUrJthQKI8xN8S5Xo796fFwFvZvDvJBdCmAyBa7R6rp
	frlqMddFaG/Cgm3lYzAhpENWuBUVFdtjWnVPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=COu0cjlinOfrPRzziVOeKHKzTlm2Mqjc
	SwLqo3g3uoUXRz4J7c28kTZMGrVsuqOGtzye1E8y7TKVyc10fGN36HyJeF+XNBWm
	WfGFrwX2PDDIOaEgxw4EYlxx6d+3qOA9dljkY9QWzlkGYUfmoEU5umBXi+yh7e1b
	Pp1Ye72Qpu4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE6B82FCE2;
	Thu, 11 Jul 2013 17:42:10 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61D5A2FCD7;
	Thu, 11 Jul 2013 17:42:09 +0000 (UTC)
In-Reply-To: <20130711113653.GD6015@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 11 Jul 2013 07:36:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 36117460-EA51-11E2-A9ED-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230122>

Jeff King <peff@peff.net> writes:

> On Wed, Jul 10, 2013 at 08:59:51PM +0530, Ramkumar Ramachandra wrote:
>
>> Jeff King wrote:
>> >   git rev-list --objects HEAD |
>> >   git cat-file --batch-check='%(objectsize) %(text)'
>> 
>> If anything, I would have expected %(rest), not %(text).  This atom is
>> specific to commands that accept input via stdin (i.e. not log, f-e-r,
>> branch, or anything else I can think of).
>
> I considered %(rest) as well. I don't have a strong preference.
>
>> Also, this makes me wonder if %(field:0), %(field:1), and probably
>> %(field:@) are good ideas.  Even if we go down that road, I don't
>> think %(rest) is a problem per-se.
>
> I don't have a use for them, and even if we want to add them later, you
> would still want to support %(rest) for when the user wants to take the
> rest of the line verbatim without caring about field-splitting.
>
> To be honest, I do not see %(field) as all that useful. If you want to
> go about rearranging or selecting fields, that is what "cut" (or "awk")
> is for.  Having fields means you need to specify field separators, and
> how runs of separators are treated. Other tools already do this.

Very true, and more importantly, you cannot still say "my input
object name is at field N, not at the beginning", so that makes it
doubly dubious how %(field:$n) would be any useful.

> So it would (at best) save you from an extra cut invocation, whereas
> %(rest) gets you out of doing something much more difficult. Without it,
> information is lost from your pipeline (so you have to have tee to a
> separate pipeline, and then reassemble the pieces).
