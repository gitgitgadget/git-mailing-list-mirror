From: Junio C Hamano <gitster@pobox.com>
Subject: Re: sha-1 check in rev-list --verify-objects redundant?
Date: Sun, 26 Feb 2012 13:37:27 -0800
Message-ID: <7v1uphff8o.fsf@alter.siamese.dyndns.org>
References: <CACsJy8D_BdV14dGc2YsK91FrX8S=70DJOY3cU=oH3y41N2Ar0w@mail.gmail.com>
 <7vk43af14m.fsf@alter.siamese.dyndns.org>
 <CACsJy8BUeedTZSq_ay=JmqUt3wrnm6n1eOcFt0WPkEo2B-1zwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 26 22:37:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1lmi-0004Qk-RG
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 22:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053Ab2BZVhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 16:37:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61454 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753003Ab2BZVhb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 16:37:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51971676E;
	Sun, 26 Feb 2012 16:37:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lgFg6GbY9lEmWOe/95NUfdytu0M=; b=cMXjLg
	IYzSfY6fNpsb1lhs2ASKPIDuYQCOZr0R+WOnAuH/bHCz3HGX6bSam5DAaiqtdnqk
	raNDEB+8XIMbvRBYQm6oejVj3fKyDmkiBYHC0SlRqYFsO076k5Sz2R8nd5uaTJaG
	tf4SYcw5lvvpyuf/6azSBezxX13O0YYGkwTqI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JqXIr3VxVbSyFW8vMp6EWJ2Y5/n51qmM
	KspEn9NKNnhWjcPO1piS8kGOjAHlJJcNGriwIpZ2A2hNtHZVw9lNekPOs/vHUe7b
	9mG3CCsQeNb61bTwJEHOXw5SjFFEMGBIS/TUCKcKDCteMX2pG6hbfj8gedjYQb7d
	Qtd2YnTKeIA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49167676D;
	Sun, 26 Feb 2012 16:37:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A4354676B; Sun, 26 Feb 2012
 16:37:29 -0500 (EST)
In-Reply-To: <CACsJy8BUeedTZSq_ay=JmqUt3wrnm6n1eOcFt0WPkEo2B-1zwA@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sun, 26 Feb 2012 18:11:30 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1567330E-60C2-11E1-8562-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191576>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On the well-formedness, unless I'm mistaken, --verify-objects is
> _always_ used in conjunction with index-pack.

Hmm, you are making my head hurt.  Is the above "always" a typo of
"never"?

The static check_everything_connected() function in builtin/fetch.c is a
direct callsite of "rev-list --verify-objects", and the function is used
in two codepaths:

 * store_updated_refs() that is used after we receive and store objects
   from the other end.  We may or may not have run index-pack in this
   codepath; in either case we need to make sure the other side did send
   everything that is needed to complete the history between what we used
   to have and what they claimed to supply us, to protect us from a broken
   remote side.

 * quickfetch() that is called even before we get any object from the
   other end, to optimize the transfer when we already have what we need.

The latter is the original use to protect against unconnected island of
chain I explained in the previous message, but the former is also abot the
same protection, in a different callchain.

In both cases, the check by --verify-objects is about completeness of the
history (is everything connected to the tips of refs we have?), and is
different from integrity of individual objects (is each individual object
well formed and hash correctly?).  Both kinds of sanity need to be
checked, as they are orthogonal concepts.

In order to check the history completeness, we need to read the objects
that we walk during the check. I wouldn't be surprised if the codepath to
do this is written overly defensive, taking a belt-and-suspender approach,
and check the well-formedness of an object before it reads it to find out
the other objects pointed by it.

If we _know_ that we have checked the integrity of all the necessary
individual objects before we start reading them in order to check the
completeness of the history, there is an opportunity to optimize by
teaching --verify-objects paths to optionally be looser than it currently
is, to avoid checking the object integrity twice.
