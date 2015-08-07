From: Junio C Hamano <gitster@pobox.com>
Subject: Re: resolving a (possibly remote) branch HEAD to a hash
Date: Fri, 07 Aug 2015 10:24:10 -0700
Message-ID: <xmqq8u9nyptx.fsf@gitster.dls.corp.google.com>
References: <55c47766.dDi8LaxdDqOeptUd%perryh@pluto.rain.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: perryh@pluto.rain.com (Perry Hutchison)
X-From: git-owner@vger.kernel.org Fri Aug 07 19:24:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNlNR-0002Z2-S9
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 19:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbbHGRYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 13:24:13 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:32991 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932419AbbHGRYN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 13:24:13 -0400
Received: by pabyb7 with SMTP id yb7so59919726pab.0
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 10:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=tpuWF0Blq9a2QwQNGZh6BQouqNwTOy3ER7wp3Uq5XNQ=;
        b=gQP6oZF+YT4Cpzqy8v4i6m8EjqpVG2tI7NafKf7oM77nb/Zws+sCyVZww+UKP+eea7
         dqlL2gYdDWXHR84gDj45IJdV/sI7ZQYZTYGjP1DwHpxgo7lGQA2eJJ+87ZmIMbCY7iu5
         3vYsuF9uhr075e4ssrCV47GHgGMqcUM2qarz4GgwolJbQU6nJhZYpzdbDIg+tZTHGVRx
         RjrBf/Fydvjzc2VmURVSdHmLGskg9bt3EIWgnacxjx5XiPaoaJQyDRO2rWdf5iKaeRvp
         naaMe8SWZ88L+5pu71Ct6f87lppko6Jh1EF6kW5n3YJExvTmx/dGh5iHIoZBWkhV+/d0
         TRyg==
X-Received: by 10.66.250.226 with SMTP id zf2mr16858879pac.20.1438968252482;
        Fri, 07 Aug 2015 10:24:12 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6597:23b2:a33a:2b5b])
        by smtp.gmail.com with ESMTPSA id xv1sm10740881pbb.25.2015.08.07.10.24.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Aug 2015 10:24:11 -0700 (PDT)
In-Reply-To: <55c47766.dDi8LaxdDqOeptUd%perryh@pluto.rain.com> (Perry
	Hutchison's message of "Fri, 07 Aug 2015 02:16:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275476>

perryh@pluto.rain.com (Perry Hutchison) writes:

>   $ git rev-parse r5.0.1
>   r5.0.1
>   fatal: ambiguous argument 'r5.0.1': unknown revision or path not in the working tree.
>   Use '--' to separate paths from revisions

This is not because of ambiguity among refs.  The message is telling
you:

    r5.0.1 is not interpretable as a revision, and it is not likely
    to be interpretable as a path.  If you meant to use it as a
    revision, put '--' after it, if you meant to use it as a path,
    put '--' before it.

When we try to see if the user meant "r5.0.1" as a revision or a
path on a command line that does not have "--", we make sure that it
can be interpreted only as a revision but not as a path or the other
way around.  You see the above error when it cannot be a revision
and it does not appear in the _current_ working tree.

The "not likely to be" part comes because this is a heuristic to
catch your typo.  "git log r5.0.1" _could_ be a request to show a
simplified history that ends with the current commit (i.e. HEAD)
that touched the path r5.0.1 that used to exist but was removed in
the history, and it is way too expensive to dig the history at that
point to see if a path r5.0.1 ever existed, so we only check the
current working tree.

Now, admittably, if you say "git rev-parse r5.0.1 --" in this
situation, it is not likely that the corrected command line will
succeed.  After all, the error message was issued because we already
know that r5.0.1 is _not_ a correct way to spell any revision.  So
the message _might_ want to be reworded to make it clear that:

 * 'r5.0.1' is not a valid revision name.  Perhaps you misspelt it?

 * 'r5.0.1' does not exist in the current working tree.  Perhaps you
   misspelt it?

 * With 'r5.0.1', you may be trying to refer to a path that (might)
   existed in the past.  If that is the case, please have "--"
   before it to explicitly tell us that you mean a path, not a
   revision.

> It works if I explicitly specify that I want the remote instance:
>
>   $ git rev-parse origin/r5.0.1
>   bb193a818fc984adbfd631951f3c89c16d5d3476

This is the correct behaviour and the expected usage.  When talking
about r5.0.1 that came from origin, origin/r5.0.1 is the shortest
and still valid way to spell it.

> and the reference is, in fact, not ambiguous:
>
>   $ git for-each-ref --format "%(refname)" | grep '/r5\.0\.1$'
>   refs/remotes/origin/r5.0.1

Because it is not about ambiguity among refs, this observation is
irrelevant ;-).

> Interestingly, master -- the one that works -- _is_ ambiguous:
>
>   $ git for-each-ref --format "%(refname)" | grep '/master$'
>   refs/heads/master
>   refs/remotes/origin/master

The thing is, there is no ambiguity among

    refs/heads/master
    refs/remotes/origin/master
    refs/remotes/another/master

because we do not say "append 'refs/remotes/<anything>/' for various
values of <anything> and see if such a ref exists" when resolving an
abbreviated refname 'master'.

Ambiguity among refs exists if you had these

    refs/heads/master
    refs/tags/master
    refs/remotes/master/HEAD

But that is not what we are seeing in your case.
