From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] clone: add clone.recursesubmodules config option
Date: Thu, 05 Jun 2014 11:18:28 -0700
Message-ID: <xmqq4mzzte2z.fsf@gitster.dls.corp.google.com>
References: <xmqqoay9wvo6.fsf@gitster.dls.corp.google.com>
	<1401874256-13332-1-git-send-email-judge.packham@gmail.com>
	<xmqqvbsgvb9l.fsf@gitster.dls.corp.google.com>
	<538F6E52.9000009@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org,
	mara.kim@vanderbilt.edu, Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Jun 05 20:18:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WscFQ-0007jz-8A
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 20:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbaFESSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 14:18:40 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56156 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980AbaFESSj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 14:18:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B9AF11CB99;
	Thu,  5 Jun 2014 14:18:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eHonsVxmUfz8S/Q6TBpAa1ZMm1k=; b=MjmKhy
	nEJQrEavpUoUW8B2N/cM+oy791DKC6JQRmCT1lDX6NNv8zU7tIXZ31bV+B0kwowz
	hXeqt/ZI0UOlnfn8ouSplFzWijaotiG91zoEyP4SgoXyQpzZytB5gfK7SHcCX303
	FiZztUVXwaREcwYAORLH1DZ3VAxbfPKEfVeJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s2o34xz66lKRMmpcRz0vqKwoSADKWuqY
	XnUugWw9IJD/pd/lepjF6wsKy7CMpWhB3aqgaELZuwGkxGYnNTBYqZ2UXvDNJGpl
	92Pf16403jT6+/x2DKKLyc1wRLOJru3I1N28dsE+wr5zpprVkJB4AuNeu0gnm+aQ
	PDPFDaD9bdQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AED031CB98;
	Thu,  5 Jun 2014 14:18:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EC5941CB93;
	Thu,  5 Jun 2014 14:18:29 -0400 (EDT)
In-Reply-To: <538F6E52.9000009@web.de> (Jens Lehmann's message of "Wed, 04 Jun
	2014 21:06:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CBB06050-ECDD-11E3-8FB8-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250853>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> ... I believe we
> should have one or two switches telling Git "I want my submodules be
> updated without having to use the 'git submodule' command". And
> after that submodule specific overrides can kick in, e.g. when
> "submodule.<name>.update" is set to "none" the submodule won't be
> updated no matter how the default is.

OK, so submodule.*.update for each submodule, and a default value
for submodules that do not have submodule.*.update set to anything.

Sounds workable.

> We had two settings in mind,...
> So what if clone would just do an "git submodule init" for now when
> "submodule.autoinit" is set but "submodule.autoupdate" isn't [?]
> ... and a single "submodule.auto" setting would be what users really want?

I do not offhand think of a sensible scenario where you want to init
a submodule once but do not want to update it when the superproject
changes.  Even if the user uses the mode to detach the submodule
HEAD, i.e. the branches in submodules do not matter and the whole
tree is described by the superproject's commit and gitlinks recorded
in it, the user would want the new objects necessary for the updated
superproject, which means a submodule that is init'ed (whether it is
via "git submodule init" or the submodule.autoinit variable) must be
updated.

So I am not sure why a user wants to disable autoupdate in the first
place.  For the same reason, setting submodule.*.update to none
would not make much sense, either.  Perhaps I am missing something.

Unless the user is very conservative and suspects that these
recursive behaviour we are going to bolt on to various commands
could be buggy and untrustworthy, in which case the user might want
to manually run "git submodule update", or even run "git fetch"
after going there while bypassing the whole "git submodule".  But I
do not think that is healthy in the longer run.
