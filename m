From: Junio C Hamano <gitster@pobox.com>
Subject: [1.8.0] (v2) default "git merge" without argument to "git merge
 @{u}"
Date: Mon, 31 Jan 2011 12:50:30 -0800
Message-ID: <7vzkqg4x2h.fsf_-_@alter.siamese.dyndns.org>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <7vsjw957fq.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Miles Bader <miles@gnu.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 31 21:50:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk0i1-0007cb-55
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 21:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189Ab1AaUun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 15:50:43 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48816 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753729Ab1AaUum (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 15:50:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9E5644115;
	Mon, 31 Jan 2011 15:51:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xESHzCiQTaDnj0n6NcExqwzkuIU=; b=DKJLgs
	kyaCHmfq/KQZjwpu99RsLIBwYEdbw4TlRQvT0BBcrQnJ4/QtBKXmRckyDoLGP0Is
	hoVZa2gXqPj3psagKVaqDuAzqNp5tAMQIPW8PZ/3Bszm7yV8OpUsQzwZLEw7uatK
	gLB94rbiFfu0FQy8nmGLi1id6CERv3KjKRnOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eJaiMgXMbVIEJzHcOWKJtgS3a71w3Phb
	pDy4+ez/cqzJ3l4vL8X9b76rSnmlzyRb9tIPhhG71ZkyypFV4Rf/OpexUY1lKAru
	cCJf7Lz439K+ugjJjLX3Vm1FwmmoPvMXH5EFPrRv2P0+491gvhJ8wbEc88qqoeCC
	jl/usiaEk7o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 508D14114;
	Mon, 31 Jan 2011 15:51:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0E0A94111; Mon, 31 Jan 2011
 15:51:24 -0500 (EST)
In-Reply-To: <7vsjw957fq.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 31 Jan 2011 09\:06\:33 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E0907110-2D7B-11E0-B1C7-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165750>

Ok, here is an update.

I wonder how we should keep track of the "proposal" series, though.
Sending the full-text replacement like I am doing here feels eh not
gittish.

Perhaps I should start a new directory in todo branch (say, 1.8.0), accept
patches from people?  I'd grudgingly admit that using Wiki on k.org may be
less burdensome (I hate editing inside the browser myself), but I'd want
to keep the mailing list the center of discussion and am afraid that
forcing people to go to Wiki would fragment the discussion.

I dunno.

--

Proposal:

Currently "git merge" without saying what to merge fails loudly.  As many
downstream developers (that are by definition more numerous than people
who do not have "upstream") run merge from the configured upstream of the
current branch most of the time, it would make it more convenient for them
to change the default to merge from the upstream of the current branch.
Running "git merge" without argument, when there is no upstream defined
for the current branch, will be an error.

Risks:

Existing scripts may prepare what to merge in an array (e.g. in Bourne,
accumulating them in "$@" by repeatedly doing 'set "$@" "$newbranch"') and
call 'git merge "$@"', relying on the current behaviour that zero argument
will flag an error condition.  Such scripts will be broken by this change.

Driving "git merge" with xargs without --no-run-if-empty (not POSIX),
feeding the branches to merge in an Octopus, will be broken the same way.

Migration plan:

Add merge.defaultToUpstream configuration variable, which defaults to
false when unconfigured.  Change "git merge" so that when this variable is
set and the command is run without the commit to merge to use the
configured upstream of the current branch (or error out if there isn't one).
Merge this change in the next 1.7.x series.

Update the error message issued when when "git merge" is run without the
commit to merge and this configuration variable is not explicitly set
either way to notify the user of upcoming incompatibility.

In 1.8.0, flip the default for merge.defaultUpstream to true.

Helped-by: Jeff King <peff@peff.net>
