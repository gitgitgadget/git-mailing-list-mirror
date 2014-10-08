From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] `config branch.autosetuprebase true` breaks `rev-parse --is-inside-work-tree`
Date: Wed, 08 Oct 2014 10:52:12 -0700
Message-ID: <xmqqlhoqbgab.fsf@gitster.dls.corp.google.com>
References: <CAD77+gTuqbZimEK-=gXY8o4wFqOicFvnQ5MnV6Fq1npuckwYFQ@mail.gmail.com>
	<xmqqppe2bh1p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Tanay Abhra <tanayabh@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 08 19:52:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbvPS-0007RF-4V
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 19:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754026AbaJHRwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 13:52:18 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56425 "EHLO sasl.smtp.pobox.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752640AbaJHRwP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 13:52:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A3C241268B;
	Wed,  8 Oct 2014 13:52:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+VIHnxQL28SRlpRvMdStUm+tB7I=; b=xkb6dB
	HaO2Lq9s8vLXJgNmnoQG8N/HA62ligWk2FhRpFa2GKdnoayg0E2EfFipqFl86Ghw
	Kvrn/3cyJ0cHQRAsHt9u/dsUGmgEKgroLfuqGTMoRv1nbFUbJUqpQmsE6JGl+Qn7
	Wv1z3kLHvCorNMqX/xSXjtNxN8okMC31bdEBI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q677fmjozzjIv+2S0DfZ+Q/HaoQSHC4B
	0ZkEXCgbOFg4ixOQeXOMpsWA0WxqCQmCi3a6hEjtHQ+Tg8b1FwzZo4/aUBNG2QVV
	T1pn6be41b7hJAOhBhLQlUzz0U9XjroLEi0I3glVlPEbo0RU792x2vbo/ZmyC+KY
	1D2HH5ytMXQ=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A9D51268A;
	Wed,  8 Oct 2014 13:52:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F2AFA12687;
	Wed,  8 Oct 2014 13:52:13 -0400 (EDT)
In-Reply-To: <xmqqppe2bh1p.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 08 Oct 2014 10:35:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D5ED9374-4F13-11E4-A21C-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> In config.c, git_default_branch_config() must be corrected to set
> git_branch_track and autorebase to BRANCH_TRACK_MALFORMED and
> AUTOREBASE_MALFORMED and the users of these two variables must be
> fixed to deal with the "malformed in the configuration" cases, I
> think.  The error should happen only in the codepath where we need
> the value, and no other places.

Having said that, given that any call git_config_bool() inside a
callback function given to the git_config() will stop Git from doing
anything even if the variable with a malformed value in quesiton is
not used by the operation at all, and there are very many of them
(e.g. setting core.filemode to "treu" would break everything), it
appears to me that:

 (1) it could be argued that catching obvious typos in the
     configuration file as early as possible, even if the variables
     with typos are not used for the particular operation, is even a
     feature, as long as you can fix the brekage with "git config"
     (and/or your editor);

 (2) it is too much pain to shift the error checking to the site of
     their use from the site of their parsing anyway ;-)

And I suspect Tanay and Matthieu's recent work is taking us to a
direction where many code paths do not use the config callbacks
(which is what leads us to detect errors at parse time even for
variables that are not used) and instead allow the callers that care
about the individual variables to diagnose errors at the site of
use.  So as you stated originally, this may not be something we want
to patch up in the current callback based config system.
