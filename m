From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: CPPCheck found 24 high risk bugs in Git v.1.8.3.4
Date: Tue, 20 Aug 2013 01:15:02 +0200
Message-ID: <CABPQNSZidMv4MEW+SqVm94pX4szw9QW8LFWsvBTOXYH7ezzycw@mail.gmail.com>
References: <85C8141E5DAD94428A121F706995A31F010F116FDAD3@MX1.net.tbe.com>
 <33FCCE7A2CD5494B88F3C5CDBC341DFD@PhilipOakley> <166132E40AA54EE387BA9B4558823C55@PhilipOakley>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Koch, Rick (Subcontractor)" <Rick.Koch@tbe.com>,
	Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Aug 20 01:15:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBYfs-0002zO-V7
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 01:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629Ab3HSXPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 19:15:45 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:44050 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264Ab3HSXPo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 19:15:44 -0400
Received: by mail-ob0-f172.google.com with SMTP id er7so6301153obc.31
        for <git@vger.kernel.org>; Mon, 19 Aug 2013 16:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=lWfmqef2zJ6jaHaKHjMGROGmuae4+dhk5/brByoFgbM=;
        b=JE86upwz9k8kvf702qDdJnX8eb0okaixpiqRaYN+hyZl5V2yv7O54CPpiPUFetQzUF
         WKpMXlnkvgbcFDrcn7zoFoKG+GLxEQEF7aqdZHUir0wK+3YDCrs1kVZh8V5X4H5mzBWI
         cGEVFxO+1mUtY261DCVdvMaxfK64CsJ2UXF5QNHjqmKqJhoI2QhMNTRpBa1ZP19dt7kS
         1kkujkY7scK0edKIU47iFOLQVC1XmqtkEPo7RDIqLVlTrB5z6PQseU2EC2lstMVABRSJ
         ilpWuHAmREsHhHaG1uvLRBCKlOg4+i1RaecZpmvCU42NJFLDRHR+mdqUmxzKl5+lNtHd
         Cm0g==
X-Received: by 10.182.246.232 with SMTP id xz8mr15577841obc.9.1376954143900;
 Mon, 19 Aug 2013 16:15:43 -0700 (PDT)
Received: by 10.76.162.68 with HTTP; Mon, 19 Aug 2013 16:15:02 -0700 (PDT)
In-Reply-To: <166132E40AA54EE387BA9B4558823C55@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232577>

This one seems real, although it's quite theoretical. It should only happen
in cases where the log-message contains "%1", the initial malloc passed and
reallocing two more bytes failed.

However, what's much more of a disaster: "pos" is used after the call to
realloc might have moved the memory!

I guess something like this should fix both issues. Sorry about the
lack of indentation, it seems Gmail has regressed, and the old compose
mode is somehow gone... (also sorry for triple-posting to some of you,
Gmail seems particularly broken today)

diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
index d015e43..0641f4e 100644
--- a/compat/win32/syslog.c
+++ b/compat/win32/syslog.c
@@ -43,11 +43,14 @@ void syslog(int priority, const char *fmt, ...)
  va_end(ap);

  while ((pos = strstr(str, "%1")) != NULL) {
- str = realloc(str, ++str_len + 1);
- if (!str) {
+ char *tmp = realloc(str, ++str_len + 1);
+ if (!tmp) {
  warning("realloc failed: '%s'", strerror(errno));
+ free(str);
  return;
  }
+ pos = tmp + (pos - str);
+ str = tmp;
  memmove(pos + 2, pos + 1, strlen(pos));
  pos[1] = ' ';
  }



On Tue, Aug 20, 2013 at 12:55 AM, Philip Oakley <philipoakley@iee.org> wrote:
> ----- Original Message ----- From: "Philip Oakley" <philipoakley@iee.org>
>
>> From: "Koch, Rick (Subcontractor)" <Rick.Koch@tbe.com>
>> Sent: Monday, August 19, 2013 6:09 PM
>>>
>>> I'm directing to this e-mail, as it seems to be the approved forum
>>> for posting Git bugs. We ran CPPCheck against Git v.1.8.3.4
>>> and found 24 high risk bugs. Please see the attachment xlsx.
>>
>>
>>> Is there a method to post to the Git community to allow the
>>> community to review and debunk as faults positive or develop
>>> patches to fix lists code files?
>>
>>
>>> v/r
>>
>>
>>> Roderick (Rick) Koch
>>> Information Assurance
>>> Rick.Koch@tbe.com
>>
>>
>> What OS version / CPPCheck version was this checked on?
>>
>> In case other readers don't have a .xlsx reader here is Rick's list in
>> plain text (may be white space damaged).
>>
>> I expect some will be false positives, and some will just be being too
>> cautious.
>>
>> Philip
>>
>> description resourceFilePath fileName lineNumber
>>      nullPointer(CppCheck) \git-master\builtin\add.c add.c 286
>>      wrongPrintfScanfArgNum(CppCheck) \git-master\builtin\fetch.c
>> fetch.c 588
>>      nullPointer(CppCheck) \git-master\builtin\ls-files.c ls-files.c
>> 144
>>      nullPointer(CppCheck) \git-master\builtin\merge.c merge.c 1208
>>      doubleFree(CppCheck) \git-master\builtin\notes.c notes.c 275
>>      nullPointer(CppCheck) \git-master\builtin\reflog.c reflog.c 437
>>      uninitvar(CppCheck) \git-master\builtin\rev-list.c rev-list.c 342
>>      uninitvar(CppCheck) \git-master\builtin\rev-list.c rev-list.c 342
>>      uninitvar(CppCheck) \git-master\compat\regex\regcomp.c regcomp.c
>> 2803
>>      uninitvar(CppCheck) \git-master\compat\regex\regcomp.c regcomp.c
>> 2802
>>      uninitvar(CppCheck) \git-master\compat\regex\regcomp.c regcomp.c
>> 2805
>>      memleakOnRealloc(CppCheck) \git-master\compat\win32\syslog.c
>> syslog.c 46
>
>
> This looks like a possible, based on
> http://bytes.com/topic/c/answers/215084-can-realloc-potentially-cause-memory-leak
> (Mac's reply, with tweaks)
>
> "Misuse of realloc CAN cause a memory leak, but only when allocation fails"
> "if realloc fails, the memory previously pointed to by 'str = realloc(str,
> ++str_len + 1)' will still be claimed, but you will have lost your only
> pointer to it, because realloc returns NULL on failure. This is a memory
> leak."
>
> We (those using the compat function) then only provide a warning, so it
> could repeat endlessly.
>
> Eric (cc'd) may be able to clarify if this is a possibility.
>
>
>>      uninitvar(CppCheck)
>> \git-master\contrib\examples\builtin-fetch--tool.c builtin-fetch--tool.c
>> 419
>>      uninitvar(CppCheck) \git-master\fast-import.c fast-import.c 2917
>>      nullPointer(CppCheck) \git-master\line-log.c line-log.c 638
>>      nullPointer(CppCheck) \git-master\mailmap.c mailmap.c 156
>>      uninitvar(CppCheck) \git-master\merge-recursive.c
>> merge-recursive.c 1887
>>      uninitvar(CppCheck) \git-master\notes.c notes.c 805
>>      uninitvar(CppCheck) \git-master\notes.c notes.c 805
>>      deallocret(CppCheck) \git-master\pretty.c pretty.c 677
>>      resourceLeak(CppCheck) \git-master\refs.c refs.c 3041
>>      doubleFree(CppCheck) \git-master\sequencer.c sequencer.c 924
>>      nullPointer(CppCheck) \git-master\sha1_file.c sha1_file.c 125
>>      doubleFree(CppCheck) \git-master\shell.c shell.c 130
>>
>> --
>
> Philip
