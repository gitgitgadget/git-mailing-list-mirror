From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: [PATCH 3/5] run-command: Elaborate execvp error checking
Date: Wed, 25 Jan 2012 08:09:25 +0100
Message-ID: <op.v8motzak0aolir@keputer>
References: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
 <1327444346-6243-4-git-send-email-fransklaver@gmail.com>
 <20120124232239.GG8222@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C. Hamano" <gitster@pobox.com>,
	"Johannes Sixt" <j6t@kdbg.org>
To: "Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 08:09:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rpwz8-0000aC-1u
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 08:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485Ab2AYHJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jan 2012 02:09:29 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:53716 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369Ab2AYHJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 02:09:29 -0500
Received: by eekc14 with SMTP id c14so2487518eek.19
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 23:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=pslWhbnzvXp/gODU5eEptpY8cZAfascDjMx4VuSnCfY=;
        b=rT0V+mXkqs9eGdWYfTcksVldulLUKxbaImAHjRoBXPQ0kxCec5e5YEenqX6S6cbsXv
         KwPhee/m6Fw+Aw2+H3ZeNV5HPabb8hrpsged5dB7aXwL2gPa4vi6iwQM39rdpCqancsh
         RyZ9wGabCkinGkloplEI+iJckAMZvtk/2UAIk=
Received: by 10.14.9.84 with SMTP id 60mr1890085ees.72.1327475367830;
        Tue, 24 Jan 2012 23:09:27 -0800 (PST)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id s16sm77872207eef.2.2012.01.24.23.09.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jan 2012 23:09:27 -0800 (PST)
In-Reply-To: <20120124232239.GG8222@burratino>
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189101>

On Wed, 25 Jan 2012 00:22:39 +0100, Jonathan Nieder <jrnieder@gmail.com>  
wrote:

> Klaver wrote:
>
>> The interpretation of errors from execvp was rather terse. For user
>> convenience communication of the nature of the error can be improved.
>
> Could you give an example?

The case that triggered me to work on this. I had an incorrect entry in my  
PATH and some aliasing tests failed. The generated command output was  
something like

fatal: script: Access Denied

while I was certain it didn't exist because I was expecting an alias to be  
executed. Also, access denied on a file that doesn't exist? That didn't  
make sense (it really doesn't if you don't know the execvp workings).  
Basically git takes no effort in actually pointing the user to the source  
of the problem. During the previous two versions I came to realize that  
this goes for all error codes execvp produces.


>
> [...]
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -2,6 +2,7 @@
>>  #include "run-command.h"
>>  #include "exec_cmd.h"
>>  #include "argv-array.h"
>> +#include "dir.h"
>>
>>  static inline void close_pair(int fd[2])
>>  {
>> @@ -134,6 +135,140 @@ static int wait_or_whine(pid_t pid, const char  
>> *argv0, int silent_exec_failure)
>>  	return code;
>>  }
>>
>> +#ifndef WIN32
>
> Not related to this patch, but I wonder if there should be a separate
> run-command-unix.c file so these ifdefs would no longer be necessary.

Might be useful indeed.


> What happens on Windows?

I haven't changed anything on the windows side, so that probably sticks to  
the old behavior.



>> +static void die_file_error(const char *file, int err)
>> +{
>> +	die("cannot exec '%s': %s", file, strerror(err));
>> +}
>
> I suspect it might be clearer to use die() inline in the two call
> sites so the reader does not have to figure out the calling
> convention.

Fair enough. I originally expected it to be used more than twice in the  
code.



>
>> +
>> +static char *get_interpreter(const char *first_line)
>> +{
>> +	struct strbuf sb = STRBUF_INIT;
>> +	size_t start = strspn(first_line + 2, " \t") + 2;
>> +	size_t end = strcspn(first_line + start, " \t\r\n") + start;
>> +
>> +	if (start >= end)
>> +		return NULL;
>> +
>> +	strbuf_add(&sb, first_line + start, end - start);
>> +	return strbuf_detach(&sb, NULL);
>> +}
>
> What does this function do?  What happens if first_line doesn't start
> with "#!"?  What should happen when there is a newline instead of a
> command name?  How about commands with quoting characters like " and
> backslash --- are the semantics portable in these cases?

This gets the interpreter from a #! line, assuming that it actually has a  
#!. You might call it naive, which would be fair enough. I didn't see much  
point in doing the same check twice, but inlining this code in its  
callsite felt messy.


> No need to use a strbuf here: xmemdupz would take care of the
> allocation and copy more simply.

Right.


>> +static void inspect_failure(const char *argv0, int silent_exec_failure)
>> +{
>> +	int err = errno;
>> +	struct strbuf sb = STRBUF_INIT;
>> +
>> +	/* errors not related to path */
>> +	if (errno == E2BIG || errno == ENOMEM)
>> +		die_file_error(argv0, err);
>> +
>> +	if (strchr(argv0, '/')) {
>> +		if (file_exists(argv0)) {
>> +			strbuf_add(&sb, argv0, strlen(argv0));
>> +			inspect_file(&sb, err, argv0);
>> +		}
>> +	} else {
>> +		char *path, *next;
>> +		path = getenv("PATH");
>
> I wonder if it's possible to rearrange this code to avoid deep
> nesting.  What does the function do, anyway?  (If the reader has to
> ask, it needs a comment or to be renamed.)
>
> I guess the idea is to diagnose after the fact why execvp failed.

Correct guess.

> Might be simplest like this:
>
> 	To diagnose execvp failure:
> 		if filename does not contain a '/':
> 			if we can't find it on the search path:
> 				That's the problem, dummy!
> 			replace filename with full path
> 		if file does not exist:
> 			just report strerror(errno)
> 		if not executable:
> 			...
> 		if interpreter does not exist:
> 			...
> 		if interpreter not executable:
> 			...
> 		otherwise, just report strerror(errno)
>
> with a separate function to find a command on the PATH, complaining
> when it encounters an unsearchable entry.

Well, this approach basically does the same thing, but this may have  
gotten a bit tunnel-visioned. I'll have a look at your approach and see  
what it gives us.

>
> Thanks for a fun read.

Thanks for an insightful review.
