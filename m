From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: Modify push dialog to support Gerrit review
Date: Thu, 05 Sep 2013 11:19:02 -0700
Message-ID: <xmqqtxhzi12h.fsf@gitster.dls.corp.google.com>
References: <20130904150853.52EC4121B7E@jed-dev-01.labnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org, hvoigt@hvoigt.net
To: Joergen Edelbo <jed@napatech.com>
X-From: git-owner@vger.kernel.org Thu Sep 05 20:19:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHe9C-0004dX-NE
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 20:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089Ab3IESTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 14:19:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57537 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752303Ab3IESTI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 14:19:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A7713F0C1;
	Thu,  5 Sep 2013 18:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uxXWSd6KW57Ya1grtxoD4xjupi0=; b=hLK3eb
	8XmXmLox+AIl9CK74CJrvyTKwGmTvRPVSCND6BpvrJQvV6pXEOUPVHIvNCRtIKVW
	N2P91NO7hsTQFZ48+UMl9HJyZE7wHRem/S9ojdcXNDMRLqxV8BUub8aHBcJ0JZ7n
	uTwzSx+/zMEkqU7WYY3FSrKa9/IjgG/iiENeM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n843luANAguVuvbFEcaDcFBrNUhaHBUn
	G4ciRvaOHClt+V3dyWj4YOTKFOdTfX4+E0rJeTKdcWTOENVyXP/z4SEOduovPIVs
	OIXwlpshuUlQ5l2rn5wY17OTZ3ylbYsS/HiH5AdzVq5nizPtAMptSOma/ciEAeFs
	00wSvMNISBc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FE9B3F0BF;
	Thu,  5 Sep 2013 18:19:06 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C37E3F0B4;
	Thu,  5 Sep 2013 18:19:04 +0000 (UTC)
In-Reply-To: <20130904150853.52EC4121B7E@jed-dev-01.labnet> (Joergen Edelbo's
	message of "Mon, 2 Sep 2013 10:54:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A587C09C-1657-11E3-8DEC-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233976>

Joergen Edelbo <jed@napatech.com> writes:

> +proc get_remote_branch {} {
> +	global push_branchtype push_branch push_new
> +	set branch {}
> +	switch -- $push_branchtype {
> +	existing { set branch $push_branch }
> +	create   { set branch $push_new }
> +	}
> +   return $branch
> +}
> +
> +proc get_remote_ref_spec {} {
> +	global gerrit_review
> +	set push_branch [get_remote_branch]
> +	if {$gerrit_review} {
> +		return "refs/for/$push_branch"
> +	} else {
> +		return "refs/heads/$push_branch"
>  	}
> +}

I am puzzled.  This may be fine for those who use Git-GUI and
nothing else to push, but will not help whose who use both Git-GUI
and the command line.

Isn't the right way to improve the situation to let the command line
tools know how the user wants to push things out and just have
Git-GUI delegate the choice to the underlying "git push"?

For example, if you are working on a topic 'frotz', and if the
location you push is managed by Gerrit, isn't it the case that you
always want to push it to "refs/for/frotz", whether you are pushing
via Git-GUI or from the command line?

I think we discussed during 1.8.4 cycle a configuration like this:

	[branch "frotz"]
        	push = refs/heads/frotz:refs/for/frotz

as part of the "triangular workflow" topic that allows you to
specify that "when 'frotz' is pushed out, it goes to
refs/for/frotz", or something like that, but I do not recall what
came out of that.
