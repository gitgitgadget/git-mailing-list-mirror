From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH 2/2] help.c: use SHELL_PATH instead of hard-coded "/bin/sh"
Date: Sun, 8 Mar 2015 23:32:22 -0700
Message-ID: <C611A125-D641-46E6-A5AD-1010D70582F0@gmail.com>
References: <38be9195b966a027cb050e5a1b47526@74d39fa044aa309eaea14b9f57fe79c> <0ebc0373b21c75fa88adb5aefd098e9@74d39fa044aa309eaea14b9f57fe79c> <xmqq61acsz7k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 07:32:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUrEs-0008Iu-Q2
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 07:32:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbbCIGc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 02:32:26 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34931 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbbCIGc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 02:32:26 -0400
Received: by pdbfp1 with SMTP id fp1so41640525pdb.2
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 23:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=Hs7LXq9Snv5OLCvQux3K7Mx9v2M2vMSBQfVLOOKAGMo=;
        b=McxP+LBD2BiaTO3dxK4lSFA4Qy+YoIaE3QnBdMmReyk7SDwxDiy1RXqofEly7iWv4o
         8LxTaiIyF8gqFKdAgPfBo95bmmjshmDfrhJUgjN+g66LFDkfXGgwkX9/ZSDBq/5VABgT
         mLEKsjuoMlRN14VLh1p9vOPX99jFZrtGQol6440meYNXfSUsAl89bDkKm5TBc0BOH0L9
         Qxu02qQn1QfkT00nDs+wxydo4a/DSwx8o2e44V+kGGJ9llxJOBRlIWxXXycircNeBpkU
         +Hq76MqLS6Oeirz0cNOedOzcFnc8RLsGtwsQiduHuXGLEsTgFGjiRnxL5uoSn4El5eYm
         X1nw==
X-Received: by 10.70.36.169 with SMTP id r9mr2150311pdj.81.1425882745590;
        Sun, 08 Mar 2015 23:32:25 -0700 (PDT)
Received: from ?IPv6:2002:48c0:ad8d::223:12ff:fe05:eebd? ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id rf12sm10018102pdb.0.2015.03.08.23.32.24
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 08 Mar 2015 23:32:24 -0700 (PDT)
In-Reply-To: <xmqq61acsz7k.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265129>

On Mar 7, 2015, at 23:52, Junio C Hamano wrote:
> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>> If the user has set SHELL_PATH in the Makefile then we
>> should respect that value and use it.
>>
>> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
>> ---
>> builtin/help.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/help.c b/builtin/help.c
>> index 6133fe49..2ae8a1e9 100644
>> --- a/builtin/help.c
>> +++ b/builtin/help.c
>> @@ -171,7 +171,7 @@ static void exec_man_cmd(const char *cmd, const  
>> char *page)
>> {
>> 	struct strbuf shell_cmd = STRBUF_INIT;
>> 	strbuf_addf(&shell_cmd, "%s %s", cmd, page);
>> -	execl("/bin/sh", "sh", "-c", shell_cmd.buf, (char *)NULL);
>> +	execl(SHELL_PATH, SHELL_PATH, "-c", shell_cmd.buf, (char *)NULL);
>
> It is a common convention to make the first argument the command
> name without its path, and this change breaks that convention.

Hmpf.  I present these for your consideration:

$ sh -c 'echo $0'
sh
$ /bin/sh -c 'echo $0'
/bin/sh
$ cd /etc
$ ../bin/sh -c 'echo $0'
../bin/sh

I always thought it was the actual argument used to invoke the item.   
If the item is in the PATH and was invoked with a bare word then arg0  
would be just the bare word or possibly the actual full pathname as  
found in PATH.  Whereas if it's invoked with a path (relative or  
absolute) that would passed instead.

> Does it matter, or would it break something?  I recall that some
> implementations of shell (e.g. "bash") change their behaviour
> depending on how they are invoked (e.g. "ln -s bash /bin/sh" makes
> it run in posix mode) but I do not know if they do so by paying
> attention to their argv[0].

Several shells are sensitive to argv[0] in that if it starts with a  
'-' then they become a login shell.  Setting SHELL_PATH to anything  
that is not an absolute path is likely to break things in other ways  
though so that doesn't seem like a possibility here.

> There might be other fallouts I do not
> think of offhand here.
>
> I do not have an objection to what these patches want to do, though.

I also have no objection to changing it to:

> -	execl("/bin/sh", "sh", "-c", shell_cmd.buf, (char *)NULL);
> +	execl(SHELL_PATH, basename(SHELL_PATH), "-c", shell_cmd.buf, (char  
> *)NULL);

just to maintain the current behavior.

Would you be able to squash that change in or shall I re-roll?

-Kyle
