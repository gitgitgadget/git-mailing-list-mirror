From: Aleksey Mokhovikov <moxobukob@gmail.com>
Subject: Re: [PATCH][GSOC] Selection of the verbose message is replaced with
 generated message in install_branch_config()
Date: Thu, 20 Mar 2014 18:56:38 +0700
Message-ID: <lgekju$u6t$1@ger.gmane.org>
References: <1395050104-19152-1-git-send-email-moxobukob@gmail.com>	<loom.20140318T124348-742@post.gmane.org>	<lg9l22$qto$1@ger.gmane.org> <CAPig+cQLACyFwVypi08ZGQ14mpc0zt0fRRNhPzswRjsTaFQz2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 12:49:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQbTu-0002wQ-9n
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 12:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757027AbaCTLts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 07:49:48 -0400
Received: from plane.gmane.org ([80.91.229.3]:33107 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755353AbaCTLtr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 07:49:47 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WQbTl-0002hB-Cg
	for git@vger.kernel.org; Thu, 20 Mar 2014 12:49:45 +0100
Received: from l37-193-248-93.novotelecom.ru ([37.193.248.93])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 12:49:45 +0100
Received: from moxobukob by l37-193-248-93.novotelecom.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 12:49:45 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: l37-193-248-93.novotelecom.ru
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <CAPig+cQLACyFwVypi08ZGQ14mpc0zt0fRRNhPzswRjsTaFQz2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244542>

On 03/19/2014 04:21 PM, Eric Sunshine wrote:
> Thanks for the resubmission. Comments below...
> 
> On Tue, Mar 18, 2014 at 10:33 AM, Aleksey Mokhovikov
> <moxobukob@gmail.com> wrote:
>> Subject: [PATCH][GSOC] Selection of the verbose message is replaced with generated message in install_branch_config()
> 
> Say [PATCH v2] to indicate your second attempt.
> 
> This subject is quite long. Try to keep it short but informative.
> Mention the module or function first. Use imperative voice. You might
> say:
> 
>     Subject: install_branch_config: replace if-chain with table lookup

Thanks. This is my first experience with such newsgroups. I don't know explicitly how this mail-nntp newsgroups work
under the hood, so I was afraid, that if I'll change the subject, gmane will create a new thread instead of placing a
comment.

>> Compare with original construction
>> Pros:
>> 1) Remove if chain.
>> 2) Single table contains all messages with arguments in one construction.
>> 3) Less code duplication.
>> Cons:
>> 1) Harder to associate the case with message.
>> 2) Harder for compiler to warn the programmer about not
>>    enough arguments for format string.
>> 3) Harder to add non-string argument to messages.
> 
> Nice summary. Do you draw any conclusions from it? Is the new code
> better? Easier to understand? Would it be better merely to refactor
> the 'if' statements a bit instead of using a table?

I think if that code is heavily developed at this time, then if chain is better,
because if construction is more simple and looks more flexible to major changes.
And if there is no plans to make huge but minor changes,
then table driven approach looks better for me. So I would wrote the if chain at
first, and later, If I had to change verbose message or something similar,
I could rewrite it.


>> If !!(x) is out of the coding guide, then message_id construction
>> can be rewritten in several other ways.
>> The guideline tells that !!(x) is not welcome and should not be
>> unless needed. But looks like this is normal place for it.
> 
> Curious. !!x is indeed used regularly. Where did you read that it is
> not welcome?

In git/Documentation/CodingGuidelines:
>   170   - Some clever tricks, like using the !! operator with arithmetic
>   171     constructs, can be extremely confusing to others.  Avoid them,
>   172     unless there is a compelling reason to use them.



> Unnecessary blank line insertion. This adds noise to the patch which
> distracts from the real changes.

>>  void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
>>  {
>>         const char *shortname = remote + 11;
>>         int remote_is_branch = starts_with(remote, "refs/heads/");
>>         struct strbuf key = STRBUF_INIT;
>>         int rebasing = should_setup_rebase(origin);
>> +       int message_id = (!!remote_is_branch << 2) | (!!origin << 1) | (!!rebasing);
> 
> It works, but it's also a fairly magical incantation, placing greater
> cognitive demands on the reader. You could achieve a similar result
> with a multi-dimensional table which is indexed directly by
> !!remote_is_branch, !!origin, and !!rebasing. (Whether you actually
> want to do so is a different question.)

I thought about a multidimensional table and about this approach before submitting a patch
and it looks easier for me to read without multidimensional table. But I mentioned that indexing can be rewritten
several ways. It will be even easier if the named function or macro is used:

#define BOOL_TO_BITFLAG(x, shift) (!!(x) << (shift))
...
int message_id = BOOL_TO_BITFLAG(remote_is_branch, 2) | BOOL_TO_BITFLAG(origin, 1) | BOOL_TO_BITFLAG(rebasing, 0);


>> +       const char *message_table[][4] =
>> +               {{N_("Branch %s set up to track local ref %s."),
>> +                 local, remote},
>> +                {N_("Branch %s set up to track local ref %s by rebasing."),
>> +                 local, remote},
>> +                {N_("Branch %s set up to track remote ref %s."),
>> +                 local, remote},
>> +                {N_("Branch %s set up to track remote ref %s by rebasing."),
>> +                 local, remote},
>> +                {N_("Branch %s set up to track local branch %s."),
>> +                 local, shortname},
>> +                {N_("Branch %s set up to track local branch %s by rebasing."),
>> +                 local, shortname},
>> +                {N_("Branch %s set up to track remote branch %s from %s."),
>> +                 local, shortname, origin},
>> +                {N_("Branch %s set up to track remote branch %s from %s by rebasing."),
>> +                 local, shortname, origin}};
> 
> Indeed, this is a reasonably decent way to keep the arguments and
> messages together and can simplify the code nicely. Unfortunately,
> this project is still restricted primarily to C89, so using
> non-constant C99 initializers is likely to prevent the patch from
> being accepted.

Strange. This is not a static variable. N_(x) is expanded to x - is just a marker for xgetext.
array dimensions are known on compile time. Thought here will be no problems with standard.

>> +                       message = message_table[message_id];
>>                 else
>> -                       die("BUG: impossible combination of %d and %p",
>> -                           remote_is_branch, origin);
>> +                       die("BUG: id is out of range:id=%d (is_branch=%d, origin=%p, rebasing=%d)",
>> +                           message_id, remote_is_branch, origin, rebasing);
> 
> As this is indicates a programmer error, assert() may be more
> appropriate, and placed as near the computation of message_id as
> possible. The original code used die() because it didn't detect the
> error until the end of the if-chain, but you can detect it as soon as
> you compute message_id.

Thanks. At first I wrote assert, but decided to leave die because if was there before.


>> +               if (!message || !message[0])
>> +                       die("BUG: message is NULL. Fix verbose message table.");
> 
> Meh. May be overkill. If either of these is NULL, you'll get a crash
> anyhow, which is a good indication of a bug.

If either of them is NULL it can be UB. And if message[0] is NULL, it's quite likely. that
printf will just skip it, so I think it's better to assert message[0].
