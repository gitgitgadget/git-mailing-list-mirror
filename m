From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] pull --rebase: add --[no-]autostash flag
Date: Mon, 07 Mar 2016 15:01:34 -0800
Message-ID: <xmqqy49tnb8x.fsf@gitster.mtv.corp.google.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<1457354245-26871-1-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	pyokagan@gmail.com, sunshine@sunshineco.com
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 00:02:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ad4AZ-00022M-60
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 00:02:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699AbcCGXC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 18:02:26 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60154 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932593AbcCGXBi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 18:01:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BEF304BF68;
	Mon,  7 Mar 2016 18:01:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q/9F0FbtrpG1y17yZaZTJ5XoHFM=; b=Gfj966
	w7Pdw/BBARhl2n08M4+XWoQoDFXOFQhAS6fxioDPqrRJiqrZ8KF32MxbEX71QK4W
	xoon9O3ELBa9JwezQcYzbPORn62tpfl+t7ZPLlZ/Eo7oH6M4N9X2rMrdRNszbl31
	Cba3ja5ZkxFPslCi/qsv7SI1R7DkjDaInpMAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vbkcs+CMD1ywa5hY5XbFWNz/79kJ7+JA
	UOioJttJExIk7kNMo01AVAwP6Q0hPU2fNwroNAwMy4NznqDMSG6hgjVeVz4QNF6n
	I5LWaZpwpxV49suzb7ezUwj/yIkvovg2EtIl6vWg5zgkQsGObnbdtZFifIa9Gqev
	oeNNJlBqySU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B71494BF67;
	Mon,  7 Mar 2016 18:01:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2B7674BF66;
	Mon,  7 Mar 2016 18:01:35 -0500 (EST)
In-Reply-To: <1457354245-26871-1-git-send-email-mehul.jain2029@gmail.com>
	(Mehul Jain's message of "Mon, 7 Mar 2016 18:07:25 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8A73654A-E4B8-11E5-8092-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288406>

Mehul Jain <mehul.jain2029@gmail.com> writes:

> If rebase.autoStash configuration variable is set, there is no way to
> override it for "git pull --rebase" from the command line.
>
> Teach "git pull --rebase" the --[no-]autostash command line flag which
> overrides the current value of rebase.autoStash, if set. As "git rebase"
> understands the --[no-]autostash option, it's just a matter of passing
> the option to underlying "git rebase" when "git pull --rebase" is called.
>
> Also introduce a callback function to read config variables.

I was expecting you not to do this (it does not have to be in the
scope of this topic), but if you do so, it would be preferrable to
do it as a preparatory clean-up patch--the existing code already
makes a separate get_bool() call to read a single config while it
uses git_config(git_default_config) to read the other variables, and
introduction of git_pull_config() is a clean-up that is independent
of your new feature.

And then on top of that cleaned-up codebase, add this new feature.

> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index a62a2a6..393ac7d 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -128,6 +128,15 @@ unless you have read linkgit:git-rebase[1] carefully.
>  --no-rebase::
>  	Override earlier --rebase.
>  
> +--autostash::
> +--no-autostash::
> +	Before starting rebase, stash local modifications away (see
> +	linkgit:git-stash.txt[1]) if needed, and apply the stash when
> +	done (this option is only valid when '--rebase' is used).
> ++
> +'--no-autostash' is useful to override the 'rebase.autoStash'
> +configuration variable (see linkgit:git-config[1]).

Don't we use `typewriter font` when referring to literal command,
option and variable names in the documentation?  The description
for `--rebase` that comes immediately before this hunk seems to
support that observation.

> @@ -306,6 +310,18 @@ static enum rebase_type config_get_rebase(void)
>  }
>  
>  /**
> + * Read config variables.
> + */
> +static int git_pull_config(const char *var, const char *value, void *cb)
> +{
> +	if (!strcmp(var,"rebase.autostash")) {

Style: SP after a comma.  There may be the same problem elsewhere on
the new lines, but I won't point out all of them.

Other than that, looking better.

Thanks.
