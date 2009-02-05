From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/4] Add log.mailmap as configurational option for
 mailmap location
Date: Thu, 05 Feb 2009 09:44:54 -0800
Message-ID: <7vljskeq21.fsf@gitster.siamese.dyndns.org>
References: <cover.1233819451.git.marius@trolltech.com>
 <cover.1233819451.git.marius@trolltech.com>
 <565c86bdbc8d6303d7d468fa196fb54ff7bd2352.1233819451.git.marius@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 18:46:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV8JE-0003Mc-PY
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 18:46:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755689AbZBERpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 12:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755149AbZBERpE
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 12:45:04 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51517 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219AbZBERpB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 12:45:01 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1B5BF97A00;
	Thu,  5 Feb 2009 12:45:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F20B3979FE; Thu,
  5 Feb 2009 12:44:56 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B5CAF2DA-F3AC-11DD-A25B-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108591>

Marius Storm-Olsen <marius@trolltech.com> writes:

> diff --git a/config.c b/config.c
> index 790405a..9ebcbbe 100644
> --- a/config.c
> +++ b/config.c
> @@ -565,6 +565,13 @@ static int git_default_branch_config(const char *var, const char *value)
>  	return 0;
>  }
>  
> +static int git_default_log_config(const char *var, const char *value)
> +{
> +	if (!strcmp(var, "log.mailmap"))
> +		return git_config_string(&git_log_mailmap, var, value);
> +	return 0;
> +}
> +
>  int git_default_config(const char *var, const char *value, void *dummy)
>  {
>  	if (!prefixcmp(var, "core."))
> @@ -579,6 +586,9 @@ int git_default_config(const char *var, const char *value, void *dummy)
>  	if (!prefixcmp(var, "branch."))
>  		return git_default_branch_config(var, value);
>  
> +	if (!prefixcmp(var, "log."))
> +		return git_default_log_config(var, value);
> +

The placement of this looked *really* wrong, as mailmap is not *that*
important to most of the commands.

Initially I wondered if this should be better done inside existing
git_log_config().  I suspect that the reason you didn't do so is because
you would want to use this also in blame, which is not part of the log
family, and does not use git_log_config() (nor it should).

Which probably means that the code can stay here (it is just two strcmp
and assignment to a pointer variable), but also suggests that log.mailmap
is perhaps misnamed.
