From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 05/16] ref-filter: move get_head_description() from branch.c
Date: Wed, 30 Mar 2016 15:16:13 -0700
Message-ID: <xmqqy48zr4r6.fsf@gitster.mtv.corp.google.com>
References: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
	<1459330800-12525-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jacob.keller@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 00:16:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alOPU-0005GS-SA
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 00:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754402AbcC3WQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 18:16:16 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:63593 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753860AbcC3WQP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 18:16:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B28D251834;
	Wed, 30 Mar 2016 18:16:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZreLIsYThB0fVjjdRFWKN4naP6I=; b=W3fBQ/
	tWt+j8kxWKwoWN3BofH3Mnu9tg+O+ERfNLpGmco4JBZT59NlZ0QkWZ1ADnRTjE3D
	tC/66RyMPAUqpRUzfXnyxv3p2cdcs60m3J4NQl2mD/SXdaurlM9JW1sqZ8WP/oC1
	eJCnoBj5jGtvJgongrCxMwUwo2QkBGIBNvQu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RgJvlLuLBvSYnlGZRsip0VE3KHh8Spxo
	c5xzh6M8nqL5gL48yOKpHZRfKxLtn7mD1KSaa9n5PU3vSM6JnIzJZxNuK0pyz65n
	8mo2vwDiAS7imBgeaXVXxhulYyrs90N+3U5bp/qfiICfM+Uuvt/u4Xzx4eYB/Hry
	XxvssdvGCqU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AADEF51833;
	Wed, 30 Mar 2016 18:16:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 291F551832;
	Wed, 30 Mar 2016 18:16:14 -0400 (EDT)
In-Reply-To: <1459330800-12525-6-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Wed, 30 Mar 2016 15:09:49 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0410552A-F6C5-11E5-9388-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290352>

Karthik Nayak <karthik.188@gmail.com> writes:

> -static char *get_head_description(void)
> -{
> -	struct strbuf desc = STRBUF_INIT;
> -	struct wt_status_state state;
> -	memset(&state, 0, sizeof(state));
> -	wt_status_get_state(&state, 1);
> -	if (state.rebase_in_progress ||
> -	    state.rebase_interactive_in_progress)
> -		strbuf_addf(&desc, _("(no branch, rebasing %s)"),
> -			    state.branch);
> -	else if (state.bisect_in_progress)
> -		strbuf_addf(&desc, _("(no branch, bisect started on %s)"),
> -			    state.branch);
> -	else if (state.detached_from) {
> -		/* TRANSLATORS: make sure these match _("HEAD detached at ")
> -		   and _("HEAD detached from ") in wt-status.c */
> -		if (state.detached_at)
> -			strbuf_addf(&desc, _("(HEAD detached at %s)"),
> -				state.detached_from);
> -		else
> -			strbuf_addf(&desc, _("(HEAD detached from %s)"),
> -				state.detached_from);
> -	}
> -	else
> -		strbuf_addstr(&desc, _("(no branch)"));
> -	free(state.branch);
> -	free(state.onto);
> -	free(state.detached_from);
> -	return strbuf_detach(&desc, NULL);
> -}
> -

Hmph, the name used to be a good one within the context of
implementation of "git branch" command, but I have to wonder if it
is a specific enough name in the global context of the entire
project.  I also wondered if this sits better in wt-status.c;
doesn't "git status" do something similar?

For now, this should do, as I do not think of anything better.  

Thanks.
