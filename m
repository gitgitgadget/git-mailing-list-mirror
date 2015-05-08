From: evgeny <illumsoft.org@gmail.com>
Subject: Re: t0005-signals.sh fails with ksh
Date: Sat, 9 May 2015 02:05:06 +0300
Message-ID: <727591966.20150509020506@gmail.com>
References: <31108626.20150508231514@gmail.com> <xmqq1tiqkdue.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 09 00:58:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqrEC-0001l4-Ga
	for gcvg-git-2@plane.gmane.org; Sat, 09 May 2015 00:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbbEHW6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 18:58:40 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:35109 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090AbbEHW6j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 18:58:39 -0400
Received: by labbd9 with SMTP id bd9so62109215lab.2
        for <git@vger.kernel.org>; Fri, 08 May 2015 15:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:message-id:to:cc:subject:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dBgdz+HuF0Ux2wsGBQANissanMge23ZWaMycmhMNdqg=;
        b=s+op+jOI1WrI4gSSPsBrQQymv9trG3SS7RRvbgTgqS9YKuzelYLmA/DCgZDgSh05nC
         sU5gxCQyHOe725Jg4DFfeFust102ArDs3vvBapBUV/Xi7v3PTwynpq/1zz+8cnQPb1y4
         ff/Q9rCQFCEMSWxqQtHz1UOBK3vDcM2tX8JArrw4PxmLkqK4MmTYAF5Jlpz7TnwlLc7P
         txSmpJjihGS3/yvgcQJORhF2JTaUVNqoAB7sS7wKjqPmMl3Clun2joM42Ux6CV19n2za
         MN0HclgCl1Y+wQXV32biT9b2LHVdYy+Gl7SwEFVUtCvW0JNAIQYngjVS1bXbJyU3vdpA
         pBxw==
X-Received: by 10.112.167.228 with SMTP id zr4mr184297lbb.113.1431125917946;
        Fri, 08 May 2015 15:58:37 -0700 (PDT)
Received: from [10.0.2.15] (ppp78-37-187-150.pppoe.avangarddsl.ru. [78.37.187.150])
        by mx.google.com with ESMTPSA id t1sm1452918lbb.25.2015.05.08.15.58.36
        (version=TLSv1.1 cipher=RC4-SHA bits=128/128);
        Fri, 08 May 2015 15:58:37 -0700 (PDT)
X-Priority: 3 (Normal)
In-Reply-To: <xmqq1tiqkdue.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268684>

Hello Junio,

Friday, May 8, 2015, 11:34:49 PM, you wrote:

> evgeny <illumsoft.org@gmail.com> writes:

>> expecting success: 
>>         OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
>>         test "$OUT" -eq 141
>>
>> t0005-signals.sh[499]: eval: syntax error at line 4: `(' unmatched
>> Memory fault

> Does this work if you did

>         OUT=$( ( (large_git ; echo $? 1>&3) | : ) 3>&2 ) &&

> instead?

Yes. when I add a space between parentheses and change 141 to 269 all tests in 
t0005-signals.sh are passed.

... stripped first lines ...
ok 3 - create blob

expecting success: 
        OUT=$( ( (large_git; echo $? 1>&3) | :) 3>&1 ) &&
        test "$OUT" -eq 269

ok 4 - a constipated git dies with SIGPIPE

expecting success: 
        OUT=$( ( (trap "" PIPE; large_git; echo $? 1>&3) | :) 3>&1 ) &&
        test "$OUT" -eq 269

ok 5 - a constipated git dies with SIGPIPE even if parent ignores it

# passed all 5 test(s)
1..5


>> 'man ksh' reads:
>>   (list)
>>     Execute  list  in  a  separate environment.
>>     Note, that if two adjacent open parentheses are needed for nesting,
>>     a space must be inserted to avoid evaluation as an arithmetic command as
>>     described above.

> Hmm, I cannot see "as described above" in your message, but isn't
> that talking about a common mistake of turning cmd1 in this pipeline

>         x=$(cmd1 | cmd2)

> into a series of two commands, e.g. (cmd1a && cmd1b) and saying

>         x=$((cmd1a && cmd1b) | cmd2)

> which does make "$((" interpreted as the beginning of arithmetic
> expansion?

> And the "OUT=$( ((large..." construct seems to be written in order
> to avoid that exact issue (notice the SP after "$(").

> Puzzled....

It was an excerpt from ksh's man page, and "as described above" refers to 
previous paragraph where "((expression))" expained.

I think the space after "$(" refers to "Arithmetic Substitution" paragraph
and the following two parentheses are about "Note, that if two adjacent open 
parentheses are needed for nesting, a space must be inserted"

              
$ man ksh
... skipped ...

      Arithmetic Substitution.
       An  arithmetic  expression  enclosed  in  double parentheses preceded by a dollar sign ( $(()) ) is replaced by the
       value of the arithmetic expression within the double parentheses.

... skipped ...

       ((expression))
              The expression is evaluated using the rules for arithmetic evaluation described below.  If the value of  the
              arithmetic expression is non-zero, the exit status is 0, otherwise the exit status is 1.

       (list)
              Execute list in a separate environment.  Note, that if two adjacent open parentheses are needed for nesting,
              a space must be inserted to avoid evaluation as an arithmetic command as described above.

... skipped ...


Some info about my system:

$ head -1 /etc/os-release 
PRETTY_NAME="Debian GNU/Linux 7 (wheezy)"

$ ksh --version
  version         sh (AT&T Research) 93u+ 2012-02-29

  It is surprise for me that ksh is so old.
  
$ ls -l $(which ksh)
lrwxrwxrwx 1 root root 29 May  6 22:44 /usr/bin/ksh -> /etc/alternatives/usr.bin.ksh

$ ls -l /etc/alternatives/usr.bin.ksh
lrwxrwxrwx 1 root root 10 May  6 22:44 /etc/alternatives/usr.bin.ksh -> /bin/ksh93

$ ls -l /bin/ksh93
-rwxr-xr-x 1 root root 1446836 Jan  3  2013 /bin/ksh93
  
-- 
Best regards,
 evgeny
 
