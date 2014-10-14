From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH] git-prompt.sh: Hide prompt for ignored pwd
Date: Tue, 14 Oct 2014 15:08:07 -0400
Message-ID: <543D7497.2020001@bbn.com>
References: <1412795040-19267-1-git-send-email-jess.austin@gmail.com> <5435A8A7.2030008@bbn.com>  <CANp8Xb8ETG-ZFCqrOk=f-RbxtRxehBmAR1O5ozLH80zimWq_Gw@mail.gmail.com>  <CANp8Xb9MUbQCVZRNYibFBibzTFF=56BqNFFC1G2iTF7WGBNi7g@mail.gmail.com>  <54361F30.8020603@bbn.com> <CANp8Xb_kdpzYjWZxoWFtT+UWwMPpFD0znkoEKVpdukGf61Preg@mail.gmail.com>  <5437078B.6020307@bbn.com> <1413253924-8065-1-git-send-email-jess.austin@gmail.com> <543D6FD7.3090306@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>, Jess Austin <jess.austin@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 21:08:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xe7SB-00036e-GN
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 21:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705AbaJNTIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 15:08:11 -0400
Received: from smtp.bbn.com ([128.33.1.81]:10069 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753866AbaJNTIK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Oct 2014 15:08:10 -0400
Received: from socket.bbn.com ([192.1.120.102]:51970)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Xe7SJ-0005fe-1P; Tue, 14 Oct 2014 15:08:23 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 809BC408B1
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <543D6FD7.3090306@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2014-10-14 14:47, Johannes Sixt wrote:
> Am 14.10.2014 um 04:32 schrieb Jess Austin:
>> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
>> index c5473dc..d7559ff 100644
>> --- a/contrib/completion/git-prompt.sh
>> +++ b/contrib/completion/git-prompt.sh
>> @@ -84,6 +84,11 @@
>>  # GIT_PS1_SHOWCOLORHINTS to a nonempty value. The colors are based on
>>  # the colored output of "git status -sb" and are available only when
>>  # using __git_ps1 for PROMPT_COMMAND or precmd.
>> +#
>> +# If you would like __git_ps1 to do nothing in the case when the current
>> +# directory is set up to be ignored by git, then set
>> +# GIT_PS1_HIDE_ON_IGNORED_PWD to a nonempty value, or set
>> +# bash.hideOnIgnoredPwd to true in the repository configuration.
>>  
>>  # check whether printf supports -v
>>  __git_printf_supports_v=
>> @@ -501,6 +506,13 @@ __git_ps1 ()
>>  	local f="$w$i$s$u"
>>  	local gitstring="$c$b${f:+$z$f}$r$p"
>>  
>> +	if [ -n "$(git check-ignore .)" ] &&
>> +	   ( [ -n "${GIT_PS1_HIDE_ON_IGNORED_PWD}" ] ||
>> +	     [ "$(git config --bool bash.hideOnIgnoredPwd)" = "true" ] )
> 
> Ahem, no. Please do not punish users who are not interested in the new
> feature with two new processes every time __git_ps() is run. Think of
> Windows where fork() is really, *really* expensive.

Is this why bash.showDirtyState and friends aren't checked unless the
corresponding environment variable is set to a non-empty value?

Regardless, it would be nice if the behavior matched the other bash.*
variables (only check the bash.* variable if the corresponding
environment variable is set, and default to true).  The following should
fix it:

    if [ -n "${GIT_PS1_HIDE_ON_IGNORED_PWD}" ] &&
       [ "$(git config --bool bash.hideOnIgnoredPwd)" != "false" ] &&
       [ "$(git check-ignore .)" ]
    then
            ...

-Richard

> 
> BTW, you can write '{ foo || bar; }' to bracket a || chain without a
> sub-process.
> 
>> +	then
>> +		printf_format=""
>> +	fi
>> +
>>  	if [ $pcmode = yes ]; then
>>  		if [ "${__git_printf_supports_v-}" != yes ]; then
>>  			gitstring=$(printf -- "$printf_format" "$gitstring")
> 
> -- Hannes
> 
