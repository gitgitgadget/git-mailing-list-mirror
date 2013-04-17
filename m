From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Wed, 17 Apr 2013 08:24:12 -0700
Message-ID: <7vd2ttgoyr.fsf@alter.siamese.dyndns.org>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
 <87txn5xzdn.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Apr 17 17:24:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USUDc-0005bt-OA
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 17:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754316Ab3DQPYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 11:24:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61187 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038Ab3DQPYP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 11:24:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91A7417E38;
	Wed, 17 Apr 2013 15:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FWNBJLdHfUJnzdKbLqX+LVQnG6c=; b=nnghTs
	a9pSCUEydpKlwFB9pHpCikNexRTYe4EFJ0vkB0rgGc6auQwhmqgoTj2HE+wf2fYZ
	GrGmJ5GcBfQ89eJAhRKQ4irKGnRgyHNshFFwNPhAENyVTbNw6ycHLMrF2EVfgpRm
	CwAymyV+jPg7W5LgcvOZ1EBSd2TUSPmoqAUYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oAZ0xeRwGN9itPR/vwReSGFdSwPUnIOQ
	4nE4OIOQj43cC25I1IDgwPvo6xU2u7JWDkZhM8mTJ2Mkud/4i769n4GEEtiAsN+B
	Td/xsnR+1cApiN966AHA0uaq9HQLsjVf05jzmWGDHRKzNUG4Oqf7F7uL1EzDJWSE
	oQ6Vkpk3o9o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 895BE17E37;
	Wed, 17 Apr 2013 15:24:14 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D6BC17E36; Wed, 17 Apr
 2013 15:24:13 +0000 (UTC)
In-Reply-To: <87txn5xzdn.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's
 message of "Wed, 17 Apr 2013 11:47:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DC6AB154-A772-11E2-AED0-CC48E7F0ECB6-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221544>

Thomas Rast <trast@inf.ethz.ch> writes:

> The warning triggers in some cases where it shouldn't, relating to
> submodules:
>
>   $ git submodule add gitosis@git.csa.inf.ethz.ch:domjudge.git domjudge
>   Adding existing repo at 'domjudge' to the index
>   warning: In Git 2.0, 'git add <pathspec>...' will also update
>   the index for paths removed from the working tree that match
>   the given pathspec. If you want to 'add' only changed
>   or newly created paths, say 'git add --no-all <pathspec>...' instead.

Good one.  So "add" used internally there needs to say --no-add?

> It also seems to hint that the problem is with giving a 'pathspec', but
> in fact in the case of a "proper" pathspec (that isn't an existing path)
> it does *not* trigger, even though it probably should:

We have seen users who explicitly say:

	git add dir

after removing dir/del and adding dir/ins got surprised that we do
not notice removal of dir/del without "add -A".  And it is fairly
straight-forward to check and warn for such a case.

> That's of course assuming that you want to unconditionally make -A the
> default.

I thought what the warning text says is what we decided to do
eventually.  Not "unconditionally", but "with <pathspec>", but not
"only with pathspec that exactly matches an existing path".  It
appears that we would better discuss and decide such details
further, so let's revert the "warn early" bits from master and kick
the topic back.
