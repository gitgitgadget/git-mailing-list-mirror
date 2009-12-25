From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/2] Improve transport helper exec failure reporting
Date: Thu, 24 Dec 2009 23:44:49 -0800
Message-ID: <7vljgrebv2.fsf@alter.siamese.dyndns.org>
References: <1261676971-3285-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1261676971-3285-3-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Fri Dec 25 08:45:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NO4rD-0005Tn-2U
	for gcvg-git-2@lo.gmane.org; Fri, 25 Dec 2009 08:45:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbZLYHo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Dec 2009 02:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbZLYHo6
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Dec 2009 02:44:58 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45860 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbZLYHo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Dec 2009 02:44:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 474B18BC70;
	Fri, 25 Dec 2009 02:44:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kVn9KNn+lu2ikbAwdkFjEgB6e6w=; b=VT0cVx
	4juHOhVkBm0NQy+ZDAsU0mCJWdRImRzZbozL+d12mDAJqukvMwz0wYITmLis1GU2
	/FARZZXJ5N29L5RlKTzuT48yoIugm3ZYEkB7vsD4gvCXMH362pyf2uBGune78e2i
	u3PiQyJFDRTFDw7kgxwPcNI5qd3BedE82tLlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LkXGKrLrqWR0BIrhAlNUYI/mMklKNf2c
	1zSLTD1a3GMLlcbRomBH72LgmBXew8A68cJfJ3UZ3TfG6UAJ4DG8hX4fSRSvoOby
	845vQS0V9cuCx0VrrqI7qLCpjhnztLlaWl7fKk7q/uzKPzwHrIuA5Jp3jsv+RqIi
	sZzEszTMcmM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 26EB38BC6F;
	Fri, 25 Dec 2009 02:44:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76C5C8BC6E; Fri, 25 Dec
 2009 02:44:50 -0500 (EST)
In-Reply-To: <1261676971-3285-3-git-send-email-ilari.liusvaara@elisanet.fi>
 (Ilari Liusvaara's message of "Thu\, 24 Dec 2009 19\:49\:31 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 63662E4E-F129-11DE-8E9B-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135666>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> Previously transport-helper exec failure error reporting was pretty
> much useless as it didn't report errors from execve, only from pipe
> and fork. Now that run-command passes errno from exec, use the
> improved support to actually print useful errors if execution fails.
>
> Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>

Looks pretty straightforward, except that I have this nagging feeling that
we should *not* be married to the idea of "'proc->git_cmd = 1' is merely a
way to save you from typing 'git-' prefix in start_command(proc)".

> diff --git a/transport-helper.c b/transport-helper.c
> index 5078c71..0965c9b 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -31,13 +31,19 @@ static struct child_process *get_helper(struct transport *transport)
>  	helper->out = -1;
>  	helper->err = 0;
>  	helper->argv = xcalloc(4, sizeof(*helper->argv));
> -	strbuf_addf(&buf, "remote-%s", data->name);
> +	strbuf_addf(&buf, "git-remote-%s", data->name);
>  	helper->argv[0] = strbuf_detach(&buf, NULL);
>  	helper->argv[1] = transport->remote->name;
>  	helper->argv[2] = transport->url;
> -	helper->git_cmd = 1;
> -	if (start_command(helper))
> -		die("Unable to run helper: git %s", helper->argv[0]);
> +	helper->git_cmd = 0;
> +	if (start_command(helper)) {

For example, we might later want to use different $PATH only when running
a git subcommand, and telling run_command() explicitly that we are running
a git thing would help if you don't add "git-" to the command line and
drop "proc->git_cmd = 1" in the caller like your patch does.

> +		if (errno == ENOENT)
> +			die("Unable to find remote helper for \"%s\"",
> +				data->name);
> +		else
> +			die("Unable to run helper %s: %s", helper->argv[0],
> +				strerror(errno));
> +	}
>  	data->helper = helper;
>  
>  	write_str_in_full(helper->in, "capabilities\n");
> -- 
> 1.6.6.3.gaa2e1
