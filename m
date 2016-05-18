From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git fetch origin $SHA1 doesn't work as often as it could
Date: Wed, 18 May 2016 14:59:34 -0700
Message-ID: <xmqq8tz7qb7d.fsf@gitster.mtv.corp.google.com>
References: <CAD0oC4yQzvAH=6a6Xgy6xOPoYCaO2zsDg5mDySkb6VJ6FdeeEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: JP Sugarbroad <jpsugar@google.com>
X-From: git-owner@vger.kernel.org Wed May 18 23:59:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b39VG-0000Ij-PK
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 23:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605AbcERV7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 17:59:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57162 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753207AbcERV7h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 17:59:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7AAF0190FA;
	Wed, 18 May 2016 17:59:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rNhgWcpIUETHvSHfCsy4egcqSsM=; b=iGGzp7
	hkN8cjLy5aXLU7deqnP88kBl8+WfzDUJp9tu+4b3xcUBEArEg/Nyh9T9K1wiPK/I
	9vmIvqNiVTKYNiyzm++HULzQDGY43nSyAOKO+P+gWCYoLkr7kWPi3AMi4DQz3c/4
	kmj0R/k9pHMHv2LdzQSqNCQrWDxJdbg40D3+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SgkYtb0n3foDoHPiHenrNJuAP3Mcnb/U
	cDiQ6WkcOq4PfYgY+15mdSXgmX3ivzEgVYM0JAZN6V6FIuFSAPtNju2GVwD0r5Mg
	YH8FtnnSlxFoqvt6hO1AmZpFLb7ha3MfgJ9D8ODQ7vo161MrZMGmGOmhWcgeWRwv
	9H7Sl73Gmik=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 73A60190F9;
	Wed, 18 May 2016 17:59:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E8D37190F8;
	Wed, 18 May 2016 17:59:35 -0400 (EDT)
In-Reply-To: <CAD0oC4yQzvAH=6a6Xgy6xOPoYCaO2zsDg5mDySkb6VJ6FdeeEQ@mail.gmail.com>
	(JP Sugarbroad's message of "Wed, 18 May 2016 16:20:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CF523CB8-1D43-11E6-92A9-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295015>

JP Sugarbroad <jpsugar@google.com> writes:

> So I'm trying to make cloning the rust repo a little easier, and I
> noticed there's a new feature to `git submodule update --depth=1` --
> but it doesn't work for this, even though it could.
>
> Reason is that fetch-pack will only fetch by sha1 if the remote
> specifies allow_tip/unreachable_sha1, even if the sha1 specified
> matches an advertised ref.

If a project wants its users to do the 'update --depth=1' thing, it
should allow fetching not just from the tip but also reachable.

The commit from the submodule that is bound to the superproject may
no longer be sitting at the tip of any branch in the submodule.  The
hack you are outlining here would not help, and invites "the feature
works some of the time (i.e. the commit happens to be at the tip of
one of the refs) but fails most of the time" bug reports.

So I am not enthused, even though at the technical level, I agree
that it is a good "solution" to pretend as if one of the refs were
requested after the fetch-pack discovers the refs advertised by the
upload-pack.

I just fear that it is a wrong approach to solve the real issue and
instead make it worse by relieving the pressure from the project and
hosting site to configure their repository to support their users
properly.
