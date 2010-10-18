From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] reset: accept "git reset <removed file>"
Date: Mon, 18 Oct 2010 16:56:56 -0700
Message-ID: <7viq0z2gxj.fsf@alter.siamese.dyndns.org>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
 <20101018211522.GA7655@burratino> <20101018224840.GA9729@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 01:57:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7zZx-0006h1-U4
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 01:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933147Ab0JRX5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 19:57:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61761 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931Ab0JRX5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 19:57:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D00FDF6C0;
	Mon, 18 Oct 2010 19:57:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mcxeh1MppzOpX6qoqp8qoCiMvoM=; b=VZ62uF
	lQHtUXhB7DG1A+wM2LVqmC54ihr3snvtiyRNOvrYIoYnd9psodvpXCWIQOYlg3Gu
	RpYWGhyR4s9LrEstGgRf5BcpxJJ6EN4L7DtTc4M/A4E11Ys/nVOakvwgZyT/7M4y
	FnOIxtSIwm6U7cEDX81f4wpH/8kvT+5PnpDaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GvICSu2HjoPAso9cxas/B/GorPg9uIhS
	RqTdaZ1ZGl/Bj6J7X7ViPsn/P7n9HyFQADIBFviqrWILHY4O5xAPgG+Kqaz/iLGH
	JZmCA95hXKUV6+4p93MxCRa9Lpr5pb3O3jkdmDJ/VuFgH9o12EN6V8iCayLyhdjv
	KnwMXcithYk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DD7BBDF6BF;
	Mon, 18 Oct 2010 19:57:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97A80DF6BE; Mon, 18 Oct
 2010 19:56:58 -0400 (EDT)
In-Reply-To: <20101018224840.GA9729@burratino> (Jonathan Nieder's message of
 "Mon\, 18 Oct 2010 17\:48\:40 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 69B5AA70-DB13-11DF-9A22-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159297>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Suppose I try to use "git reset" to un-add an new, unwanted file:
>
> 	echo hello >foo.c
> 	git add foo.c
> 	rm foo.c; # bad file! bad!
> 	git reset foo.c
>
> The file foo.c does not exist on disk, so "git reset" rejects the
> request with
>
> 	fatal: ambiguous argument 'foo.c': unknown revision or path not in the working tree.
> 	Use '--' to separate paths from revisions
>
> Git can do better: since foo.c is not a revision and has an entry in
> the index, it is clear the request refers to a path and not a rev.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---

This changes the definition of path/rev disambiguation only for "reset"
and makes things inconsistent.  Is it a good thing?

If a token is not a filename in the working tree, but is a path in the
index, and at the same time is a valid ref, wouldn't it make the token
ambiguous with the updated definition of disambiguation code here?

> diff --git a/builtin/reset.c b/builtin/reset.c
> index 0037be4..7d23d75 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -295,7 +295,13 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  			rev = argv[i++];
>  		} else {
>  			/* Otherwise we treat this as a filename */
> -			verify_filename(prefix, argv[i]);
> +			const char *name = argv[i];
> +			if (prefix)
> +				name = prefix_filename(prefix, strlen(prefix), name);
> +			if (read_cache() < 0)
> +				die("Could not read index");
> +			if (cache_name_pos(name, strlen(name)) < 0)
> +				verify_filename(prefix, argv[i]);
>  		}
>  	}

Makes me wonder

 - if we can/want to have a logic like this inside verify_filename();

 - if we need a corresponding logic in either the previous else/if cascade
   that calls verify_non_filename(), or in verify_non_filename() itself.
