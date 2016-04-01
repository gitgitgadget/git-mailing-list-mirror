From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 3/4] bundle: don't leak an fd in case of early return
Date: Fri, 01 Apr 2016 10:05:49 -0700
Message-ID: <xmqqzitdi7iq.fsf@gitster.mtv.corp.google.com>
References: <1459470946-16522-1-git-send-email-sbeller@google.com>
	<1459470946-16522-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: peff@peff.net, sunshine@sunshineco.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 19:06:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am2WI-0003An-0L
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 19:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420AbcDARFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 13:05:53 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57936 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752681AbcDARFw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 13:05:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DD8524F5A0;
	Fri,  1 Apr 2016 13:05:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vmJaAPtfRNoE4gKB6uWmIrU8/6E=; b=ZSGV0b
	FC8PegSqc6lN7yEckDlFKL+vCJVHq3JVIl8Yl+8wp4uhmLZHGXd7lXzNn5CN1WCi
	7qnufhIpicb226LNac9S2dG/c2SJLovVwQXraYafvZpjEfIiJb+Jd0n+DaUxEntO
	jBS2TCPm9UXinDkwJFGwGjkRdrafnGXEWc3pA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DRzcPMUuTe6or3uoI8OCicng6tgX+9F9
	/F2W7tbttRIdi3+lkthhHEtYVs+aoiLnkQBN8WjDhY0F9o/pBKJtPm6Fk/fPPE9E
	zPEvgu7lHjuxfibZ8x9lCVVJIXSiPEp73OkdqM6UQmeC5xshclCudqxazGrVntI1
	3BJTWg2CfLQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9E2BA4F59F;
	Fri,  1 Apr 2016 13:05:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C10DC4F59E;
	Fri,  1 Apr 2016 13:05:50 -0400 (EDT)
In-Reply-To: <1459470946-16522-4-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 31 Mar 2016 17:35:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FC7E02AE-F82B-11E5-A694-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290560>

Stefan Beller <sbeller@google.com> writes:

> In successful operation `write_pack_data` will close the `bundle_fd`,
> but when we exit early, we need to take care of the file descriptor
> as well as the lock file ourselves. The lock file may be deleted at the
> end of running the program, but we are in library code, so we should
> not rely on that.
>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Thanks.  I think this turned out to be the trickiest one to get
right among the four and my reading of this round tells me that
it addresses all the trickiness pointed out in the reviews.

Will replace.

>  bundle.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/bundle.c b/bundle.c
> index 506ac49..08e32ca 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -435,12 +435,14 @@ int create_bundle(struct bundle_header *header, const char *path,
>  
>  	/* write prerequisites */
>  	if (compute_and_write_prerequisites(bundle_fd, &revs, argc, argv))
> -		return -1;
> +		goto err;
>  
>  	argc = setup_revisions(argc, argv, &revs, NULL);
>  
> -	if (argc > 1)
> -		return error(_("unrecognized argument: %s"), argv[1]);
> +	if (argc > 1) {
> +		error(_("unrecognized argument: %s"), argv[1]);
> +		goto err;
> +	}
>  
>  	object_array_remove_duplicates(&revs.pending);
>  
> @@ -448,17 +450,23 @@ int create_bundle(struct bundle_header *header, const char *path,
>  	if (!ref_count)
>  		die(_("Refusing to create empty bundle."));
>  	else if (ref_count < 0)
> -		return -1;
> +		goto err;
>  
>  	/* write pack */
>  	if (write_pack_data(bundle_fd, &revs))
> -		return -1;
> +		goto err;
>  
>  	if (!bundle_to_stdout) {
>  		if (commit_lock_file(&lock))
>  			die_errno(_("cannot create '%s'"), path);
>  	}
>  	return 0;
> +err:
> +	if (!bundle_to_stdout) {
> +		close(bundle_fd);
> +		rollback_lock_file(&lock);
> +	}
> +	return -1;
>  }
>  
>  int unbundle(struct bundle_header *header, int bundle_fd, int flags)
