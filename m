From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cherry-pick: allow to pick to unborn branches
Date: Tue, 07 Jun 2016 00:03:28 -0700
Message-ID: <xmqqoa7dscov.fsf@gitster.mtv.corp.google.com>
References: <afafa51c-f950-594e-7142-5b28b1182add@drmicha.warpmail.net>
	<69f7973e353f52a62157ca59af5027c9617506a4.1465219182.git.git@drmicha.warpmail.net>
	<xmqq7fe2w087.fsf@gitster.mtv.corp.google.com>
	<88c61a4d-abee-2c01-a521-8094b4baf3ac@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Fabrizio Cucci <fabrizio.cucci@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jun 07 09:03:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAB34-0001me-FG
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 09:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314AbcFGHDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 03:03:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65435 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750974AbcFGHDb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 03:03:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 851D817B33;
	Tue,  7 Jun 2016 03:03:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xTnSHFlJueYRostnRWpvK8I1mSI=; b=UzcDZZ
	2sB7xsNAY7LPJi/2Tqc9E2anwyorEbxq3JZOJvn2YbvGb2fg7vhdaCN4AlL5Ep4B
	HAXCk3wFrglP/W3qC9D5dwszszIdWxSN/xM8deTkEcchXh2FztksRNzPyc19YXd6
	IKCQxyMOjSybFCuPYS4dJFAgn6szTTfq28RB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R/85OL+cthGeKxdO/OKgtv+BWeMedO3a
	u6oKY6Nos3Yub3CZx6UWleJ8qTXvNs84EaaBzrJwtte9PNinUcXjba8cPhHif+zP
	3XHLpLjp4t8vor82XHxMD3IXdewiSznPEuYh3p91X+6RfrGJKdOjx5zrFY774q/V
	zdtwcBPi2fc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E22F17B31;
	Tue,  7 Jun 2016 03:03:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0BB4817B30;
	Tue,  7 Jun 2016 03:03:29 -0400 (EDT)
In-Reply-To: <88c61a4d-abee-2c01-a521-8094b4baf3ac@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Tue, 7 Jun 2016 08:37:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F09AE64C-2C7D-11E6-9FA1-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296607>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Here and below, I'm mimicking/copying the behavior that we have right
> now already. I asked myself the same question - rolling back to orphan
> state shouldn't be that hard after all. But that would be a change in
> behavior that - if considered a fix/improvement - would be orthogonal to
> the multi-pick fix.

Hmph, OK.

>>> @@ -1086,11 +1090,8 @@ int sequencer_pick_revisions(struct replay_opts *opts)
>>>  	walk_revs_populate_todo(&todo_list, opts);
>>>  	if (create_seq_dir() < 0)
>>>  		return -1;
>>> -	if (get_sha1("HEAD", sha1)) {
>>> -		if (opts->action == REPLAY_REVERT)
>>> -			return error(_("Can't revert as initial commit"));
>>> -		return error(_("Can't cherry-pick into empty head"));
>>> -	}
>>> +	if (get_sha1("HEAD", sha1) && (opts->action == REPLAY_REVERT))
>>> +		return error(_("Can't revert as initial commit"));
>> 
>> Not a new issue, but I cannot quite fathom what this error message
>> wants to say.  "Can't revert an initial commit"?
>
> Cannot create a "revert commit" as the initial commit on a yet unborn
> branch. Maybe "nothing to revert" would be clearer, but then another
> user might ask: If I say "git revert deabeef" and there is a commit
> "deadbeef" then why is there "nothing to revert"?
>
> Applying the reverse of a patch to an empty tree should result in an
> empty tree, and creating a commit with that empty tree as "This reverts
> commit deadbeef" is what we are refusing here, unless I'm confused.

OK, so the message wants to say "a revert cannot be recorded as
initial commit" (because the original change has to be one that
results in an empty tree to be able to sanely be reversed its effect
on top of an empty tree)?  That interpretation is understandable.

But that still sounds like a fishy logic.

A root commit should be cherry-pickable as it is a change to
whatever state from an empty tree, and we do allow it.  The same
reasoning suggests that if you find a change that makes the tree
empty, such a change should be revert-able on top of an empty tree.

In fact, we do allow cherry-picking a non-root commit onto an empty
tree, as long as the changes are all about creating new files.  So
perhaps a change that only removes files should be revert-able on
top of an empty tree?

In any case, this topic is not about fixing that semantics of the
revert and it is a tangent.  I'll just leave the usual "low hanging fruit"
mark so that people can list-archive-search for that string to find
it as a possible mini-project to allow reverting such a change on top
of an empty tree.

Thanks.
