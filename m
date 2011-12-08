From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Parsing a subcommand using parse-options
Date: Thu, 08 Dec 2011 11:51:24 -0800
Message-ID: <7v4nxaj0zn.fsf@alter.siamese.dyndns.org>
References: <1323346028-9201-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 20:51:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYk0C-0001Fu-FM
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 20:51:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033Ab1LHTv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 14:51:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63453 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883Ab1LHTv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 14:51:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 959C16612;
	Thu,  8 Dec 2011 14:51:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i0HZ8vJx+NawXwpzDr+zUndRi1U=; b=oAlaHp
	rEMhqCKjt/8DQYELafWIlowMIqvmx+SyEHTLad64phtbKZbtlAjos/ofhx4BelR8
	PyE6Yi7T6/jw0NwHLbZL9D+JjqHZ1MTYgh8MBUe48jFEcVk52OAss5MIncpmeQPU
	1cdLlVqYHHbwk0a+BVSA9RsCm3mrOSBTyWWhc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S4TySb67gs5D4nsj5mr7IsVltOvpgSX3
	r8xQyXPJE4X3k7iX58KtBnpDCRSExU3pZ/hm12I7tuB1fg97hE6xfAi9pNU82z1t
	rFjcnqL70ddl2h0iswd8bdFA4FmyLw748HzWMNPt+pduYkyFQWQuMTIxFahsk0Xl
	xsdNwfaeE4M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B3786611;
	Thu,  8 Dec 2011 14:51:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1356B6610; Thu,  8 Dec 2011
 14:51:25 -0500 (EST)
In-Reply-To: <1323346028-9201-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Thu, 8 Dec 2011 17:37:06 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 035BEA7C-21D6-11E1-8CB0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186590>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>   git stash show
>             ^^ -- The subcommand "show" to the git-stash builtin

Contrasting this with "git tag --list", one uses subcommand verb while the
other uses operating mode option and one could say they are inconsistent.

But it does not bother me that much, and for a good reason other than
inertia.

When a command whose primary purpose is very clear (e.g. "git tag" and
"git branch" are primarily to create these things, just like "git commit"
is to create a commit), it is more natural to give the primary mode the
main interface so that you do not have to say "git tag create v1.0"; hence
operating mode option makes sense than subcommand.

On the other hand, when a command does not have a clear primary mode
(e.g. if you save a stash you must be able to use (i.e. apply or pop) the
saved one and both are equally important feature), but its primary purpose
is to dispatch various different operation, it makes more sense to name
them as subcommands. You _could_ make all of them into operating mode
options, but that only requires more typing, i.e. "git stash --save"/"git
stash --pop", without adding much value to the command. In addition, it
invites unnecessary confusion "what is the default mode of operation, and
is it really that important to be the default?", because not requiring an
explicit "subcommand" but merely allowing "operation mode option" implies
that you can say "git cmd" without anything, i.e. there must be some
default.

For "stash", "save" has been the default merely by historical accident,
but that has been rectified (it now requires you do not have any message
for the quick stash "git satsh<ENTER>" to work). There really isn't any
"default" operating mode to the command, and the command is a dispatcher
to its subcommands.
