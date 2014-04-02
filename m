From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 18/27] update-ref --stdin: Harmonize error messages
Date: Wed, 02 Apr 2014 09:38:01 -0700
Message-ID: <xmqq61mry9ee.fsf@gitster.dls.corp.google.com>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
	<1395683820-17304-19-git-send-email-mhagger@alum.mit.edu>
	<xmqqy4zq2g0b.fsf@gitster.dls.corp.google.com>
	<5339EE33.7050708@alum.mit.edu> <533A86F2.90508@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:54:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeS6-0000xS-Az
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 12:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbaDBQiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 12:38:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61863 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932456AbaDBQiI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 12:38:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC385773DB;
	Wed,  2 Apr 2014 12:38:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FV2vIGkRDWVqya5tD/0ktFx2Fl4=; b=XzN5CN
	KvOyMqbQPqkdkXVyvSsAt7/5zjnBUvZy9d75fwhtdsWLgktLJiuwPxxAPKsurlWf
	/eQf0PF1RNDK6Ys5A2Pfy4t4TYWEU7Q4taU+vv/btyeceH1K7ezuwJSqWcKjwcEX
	w3yCszBF/n7jTvESRhpNCPaPcNE+vTSdSbNkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AwHmQ+kqPksOmcunDWLMwXETBE7f0AQg
	yRBieafRjiA/Euf+bGD2JPckwNQQCT68S3Swy12DDg4TSthqmdlfmuqMjRvDSxYR
	cxeEXJ6YhMZiwYdnVxAzYqYTS5ndI8VH5PqKTRPfqCnQO2LPD6FgTNUVAKi6eZB+
	5/bfEbAmnVY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9E6C773DA;
	Wed,  2 Apr 2014 12:38:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2A08773D8;
	Wed,  2 Apr 2014 12:38:05 -0400 (EDT)
In-Reply-To: <533A86F2.90508@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 01 Apr 2014 11:29:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2B3C33EA-BA85-11E3-8D69-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245699>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Junio, I incorporated your feedback (which so far has only affected
> commit messages).  I also rebased the patch series to the current
> master.  I pushed the result to GitHub [1].  I'll refrain from spamming
> the list with v3 yet.

Thanks; let us know when you are ready ;-) I finished reading the
remainder of the v2, and I think I sent out what I found worth
commenting on (either positive or negative).

I think the next thing to convert to the transaction API would be
the "ok we know the set of updates from the pusher; let's update all
of them" in receive-pack?  In a sense that is of a lot more
real-world impact than the update-ref plumbing.  

           Side note: honestly speaking, I was dissapointed to see
           that the ref updates by the receive-pack process was not
           included in the series when I saw the cover letter that
           said this was a series about transactional updates to
           refs.  Anyway...

There are a few things that need to be thought through.

Making the update in receive-pack all-or-none is a behaviour change,
even though it may be a good one.  We may want to allow the user a
way to ask for the traditional "reject only the ones that cannot be
updated".  It probably goes like this:

 - On the wire, a new "ref-update-aon" capability is
   advertised from receive-pack to send-pack and can be requested in
   the opposite direction.

 - On the "git push" side, a new "--all-or-none" option, and
   optionally a new "push.allOrNone" configuration, is used to
   request the "ref-update-aon" capability over the wire.

 - On the receive-pack side, a new "receive.allOrNone" configuration 
   can be used to always update refs in all-or-none fashion, no
   matter what the pusher says.

 - The receive-pack uses the ref transaction to update the refs in
   all-or-none fashion if it has receive.allOrNone, or both sides
   agree to use ref-update-aon in the capability exchange.  If not,
   it updates the refs in some-may-succeed-some-may-fail fashion,
   one by one.

Or something like that.
