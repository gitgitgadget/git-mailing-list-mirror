From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help: include list of aliases in git-help --all
Date: Tue, 25 Feb 2014 15:22:24 -0800
Message-ID: <xmqqmwhe4w27.fsf@gitster.dls.corp.google.com>
References: <1393289315-28982-1-git-send-email-joel.nothman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joel Nothman <joel.nothman@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 26 00:22:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIRKc-0005ji-Iu
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 00:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbaBYXWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Feb 2014 18:22:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49814 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849AbaBYXWa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Feb 2014 18:22:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26C5A6E02C;
	Tue, 25 Feb 2014 18:22:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=55uauc+5MieHrijhA/+wslaFz6c=; b=bRDTiv
	zUhnLsMc0BnD3+hhd6p9UPD+obkRH26hTjSZaZXnEFgH7cg0KtTNFIVmYa3p+SLr
	gWGs6a12KYVXDD4Rbz+hW5KoJS/EqpD2rY0cLPN0C4dfxmgjToJW+bkq+WHffKiM
	7Ds+x+LGE7suLVHPMHx0mnHH0rP6HGhAlXhbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KWwxLXpzvgxaxEz22+i44LI26sl6c3w0
	yUL6lbBg/cQnJFNGg5dGMMFfoxcDFwi3wpqLhpkLADWpnt5I6w0DsZtEpq0X2XgC
	/nyvAZQKKhl1SI5QEoqrR11A99C5BF4pNLzxoI+OJOdcYLIpYKz9ux3tT5v/5+/S
	q5W3xOaaCk4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3B1E6E02A;
	Tue, 25 Feb 2014 18:22:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 244FE6E026;
	Tue, 25 Feb 2014 18:22:28 -0500 (EST)
In-Reply-To: <1393289315-28982-1-git-send-email-joel.nothman@gmail.com> (Joel
	Nothman's message of "Tue, 25 Feb 2014 11:48:34 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B1238CCA-9E73-11E3-AE49-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242693>

Joel Nothman <joel.nothman@gmail.com> writes:

> Git help --all had listed all git commands, but no configured aliases.
> This includes aliases as a separate listing, after commands in the main
> git directory and other $PATH directories.
>
> Signed-off-by: Joel Nothman <joel.nothman <at> gmail.com>
> ---

Thanks.

> diff --git a/help.c b/help.c
> index df7d16d..3c14af4 100644
> --- a/help.c
> +++ b/help.c
> @@ -86,7 +86,7 @@ static void pretty_print_string_list(struct cmdnames *cmds,
>  	int i;
>  
>  	for (i = 0; i < cmds->cnt; i++)
> -		string_list_append(&list, cmds->names[i]->name);
> +	    string_list_append(&list, cmds->names[i]->name);

Why?

> @@ -202,8 +202,48 @@ void load_command_list(const char *prefix,
>  	exclude_cmds(other_cmds, main_cmds);
>  }
>  
> +static struct cmdnames aliases;

Instead of using a static global variable, perhaps make this an
on-stack variable in load_commands_and_aliases() that is passed as a
callback parameter to load_aliases_cb() thru git_config()?

> +static int load_aliases_cb(const char *var, const char *value, void *cb)
> +{

That is, cb here is the second parameter you gave to git_config().

>  void list_commands(unsigned int colopts,
> -		   struct cmdnames *main_cmds, struct cmdnames *other_cmds)
> +		   struct cmdnames *main_cmds, struct cmdnames *other_cmds,
> +		   struct cmdnames *alias_cmds)
>  {
>  	if (main_cmds->cnt) {
>  		const char *exec_path = git_exec_path();
> @@ -219,6 +259,13 @@ void list_commands(unsigned int colopts,
>  		pretty_print_string_list(other_cmds, colopts);
>  		putchar('\n');
>  	}
> +
> +	if (alias_cmds->cnt) {
> +		printf_ln(_("aliases defined in git configuration"));

This will not break the use of "git help -a" in our completion
script, because it ignores anything that does not begin with two SP
followed by alphanumerics.

It may however break scripts that read from "help -a" done by other
people that may remove the lines in the output that are known to
them as not names of commands (i.e. "available git commands..."  and
"git commands avaliable elsewhere...")---they haven't seen this new
string and would not know that this line must be skipped.

Other than that, looks reasonably cleanly done.  We'd need a test to
cover this so that other people will not break it in future patches.
