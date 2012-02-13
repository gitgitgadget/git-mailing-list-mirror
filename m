From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC/PATCH] tag: make list exclude !<pattern>
Date: Mon, 13 Feb 2012 15:34:04 +0100
Message-ID: <4F391F5C.1000400@alum.mit.edu>
References: <20120210185516.GA4903@tgrennan-laptop> <1328926618-17167-1-git-send-email-tmgrennan@gmail.com> <7vaa4qnk4u.fsf@alter.siamese.dyndns.org> <4F361DD4.9020108@alum.mit.edu> <7vlio9n5ym.fsf@alter.siamese.dyndns.org> <4F389FB1.2070706@alum.mit.edu> <7vsjifgrwl.fsf@alter.siamese.dyndns.org> <4F38D9D4.5000203@alum.mit.edu> <7v4nuvghfk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Tom Grennan <tmgrennan@gmail.com>, pclouds@gmail.com,
	git@vger.kernel.org, krh@redhat.com, jasampler@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 15:34:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rwwyv-000233-TG
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 15:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756713Ab2BMOeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 09:34:13 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:44082 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756711Ab2BMOeN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 09:34:13 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q1DEY5NZ012988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 13 Feb 2012 15:34:07 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.26) Gecko/20120131 Lightning/1.0b2 Thunderbird/3.1.18
In-Reply-To: <7v4nuvghfk.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190629>

On 02/13/2012 11:23 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> On 02/13/2012 07:37 AM, Junio C Hamano wrote:
>>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>>
>>>> Of *course* they operate on different namespaces.  But part of the way
>>>> that revisions are selected using rev-list is by *selecting or excluding
>>>> refnames* from which it should crawl.
>>>
>>> I am appalled if that is truly the understanding of yours, after having
>>> taken more than a few patches from you to fairly core parts of Git.
>>>
>>> "rev-list A ^B" does not say "include A and exclude B from which rev-list
>>> should crawl" AT ALL.  We _actively_ crawl from both A and B.  It is that
>>> what are reachable from B is painted in a color different from the color
>>> in which we paint what are reachable from A.
>>
>> Please read my emails more carefully before insulting me.
>> ...
>> o---o---o---*  A
>>      \   \
>>       \   o---o  C
>>        \
>>         *---*  B
>>
>> ... vs ...
>>
>> *---*---*---*  A
>>      \   \
>>       \   o---o  C
>>        \
>>         *---*  B
>>
>> I argue that this is a useful selection.
> 
> Then why were you so against the addition of "negation" to for-each-ref?

I'm not against it.  I just think it should be spelled differently.

> If you want "I want histories reaching A and B", just say "rev-list A B",
> without adding useless "er, I do not want histories reaching C in the
> output, but I do not want commits reachable from C to be excluded from the
> output either" by mentioning C. Learn to shut your mouth and not talk
> about irrelevant "C" in such a case, and you will do just fine.

That's fine if we're talking about single references.  But it does not
generalize to patterns, like my example

    gitk --with-branch='refs/heads/*' \
         --with-branch='remotes/gitster/*' \
         --without-branch='remotes/gitster/*/**' \
         --with-branch='remotes/gitster/mh/*'

If these options were supported, I could store this set of arguments as
a "view" in gitk and have it load automatically.  It would continue to
work even as you add and delete branches from your repository.  Listing
the branches explicitly would be fragile.  Currently I would have to
write a script wrapper around gitk that invokes multiple git commands
and filters the results using grep or something.  (At least I don't know
a better way.)  Even if for-each-ref were taught to exclude branches, I
don't believe it is possible to use arbitrary shell commands to build a
gitk view.

> Especially, re-read your first message where you said that between
> 
>     git rev-list A B ^C
> 
> and
> 
>     git rev-list $(git for-each-ref A B ^C)
> 
> "consistency suggests should do the same".

I should have connected the dots better: consistency suggests they
should do the same, but they obviously cannot.  Moreover, it would be
nice if the two types of exclusion could be combined in single commands,
in which case consistency is mandatory.  Therefore, let's spell the
for-each-ref option another way that *can* be made consistent across
commands.

> Having said all that, if your argument against using "^" as negation for
> for-each-ref *were* with something like this from the beginning:
> 
>     git rev-list --all --exclude-refs=refs/tags/v\*
> 
> it would have been very different. I would wholeheartedly buy the
> consistency argument that says
> 
>     git for-each-ref --exclude-refs=refs/tags/v\*
> 
> ought to give all refs (only because for-each-ref "all" is implied) except
> for the tagged tips, and
> 
>     git log --all --exclude-refs=refs/tags/v\*
> 
> should be the notation to produce consistently the same result as
> 
>     git log $(git for-each-ref --format='%(objectname)' --exclude-refs=refs/tags/v\*)
> 
> but if we used "^" as negated match in for-each-ref argument, we would
> close the door to give such consistency to log family of commands later.

That *has* been exactly my argument from the beginning [1].  I
cautiously hope that we are now talking about the same thing, even if it
is not yet clear whether we agree on a conclusion.

I think this would be an interesting project, but I won't have time to
work on it in the near future.  My first priority is to get the
hierarchical-refs patches rebased on top of the removal of extra refs
and do some more rationalization in that area.

Michael

[1] I don't see where anything I've written is inconsistent with your
phrasing of the argument.  But fine, let's just be happy that the
miscommunication now seems to be cleared up.

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
