From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [RFC/GSoC] Proposal: Make git-pull and git-am builtins
Date: Wed, 25 Mar 2015 13:55:22 +0800
Message-ID: <CACRoPnTL78ZrqPYYNPkNcW7vConHZXZ66z5P2=3HySrtmZKcrg@mail.gmail.com>
References: <20150324163730.GA8366@yoshi.chippynet.com>
	<xmqqwq265jjl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 06:55:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaeHq-0005rJ-GZ
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 06:55:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283AbbCYFzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 01:55:25 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:36573 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273AbbCYFzY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 01:55:24 -0400
Received: by lbbug6 with SMTP id ug6so9956778lbb.3
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 22:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6Bm6bgrEZacy/CktjkQM6+LbwxEeGHV0K3gpmEBdzCQ=;
        b=PmfznSAi9ArQcQGR102hhEgdtCdp4pNn5dy8K0fktKHdiWo9A4irkaICJVML1+8T5e
         GfLTTUph4sxqZjTFiJTjL5OHeNQr5hkj7WpVual1JQ1pswIm+ZLT//s3fYP9ZLbLzAVq
         Cq79O4KNjsvo1IgboL6PZwfPQ1KmIj08zD1yNRY6Djy68znxEc9QD4kuBBLZd8YolhT9
         VYGMVhZCgPEEfveShM2Sy37SG0SohnRlKXzaDEKvzpZg90Yy7cKkCKUM6L4ecbZZ20+e
         9MR37h72g86Uw22O2cgVAn5CcZDtWzM9oDWMF1kDbYu2iqcpQ7GmMgtdN/f15gF3lAI9
         Ds0A==
X-Received: by 10.112.218.5 with SMTP id pc5mr7137119lbc.32.1427262922460;
 Tue, 24 Mar 2015 22:55:22 -0700 (PDT)
Received: by 10.112.130.228 with HTTP; Tue, 24 Mar 2015 22:55:22 -0700 (PDT)
In-Reply-To: <xmqqwq265jjl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266262>

Hi,

On Wed, Mar 25, 2015 at 2:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> ..., I propose the following requirements for the rewritten code:
>>
>> 1. No spawning of external git processes. This is to support systems with high
>>    ``fork()`` or process creation overhead, and to reduce redundant IO by
>>    taking advantage of the internal object, index and configuration cache.
>
> I suspect this may probably be too strict in practice.
>
> True, we should never say "run_command_capture()" just to to read
> from "git rev-parse"---we should just call get_sha1() instead.
>
> But for a complex command whose execution itself far outweighs the
> cost of forking, I do not think it is fair to say your project
> failed if you chose to run_command() it.  For example, it may be
> perfectly OK to invoke "git merge" via run_command().

Yes, which is why I proposed writing a baseline using only the
run-command APIs first. Any other optimizations can then be done
selectively after that.

I think it's still good to have the ideal in mind though (and whoops I
forgot to put in the word "ideal" in the text).

>
>> 3. The resulting builtin should not have wildly different behavior or bugs
>>    compared to the shell script.
>
> This on the other hand is way too loose.
>
> The original and the port must behave identically, unless the
> difference is fixing bugs in the original.
>

I was considering that there may be slight behavioral changes when the
rewritten code is modified to take greater advantage of the internal
API, especially since some builtins due to historical issues, may have
duplicated code from the internal API[1].

[1] I'm suspecting that the implementation of --merge-base in
show-branch.c re-implements get_octopus_merge_bases().

>> Potential difficulties
>> =======================
>>
>> Rewriting code may introduce bugs
>> ...
>
> Yes, but that is a reasonable risk you need to manage to gain the
> benefit from this project.
>
>> Of course, the downside of following this too strictly is that if there were
>> any logical bugs in the original code, or if the original code is unclear, the
>> rewritten code would inherit these problems too.
>
> I'd repeat my comment on the 3. above.  Identifying and fixing bugs
> is great, but otherwise don't worry about this too much.
>
> Being bug-to-bug compatible with the original is way better than
> introducing new bugs of an unknown nature.

Well yes, but I was thinking that if there are any glaring errors in
the original source then it would be better to fix these errors during
the rewrite than wasting time writing code that replicates these
errors.

>> Rewritten code may become harder to understand
>> ...
>
> And also it may become harder to modify.
>
> That is the largest problem with any rewrite, and we should spend
> the most effort to avoid it.
>
> A new bugs introduced we can later fix as long as the result is
> understandable and maintainable.
>
>> For the purpose of reducing git's dependencies, the rewritten C code should not
>> depend on other libraries or executables other than what is already available
>> to git builtins.
>
> Perhaps misphrased; see below.

In this case I was thinking of "making git depend on another project".
(e.g, using an external regular expression library). Of course a
balance has to be made in this aspect (thus the use of "should not"),
but git-pull and git-am are relatively simple so there should be no
need for that,

>
>> We can see that the C version requires much more lines compared to the shell
>> pipeline,...
>
> That is something you would solve by introducing reusable code in
> run_command API, isn't it?  That is how various rewrites in the past
> did, and this project should do so too.  You should aim to do this
> project by not just using "what is already available", but adding
> what you discover is a useful reusable pattern into a set of new
> functions in the "already available" API set.

Whoops, forgot to mention that here. (A brief mention was made on this
kind of refactoring in the Development Approach).

Thank you for your review.
