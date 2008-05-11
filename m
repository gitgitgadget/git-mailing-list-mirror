From: nathan spindel <nathans@gmail.com>
Subject: Re: [PATCH] instaweb: if no httpd is specified and lighttpd doesn't exist, fall back on apache2.
Date: Sun, 11 May 2008 10:00:11 -0700
Message-ID: <0EB126FA-6752-4C66-B93D-48694159E3B6@gmail.com>
References: <1210483565-12415-1-git-send-email-nathans@gmail.com> <7vlk2h7318.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 11 19:01:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvEv7-0005oV-AX
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 19:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061AbYEKRAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 13:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbYEKRAR
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 13:00:17 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:15298 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbYEKRAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 13:00:16 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1966894wfd.4
        for <git@vger.kernel.org>; Sun, 11 May 2008 10:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=ZKmf/XZaOBMDV3rBmgJxvZOgEhlTIvLzo+xsc6w7/sg=;
        b=tWD9NDGe26pU1OREWz+t3QT32iwjI2ShCtqGKk2e3bz3JaVrEDmjmhJTPC9yWFGjAP9vx2x6I4dRe8h41LZ0JFslbPgX0acN2U21ESiqlIdqdjzwZms9h/P98w8E5yP9uF5taS0haid+plVPWnedKP4RYVnCvItj3FoNYkYQlYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=BeZds4urjuzu/Xdmi8DBIu5OFvWFb2LSWx5Q9BUpdfg6Bd5oDyU+z9X1/8GuEfLN3w8Bl2yFl7CtW2c5tJyjU132Ggwsy8grhT4/FzkpLNV4xgG/iSsj2j7buyn8exq91s3p9O8vj+Rm02MPoxfe+oggDspRcXljoMlSKwjMxp0=
Received: by 10.142.240.9 with SMTP id n9mr2892777wfh.79.1210525215521;
        Sun, 11 May 2008 10:00:15 -0700 (PDT)
Received: from ?10.0.1.4? ( [76.14.71.118])
        by mx.google.com with ESMTPS id 28sm16286906wfg.15.2008.05.11.10.00.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 May 2008 10:00:15 -0700 (PDT)
In-Reply-To: <7vlk2h7318.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81794>

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

I didn't know that the portability of "type" was questionable.  That's  
a good idea.  Thanks!
