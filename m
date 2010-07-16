From: "Kevin P. Fleming" <kpfleming@digium.com>
Subject: Re: [PATCH] post-receive-email: optional message line count limit
Date: Fri, 16 Jul 2010 14:13:58 -0500
Organization: Digium, Inc.
Message-ID: <4C40AF76.80709@digium.com>
References: <m2vd8jhxbd.fsf@igel.home> <1279205516-3302-1-git-send-email-kpfleming@digium.com> <7v1vb4wsso.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 16 21:14:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZqML-0005Cx-PN
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 21:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758955Ab0GPTOD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jul 2010 15:14:03 -0400
Received: from mail.digium.com ([216.207.245.2]:1025 "EHLO mail.digium.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758962Ab0GPTOA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 15:14:00 -0400
Received: from zimbra.digium.internal ([10.24.55.203] helo=zimbra.hsv.digium.com)
	by mail.digium.com with esmtp (Exim 4.69)
	(envelope-from <kpfleming@digium.com>)
	id 1OZqMB-0006ip-M6; Fri, 16 Jul 2010 14:13:59 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.hsv.digium.com (Postfix) with ESMTP id 9844AD8025;
	Fri, 16 Jul 2010 14:13:59 -0500 (CDT)
Received: from zimbra.hsv.digium.com ([127.0.0.1])
	by localhost (zimbra.hsv.digium.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pLUuRua9Lf00; Fri, 16 Jul 2010 14:13:59 -0500 (CDT)
Received: from [10.24.250.46] (unknown [10.24.250.46])
	by zimbra.hsv.digium.com (Postfix) with ESMTPSA id 0D96AD8023;
	Fri, 16 Jul 2010 14:13:59 -0500 (CDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100528 Thunderbird/3.0.5
In-Reply-To: <7v1vb4wsso.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
OpenPGP: id=05FB8DB2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151163>

On 07/15/2010 12:36 PM, Junio C Hamano wrote:
> "Kevin P. Fleming" <kpfleming@digium.com> writes:
> 
>> We have become used to the features of svnmailer when used with Subversion,
>> and one of those useful features is that it can limit the maximum length
>> (in lines) of a commit email message. This is terribly useful since once the
>> goes beyond a reasonable number of lines, nobody is going to read the remainder,
>> and if they really want the entire contents of the commits, they can use
>> git itself to get them using the revision IDs present in the message already.
>>
>> Change the post-receive-email script to respond to an 'emailmaxlines' config key
>> which, if specified, will limit the number of lines generated (including
>> headers); any lines beyond the limit are suppressed, and a final line is added
>> indicating the number that were suppressed.
>> ---
> 
> Sign-off?

Oops... first-timer, I was under the mistaken impression that
git-send-email did that for me :-)

>> diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
>> index 30ae63d..4dc85c2 100755
>> --- a/contrib/hooks/post-receive-email
>> +++ b/contrib/hooks/post-receive-email
>> @@ -642,6 +647,27 @@ show_new_revisions()
>>  }
>>  
>>  
>> +limit_lines()
>> +{
>> +	lines=0
>> +	skipped=0
>> +	while IFS="" read -r line
>> +	do
>> +		lines=$((lines + 1))
>> +		if [ $lines -gt $1 ]
>> +		then
> 
> Since this is a contrib/ material, I should probably be not so picky about
> it, but the style used in this script seems to be to use "; then" tacked
> at the end on the same line as "if" is on.  Which is different from the
> main scripted Porcelains in git.git, but you would want to be consistent
> with the local convention around your code.

Agreed, I'll change it to match the rest of the script.

> 
>> +			skipped=$((skipped + 1))
>> +		else
>> +			printf "%s\n" "$line"
>> +		fi
>> +	done
>> +	if [ $skipped -ne 0 ]
>> +	then
>> +		echo "... $skipped lines suppressed ..."
>> +	fi
>> +}
> 
> The above makes me wonder if the nicety of saying "we are not showing
> everything; instead we skipped N lines" is really worth the trouble of the
> shell loop.  Otherwise, a lot simpler:
> 
> 	limit_lines ()
>         {
>         	head -n "$1"
> 	}
> 
> would be sufficient.  I dunno, and I don't deeply care either way.

I think people would be concerned about 'missing' content if there was
no indicator that lines had been suppressed.

> 
>> @@ -679,6 +705,7 @@ announcerecipients=$(git config hooks.announcelist)
>>  envelopesender=$(git config hooks.envelopesender)
>>  emailprefix=$(git config hooks.emailprefix || echo '[SCM] ')
>>  custom_showrev=$(git config hooks.showrev)
>> +maxlines=$(git config hooks.emailmaxlines)
>>  
>>  # --- Main loop
>>  # Allow dual mode: run from the command line just like the update hook, or
>> @@ -691,6 +718,10 @@ if [ -n "$1" -a -n "$2" -a -n "$3" ]; then
>>  else
>>  	while read oldrev newrev refname
>>  	do
>> -		generate_email $oldrev $newrev $refname | send_mail
>> +		if [ -z "$maxlines" ]; then
>> +			generate_email $oldrev $newrev $refname | send_mail
>> +		else
>> +			generate_email $oldrev $newrev $refname | limit_lines $maxlines | send_mail
>> +		fi
> 
> Hmm, the above made me wonder how the raw message needs to be generated
> differently depending on maxlines and eyeball the common part for three
> times to spot there is no difference.  I wouldn't have if it were written
> this way:
> 
> 	generate_email $oldrev $newrev $refname |
>         if ...; then
>         	send_mail
> 	else
>         	limit_lines ... | send_mail
> 	fi
> 
> But more importantly, I have a suspicion that this patch is hooking into a
> wrong place.  Look at what generate_email does.  It consists of calls to
> 
>  - generate_email_header, that gives the To:/Subject:/etc and the header
>    boilerplate;
> 
>  - generate_*_*_email, that gives the body of the message; and
> 
>  - generate_email_footer, that gives the standard "-- " signature line.
> 
> You would never want to shorten the output so much that the header is cut
> in the middle.  What you are trying to shorten is the body of the message,
> so it would make a lot more sense to cut only the generate_*_*_email part.
> 
> IOW, shouldn't the patch be more like this?
> 
> diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
> index 30ae63d..d8964b6 100755
> --- a/contrib/hooks/post-receive-email
> +++ b/contrib/hooks/post-receive-email
> @@ -84,6 +84,7 @@ generate_email()
>  	oldrev=$(git rev-parse $1)
>  	newrev=$(git rev-parse $2)
>  	refname="$3"
> +	maxlines=$4
>  
>  	# --- Interpret
>  	# 0000->1234 (create)
> @@ -192,7 +193,12 @@ generate_email()
>  		fn_name=atag
>  		;;
>  	esac
> -	generate_${change_type}_${fn_name}_email
> +	if [ -z "$maxlines" ]; then
> +		generate_${change_type}_${fn_name}_email
> +	else
> +		generate_${change_type}_${fn_name}_email |
> +		limit_lines $maxlines
> +	fi
>  
>  	generate_email_footer
>  }
> @@ -691,6 +697,6 @@ if [ -n "$1" -a -n "$2" -a -n "$3" ]; then
>  else
>  	while read oldrev newrev refname
>  	do
> -		generate_email $oldrev $newrev $refname | send_mail
> +		generate_email $oldrev $newrev $refname $maxlines | send_mail
>  	done
>  fi

It should indeed; I'll post a new version in a minute that incorporates
your feedback. Thanks!

-- 
Kevin P. Fleming
Digium, Inc. | Director of Software Technologies
445 Jan Davis Drive NW - Huntsville, AL 35806 - USA
skype: kpfleming | jabber: kfleming@digium.com
Check us out at www.digium.com & www.asterisk.org
