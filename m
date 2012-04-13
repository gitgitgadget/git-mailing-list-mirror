From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] fetch: Only call a new ref a "branch" if it's under
 refs/heads/.
Date: Fri, 13 Apr 2012 15:39:59 -0700
Message-ID: <7vy5pz1cjk.fsf@alter.siamese.dyndns.org>
References: <1334336904-18649-1-git-send-email-marcnarc@xiplink.com>
 <20120413211350.GD7919@sigill.intra.peff.net>
 <20120413215316.GA19826@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, marcnarc@xiplink.com,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 00:40:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIpAE-0007OO-Te
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 00:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449Ab2DMWkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 18:40:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64785 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932443Ab2DMWkI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 18:40:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8A827086;
	Fri, 13 Apr 2012 18:40:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ax77Wu7NZADPnfTgDU6S7cwLZEI=; b=KcSVcv
	Q3RoxnJ9oSRFhjW9GWCgN5Q0dW4GlLm0gqvzXfncYMf5KkSoG7YOz0dpS/SNtJIn
	A+H9uGBvrr573mF0XN8hno9h/oURpyTP0MtpiEFwNlrtYsijDAUh/06DBxCNwBSr
	yy3SsOj/n4AEd/HXmGrlzUWeY1GeIQmrLrRz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pUMYHG/lXIR7+lqXINdn3AySE7p/+W2H
	bTVZ1iVnBf/WG81R7tA6b/NxFKmhBLB8mLtx6o7Pu8FKWPtHwaM/AReAqDYkArfJ
	X559EOlQ8wZWoohR15sJPjqg0wBg5cxUA34NSQfnK+wX3rdZPumyTMhMTHa2BlJ+
	Rdrn1AFyMbU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B20737085;
	Fri, 13 Apr 2012 18:40:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53F2C7083; Fri, 13 Apr 2012
 18:40:01 -0400 (EDT)
In-Reply-To: <20120413215316.GA19826@burratino> (Jonathan Nieder's message of
 "Fri, 13 Apr 2012 16:53:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9AFD1FC6-85B9-11E1-8527-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195451>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jeff King wrote:
>
>> Hmm. The ref->name we are comparing here is the local side. So if I am
>> fetching a new branch "foo" from the remote into a local
>> "refs/remotes/origin/foo" tracking ref, it used to say:
>>
>>     From ../parent
>>      * [new branch]      master     -> origin/master
>>
>> Now it says:
>>
>>     From ../parent
>>      * [new ref]         master     -> origin/master
>>
>> while refs/remotes/* are not technically branches in our side, I think
>> from the user's perspective, it is true that we have fetched a branch.
>> Should we be calling refs/remotes/* branches, too? Should we be checking
>> the remote's name for the item instead of the local one?
>
> The former sounds sensible.  Then once the default refspec learns to
> fetch into separate refs/remotes/origin/heads/* and
> refs/remotes/origin/notes/* namespaces the logic could be updated to
> write [new branch] or [new note collection] according to the
> situation.

If we give 'new branch' label for this case because we store it in our
'refs/remotes/*', a natural extension of it would be to redefine the rule
to narrow it to 'refs/remotes/*/heads/*' for using 'branch' when we
introduce 'new notes collection' label to give refs we are going to store
in 'refs/remotes/origin/notes/*'.  That is consistent with the former.

If we give 'new branch' label because refs/heads/master on the originating
end is what is shown on the line, a natural extension would be to use 'new
notes collection' label when we are fetching from refs/notes/* on the
originating end, and it does not matter where we store it, either our own
refs/notes/* or refs/remotes/origin/notes/*.  That is consistent with the
latter.

There is no concensus if refs/remotes/origin/notes/* hierarchy is a good
idea or not, but your argument does not support either side between the
former or the latter anyway, so I think it is irrelevant point to raise in
this discussion.

The choice between the two really depends on what information we are
trying to convey with this label.  Are we saying "Hey, we now have a new
'branch' on our side"?  Or are we saying "We found a new 'branch' over
there"?  It is unclear and you can argue both ways. Although I personally
think it is the latter, I do not have a strong opinion either way.

I am actually fine with just saying '[new]' without indicating what kind
at all, because the label is there only to fill the space where old..new
object names are usually shown.  We don't even say "[rejected branch]",
just "[rejected]" in the same place.
