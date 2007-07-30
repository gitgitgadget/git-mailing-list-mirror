From: Eric Lesh <eclesh@ucla.edu>
Subject: Re: [GUILT PATCH 2/4] guilt-guard: Assign guards to patches in series
Date: Sun, 29 Jul 2007 23:41:52 -0700
Message-ID: <87k5sics0f.fsf@hubert.paunchy.net>
References: <118569541814-git-send-email-eclesh@ucla.edu>
	<11856954181497-git-send-email-eclesh@ucla.edu>
	<20070730040610.GD22017@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jsipek@cs.sunysb.edu, git@vger.kernel.org
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Mon Jul 30 08:42:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFOxX-00047e-03
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 08:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937850AbXG3GmY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 02:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764100AbXG3GmX
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 02:42:23 -0400
Received: from smtp-9.smtp.ucla.edu ([169.232.48.138]:55183 "EHLO
	smtp-9.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S938505AbXG3GmW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 02:42:22 -0400
Received: from mail.ucla.edu (mail.ucla.edu [169.232.48.151])
	by smtp-9.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l6U6fwVo018499;
	Sun, 29 Jul 2007 23:41:58 -0700
Received: from localhost (adsl-75-26-171-70.dsl.scrm01.sbcglobal.net [75.26.171.70])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l6U6fwKN000811
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 29 Jul 2007 23:41:58 -0700
Received: by localhost (Postfix, from userid 1000)
	id 6EE611E80A8; Sun, 29 Jul 2007 23:41:52 -0700 (PDT)
In-Reply-To: <20070730040610.GD22017@filer.fsl.cs.sunysb.edu> (Josef Sipek's message of "Mon\, 30 Jul 2007 00\:06\:10 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.0 (gnu/linux)
X-Probable-Spam: no
X-Spam-Report: none
X-Scanned-By: smtp.ucla.edu on 169.232.48.138
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54192>

Josef Sipek <jsipek@fsl.cs.sunysb.edu> writes:

[...]

>> +get_guarded_series()
>> +{
>> +	get_series | while read p
>> +	do
>> +		[ -z `check_guards $p` ] && echo "$p"
>
> Having check_guards return 0 or 1 makes things cleaner:
>
> check_guards "$p" && echo "$p"
>
>> +	done
>> +}
>> +
>> +# usage: check_guards <patch>
>> +# Returns t if the patch should be skipped
>> +check_guards()
>> +{
>> +        get_guards "$1" | while read guard
>> +        do
>> +                pos=`echo $guard | grep -e "^+"`
>> +                guard=`echo $guard | sed -e 's/[+-]//'`
>> +                if [ $pos ]; then
>> +                        # Push +guard *only if* guard selected
>> +                        push=`grep -e "^$guard\$" "$guards_file" > /dev/null; echo $?`
>> +                        [ $push -ne 0 ] && echo t
>
> 			   [ $push -ne 0 ] && return 1
>

This returns from the subshell created by the pipe and the while loop,
right?

So I'm using:

check_guards()
{
	get_guards "$1" | while read guard
	do
		pos=`echo $guard | grep -e "^+"`
		guard=`echo $guard | sed -e 's/^[+-]//'`
		if [ $pos ]; then
			# Push +guard *only if* guard selected
			push=`grep -e "^$guard\$" "$guards_file" > /dev/null; echo $?`
			[ $push -ne 0 ] && return 1
		else
			# Push -guard *unless* guard selected
			push=`grep -e "^$guard\$" "$guards_file" > /dev/null; echo $?`
			[ $push -eq 0 ] && return 1
		fi
                return 0
	done
	return $?
}

where 1 means push.

>> +# usage: get_guards <patch>
>> +get_guards()
>> +{
>> +	grep -e "^$1[[:space:]]*#" < "$series" | sed -e "s/^$1 //" -e 's/#[^+-]*//g'
>> +}

Should this also be one sed script instead of a grep + sed?

>> +
>> +# usage: set_guards <patch> <guards>
>
> I'd try to make it clearer that multiple guards can be specified.
>

Done with <guards...> now.

>> +set_guards()
>> +{
>> +	p="$1"
>> +	shift
>> +	for x in "$@"; do
>> +		if [ -z $(echo "$x" | grep -e "^[+-]") ]; then
>
> Is that the only restriction on the guard name?
>

Yes.  On patches, you put a '+guard' or '-guard'.  When selecting with
guilt-select, it's just 'guard'.  The + or - just means 'apply when
selected' or 'apply unless selected'.  You can edit things manually to
make guards with a space in the name, but the mechanism will work even
in that case.

>> +			echo "'$x' is not a valid guard name"
>> +		else
>> +			sed -i -e "s/^\($p[[:space:]]*.*\)$/\1 #$x/" "$series"
>> +		fi
>> +	done
>> +}
>> +
>> +# usage: unset_guards <patch> <guards>
>

[...]

The rest I'll do.  Thanks for the review.

	Eric
