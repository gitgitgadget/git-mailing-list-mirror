From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] post-receive-email: optional message line count limit
Date: Thu, 15 Jul 2010 10:36:55 -0700
Message-ID: <7v1vb4wsso.fsf@alter.siamese.dyndns.org>
References: <m2vd8jhxbd.fsf@igel.home>
 <1279205516-3302-1-git-send-email-kpfleming@digium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Kevin P. Fleming" <kpfleming@digium.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 19:37:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZSMz-000393-US
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 19:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933919Ab0GORhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 13:37:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43335 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933914Ab0GORhG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 13:37:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D412CC43F6;
	Thu, 15 Jul 2010 13:37:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qQ901F1qvL1Vxzrf39OAInO6Uxk=; b=fBfBYU
	M0oZIguwBLNDN6epbLEWPIWNM5GuuAcAxRA5nA222VBcW4n/d4tLRI/s23zjp4Jn
	d+wbbQegKm8GzSg4huh1J3yHGG+bhXrSKfB2d3CB2/1sT7olKfY5H8eK4/3PMr6u
	LYrBI7xPgnmhPtARXhobZ86lp4lt9BFxoTzt0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a/qm/O8SgA6r7rDFqiGbav7A6BC0SOdB
	s7UKAkY2tnhZkRz3ajwkwBJ0BfwOKjrwHXujZGGaDKP57AQ8k3ArHhgW+xyuj5fs
	wVIWpAlT1cscOV4EmvqdZaYJHUdCvTBO5TL4OdzCsCNAC0VMVhCWqY5cV7z3jUCN
	ORrG8UoE660=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AF705C43F4;
	Thu, 15 Jul 2010 13:37:00 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8FA86C43F3; Thu, 15 Jul
 2010 13:36:57 -0400 (EDT)
In-Reply-To: <1279205516-3302-1-git-send-email-kpfleming@digium.com> (Kevin
 P. Fleming's message of "Thu\, 15 Jul 2010 09\:51\:56 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 92EB32CE-9037-11DF-92FC-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151098>

"Kevin P. Fleming" <kpfleming@digium.com> writes:

> We have become used to the features of svnmailer when used with Subversion,
> and one of those useful features is that it can limit the maximum length
> (in lines) of a commit email message. This is terribly useful since once the
> goes beyond a reasonable number of lines, nobody is going to read the remainder,
> and if they really want the entire contents of the commits, they can use
> git itself to get them using the revision IDs present in the message already.
>
> Change the post-receive-email script to respond to an 'emailmaxlines' config key
> which, if specified, will limit the number of lines generated (including
> headers); any lines beyond the limit are suppressed, and a final line is added
> indicating the number that were suppressed.
> ---

Sign-off?

> diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
> index 30ae63d..4dc85c2 100755
> --- a/contrib/hooks/post-receive-email
> +++ b/contrib/hooks/post-receive-email
> @@ -642,6 +647,27 @@ show_new_revisions()
>  }
>  
>  
> +limit_lines()
> +{
> +	lines=0
> +	skipped=0
> +	while IFS="" read -r line
> +	do
> +		lines=$((lines + 1))
> +		if [ $lines -gt $1 ]
> +		then

Since this is a contrib/ material, I should probably be not so picky about
it, but the style used in this script seems to be to use "; then" tacked
at the end on the same line as "if" is on.  Which is different from the
main scripted Porcelains in git.git, but you would want to be consistent
with the local convention around your code.

> +			skipped=$((skipped + 1))
> +		else
> +			printf "%s\n" "$line"
> +		fi
> +	done
> +	if [ $skipped -ne 0 ]
> +	then
> +		echo "... $skipped lines suppressed ..."
> +	fi
> +}

The above makes me wonder if the nicety of saying "we are not showing
everything; instead we skipped N lines" is really worth the trouble of the
shell loop.  Otherwise, a lot simpler:

	limit_lines ()
        {
        	head -n "$1"
	}

would be sufficient.  I dunno, and I don't deeply care either way.

> @@ -679,6 +705,7 @@ announcerecipients=$(git config hooks.announcelist)
>  envelopesender=$(git config hooks.envelopesender)
>  emailprefix=$(git config hooks.emailprefix || echo '[SCM] ')
>  custom_showrev=$(git config hooks.showrev)
> +maxlines=$(git config hooks.emailmaxlines)
>  
>  # --- Main loop
>  # Allow dual mode: run from the command line just like the update hook, or
> @@ -691,6 +718,10 @@ if [ -n "$1" -a -n "$2" -a -n "$3" ]; then
>  else
>  	while read oldrev newrev refname
>  	do
> -		generate_email $oldrev $newrev $refname | send_mail
> +		if [ -z "$maxlines" ]; then
> +			generate_email $oldrev $newrev $refname | send_mail
> +		else
> +			generate_email $oldrev $newrev $refname | limit_lines $maxlines | send_mail
> +		fi

Hmm, the above made me wonder how the raw message needs to be generated
differently depending on maxlines and eyeball the common part for three
times to spot there is no difference.  I wouldn't have if it were written
this way:

	generate_email $oldrev $newrev $refname |
        if ...; then
        	send_mail
	else
        	limit_lines ... | send_mail
	fi

But more importantly, I have a suspicion that this patch is hooking into a
wrong place.  Look at what generate_email does.  It consists of calls to

 - generate_email_header, that gives the To:/Subject:/etc and the header
   boilerplate;

 - generate_*_*_email, that gives the body of the message; and

 - generate_email_footer, that gives the standard "-- " signature line.

You would never want to shorten the output so much that the header is cut
in the middle.  What you are trying to shorten is the body of the message,
so it would make a lot more sense to cut only the generate_*_*_email part.

IOW, shouldn't the patch be more like this?

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 30ae63d..d8964b6 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -84,6 +84,7 @@ generate_email()
 	oldrev=$(git rev-parse $1)
 	newrev=$(git rev-parse $2)
 	refname="$3"
+	maxlines=$4
 
 	# --- Interpret
 	# 0000->1234 (create)
@@ -192,7 +193,12 @@ generate_email()
 		fn_name=atag
 		;;
 	esac
-	generate_${change_type}_${fn_name}_email
+	if [ -z "$maxlines" ]; then
+		generate_${change_type}_${fn_name}_email
+	else
+		generate_${change_type}_${fn_name}_email |
+		limit_lines $maxlines
+	fi
 
 	generate_email_footer
 }
@@ -691,6 +697,6 @@ if [ -n "$1" -a -n "$2" -a -n "$3" ]; then
 else
 	while read oldrev newrev refname
 	do
-		generate_email $oldrev $newrev $refname | send_mail
+		generate_email $oldrev $newrev $refname $maxlines | send_mail
 	done
 fi
