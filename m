From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Passing rev-list options in git-filter-branch broken
Date: Fri, 27 Jun 2014 11:31:13 -0700
Message-ID: <xmqq1tua2oi5.fsf@gitster.dls.corp.google.com>
References: <987cd4ccd2b86a840b900a25e0edf0f9@tribut.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felix Eckhofer <felix@tribut.de>
X-From: git-owner@vger.kernel.org Fri Jun 27 20:31:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0avm-0001xQ-Gy
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 20:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbaF0SbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 14:31:22 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56157 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990AbaF0SbV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 14:31:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5359021034;
	Fri, 27 Jun 2014 14:31:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S/GsLdz02iy9qCPbwZ2n26Bzqgw=; b=Q4yogE
	zFn8UjDw9hGT9F53xE5hxEUCCE8UEKVB4dB3R3m4fg/eGtIS2npRTzM4WUdr1KRy
	mcPygjziEADD2FGG4cTIsQmteupbAaR0AYr32OO3L4x4K4Kewtr3qBABVy5nqd84
	d7pIGR47KIhuVqotezQp5Ws3Gnk6gdCCE9Ovo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N6VdFKJcoWSY8h8It75zTk48PbFH6r76
	+1G0tW21H3D0P1Kxf7bzNqhoFn1hUVfmZBgW1xAYWlGM/Q+dqwjwhXH4M1E13wbn
	TLf+6KflN5wt4QTDgudPA+Oq32eEP7mnbifkLAlFiszMM94VySzTpYegNHFc+mnQ
	caMhePl4IMg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2896E21033;
	Fri, 27 Jun 2014 14:31:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4E0AB2102B;
	Fri, 27 Jun 2014 14:31:07 -0400 (EDT)
In-Reply-To: <987cd4ccd2b86a840b900a25e0edf0f9@tribut.de> (Felix Eckhofer's
	message of "Fri, 27 Jun 2014 18:26:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3426BEA2-FE29-11E3-AF5F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252568>

Felix Eckhofer <felix@tribut.de> writes:

> When trying to rewrite svn revisions in commit messages to
> corresponding git commit hashes, I came across the following problem
> (using git 1.9.1):
>
>   $ git filter-branch --msg-filter svnrev2git.py -- --date-order --all
>   fatal: options not supported in --stdin mode
>   Could not get the commits
>
> This seems to have been caused by 3361a548db. After reverting this
> commit, using --date-order appears to work again.

Hmph, unfortunate.

3361a548 (Allow git-filter-branch to process large repositories with
lots of branches., 2013-09-10) has this change:

 
    -rev_args=$(git rev-parse --revs-only "$@")
    +git rev-parse --revs-only "$@" >../parse

and then later feeds ../parse from the standard input of rev-list.

The --revs-only option, because --date-order *is* a rev-list related
argument, is emitted by the above rev-parse, along with the tip of
refs (which come from --all).  But --stdin mode of rev-list is meant
to receive *only* revisions, not options.  When it gets to the point
to accept the list of tips to start traversing from, it is too late
to give it an option.

Changing the above to something like:

	git rev-parse --revs-only --no-flags "$@" >../parse

would be a better workaround that would not break repositories with
large number of references, but it obviously will lose --date-order
option (why would it be even necessary, though?  I suspect that
forcing the date-order will make the resulting pack a lot worse by
robbing the data stream of locality).
