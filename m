From: Junio C Hamano <gitster@pobox.com>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Tue, 22 May 2012 16:23:17 -0700
Message-ID: <7v8vgj3imy.fsf@alter.siamese.dyndns.org>
References: <4FB9F92D.8000305@alum.mit.edu>
 <3b77e2a3-872a-41c1-9a51-0f219a549c04@email.android.com>
 <20120522182157.GB20305@sigill.intra.peff.net>
 <201205221619.31738.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Wed May 23 01:23:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWyQf-0004w0-6h
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 01:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181Ab2EVXXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 19:23:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54751 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753056Ab2EVXXX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 19:23:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D5349338;
	Tue, 22 May 2012 19:23:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XS58wbWCLl0fsqPqNYvTIzpSndM=; b=bS2xHB
	eRbd2tUMOWSsQuYNR8y9g4JMLf2YfCt3tKUUn21gFeAQfqkFneIBl58g35CERLtb
	7cUDuu2uXxPSZWxbQ+I58nes4pJyNhf34JhJtGD+Cv3Y2xUUmmi6iB42u7Wbd+/O
	jKBU2gxHu9F1ghsIJ7pJhR5q1iXnNqLPKun6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Et4TMWVtgDsxckpuMlYx5YZUKLersdFj
	JIoidK8Zzhg8B0CrBrot9ftG9PXUcI+gaFXU4HI0bQlJgHggz9eVm3P4VaFKhLkz
	wwH6CHh234HPzZNK30Ugg5S9LbLcR7sW1VAOGcVbn6aCUuS8oRjQARjekSVKQQTz
	83PV8S/nFgU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8496B9337;
	Tue, 22 May 2012 19:23:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1277B9336; Tue, 22 May 2012
 19:23:20 -0400 (EDT)
In-Reply-To: <201205221619.31738.mfick@codeaurora.org> (Martin Fick's message
 of "Tue, 22 May 2012 16:19:30 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1EA8E566-A465-11E1-9F89-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198264>

Martin Fick <mfick@codeaurora.org> writes:

> Android consists of approximately 400 projects, and if 
> anyone tags their builds regularly, that means that they 
> will be tagging 400 projects per build.  We have something 
> like 10K tags on average across 400 projects, so when we do 
> a simple No Op sync just to see if all 400 projects are up 
> to date, this yields about 200MB of data over the wire (4M 
> refs)!!!
> ...
> As you can imagine, we really would like to see this 
> eliminated from our workflows.  If we want to check 400 
> projects to see if they are up to date, it should be 400 
> refs, not 400 * 10K.

I think we can ignore that 400 part from the above for now.  As they are
independent "projects", it is unreasonable to expect that any solution
would add costs less than linearly when you add more projects.  But it
should be possible to make the cost of update discovery comparable between
the cases where you have 10K existing refs that both ends have seen and
one ref got updated vs you started from 20K common refs.  The latter does
not have to cost twice (or 4 times if an inefficient way is quadratic).

I think the assumption in your build-bot scenario needs to be a bit more
clarified to give context.  I am assuming, when you say "see if projects
are up to date", you mean your build-bot is interested in a single branch
in each repository, possibly together with new tags that have become
reachable from the updated tip of the branch (if the branch tip moved).  I
also assume that the build-bot polls very often and that is why 200MB (or
divided by 400 it would be 0.5MB, which still is a lot when you talk about
a single repository) hurts a lot.

Everything below is what I think you already know about; I am giving an
overview of _my_ understanding of the issue for the benefit of others (and
have you sanity check if I misunderstood your pain points).

Even an attempt to optimize "can we skip updating" by asking "ls-remote"
about a single branch is futile with the current protocol, as we expect
the server to respond with the full ref advertisement and filter out the
result on our end.  In the upload-pack protocol, the serving side talks
first and that is "here are all the refs I have and their values".  The
other side that asks for objects does not have a way to tell it that it is
only interested in a subset, even if it wanted to.  Unlike the capability
exchange that happens after the initial connection, there is no gap in
the protocol for the side that initiates the connection to tell the
serving side to skip/delay the initial ref advertisement.

What the above means is that the transition has to happen by keeping the
current upload-pack and a new protocol has to be invoked by a different
program ("upload-pack-2" or something needs to be taught to the git-daemon
and also invoked by ssh) even if an updated protocol is designed. The
updated connection initiator (i.e. ls-remote and fetch) may be able to try
upload-pack-2 first and fall back to upload-pack after getting a failure,
but afaik nobody figured out if this is doable by checking if a failure
signal that comes from currently deployed software is detailed enough for
our side to tell if the failure is because the other end does not support
upload-pack-2 or because of some other failure (e.g. auth failed, no such
repo, etc.).  Regardless of auto-fallback, an updated connection initiator
needs a configuration switch to be explicitly told which protocol to talk
to with which remote.

What exact protocol "upload-pack-2" talks may be an interesting subject on
its own.  It may still have the serving side talk first (probably show its
capabilities and tips of branches if there are not too many of them), or
it may instead let the connection initiator talk first and ask for
specific set of refs.  But that is of lessor importance from the
high-level point of view and I won't go into the details in this thread.
