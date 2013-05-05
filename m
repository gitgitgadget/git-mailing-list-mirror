From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 0/7] Make "$remote/$branch" work with unconventional refspecs
Date: Mon, 6 May 2013 00:26:40 +0200
Message-ID: <CALKQrgf6NcT2tEGMTczxR2WspOi4NjrN_kxmKN-QyE2Py3iSaQ@mail.gmail.com>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
	<7vr4hmuk20.fsf@alter.siamese.dyndns.org>
	<CALKQrgdp9DVDBLNwCAmQHbEfZDvhdsmSW3sh1BRo1XEnyqPPaA@mail.gmail.com>
	<7v8v3tuu6i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 06 00:27:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZ7OZ-00079s-KN
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 00:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168Ab3EEW0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 May 2013 18:26:47 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:56850 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977Ab3EEW0q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 May 2013 18:26:46 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UZ7OG-0004Jp-Ct
	for git@vger.kernel.org; Mon, 06 May 2013 00:26:44 +0200
Received: from mail-oa0-f48.google.com ([209.85.219.48])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UZ7OF-000FFa-Oe
	for git@vger.kernel.org; Mon, 06 May 2013 00:26:44 +0200
Received: by mail-oa0-f48.google.com with SMTP id i4so648790oah.21
        for <git@vger.kernel.org>; Sun, 05 May 2013 15:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ShbsmWUJ5+1j+PF3vUgY6LU+FaL8WW8UpdYAOLCyMpw=;
        b=kNArGxtlpE6VPPDLBZSxMIE7Ebt+oEYDhrzacdwfTngDYL0Dq4q03ZuU4csDJV1EKn
         jPb5N7b+ppYnTmac3limsADwkvseGIUUUXuHVmTuSItFOCRJ7OYrmWVCoxilqNNgNtzh
         a3ZU/07V6q81yrbL/lYH93M/pfF53F5SM3Q7k/YDaWd/BFm/zcdZty0sj5Gg4AA6R1es
         U2vzhCKRNAr/cFT90s5xh8hGwbIyLSQBVcbEztLd5/ao26UP+9U5R00xTqHHgT8xifHI
         vFjr72TxlyP2FN6klJ8804vqRwW1vKHSunvCp1yuFgavCCS7fkknZ74eu/jRA7LWd6B+
         Z26w==
X-Received: by 10.182.66.12 with SMTP id b12mr4771600obt.48.1367792800295;
 Sun, 05 May 2013 15:26:40 -0700 (PDT)
Received: by 10.182.129.110 with HTTP; Sun, 5 May 2013 15:26:40 -0700 (PDT)
In-Reply-To: <7v8v3tuu6i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223419>

On Sun, May 5, 2013 at 9:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> So another issue that remains is the following, I think.
>
> When interpreting $nick/$name, assuming that we can tell where $nick
> for a remote ends and $name for the ref we take from the remote
> begins [*1*], how would we determine which refs/remotes/$remote/ is
> used for $nick?

My code currently iterates for_each_remote() until we find a remote whose
name == $nick. After all, the remote name is what the user interacts with
when doing things like "git fetch $remote" and "git push $remote ...".
Hence, I believe that the remote name is the most natural name to use for
the "$nick/$name" shorthand.

> My gut feeling is that we should ignore any "remote.$nick.fetch"
> wildcard mapping, e.g.
>
>     [remote "foo"]
>         fetch = +refs/heads/*:refs/remotes/bar/heads/*
>         fetch = +refs/tags/*:refs/remotes/baz/tags/*
>
> so that we look always in refs/remotes/$nick/ somewhere, for at
> least two reasons:
>
>  * For sane people, "bar" and "baz" in the above example are both
>    "foo", so ignoring remote.foo.fetch mapping is a no-op for them.

Agreed.

>  * For people who deliberately wanted to move "foo"'s refs to
>    different hierarchies depending on the hierarchies at the origin
>    (i.e. branches to "bar", tags to "baz"), they wanted to do so for
>    a reason to group related things in "bar" (and "baz") [*2*].  For
>    them, mapping with remote.$nick.fetch" means not allowing them to
>    use the real name of the group (i.e. "bar") they chose to name
>    their refs.

Actually, this series currently accepts _both_. Observe (using your config
from above):

  Shorthand         -> Expansion                         Matching rule
  --------------------------------------------------------------------
  foo/$branch       -> refs/remotes/bar/heads/$branch    foo's refspec
  foo/$tag          -> refs/remotes/baz/tags/$branch     foo's refspec
  bar/heads/$branch -> refs/remotes/bar/heads/$branch    refs/remotes/%.*s
  baz/tags/$tag     -> refs/remotes/baz/tags/$tag        refs/remotes/%.*s

(If you want to lose the "heads/" from the "bar/heads/$branch" shorthand
 (or lose "tags/" from "baz/tags/$tag"), use this config instead:

    [remote "foo"]
        fetch = +refs/heads/*:refs/remotes/bar/*
        fetch = +refs/tags/*:refs/remotes/baz/tags/*
)

Now, IINM you seem to mean that we shouldn't look at refspecs (or the
config file) at all, but should instead require that $nick matches a
subdirectory of "refs/remotes", and then allow for some flexibility as
to what comes between "refs/remotes/$nick" and "$name" (for example, one
of "/", "/heads/", and "/tags/").

This would not allow the user to use the relevant $remote_name for $nick,
which I argue might be the more natural name for the user to use, since
it's the same name that is used for otherwise interacting with the remote.

>>> If the final end result you are shooting for is to introduce an
>>> extra level between the remote name and the branch names, i.e.
>>> "heads/", any solution needs to at least have a plan (not necessarily
>>> a detailed design or implementation) for the other hierarchies.  The
>>> possibility to have these other hierarchies per remote is the true
>>> progress that the "heads/" at that level can give us; there is not
>>> much point to have heads/ after refs/remotes/origin/, if heads/ is
>>> the only thing that can come there.
>>
>> I fully agree. This series was meant as the first step in that direction
>> (sorry for not describing my intentions more clearly).
>
> And I do not think we mind terribly if we extend the ref_rev_parse_rules[]
> used in dwim_ref() to also look at these
>
>         refs/remotes/$nick/$name
>         refs/remotes/$nick/tags/$name
>         refs/remotes/$nick/heads/$name
>
> (the first of the above is existing "refs/remotes/%.*s").

This is not what I have in mind with this series (although the behavior
will be identical for the refspecs suggested in the remote ref namespace
discussion). Rather I would have the following three rules:

        refs/remotes/%.*s
            (which is - as you say - identical to your first rule)
        RHS from remote $nick's refspec matching LHS = refs/tags/$name
        RHS from remote $nick's refspec matching LHS = refs/heads/$name

and indeed, my series implements the last of these (in addition to
retaining the first). The middle one (for tags) would be added by a future
patch series.

The whole point of mapping through the refspecs, is that we DON'T hardcode
any preference as to where remote-tracking branches (or tags, or whatever)
should be located. It's _purely_ up to how the user has configured her
refspecs, and any expansion for remote-tracking refs should obey those
refspecs.

> I think it is going too far if you extend it further to
>
>         refs/remotes/$nick/*/$name
>
> where the code does not control what an acceptable match for '*' is
> (i.e. origin/foo matching origin/changes/foo might be OK, but
> matching it with origin/randomstring/foo is not, unless the canned
> ref_rev_parse_rules[] knows about the "randomstring", or there is a
> configuration mechanism for the user to tell us she cares about the
> "randomstring" hierarchy in her project).

Fully agreed, although this is somewhat irrelevant to my objective.
I don't want a list of "blessed" strings that will be automatically
traversed upon expansion at all (much less a configuration mechanism
to customize it). I want the _refspec_ to be the king of deciding where
remote-tracking branches and tags are

Let me try to summarize my views on how refnames should work in Git, to
see if we can identify where we differ on the principles (or if we, in
fact, differ at all):

0. refnames must obviously follow the check-ref-format syntactic rules.

1. refs should generally be placed within the refs/ hierarchy. Anything
   outside refs/ is only for Git's own special use (e.g. HEAD, FETCH_HEAD,
   etc.).

2. refs may in general be placed anywhere within refs/, but there are some
   places that are interpreted specially by Git:
     - refs/heads/* hold local branches
     - refs/tags/* hold local tags
     - refs/replace/* hold local replace refs
     - refs/notes/* hold local notes
     - (there may be more here, for other ref types, e.g. refs/original/)

3. refs that originate from a remote repository (a.k.a. remote-tracking
   refs) are typically placed within refs/remotes/*, however there are NO
   _hardcoded_ rules dictating how remote-tracking refs are to be
   organized.

4. The organization of remote-tracking refs is determined by the
   configured (fetch) refspecs, which map remote refs to their remote-
   tracking counterparts (typically - but not necessarily - located
   within refs/remotes/*).

5. Ideally, all refs within refs/remotes/* should correspond to exactly
   one refspec (i.e. be matched by the RHS side of that refspec) in one
   remote, although this is not a requirement.

6. The user should be able to use shorthand notation for local refs when
   doing so is natural and unambiguous in the current context. For example
   in a branch context, "$name" should automatically be expanded into
   "refs/heads/$name", if doing so is unambiguous. Likewise for tags,
   notes and other contexts corresponding to the local ref types mentioned
   in #2.

7. When there is no context limiting us to a specific ref type, we should
   still allow the shorthands from #6, as long as they are unambiguous.

8. For remote-tracking refs, there is no _hardcoded_ structure along which
   we can expand shorthand notations. However, since the structure is
   defined by the configured (fetch) refspecs, we can use those same
   refspecs to expand the "$nick/$name" shorthand notation into the
   remote-tracking ref from remote "$nick" that (unambiguously) matches
   "$name". (When matching "$name" against $nick's refspecs, we should use
   the same expansions as in #6 to expand "$name" into something matching
   the LHS of a refspec (e.g. "refs/heads/$name", "refs/tags/$name"), and
   then use the corresponding RHS as the resulting expansion.)

9. In addition to the refspec-sensitive expansion of shorthand notations
   described in #8, we probably also want to allow a blanket expansion of
   "$anything" into "refs/remotes/$anything", since that seems generally
   useful.

Some notes:

- Both the current default refspecs, and the refspecs suggested in the
  remote ref namespace discussion follow the above principles. Also, your
  non-integration single topic hierarchy mentioned below should work with
  these principles.

- My rationale for #3 is that hardcoding a structure within refs/remotes/*
  will likely resist future inventions for how to deal with remote refs,
  and the likely result will be to create ad hoc solutions outside the
  refs/remotes/* hierarchy, like we have already seen with e.g.
  "refs/remote-notes/*". By leaving the organizing of refs/remotes/* up to
  the refspecs (#4), we are infinitely more customizable and future-proof
  when it comes to new ways of organizing remote refs.

> [Footnotes]
>
> *1* I offhand do not remember if we even allow multi-level remote
>     nicks, but I do know we support multi-level branch names, so it
>     may turn out that the only valid split of origin/jh/rbranch is
>     topic 'jh/rbranch' from remote 'origin' and not topic 'rbranch'
>     from remote 'origin/jh'.

We do currently allow this. Observe:

$ git init clobbering_remotes
Initialized empty Git repository in ./clobbering_remotes/.git/
$ cd clobbering_remotes/
$ echo foo > foo
$ git add foo
$ git commit -m foo
[master (root-commit) 5b5db04] foo
 1 file changed, 1 insertion(+)
 create mode 100644 foo
$ git checkout -b bar/master
Switched to a new branch 'bar/master'
$ echo bar > foo
$ git commit -am bar
[bar/master 03f1d10] bar
 1 file changed, 1 insertion(+), 1 deletion(-)
$ git remote add foo .
$ git fetch foo
From .
 * [new branch]      bar/master -> foo/bar/master
 * [new branch]      master     -> foo/master
$ git rev-parse refs/remotes/foo/bar/master
03f1d10c1456aec8b42e2432cb7726e92d0dc17a
$ git remote add foo/bar .
$ git fetch foo/bar
From .
 * [new branch]      bar/master -> foo/bar/bar/master
 + 03f1d10...5b5db04 master     -> foo/bar/master  (forced update)
$ git rev-parse refs/remotes/foo/bar/master
5b5db042e0af6f10bef7a3c82ce53e5c0ac9ab8a

I would support disallowing multi-level remote names, although I don't
know if it is commonly used, and would break many existing users.

> *2* Perhaps "bar" in the above is spelled "topics", and the
>     hierarchy may be used to collect non-integration single topic
>     branches from more than one remote.  An example that is more in
>     line with such a usage might be:
>
>     [remote "jh"]
>         fetch = +refs/heads/*:refs/remotes/topics/heads/jh/*
>     [remote "jk"]
>         fetch = +refs/heads/*:refs/remotes/topics/heads/jk/*
>     [remote "fc"]
>         fetch = +refs/heads/*:refs/remotes/topics/heads/fc/*
>
>     and I would expect "git merge topics/jh/rbranch" to merge the
>     "refs/remotes/topics/heads/jh/rbranch" topic branch.

I like the use case, but not necessarily your expectation. ;-)

With the above configuration, and my series as-is, you could simply do
"git merge jh/rbranch" to merge the "refs/remotes/topics/heads/jh/rbranch"
topic branch. Furthermore, I don't see why you want/need the extra
"heads/" level in the refspec. If you do this instead:

    [remote "jh"]
        fetch = +refs/heads/*:refs/remotes/topics/jh/*
    [remote "jk"]
        fetch = +refs/heads/*:refs/remotes/topics/jk/*
    [remote "fc"]
        fetch = +refs/heads/*:refs/remotes/topics/fc/*

your "git merge topics/jh/rbranch" should work with current Git. With my
patch series on top, it would also be equivalent to "git merge jh/rbranch".


...Johan

--
Johan Herland, <johan@herland.net>
www.herland.net
