From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] transport-helper: check if remote helper is alive
Date: Mon, 01 Apr 2013 17:26:24 -0700
Message-ID: <7v38v9ixqn.fsf@alter.siamese.dyndns.org>
References: <1364852804-31875-1-git-send-email-felipe.contreras@gmail.com>
 <1364852804-31875-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 02:27:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMp42-0005D8-V4
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 02:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759293Ab3DBA03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 20:26:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54917 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754323Ab3DBA02 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 20:26:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6688B11A3E;
	Tue,  2 Apr 2013 00:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=w4oaS8AIq6NNldgvJTAghcwsHMs=; b=Ut3ICG47iDh7UnnpP2Ks
	dqL/DHDTLd4Jw46lBvKD76RQ1fmuHAkzuKi3PtAs/XfThwp8n4Y86vutzLoJXuIK
	llyHlJRP6eKuCtrj0PzR/+1coYV0ZB1BMamym+2Apn2sqDLXUKTBbmLHhmtx/Wq5
	BiglDP3PgVArdh9G4m5+kjY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Yb0IWJlDetoasQHUbfQzZCDyfcpbNcKTq3RsBddbSQUV5f
	1TqCUgs9KIUJJ5BCGNrDhmHAt/JGeBDEAi+mOR+Kv6uQyAfiVOtVulSTk5QIKBIq
	Ty1k12jgUIG8zk+8jlTTSqzKveLDbzDLWiNW+3zQwi+epHr08UNjo4agLBFw4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5930211A3D;
	Tue,  2 Apr 2013 00:26:27 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78A7511A3B; Tue,  2 Apr
 2013 00:26:26 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F4B61846-9B2B-11E2-948D-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219729>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Otherwise transport-helper will continue checking for refs and other
> things what will confuse the user more.
> ---

Sign-off?

>  git-remote-testgit        | 11 +++++++++++
>  t/t5801-remote-helpers.sh | 19 +++++++++++++++++++
>  transport-helper.c        |  8 ++++++++
>  3 files changed, 38 insertions(+)
>
> diff --git a/git-remote-testgit b/git-remote-testgit
> index b395c8d..ca0cf09 100755
> --- a/git-remote-testgit
> +++ b/git-remote-testgit
> @@ -61,12 +61,23 @@ do
>  			echo "feature import-marks=$gitmarks"
>  			echo "feature export-marks=$gitmarks"
>  		fi
> +
> +		if test -n "$GIT_REMOTE_TESTGIT_FAILURE"
> +		then
> +			exit -1
> +		fi
> +
>  		echo "feature done"
>  		git fast-export "${testgitmarks_args[@]}" $refs |
>  		sed -e "s#refs/heads/#${prefix}/heads/#g"
>  		echo "done"
>  		;;
>  	export)
> +		if test -n "$GIT_REMOTE_TESTGIT_FAILURE"
> +		then
> +			exit -1
> +		fi
> +
>  		before=$(git for-each-ref --format='%(refname) %(objectname)')
>  
>  		git fast-import "${testgitmarks_args[@]}" --quiet
> diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
> index f387027..26e9a5b 100755
> --- a/t/t5801-remote-helpers.sh
> +++ b/t/t5801-remote-helpers.sh
> @@ -166,4 +166,23 @@ test_expect_success 'push ref with existing object' '
>  	compare_refs local dup server dup
>  '
>  
> +test_expect_success 'proper failure checks for fetching' '
> +	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
> +	export GIT_REMOTE_TESTGIT_FAILURE &&
> +	cd local &&
> +	test_must_fail git fetch 2>&1 | \
> +		grep "Error while running helper"

This will not care if "git fetch" succeeds or fails and returns the
exit code from grep.  Perhaps something like this instead?

	(
		GIT_REMOTE_TESTGIT_FAILURE=1 &&
		export GIT_REMOTE_TESTGIT_FAILURE &&
		cd local &&
		test_must_fail git fetch 2>error &&
		grep "Error while running helper" error
	)


> +# We sleep to give fast-export a chance to catch the SIGPIPE
> +test_expect_failure 'proper failure checks for pushing' '
> +	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
> +	export GIT_REMOTE_TESTGIT_FAILURE &&
> +	cd local &&
> +	test_must_fail git push --all 2>&1 | \
> +		grep "Error while running helper"

Ditto.

> +	)
> +'
> +
>  test_done
> diff --git a/transport-helper.c b/transport-helper.c
> index cb3ef7d..dfdfa7a 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -460,6 +460,10 @@ static int fetch_with_import(struct transport *transport,
>  
>  	if (finish_command(&fastimport))
>  		die("Error while running fast-import");
> +
> +	if (!check_command(data->helper))
> +		die("Error while running helper");
> +
>  	argv_array_free_detached(fastimport.argv);
>  
>  	/*
> @@ -818,6 +822,10 @@ static int push_refs_with_export(struct transport *transport,
>  
>  	if (finish_command(&exporter))
>  		die("Error while running fast-export");
> +
> +	if (!check_command(data->helper))
> +		die("Error while running helper");
> +
>  	push_update_refs_status(data, remote_refs);
>  	return 0;
>  }

OK, so the idea is that fetch_with_import() does

 - get_helper(transport), which spawns a helper process;

 - get_importer(transport, &fastimport), which spawns a fast-import
   and make it read from the output of the helper process;

 - we did finish_command() to wait for the fast-import to finish,
   expecting that the fast-import would finish when the helper stops
   feeding it, which in turn would mean the helper would have died.

The same for the pushing side.

Shouldn't transport_disconnect() have called release_helper() which
in turn calls disconnect_helper() to call finish_command() on the
helper to wait for that procesanyway?  Is somebody discarding return
value from transport_disconnect() or the current calling site of
transport_disconnect() is too late to notice the error?

Puzzled...
