From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH 1/3] rebase: avoid non-function use of "return" on FreeBSD
Date: Fri, 11 Apr 2014 07:29:15 -0700
Message-ID: <D2BF8546-87B4-431A-B86D-6EFAF205279C@gmail.com>
References: <438458da797bcab97449bfa931a9d1d@74d39fa044aa309eaea14b9f57fe79c> <0779303f7d2257a618b5bed00260a8a@74d39fa044aa309eaea14b9f57fe79c> <vpqsipkmeum.fsf@anie.imag.fr>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Apr 11 16:29:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYcSJ-0002mn-Af
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 16:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757656AbaDKO3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 10:29:19 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:51940 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754223AbaDKO3S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 10:29:18 -0400
Received: by mail-pa0-f47.google.com with SMTP id lj1so5421540pab.6
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 07:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=Rsz9ZHnQ0UL4RrPZYLvoSVKBtpethGuenQW152FftOs=;
        b=FA+besrfKPFRJ5nRt2TSIu3Iad1acnqZQj8IjQshkLdVAYOEl+ZAL7kMxfgKjmBaMq
         P2hwYCMYjKHlhdG3UvZ22uTIqoMKHiW1bgrcEnEGqN0B8cMEud1VFe5t9MOteJMArvzd
         HHBJCdbB7ADO8gpUc6fmWQUvuY+f1TW84Bxnvb4Hh49oWb4ekXCL7N4ZsGD6V0hsKhda
         W2IXLalFi8TTh2UOfnhwvIR5kZCvC9aRBlzv9P3ezXyAXd+6/Q406tyR6XUjxzlDz98d
         CbovHl/r6oKc7Lmx3K0SHIpaE/+H04OgATJVEwqMhDprnuY+bLbkugACOysPgKOXhZMK
         yE7g==
X-Received: by 10.68.161.101 with SMTP id xr5mr10566569pbb.168.1397226557732;
        Fri, 11 Apr 2014 07:29:17 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id y4sm16022861pbk.76.2014.04.11.07.29.16
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 11 Apr 2014 07:29:17 -0700 (PDT)
In-Reply-To: <vpqsipkmeum.fsf@anie.imag.fr>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246095>

On Apr 11, 2014, at 01:48, Matthieu Moy wrote:
> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>> If script2.sh is changed to this:
>>
>> # script2.sh fixed
>> main() {
>>        if [ 5 -gt 3 ]; then
>>                return 5
>>        fi
>>        case bad in *)
>>                echo always shows
>>        esac
>>        echo should not get here
>>        ! :
>> }
>> main
>
> Wouldn't it be better to just stop using . within function?
>
> The .-ed script could define the complete function, and then the
> function would be used from the toplevel script.
>
> If I understand correctly, your version uses nested functions with  
> file
> inclusion between both levels of nesting. That might work for the  
> shells
> you tested, but if the goal is to avoid using tricky features that may
> trigger bugs on some shells, that seems backward.

There are already nested functions with file inclusion between both  
levels of nesting in git-rebase--interactive.sh and git-rebase-- 
merge.sh now, so it's not introducing anything new.

> IOW, why not move the whole run_specific_rebase_internal function to
> git-rebase--$type?

So what change are you proposing exactly?

The current code in maint does this:

git-rebase.sh: top-level
   git-rebase.sh: run_specific_rebase()
     git-rebase.sh: run_specific_rebase_internal() -- contains "dot"
       git-rebase--$type.sh: top-level -- has "return"

To make the kind of change I think you're proposing would be somewhat  
more invasive than the proposed patch.  Each of the git-rebase--$type  
scripts would have to be modified not to do anything other than define  
functions when included which would require some code movement to  
avoid having two "main" functions -- either that or there need to be  
multiple "dot" includes in git-rebase.sh so the code not in a function  
only executes when the selected case that uses it is active -- or the  
entire contents of each git-rebase--$type script gets indented and  
becomes a function definition, but that would introduce functions  
defining functions which seems like it would add use of a new tricky  
feature not previously used.

I'm not saying it's a bad idea, it's just somewhat more invasive than  
simply inserting 3 lines.

--Kyle
