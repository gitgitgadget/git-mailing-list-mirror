From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/3] rebase: avoid non-function use of "return" on FreeBSD
Date: Sat, 12 Apr 2014 19:07:28 +0200
Message-ID: <vpq38hi8oj3.fsf@anie.imag.fr>
References: <438458da797bcab97449bfa931a9d1d@74d39fa044aa309eaea14b9f57fe79c>
	<0779303f7d2257a618b5bed00260a8a@74d39fa044aa309eaea14b9f57fe79c>
	<vpqsipkmeum.fsf@anie.imag.fr>
	<D2BF8546-87B4-431A-B86D-6EFAF205279C@gmail.com>
	<vpq4n1zg4f9.fsf@anie.imag.fr>
	<D3916156-0F84-4DD2-833F-64DF675325D3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 19:10:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ1SB-00082v-Kr
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 19:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628AbaDLRKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 13:10:50 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59111 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752176AbaDLRKt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 13:10:49 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s3CH7R8V002173
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 12 Apr 2014 19:07:27 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3CH7SMx016768;
	Sat, 12 Apr 2014 19:07:28 +0200
In-Reply-To: <D3916156-0F84-4DD2-833F-64DF675325D3@gmail.com> (Kyle J. McKay's
	message of "Fri, 11 Apr 2014 16:08:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 12 Apr 2014 19:07:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3CH7R8V002173
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1397927250.94166@+yv7IlzdcLi9mF2zuHvvUg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246175>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> On Apr 11, 2014, at 10:30, Matthieu Moy wrote:
>> "Kyle J. McKay" <mackyle@gmail.com> writes:
>>
>>> There are already nested functions with file inclusion between both
>>> levels of nesting in git-rebase--interactive.sh and git-rebase--
>>> merge.sh now, so it's not introducing anything new.
>>
>> OK, so it's less serious than I thought. But still, we're
>> introducing a
>> function with 3 levels of nesting, split accross files, in an area
>> where
>> we know that at least one shell is buggy ...
>
> Currently in maint:
>
> The current code in maint does this:
>
> git-rebase.sh: top-level
>   git-rebase.sh: run_specific_rebase()
>     git-rebase.sh: run_specific_rebase_internal() -- contains "dot"
>       git-rebase--interactive.sh: top-level (using --continue or -- 
> skip)
>         git-rebase--interactive.sh: do_rest
>           git-rebase--interactive.sh: do_next

You're confusing function calls and function nesting. do_rest calls
do_next, but the definition of do_next is not nested within do_rest.

When I talk about nested function, I mean

f() {
	g() {
		...
	}
}

Obviously, having functions call each other is not an issue. That's what
functions are meant to be.

Now, having run_specific_rebase_internal include a file which defines
functions which contain nested functions _is_ something I find weird. It
both stresses the shell in a buggy area and makes the code harder to
understand.

> The problem with these changes, particularly the git-rebase-- 
> interactive.sh one is that a bunch of code is still run when the file
> is "dot" included.

Function definitions, and variables assignments. Is it so much of an
issue?

What's the difference between a function definition or variable
assignment within git-rebase--*.sh and within git-rebase.sh?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
