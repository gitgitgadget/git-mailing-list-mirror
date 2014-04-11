From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH 1/3] rebase: avoid non-function use of "return" on FreeBSD
Date: Fri, 11 Apr 2014 16:08:53 -0700
Message-ID: <D3916156-0F84-4DD2-833F-64DF675325D3@gmail.com>
References: <438458da797bcab97449bfa931a9d1d@74d39fa044aa309eaea14b9f57fe79c> <0779303f7d2257a618b5bed00260a8a@74d39fa044aa309eaea14b9f57fe79c> <vpqsipkmeum.fsf@anie.imag.fr> <D2BF8546-87B4-431A-B86D-6EFAF205279C@gmail.com> <vpq4n1zg4f9.fsf@anie.imag.fr>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Apr 12 01:09:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYkZr-0002yQ-RZ
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 01:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754930AbaDKXI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 19:08:57 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55692 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143AbaDKXI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 19:08:56 -0400
Received: by mail-pa0-f46.google.com with SMTP id kx10so5998739pab.33
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 16:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=TRgStzFO7705zwlt6GYG+XksCB63gaCPPIeC3V+asD8=;
        b=znvxlhQ2aLB3hov0QS3w5/CyciXIdrd6xcTFeguwtzXZgPmL3NWuG5U/rL3XAps3Tw
         +WC56mkk4bgAU95Xp0vF3E2qtMOChUpt15rw4orNhx9XtWBsROTO6sapY5Srhy9U+Qax
         w4ysewfI4fgfJ3ojULsI0ieWJYpxpHrDINYRV4JpZWV3jY60uLUvfMQHg+AyZklrE3Bm
         i6craKOxiYrTUyrTPNg7rRyoiaMRL6TIIabKKaHTq0aX2flN7o0rX1qUqwl+P22pCiY8
         kHHGAjmjSSNh9q2VcJXcQgDHemTe6p2YwFcPkvm6a5GA4Uj74B5v05Mp150YQT+bdKXh
         eXqA==
X-Received: by 10.68.163.3 with SMTP id ye3mr30614653pbb.78.1397257736055;
        Fri, 11 Apr 2014 16:08:56 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id yv5sm17991408pbb.49.2014.04.11.16.08.54
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 11 Apr 2014 16:08:55 -0700 (PDT)
In-Reply-To: <vpq4n1zg4f9.fsf@anie.imag.fr>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246155>

On Apr 11, 2014, at 10:30, Matthieu Moy wrote:
> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>> There are already nested functions with file inclusion between both
>> levels of nesting in git-rebase--interactive.sh and git-rebase--
>> merge.sh now, so it's not introducing anything new.
>
> OK, so it's less serious than I thought. But still, we're  
> introducing a
> function with 3 levels of nesting, split accross files, in an area  
> where
> we know that at least one shell is buggy ...

Currently in maint:

The current code in maint does this:

git-rebase.sh: top-level
   git-rebase.sh: run_specific_rebase()
     git-rebase.sh: run_specific_rebase_internal() -- contains "dot"
       git-rebase--interactive.sh: top-level (using --continue or -- 
skip)
         git-rebase--interactive.sh: do_rest
           git-rebase--interactive.sh: do_next
             git-rebase--interactive.sh: record_in_rewritten
               git-rebase--interactive.sh: flush_rewritten_pending

So I really do not see the additional level of nesting as an issue  
since we've already got much more than 3 levels of nesting going on  
now.  If nesting was going to be a problem, something would have  
broken already.  In fact, since the follow on patch removes the  
run_specific_rebase_internal function what we would have after the  
originally proposed first two patches is:

git-rebase.sh: top-level
   git-rebase.sh: run_specific_rebase() -- contains "dot"
     git-rebase--interactive.sh: top-level (using --continue or --skip)
       git-rebase--interactive.sh: git_rebase__interactive
         git-rebase--interactive.sh: do_rest
           git-rebase--interactive.sh: do_next
             git-rebase--interactive.sh: record_in_rewritten
               git-rebase--interactive.sh: flush_rewritten_pending

Which has exactly the same nesting depth albeit the "dot" has moved up  
one level.

>>> IOW, why not move the whole run_specific_rebase_internal function to
>>> git-rebase--$type?
>>
>> So what change are you proposing exactly?
>
> Something along the lines of this:

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 6046778..5dfbf14 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -820,6 +820,7 @@ add_exec_commands () {
> 	mv "$1.new" "$1"
> }
>
> +run_specific_rebase_infile() {
> case "$action" in
> continue)
> 	# do we have anything to commit?
> @@ -1055,3 +1056,4 @@ GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION:  
> checkout $onto_name"
> output git checkout $onto || die_abort "could not detach HEAD"
> git update-ref ORIG_HEAD $orig_head
> do_rest
> +}
> diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
> index d84f412..907aa46 100644
> --- a/git-rebase--merge.sh
> +++ b/git-rebase--merge.sh
> @@ -99,6 +99,7 @@ finish_rb_merge () {
> 	say All done.
> }
>
> +run_specific_rebase_infile () {
> case "$action" in
> continue)
> 	read_state
> @@ -149,3 +150,4 @@ do
> done
>
> finish_rb_merge
> +}


The problem with these changes, particularly the git-rebase-- 
interactive.sh one is that a bunch of code is still run when the file  
is "dot" included.  With the changes to git-rebase.sh, that code will  
now run regardless of the action and it will run before it would have  
now.  So if any of the variables it sets affect the functions like  
read_basic_state or finish_rebase (they don't currently appear to),  
then there's a potential for new bugs.  That initial code would not  
previously have run in the --abort case at all.

But, you say the tests pass with those changes, so the changes are  
probably okay.  However, they create a potential situation where some  
code is added to the top of one of the git-rebase--$type.sh scripts  
and suddenly git rebase --abort stops working right because that code  
is being run when it shouldn't or the operation of read_basic_state  
and/or finish_rebase is adversely affected.  Hopefully the rebase  
tests would catch any such issue right away though.

So, in light of the fact that function nesting seems to be a non-issue  
here, and it seems to me the originally proposed changes have much  
less potential to introduce breakage either now or in the future, I  
still prefer them.

--Kyle
