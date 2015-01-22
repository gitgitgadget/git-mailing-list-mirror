From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 05/18] fsck: Allow demoting errors to warnings via
 receive.fsck.warn =?UTF-8?Q?=3D=20=3Ckey=3E?=
Date: Thu, 22 Jan 2015 10:35:28 +0100
Organization: gmx
Message-ID: <8605af2fe097d5ebdf575d164eec2408@www.dscho.org>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421682369.git.johannes.schindelin@gmx.de>
 <3fd56573b263f2a4551c9a363d1a44728573a1c6.1421682369.git.johannes.schindelin@gmx.de>
 <xmqqlhkwy0my.fsf@gitster.dls.corp.google.com>
 <07b285ef702031fdebcf9def59528b9c@www.dscho.org>
 <xmqqa91bx0v5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 10:35:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEEBA-0003S5-W0
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 10:35:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbbAVJfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 04:35:52 -0500
Received: from mout.gmx.net ([212.227.17.22]:62382 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753015AbbAVJfl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 04:35:41 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M1RHp-1XPi3R2ccD-00tShN; Thu, 22 Jan 2015 10:35:32
 +0100
In-Reply-To: <xmqqa91bx0v5.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:bRozCHPi735MtM23DjLBRA+6LrcUClo8tD1pvamW7+MckoElxb8
 rqu2Dvx83L2jaLVd08XZiM0fls6JvN1MOPlsdx7qiqWBijorq/cgBKAGQXlFbj8JM+ro5M7
 q//1cioFbZvF9piVdf1XvQvG1sP8S6+uhzbUQfN0Nz6ma4XdtPd1dOUpj4nGcm9srqDrO1Y
 cBkT44d5KcgysBo6i2akA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262811>

Hi Junio,

On 2015-01-21 22:47, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>>>> @@ -1488,8 +1501,13 @@ static const char *unpack(int err_fd, struct shallow_info *si)
>>>>
>>>>  		argv_array_pushl(&child.args, "index-pack",
>>>>  				 "--stdin", hdr_arg, keep_arg, NULL);
>>>> -		if (fsck_objects)
>>>> -			argv_array_push(&child.args, "--strict");
>>>> +		if (fsck_objects) {
>>>> +			if (fsck_severity.len)
>>>> +				argv_array_pushf(&child.args, "--strict=%s",
>>>> +					fsck_severity.buf);
>>>> +			else
>>>> +				argv_array_push(&child.args, "--strict");
>>>> +		}
>>>
>>> Hmm.  The above two hunks look suspiciously similar.  Would it be
>>> worth to give them a single helper function?
>>
>> Hmm. Not sure. I see what you mean, but for now I found
>>
>> +                       argv_array_pushf(&child.args, "--strict%s%s",
>> +                               fsck_severity.len ? "=" : "",
>> +                               fsck_severity.buf);
>>
>> to be more elegant than to add a fully-fledged new function. But if
>> you feel strongly, I will gladly implement a separate function; I
>> would appreciate suggestions as to the function name...
> 
> Peff first introduced that trick elsewhere in our codebase, I think,
> but I find it a bit too ugly.
> 
> As you accumulate fsck_severity strbuf like this anyway:
> 
> 	strbuf_addf(&fsck_severity, "%s%s=%s",
>         	fsck_severity.len ? "," : "", var, value);
> 
> to flip what to prefix each element on the list with, I wonder if it
> is simpler to change that empty string to "=", which will allow you
> to say this:
> 
> 	argv_array_pushf(&child.args, "--strict%s", fsck_severity.buf);

But of course! This is what I did now:

-- snip --
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 8e6d1a1..08e3716 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -126,8 +126,8 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 	}
 
 	if (skip_prefix(var, "receive.fsck.", &var)) {
-		strbuf_addf(&fsck_severity, "%s%s=%s",
-			fsck_severity.len ? "," : "", var, value);
+		strbuf_addf(&fsck_severity, "%c%s=%s",
+			fsck_severity.len ? ',' : '=', var, value);
 		return 0;
 	}
 
@@ -1487,8 +1487,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		if (quiet)
 			argv_array_push(&child.args, "-q");
 		if (fsck_objects)
-			argv_array_pushf(&child.args, "--strict%s%s",
-				fsck_severity.len ? "=" : "",
+			argv_array_pushf(&child.args, "--strict%s",
 				fsck_severity.buf);
 		child.no_stdout = 1;
 		child.err = err_fd;
@@ -1507,8 +1506,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		argv_array_pushl(&child.args, "index-pack",
 				 "--stdin", hdr_arg, keep_arg, NULL);
 		if (fsck_objects)
-			argv_array_pushf(&child.args, "--strict%s%s",
-				fsck_severity.len ? "=" : "",
+			argv_array_pushf(&child.args, "--strict%s",
 				fsck_severity.buf);
 		if (fix_thin)
 			argv_array_push(&child.args, "--fix-thin");
-- snap --

> Or even this:
> 
> 	strbuf_addf(&fsck_strict_arg, "%s%s=%s",
>         	fsck_strict_arg.len ? "," : "--strict=", var, value);

Unfortunately not, because just `--strict` needs to be passed in case no severity levels were overridden.

> In any case, I tend to agree with you that it is overkill to add a
> helper function for just to add a single element to the argument
> list.

I am glad we agree!

Ciao,
Dscho
