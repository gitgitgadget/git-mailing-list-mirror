From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] `config branch.autosetuprebase true` breaks `rev-parse --is-inside-work-tree`
Date: Wed, 08 Oct 2014 10:35:46 -0700
Message-ID: <xmqqppe2bh1p.fsf@gitster.dls.corp.google.com>
References: <CAD77+gTuqbZimEK-=gXY8o4wFqOicFvnQ5MnV6Fq1npuckwYFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 08 19:36:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xbv9X-0008IQ-Dl
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 19:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614AbaJHRfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 13:35:51 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58867 "EHLO sasl.smtp.pobox.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751046AbaJHRfu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 13:35:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 948F612015;
	Wed,  8 Oct 2014 13:35:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rUTRyHaNCsZlYsM1zLsbTXi/GkU=; b=X1ybDz
	PdIktkLhi2xOVD0rp3DNluyQ1DdV5xwRaJSdoT2POQ9u+pCHjIH22gxL0Xsnmnx9
	HN3VFZMCh2KiODDMLSUSWTaA8Sf931NMrHTU/LjXVP/ZcUXDN0tGCEHyxcd2D9bI
	U7Nc8ZQ7QuCtv9muYlnIDs9vRbhquD/L2F1IY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=THGWGpGI3Ot1/mUzy4p6na1cdtN8RyoF
	CSf28aq6zZdOlBdKGEUTxt5+j1p9YGBne1jaTYrAcFSYIS4mTrz8lOBV2vUn5gKN
	ErdcpmvGnlRC4lq1kqZCGfA8Ku76YEW4QLAzpUTXxC0oWO5uVF3btEtT6WHYDV0P
	ghKQ00plQ1g=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A48612014;
	Wed,  8 Oct 2014 13:35:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F04F12011;
	Wed,  8 Oct 2014 13:35:48 -0400 (EDT)
In-Reply-To: <CAD77+gTuqbZimEK-=gXY8o4wFqOicFvnQ5MnV6Fq1npuckwYFQ@mail.gmail.com>
	(Richard Hartmann's message of "Wed, 8 Oct 2014 13:22:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8A4DD30E-4F11-11E4-B433-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Richard Hartmann <richih.mailinglist@gmail.com> writes:

> So this is not a real bug report, more of a "is this intended this way?"
> richih@titanium  ~/git_test % git rev-parse --is-inside-work-tree
> error: Malformed value for branch.autosetuprebase
> fatal: bad config file line 8 in .git/config
> richih@titanium  ~/git_test % cat .git/config
> ...
> [branch]
> autosetuprebase = true

It does not seem to be limited to rev-parse but having a malformed
configuration for that variable would break everything Git, which
certainly is not how it is supposed to work.  It also seems that the
breakage dates back very far into the past (I checked 1.7.0 and it
seems to be broken the same way).

The same breakage exists for branch.autosetupmerge, I think, e.g.

	[branch]
                autosetupmerge = garbage

In config.c, git_default_branch_config() must be corrected to set
git_branch_track and autorebase to BRANCH_TRACK_MALFORMED and
AUTOREBASE_MALFORMED and the users of these two variables must be
fixed to deal with the "malformed in the configuration" cases, I
think.  The error should happen only in the codepath where we need
the value, and no other places.
