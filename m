From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] transport-helper: emit progress and verbosity options after asking for capabilities
Date: Thu, 12 Feb 2015 12:28:24 -0800
Message-ID: <xmqqlhk2ri1j.fsf@gitster.dls.corp.google.com>
References: <1423735801-11108-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Feb 12 21:28:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YM0NC-0000lH-TP
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 21:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbbBLU21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 15:28:27 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57219 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750810AbbBLU20 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 15:28:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DE4CC372AC;
	Thu, 12 Feb 2015 15:28:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UHNKQSszOF6IZYg2y5M6vJzvT6A=; b=H/T5El
	swBvEtyzIyvSCVeg9ZIbg4dLFYIrYOXACeOfZPHrg2pIhzZhECNJp0LpG3BJgTHJ
	2q068Q9LLP2g1PQSiIqRY/Ne1dli+VzZiykhuL+WgSpNrFa9+LfE/v3sg0OG0u9q
	GZPF8RenLX3o2TiYjPruJhkU8K22OEa2cgwGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d1nt/nLG3al9mz+NT6lSmeQ//KGIWTLB
	lwtlaWXfARig58VS8VejR9YrArjS381MEOqsOV9CmCU6dp6KmcX67tanhe5em4X/
	1ocOWmqH/FyYqAmTfp9F66AruAdT7tqghxmTLkVH+2rkNbIgqqZzCZyBFcI5t6qY
	pAqcPMHCB1E=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D3F24372AB;
	Thu, 12 Feb 2015 15:28:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 39C29372A9;
	Thu, 12 Feb 2015 15:28:25 -0500 (EST)
In-Reply-To: <1423735801-11108-1-git-send-email-mh@glandium.org> (Mike
	Hommey's message of "Thu, 12 Feb 2015 19:09:59 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B215E06E-B2F5-11E4-9941-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263765>

Mike Hommey <mh@glandium.org> writes:

> Currently, the progress and verbosity options are only emitted for the fetch
> and push commands, but they should also be emitted for other commands, such as
> import or export, and, why not, even list.
>
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---

I had a hard time understanding what you are trying to achieve.  The
word "emit" may be techinically correct from the point of view of
this program, but wouldn't there be a better word to describe what
is being achieved by this program "emit"ting the additional output
lines?

Perhaps "ask the helper to enable progress and verbosity capabilities"
or somesuch?

They "should also be emitted" may also want to be justified in a
better way, by describing what _bad_ things the current code that
lacks this patch is doing as a bug.

Perhaps like "The current transport-helper.c code does not tell a
remote helper that uses the import and export interface to enable
progress and verbosity capabilities, even if the helper supports
them."

Is there a downside of doing this?  I do not think of any offhand.

Thanks.

>  transport-helper.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/transport-helper.c b/transport-helper.c
> index 0224687..23a741c 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -98,6 +98,8 @@ static void do_take_over(struct transport *transport)
>  	free(data);
>  }
>  
> +static void standard_options(struct transport *t);
> +
>  static struct child_process *get_helper(struct transport *transport)
>  {
>  	struct helper_data *data = transport->data;
> @@ -212,6 +214,7 @@ static struct child_process *get_helper(struct transport *transport)
>  	strbuf_release(&buf);
>  	if (debug)
>  		fprintf(stderr, "Debug: Capabilities complete.\n");
> +	standard_options(transport);
>  	return data->helper;
>  }
>  
> @@ -339,7 +342,6 @@ static int fetch_with_fetch(struct transport *transport,
>  	int i;
>  	struct strbuf buf = STRBUF_INIT;
>  
> -	standard_options(transport);
>  	if (data->check_connectivity &&
>  	    data->transport_options.check_self_contained_and_connected)
>  		set_helper_option(transport, "check-connectivity", "true");
> @@ -824,7 +826,6 @@ static int push_refs_with_push(struct transport *transport,
>  		return 0;
>  	}
>  
> -	standard_options(transport);
>  	for_each_string_list_item(cas_option, &cas_options)
>  		set_helper_option(transport, "cas", cas_option->string);
