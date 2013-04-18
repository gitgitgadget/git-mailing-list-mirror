From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/6] transport-helper: warn when refspec is not used
Date: Thu, 18 Apr 2013 10:30:44 -0700
Message-ID: <7vvc7j6917.fsf@alter.siamese.dyndns.org>
References: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
	<1366258473-12841-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 19:30:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USsfc-00035S-O7
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 19:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967202Ab3DRRat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 13:30:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62841 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967001Ab3DRRas (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 13:30:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C102017561;
	Thu, 18 Apr 2013 17:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=7ymYxGi/bSVNL6Blpya2itngW+8=; b=cIJR2Xn9C6gUx8Udk2Ut
	jbMGQI74irEWlwSFZWtk0Vec247irQBIdfAMVMJMIY5o4SucezkaZYD/O4Cd+HGd
	qiFHee5QqztJ0A892IVHHiRbVM/c9/6XvkcKnU4F6p5xMVv58opGE0lqRfMbrclO
	TAsqcTuXavj547HZiUHV4EU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=byp5Q3CQlSM/jAW7zjDGXAvN2VMgiRVdgtaSHE2jNfkA9G
	aDmb3o6LIwqbEZ5e3OTXFlHp1Wr0o0ug03naFZ5vVSTLyF8QT64lwU+RkSnHtvda
	WfBGPNEJrmoaf22IxXlzD9t7kT69n0fTDIqE2q3Klc6XaDt34gVEB1QeIO/WI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B39061755F;
	Thu, 18 Apr 2013 17:30:46 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 208531755E;
	Thu, 18 Apr 2013 17:30:46 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B41D5568-A84D-11E2-A0D9-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221675>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> For the modes that need it. In the future we should probably error out,
> instead of providing half-assed support.
>
> The reason we want to do this is because if it's not present, the remote
> helper might be updating refs/heads/*, or refs/remotes/origin/*,
> directly, and in the process fetch will get confused trying to update
> refs that are already updated, or older than what they should be. We
> shouldn't be messing with the rest of git.

So that answers my question in the response to an earlier one in
this series.  We expect the ref updates to be done by the fetch or
push that drives the helper, and do not want the helper to interfere
with its ref updates.

So it is not just 'refspec' _allows_ the refs to be constrained to a
private namespace, like the earlier updates made the documentation
say; it _is_ mandatory to use refspecs to constrain them to avoid
touching refs/heads and refs/remotes namespace.

Am I reading you correctly?

Assuming I am, the patch in this message looks reasonable.

It makes the documentation updates a few patches ago look a bit
wanting, though.

Thanks.

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  t/t5801-remote-helpers.sh | 6 ++++--
>  transport-helper.c        | 2 ++
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
> index 3eeb309..1bb7529 100755
> --- a/t/t5801-remote-helpers.sh
> +++ b/t/t5801-remote-helpers.sh
> @@ -100,14 +100,16 @@ test_expect_failure 'push new branch with old:new refspec' '
>  
>  test_expect_success 'cloning without refspec' '
>  	GIT_REMOTE_TESTGIT_REFSPEC="" \
> -	git clone "testgit::${PWD}/server" local2 &&
> +	git clone "testgit::${PWD}/server" local2 2> error &&
> +	grep "This remote helper should implement refspec capability" error &&
>  	compare_refs local2 HEAD server HEAD
>  '
>  
>  test_expect_success 'pulling without refspecs' '
>  	(cd local2 &&
>  	git reset --hard &&
> -	GIT_REMOTE_TESTGIT_REFSPEC="" git pull) &&
> +	GIT_REMOTE_TESTGIT_REFSPEC="" git pull 2> ../error) &&
> +	grep "This remote helper should implement refspec capability" error &&
>  	compare_refs local2 HEAD server HEAD
>  '
>  
> diff --git a/transport-helper.c b/transport-helper.c
> index 4d98567..573eaf7 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -215,6 +215,8 @@ static struct child_process *get_helper(struct transport *transport)
>  			free((char *)refspecs[i]);
>  		}
>  		free(refspecs);
> +	} else if (data->import || data->bidi_import || data->export) {
> +		warning("This remote helper should implement refspec capability.");
>  	}
>  	strbuf_release(&buf);
>  	if (debug)
