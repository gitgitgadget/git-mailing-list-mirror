From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve sed portability
Date: Thu, 12 Jun 2008 01:33:14 -0700
Message-ID: <7vy75b833p.fsf@gitster.siamese.dyndns.org>
References: <1213189759-11565-1-git-send-email-chris.ridd@isode.com>
 <484FDB5D.7060606@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Ridd <chris.ridd@isode.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jun 12 10:34:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6iGO-0005Z5-Bq
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 10:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025AbYFLIdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 04:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752372AbYFLIdf
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 04:33:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665AbYFLIde (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 04:33:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AB302283E;
	Thu, 12 Jun 2008 04:33:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B78BD283D; Thu, 12 Jun 2008 04:33:22 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3C102694-385A-11DD-87C3-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84736>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Chris Ridd schrieb:
>> On Solaris /usr/bin/sed apparently fails to process input that doesn't
>> end in a \n. Consequently constructs like
>> 
>>   re=$(printf '%s' foo | sed -e 's/bar/BAR/g' $)
>> 
>> cause re to be set to the empty string.
>
> So does /usr/bin/sed of AIX 4.3!
>
>> @@ -73,7 +73,7 @@ resolve_relative_url ()
>>  module_name()
>>  {
>>  	# Do we have "submodule.<something>.path = $1" defined in .gitmodules file?
>> -	re=$(printf '%s' "$1" | sed -e 's/[].[^$\\*]/\\&/g')
>> +	re=$(printf "%s\n" "$1" | sed -e 's/[].[^$\\*]/\\&/g')
>
> You change sq into dq. Is this not dangerous? Shouldn't backslash-en be
> hidden from the shell so that printf can interpret it?

"\n" inside dq is _not_ interpreted by the shell (printf interprets it),
but I tend to agree that using sq is worry-free and better.

>>  	name=$( git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
>>  		sed -n -e 's|^submodule\.\(.*\)\.path '"$re"'$|\1|p' )
>
> I trust you have tested this. But I wonder whether this leaves a stray
> newline in $re that gets in the way inside the sed expression...

I suspect the very original was written (or copied from something that
wrote) like this:

	re=$(echo -n "$1" | sed -e '...')

and mechanically replaced to

	re=$(printf '%s' "$1" | sed -e '...')

because "echo" is not quite portable.

But the original misunderstands the command substitution.  The trailing LF
is removed by it, so as long as "$1" is a single line, $re will get a line
without the trailing LF _anyway_.
