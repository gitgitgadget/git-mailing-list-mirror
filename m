From: Junio C Hamano <gitster@pobox.com>
Subject: Re: error: src refspec refs/heads/master matches more than one.
Date: Tue, 18 Feb 2014 11:03:10 -0800
Message-ID: <xmqqha7wfdld.fsf@gitster.dls.corp.google.com>
References: <20140214113136.GA17817@raven.inka.de> <87a9dt981o.fsf@igel.home>
	<CACsJy8BevKQaRLYMMv7bTjf_ZAOnkrimws519OyhGZz6_Vr_-A@mail.gmail.com>
	<xmqqy51dirjs.fsf@gitster.dls.corp.google.com>
	<20140215085355.GA15461@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Josef Wolf <jw@raven.inka.de>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 18 20:03:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFpxC-0000D9-3d
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 20:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbaBRTDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 14:03:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38940 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126AbaBRTDd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 14:03:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 837FE6DFD6;
	Tue, 18 Feb 2014 14:03:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jYLhhE9VXCjGO2klzHERvkifqM4=; b=KXFuVF
	7mH+HM1RRrC0r6I40yu69RygXkdf+MTFzTyKgCRsi9I3ma6QyMwatOiAZrEv8LId
	/eOAoY5pv+9sC9GiDxPT509u/Q1vrEB4zOHI3+Bk+6fsTyRaapP0VcFvfySglHO/
	lnAGqHWf9/UkBKuPcPCHx46vhvo+nVu4azTtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m1dyWAKudFjL0kv81Qvq9GJtLy61ONM7
	Wz0YclSW0vAsC9PPgk1ZI1qje7WzPJgglvjoAKAd5D/wOM0T9SM7Hex8QFkNcDIN
	/nA5XK83AblxEFlM/dsTIvSeSWoxfDee4P2ZLAETCkvAwDZc0gyTidrpt0IwtjOg
	d9iawBoISic=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E55D6DFCC;
	Tue, 18 Feb 2014 14:03:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 664B46DFC4;
	Tue, 18 Feb 2014 14:03:17 -0500 (EST)
In-Reply-To: <20140215085355.GA15461@lanh> (Duy Nguyen's message of "Sat, 15
	Feb 2014 15:53:55 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 56EAC146-98CF-11E3-97BE-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242337>

Duy Nguyen <pclouds@gmail.com> writes:

> Prevent is a strong word. I meant we only do it if they force
> it. Something like this..
>
> -- 8< --
> diff --git a/branch.c b/branch.c
> index 723a36b..3f0540f 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -251,6 +251,11 @@ void create_branch(const char *head,
>  			forcing = 1;
>  	}
>  
> +	if (!force && dwim_ref(name, strlen(name), sha1, &real_ref))
> +		die(_("creating ref refs/heads/%s makes %s ambiguous.\n"
> +		      "Use -f to create it anyway."),
> +		    name, name);

Does this check still allow you to create a branch "refs/heads/next"
and then later create a branch "next"?  The latter will introduce an
ambiguity without any prevention, even though the prevention would
trigger if the order in which these two branches are created is
swapped--- the end result has ambiguity but the safety covers only
one avenue to the confusing situation.

And the only way I can think of to avoid that kind of confusion is
to forbid creation of a subset of possible names by reserving a set
of known (but arbitrary) prefixes---which I am not sure is a good
way to go.  At least not yet.

So...
