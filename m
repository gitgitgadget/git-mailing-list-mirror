From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2 2/2] submodules: always use a relative path from gitdir
 to work tree
Date: Wed, 15 Feb 2012 23:18:39 +0100
Message-ID: <4F3C2F3F.7000203@web.de>
References: <4F32F252.7050105@web.de> <4F32F465.7090401@web.de> <4F338156.9090507@web.de> <7vlio6ec7q.fsf@alter.siamese.dyndns.org> <4F3A9B98.6040908@web.de> <7v4nut6u4s.fsf@alter.siamese.dyndns.org> <7vzkcl5f37.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Antony Male <antony.male@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 15 23:23:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxnGV-0008Vj-9h
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 23:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755920Ab2BOWXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 17:23:50 -0500
Received: from mout.web.de ([212.227.15.3]:55171 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751388Ab2BOWXu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 17:23:50 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Feb 2012 17:23:49 EST
Received: from [192.168.178.48] ([91.3.175.191]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0Mb8h9-1SE4aH2UrD-00Jsan; Wed, 15 Feb 2012 23:18:42
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:10.0.1) Gecko/20120208 Thunderbird/10.0.1
In-Reply-To: <7vzkcl5f37.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:Z14gkpTptd8OHcjExYYDZFbgkTsCRiaA4ESCs3xWx9Z
 8sBXeQkJMCFrkvKxFzFpzMC/MxPWGyP0D41oLwlDk31/Zg8Z7K
 /JJLp5b45+gydOD5X3w5ku47jRdCgMQCHc2fHYka/Ec8yJ6qdT
 gSJVgdWAD+Tpr23i0fFpfTVH53siZSZN3svqlVQXCg3StIYoEh
 oXqr3H0R04fnglLL5bn3w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190863>

Am 14.02.2012 21:34, schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>
>>> After adding a comment, using test instead of [], testing both $a and
>>> $b and assigning each variable on it's own line I get the following
>>> interdiff. Does that make more sense?
>>
>> My earlier request for comment was to say
>>
>> 	# $a is always longer than $b for such and such reasons
>>
>> to explain why testing $b without testing $a was sufficient.
> 
> Heh, after I follow the entire module_clone, $gitdir is defined in earlier
> parts of the function to be "$(rev-parse --git-dir)/modules/$path", so it
> is clear that it is longer than $path.

Unfortunately only by accident. The usage of $path is not correct here,
$name should be used instead (I have a patch in the making to correct that,
but as that hits the same code area as these fixes I'll post that later
together with some tests moving submodules around inside a superproject).
Then the result of "$(rev-parse --git-dir)/modules/$name" can be shorter
than "$path" when a submodule is renamed into a higher directory level.

> Unless "cd $there && pwd" does not
> result in a funny situation (such as $something/modules is a symbolic link
> to another place that is much closer to the root of the filesystem), that
> is.
> 
> And in such a case, the prefix part of $a and $b would be different from
> the very beginning hopefully.

Yes, they should differ somewhere in any sane setup I can imagine.

>> It is obvious (at least to me) that the loop continues as long as $a and
>> $b begin with the same string before their first '/' and removes that
>> common segment from both of them, so I do not think the new comment is
>> absolutely necessary, but it would not hurt to have it, especially it is
>> short enough and to the point.
>>
>> Thanks.
>>
>>> diff --git a/git-submodule.sh b/git-submodule.sh
>>> index 3463d6d..ed76ce2 100755
>>> --- a/git-submodule.sh
>>> +++ b/git-submodule.sh
>>> @@ -172,9 +172,11 @@ module_clone()
>>>
>>>         a=$(cd "$gitdir" && pwd)
>>>         b=$(cd "$path" && pwd)
>>> -       while [ "$b" ] && [ "${a%%/*}" = "${b%%/*}" ]
>>> +       # Remove all common leading directories
>>> +       while test -n "$a" && test -n "$b" && test "${a%%/*}" = "${b%%/*}"
>>>         do
>>> -               a=${a#*/} b=${b#*/};
>>> +               a=${a#*/}
>>> +               b=${b#*/}
>>>         done
>>>         rel=$(echo $a | sed -e 's|[^/]*|..|g')
> 
> Perhaps aseert that $a never becomes empty before this line (or set it
> explicitly to "." when $a is empty), as otherwise
> 
>>>         (clear_local_git_env; cd "$path" && git config core.worktree "$rel/$b")
> 
> this will refer to "/$b" from the root?

I think neither $a nor $b should be empty after that. But thinking deeper
about that while loop I suspect the real problem here is doing "a=${a#*/}"
or "b=${b#*/}" on a string that doesn't contain a slash anymore. We'll
happily remove a leading directory on the other path while the one without
slash will stay untouched, leading to a bogus result which is off by one
directory level.

AFAICS that will only happen when one path is a prefix of the other, which
is a pretty pathological case. So I'll whip up a new version asserting
that beforehand and dropping the -n test in the while loop, ok?
