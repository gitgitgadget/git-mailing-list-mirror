From: "Kevin P. Fleming" <kpfleming@digium.com>
Subject: Re: [PATCH] post-receive-email: ensure sent messages are not empty
Date: Mon, 02 Aug 2010 17:17:21 -0500
Organization: Digium, Inc.
Message-ID: <4C5743F1.5020806@digium.com>
References: <1280780927-29006-1-git-send-email-kpfleming@digium.com> <7vk4o8k73w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 00:17:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og3KA-0003JE-0e
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 00:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049Ab0HBWRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 18:17:24 -0400
Received: from mail.digium.com ([216.207.245.2]:51881 "EHLO mail.digium.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754007Ab0HBWRX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 18:17:23 -0400
Received: from zimbra.digium.internal ([10.24.55.203] helo=zimbra.hsv.digium.com)
	by mail.digium.com with esmtp (Exim 4.69)
	(envelope-from <kpfleming@digium.com>)
	id 1Og3Jy-0003ZN-J4; Mon, 02 Aug 2010 17:17:22 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.hsv.digium.com (Postfix) with ESMTP id 8D9A91A2015;
	Mon,  2 Aug 2010 17:17:22 -0500 (CDT)
Received: from zimbra.hsv.digium.com ([127.0.0.1])
	by localhost (zimbra.hsv.digium.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id scYsYkEyjvqx; Mon,  2 Aug 2010 17:17:22 -0500 (CDT)
Received: from [10.24.250.46] (unknown [10.24.250.46])
	by zimbra.hsv.digium.com (Postfix) with ESMTPSA id 0EA4B1A2011;
	Mon,  2 Aug 2010 17:17:22 -0500 (CDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100713 Thunderbird/3.0.6
In-Reply-To: <7vk4o8k73w.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
OpenPGP: id=05FB8DB2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152473>

On 08/02/2010 05:00 PM, Junio C Hamano wrote:
> "Kevin P. Fleming" <kpfleming@digium.com> writes:
> 
>> @@ -687,10 +699,12 @@ if [ -n "$1" -a -n "$2" -a -n "$3" ]; then
>>  	# Output to the terminal in command line mode - if someone wanted to
>>  	# resend an email; they could redirect the output to sendmail
>>  	# themselves
>> -	PAGER= generate_email $2 $3 $1
>> +	prep_for_email $2 $3 $1
>> +	PAGER= generate_email
>>  else
>>  	while read oldrev newrev refname
>>  	do
>> -		generate_email $oldrev $newrev $refname | send_mail
>> +		prep_for_email $oldrev $newrev $refname
>> +		generate_email | send_mail
>>  	done
> 
> As "prep" exits, when this is run as a hook to read many updated refs, any
> inappropriate update to one ref will cause messages for later refs from
> getting sent out.  Earlier such an update may have sent an empty message
> but at least didn't break messages for other refs, if I am reading the
> code correctly.  Is that what you really want?
> 
> Perhaps you would want to do something like this instead, after adjusting
> the exit code from the new "prep" shell function?
> 
> 	while ...
>         do
>         	prep_for_email || continue
>                 generate_email | send_mail
> 	done
> 

You are right; instead of prep_for_email using 'exit 0' to stop the
process as was done before, it should just return an exit code to skip
the current ref being processed. This was also a bug previously, since
generate_email used 'exit 0' to stop the processing of a particular ref,
which would actually stop processing of any further refs as well.

-- 
Kevin P. Fleming
Digium, Inc. | Director of Software Technologies
445 Jan Davis Drive NW - Huntsville, AL 35806 - USA
skype: kpfleming | jabber: kfleming@digium.com
Check us out at www.digium.com & www.asterisk.org
