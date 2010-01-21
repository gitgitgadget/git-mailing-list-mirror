From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] post-receive-email: allow customizing of subject/intro/footer
Date: Thu, 21 Jan 2010 12:02:58 -0500
Message-ID: <4B5888C2.60508@xiplink.com>
References: <1263877931-26047-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
X-From: git-owner@vger.kernel.org Thu Jan 21 18:09:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY0Ws-00028P-0X
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 18:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753793Ab0AURJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 12:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753752Ab0AURJE
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 12:09:04 -0500
Received: from smtp152.dfw.emailsrvr.com ([67.192.241.152]:54448 "EHLO
	smtp152.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557Ab0AURJE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 12:09:04 -0500
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jan 2010 12:09:04 EST
Received: from relay5.relay.dfw.mlsrvr.com (localhost [127.0.0.1])
	by relay5.relay.dfw.mlsrvr.com (SMTP Server) with ESMTP id E0C4E3F1739;
	Thu, 21 Jan 2010 12:02:26 -0500 (EST)
Received: by relay5.relay.dfw.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 8ED133F175B;
	Thu, 21 Jan 2010 12:02:26 -0500 (EST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <1263877931-26047-1-git-send-email-vapier@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137673>

Thanks for this!  I've been meaning to do something similar myself.  :)

A couple of thoughts struck me while looking through your patch...

Mike Frysinger wrote:
> The format of the subject/intro/footer are noise imo, but rather than
> debate the issue, let the user customize the output using the existing
> git config hooks section.  The default output is retained for each part.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
>  contrib/hooks/post-receive-email |   76 +++++++++++++++++++++++++++++---------
>  1 files changed, 58 insertions(+), 18 deletions(-)
> 
> diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
> index 58a35c8..79ab6b1 100755
> --- a/contrib/hooks/post-receive-email
> +++ b/contrib/hooks/post-receive-email
> @@ -38,6 +38,15 @@
>  # hooks.emailprefix
>  #   All emails have their subjects prefixed with this prefix, or "[SCM]"
>  #   if emailprefix is unset, to aid filtering
> +# hooks.emailsubject
> +#   Allow customizing of the subject.  Default is a description of what
> +#   ref changed and how/why.
> +# hooks.emailbodyintro
> +#   Allow customizing of the body intro.  Default is friendly paragraph that
> +#   explains why the user is receiving this e-mail and what has changed.
> +# hooks.emailfooter
> +#   Allow customizing of the footer.  Default is name of the script and the
> +#   repo description.
>  # hooks.showrev
>  #   The shell command used to format each revision in the email, with
>  #   "%s" replaced with the commit id.  Defaults to "git rev-list -1
> @@ -55,6 +64,10 @@
>  # "X-Git-Newrev", and "X-Git-Reftype" to enable fine tuned filtering and
>  # give information for debugging.
>  #
> +# All variables that start with 'email' have substitution performed on them.
> +# Patterns like @foo@ are replaced with the contents of the variable foo.
> +# See subst_vars() for the specific keywords available for substitution.
> +#
>  
>  # ---------------------------- Functions
>  
> @@ -190,36 +203,47 @@ generate_email()
>  	generate_email_footer
>  }
>  
> +subst_vars()
> +{
> +	sep=$(printf '\001')
> +	# let this be used in a pipeline or by itself
> +	( [ "$#" -ne 0 ] && echo "$@" || cat ) | sed \
> +		-e "s${sep}@change_type@${sep}${change_type}${sep}g" \
> +		-e "s${sep}@describe@${sep}${describe}${sep}g" \
> +		-e "s${sep}@newrev@${sep}${newrev}${sep}g" \
> +		-e "s${sep}@oldrev@${sep}${oldrev}${sep}g" \
> +		-e "s${sep}@projectdesc@${sep}${projectdesc}${sep}g" \
> +		-e "s${sep}@refname@${sep}${refname}${sep}g" \
> +		-e "s${sep}@refname_type@${sep}${refname_type}${sep}g" \
> +		-e "s${sep}@oldrev@${sep}${oldrev}${sep}g" \
> +		-e "s${sep}@short_refname@${sep}${short_refname}${sep}g"
> +}
> +
>  generate_email_header()
>  {
>  	# --- Email (all stdout will be the email)
>  	# Generate header
> +	(
>  	cat <<-EOF
>  	To: $recipients
> -	Subject: ${emailprefix}$projectdesc $refname_type, $short_refname, ${change_type}d. $describe
> -	X-Git-Refname: $refname
> -	X-Git-Reftype: $refname_type
> -	X-Git-Oldrev: $oldrev
> -	X-Git-Newrev: $newrev
> +	Subject: ${emailprefix}${emailsubject}
> +	X-Git-Refname: @refname@
> +	X-Git-Reftype: @refname_type@
> +	X-Git-Oldrev: @oldrev@
> +	X-Git-Newrev: @newrev@
> +	EOF
>  
> -	This is an automated email from the git hooks/post-receive script. It was
> -	generated because a ref change was pushed to the repository containing
> -	the project "$projectdesc".
> +	if [ -n "${emailbodyintro}" ] ; then

Since the script ensures there's always a value set for emailbodyintro, why
check for it here?  None of the other uses of the new config items
(emailsubject and emailfooter) have this kind of check.

> +		printf '\n%s\n' "${emailbodyintro}"
> +	fi
>  
> -	The $refname_type, $short_refname has been ${change_type}d
> -	EOF
> +	printf '\n%s\n' "The @refname_type@, @short_refname@ has been @change_type@d"
> +	) | subst_vars

Any reason why that last printf'd line shouldn't be made part of the
emailbodyintro?

So, overall, why not make generate_email_header() be simply:

generate_email_header()
{
	# --- Email (all stdout will be the email)
	# Generate header
	subst_vars <<-EOF
	To: $recipients
	Subject: ${emailprefix}${emailsubject}
	X-Git-Refname: @refname@
	X-Git-Reftype: @refname_type@
	X-Git-Oldrev: @oldrev@
	X-Git-Newrev: @newrev@

	${emailbodyintro}

	EOF
}

This would also let you simply subst_vars() so that it needn't support piped
invocations, no?  (Not a very drastic simplification, but still...)

		M.

>  }
>  
>  generate_email_footer()
>  {
> -	SPACE=" "
> -	cat <<-EOF
> -
> -
> -	hooks/post-receive
> -	--${SPACE}
> -	$projectdesc
> -	EOF
> +	subst_vars "${emailfooter}"
>  }
>  
>  # --------------- Branches
> @@ -671,6 +695,22 @@ recipients=$(git config hooks.mailinglist)
>  announcerecipients=$(git config hooks.announcelist)
>  envelopesender=$(git config hooks.envelopesender)
>  emailprefix=$(git config hooks.emailprefix || echo '[SCM] ')
> +emailsubject=$(git config hooks.emailsubject || \
> +	echo '@projectdesc@ @refname_type@, @short_refname@, @change_type@d. @describe@')
> +emailbodyintro=$(git config hooks.emailbodyintro || cat <<-EOF
> +	This is an automated email from the git hooks/post-receive script. It was
> +	generated because a ref change was pushed to the repository containing
> +	the project "@projectdesc@".
> +	EOF
> +)
> +emailfooter=$(git config hooks.emailfooter || SPACE=" " cat <<-EOF
> +
> +
> +	hooks/post-receive
> +	--${SPACE}
> +	@projectdesc@
> +	EOF
> +)
>  custom_showrev=$(git config hooks.showrev)
>  
>  # --- Main loop
