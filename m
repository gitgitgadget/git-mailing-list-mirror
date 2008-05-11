From: nathan spindel <nathans@gmail.com>
Subject: Re: [PATCH] instaweb: if no httpd is specified and lighttpd doesn't exist, fall back on apache2.
Date: Sun, 11 May 2008 11:26:31 -0700
Message-ID: <17FDB7BC-D8FC-4016-8704-61D557BF874F@gmail.com>
References: <1210483565-12415-1-git-send-email-nathans@gmail.com> <7vlk2h7318.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 11 20:27:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvGGc-0005u4-9b
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 20:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755961AbYEKS0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 14:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755097AbYEKS0g
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 14:26:36 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:1918 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755072AbYEKS0g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 14:26:36 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1989881wfd.4
        for <git@vger.kernel.org>; Sun, 11 May 2008 11:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=EMiip+rQe4OofOQvRwItM7i2rwwon4b5qO2UTuPoH/k=;
        b=TRGH6A0F0vdAWmj5TJgOw+kwcbxpAZixrNGqRW44aqcD11o4UeRNldBCwbYcYpZe7v5ig4kG1DWNAw3Vnw38Y1p3hgijDJHMlpsQuAJ3OW++xvLwwWnWacf+pJ2TFspRoxhEHHHsTPAjw34msQmMc3ZcGolCn7k6VWFBnkjSOUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=fQO9MP20NLorTvSRx/worBzKqJk2g/rB5X/ay1vFItDt2LAgp070O75p3diqqN5fKlRsV6yR6XkLdvFWzglF1/iib9xo4qAOjgH0HskB00L4FsJ9B9B0dAyCorUl1AArq2jANBVA6ruBYcnKk1ND2wO5PIos2Xob1IgR0pjhIBM=
Received: by 10.142.240.9 with SMTP id n9mr2910269wfh.136.1210530394044;
        Sun, 11 May 2008 11:26:34 -0700 (PDT)
Received: from ?10.0.1.4? ( [76.14.71.118])
        by mx.google.com with ESMTPS id 22sm15720354wfd.19.2008.05.11.11.26.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 May 2008 11:26:33 -0700 (PDT)
In-Reply-To: <7vlk2h7318.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81806>

On May 10, 2008, at 11:44 PM, Junio C Hamano wrote:

> nathan spindel <nathans@gmail.com> writes:
>
>> Signed-off-by: nathan spindel <nathans@gmail.com>
>> ---
>> git-instaweb.sh |   12 ++++++++++--
>> 1 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/git-instaweb.sh b/git-instaweb.sh
>> index 6f91c8f..b744133 100755
>> --- a/git-instaweb.sh
>> +++ b/git-instaweb.sh
>> @@ -31,8 +31,16 @@ conf="$GIT_DIR/gitweb/httpd.conf"
>>
>> # Defaults:
>>
>> -# if installed, it doesn't need further configuration (module_path)
>> -test -z "$httpd" && httpd='lighttpd -f'
>> +# use lighttpd if it exists, otherwise use apache2
>> +if test -z "$httpd"
>> +then
>> +	if type "lighttpd" > /dev/null 2>&1;
>
> The exit code from "type" is very loosely defined by POSIX which  
> just says
> it exits >0 to signal that "an error occured".  Presumably it means  
> there
> is no such command that is executable on the $PATH, and it may be more
> portable and reliable than using "which", but this still worries me.
>
> Doesn't "lighttpd" have an option that reports "I am here" and exit 0,
> e.g. "--version"?  Then we could instead say:
>
> 	if lighttpd --version >/dev/null
>        then
>        	... use it ...
>
> and that would be much nicer...

Actually, this approach has the same problem that's worked around  
here: <http://repo.or.cz/w/git.git?a=blob;f=git- 
instaweb.sh;hb=HEAD#l46>. (You might have lighttpd installed but not  
be on your $PATH, which the script should handle for you).

It seems the best approach would be to function-ize the aforementioned  
httpd-path-checking logic [that currently uses "which"] and use it for  
(a) detecting if lighttpd is installed and (b) looking for apache2  
binaries named httpd.

I think for now these particular patches will continue to use "type"  
as you somewhat suggested earlier today.  :)
