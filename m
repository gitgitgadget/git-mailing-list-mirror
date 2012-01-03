From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Submodules always use a relative path to gitdir
Date: Tue, 03 Jan 2012 10:27:30 -0800
Message-ID: <7vsjjwvdyl.fsf@alter.siamese.dyndns.org>
References: <1325192426-10103-1-git-send-email-antony.male@gmail.com>
 <7vsjk3vw67.fsf@alter.siamese.dyndns.org> <4F007492.8010909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antony Male <antony.male@gmail.com>, git@vger.kernel.org,
	iveqy@iveqy.com
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 03 19:27:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ri95H-0003of-Uj
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 19:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561Ab2ACS1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 13:27:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35123 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754538Ab2ACS1e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 13:27:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 961C67718;
	Tue,  3 Jan 2012 13:27:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SQiJM+gBWlQZSc0YmjRMPN2qJkk=; b=jn/9y0
	xg1x6PxtH0VbBUMfC73bl5swDqfj8gnTICdvbu7IXKxSBcktayMWkM7Nsagx7Ua7
	WLBJZBZCHR8QuiZdMSwsMu7pF4qTPSTHSHFY/g2LlDfcafn+xB2yybu5WCW0WBjY
	vjlxUZaSKC2e448b9e9ytF5pWQ7e1GpWyPchU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oNJeVwUvhBeMvnq3nv9WphBXTKOjSuyG
	dKp9qxjKFT0JgnGJhLLzmYc8V2cBJWvIk6M2eyJpESoy9W8RJ+uLTke2gqOQtn6F
	zz7i6iiaFL8/H45fGYwBtyQLA6YxS1U29sNW6iFcC/mjtzXf9JskrEUUrY/FrEHb
	XNIr/lT5zbk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D3FB7716;
	Tue,  3 Jan 2012 13:27:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5BF567714; Tue,  3 Jan 2012
 13:27:32 -0500 (EST)
In-Reply-To: <4F007492.8010909@web.de> (Jens Lehmann's message of "Sun, 01
 Jan 2012 15:58:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 99C7945E-3638-11E1-BD13-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187870>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 29.12.2011 23:40, schrieb Junio C Hamano:
>> Antony Male <antony.male@gmail.com> writes:
>> I further wonder if we can get away without using separate-git-dir option
>> in this codepath, though. IOW using
>> 
>>         git clone $quiet -bare ${reference:+"$reference"} "$url" "$gitdir"
>> 
>> might be a better solution.
>
> A quick test shows that using a bare repo won't fly because without the
> core.worktree setting commands that operate on the work tree can't be
> run anymore inside submodules (starting with the initial checkout). 

Probably the right thing to do would be to restructure the flow as I
suggested, i.e.

	if we do not have it yet
        then
        	git clone --bare ...
	fi
	# now we have it, make sure they are correct
	git config core.bare false
	git config core.worktree $there
        echo "gitdir: $here" >$there/.git

> Yes, and the core.worktree setting also contains an absolute path. So
> we must either make that relative too and rewrite it on every "git
> submodule add" to record the possibly changed path there or make the
> bare clone work with a work tree (which sounds a bit strange ;-).

Update of core.worktree has to be done regardless of the absolute/relative
differences anyway, no?

The first version of the superproject you trigger module_clone for
submodule $name may happen to have it at $path, module_clone notices that
you do not have it, and the initial "clone --separate-git-dir" will set
the core.worktree to $superproject/$path.  Nobody will update it after
that, even when we check out different version of superproject that has
the same submodule $name at a different location in the superproject.
