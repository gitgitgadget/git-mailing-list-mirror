From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] New sequencer workflow!
Date: Sun, 13 Nov 2011 12:56:36 -0800
Message-ID: <7v39droi63.fsf@alter.siamese.dyndns.org>
References: <1321181181-23923-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 13 21:56:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPh6h-0001a4-9o
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 21:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444Ab1KMU4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Nov 2011 15:56:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48487 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096Ab1KMU4i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2011 15:56:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B3EC53D4;
	Sun, 13 Nov 2011 15:56:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sP53fZYDA3BxJ+ImemhMI6IAxyc=; b=FexRT6
	sSdx0eeZfFZJlWQEAVgTlZAExRh97liG+tpk5g0BpkIsVSoDcD8a5WOxF7htSfMQ
	il6cZmO6+E/2hDP0fNTDgi2T3yXNwPbuwHql37ON8aR1POUjakyHmGU4auyqdRH/
	Oyp2NoPEEdRhOUG6DRCQ3XegXCjSZsZGO8TqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HiseMKjYDxZYT6SJp5pgw2hL3wOicebM
	uqDt7FaJWkQQ96a9mk0VtNwY7P9Na6TO0DTTvxz1O01+VD3CEAMXLqxSYlupyZOn
	8mJK4ogwywNAC00c4bZt0sRphrJZ5GZl1iZE7X1J6/aRhslgVXBHR+RKzFrgDwEm
	nzWieIR24+s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6284A53D3;
	Sun, 13 Nov 2011 15:56:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E84A953D2; Sun, 13 Nov 2011
 15:56:37 -0500 (EST)
In-Reply-To: <1321181181-23923-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Sun, 13 Nov 2011 16:16:14 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FAB0908A-0E39-11E1-BF62-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185349>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> This series preserves the old workflow:
>
>   $ git cherry-pick foo
>   ... conflict ...
>   $ echo "resolved" >problematicfile
>   $ git add problematicfile
>   $ git commit
>
>   $ git cherry-pick foo..bar
>   ... conflict ...
>   $ echo "resolved" >problematicfile
>   $ git add problematicfile
>   $ git commit
>   $ git revert --continue # No, there are no typos

Hmm, doesn't "git add && git cherry-pick --continue" (i.e. no "git commit"
in between) trigger the "commit the resolution first and then go on"?

> And introduces a brand new workflow:
>
>   $ git cherry-pick foo
>   ... conflict ...
>   $ echo "resolved" >problematicfile
>   $ git add problematicfile
>   $ git sequencer --continue
>
>   $ git cherry-pick foo..bar
>   ... conflict ...
>   $ echo "resolved" >problematicfile
>   $ git add problematicfile
>   $ git sequencer --continue
>
>   $ git revert moo..baz
>   ... conflict ...
>   $ echo "resolved" >problematicfile
>   $ git add problematicfile
>   $ git sequencer --continue

Almost. If these are replaced with "git cherry-pick --continue" and "git
revert --continue" that internally triggers "git sequencer --continue"
*and* errors out if a wrong command was used to "--continue", it would be
perfect.

The longer-term ultimate goal would be to make it "git continue" that
covers more than the sequencer based workflow, i.e. allow "git merge" that
conflicted to be concluded with "edit && git add && git continue".
