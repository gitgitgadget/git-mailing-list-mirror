From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 01/18] Remove duplicate code
Date: Fri, 08 Apr 2016 16:34:00 -0700
Message-ID: <xmqqvb3ru13r.fsf@gitster.mtv.corp.google.com>
References: <1460098726-5958-1-git-send-email-newren@gmail.com>
	<1460098726-5958-2-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 01:34:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aofuo-0001VJ-P4
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 01:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300AbcDHXeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 19:34:06 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:59205 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752670AbcDHXeF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 19:34:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EC74551A1E;
	Fri,  8 Apr 2016 19:34:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qeTIrrLfNS0hZK7NQQoeLWygM3o=; b=nydPyu
	l9MxB/yN1yqtxahyXWo0o+ASlmb+5l1LPDD8pDLzfq0s1Hz0Bf55S1ef3rH8JgsT
	dLlZOcLs7ygAaACwO1Gj6HQJws7Di8clIr2+69gkFehCTcSwPX0ju6pkjMqGm7ip
	bmGSMXK6WRLraLkznjzMkkDbpfS9N0qBCPJeU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tUoCMB8JLGWwvQU5NHw+mnT80RPbk0sE
	/K4ZxU+WpYaV7dqK1+u9l1tdysqUw9HnnSrfDNs/W3z5meZ9k8DbJsSb3oLab9Yx
	ce9pIdCktNl4HU95YtTEvYuyYipVlH/S66Ao8v9TO1PbOllpVgHXQJjXRTjmOPkH
	66r9DAguX5k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D3F0B51A1D;
	Fri,  8 Apr 2016 19:34:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4572D51A1C;
	Fri,  8 Apr 2016 19:34:02 -0400 (EDT)
In-Reply-To: <1460098726-5958-2-git-send-email-newren@gmail.com> (Elijah
	Newren's message of "Thu, 7 Apr 2016 23:58:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 60321018-FDE2-11E5-87FE-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291076>

Elijah Newren <newren@gmail.com> writes:

> Subject: Re: [RFC/PATCH 01/18] Remove duplicate code

Subject: [RFC/PATCH 01/18] merge-recursive: remove duplicate code

> In commit 51931bf (merge-recursive: Improve handling of rename target vs.
> directory addition, 2011-08-11) I apparently added two lines of code that
> were immediately duplicated a few lines later.  No idea why, other than
> it seems pretty clear this was a mistake: there is no need to remove the
> same file twice; removing it once is sufficient...especially since the
> intervening line was working with a different file entirely.


Interesting.

I briefly wondered if the update_files() in the middle may be
prevented by D/F conflict if you didn't remove the path beforehand,
but path and new_path are both in the same directory, so that would
not be the reason.  Checking out 51931bf and running two tests (6022
and 6042) that were modified to protect the fix after applying this
partial revert does not seem to break, either, so...

Reviewed-by: Junio C Hamano <gitster@pobox.com>

>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index b880ae5..d4292de 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1773,8 +1773,6 @@ static int process_entry(struct merge_options *o,
>  			output(o, 1, _("CONFLICT (%s): There is a directory with name %s in %s. "
>  			       "Adding %s as %s"),
>  			       conf, path, other_branch, path, new_path);
> -			if (o->call_depth)
> -				remove_file_from_cache(path);
>  			update_file(o, 0, sha, mode, new_path);
>  			if (o->call_depth)
>  				remove_file_from_cache(path);
