From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH 1/2] rm: don't fail when removing populated submodules
Date: Sun, 08 Jul 2012 17:08:17 +0200
Message-ID: <4FF9A261.3040907@web.de>
References: <4FF4AAE7.40604@web.de> <4FF4AB1B.60805@web.de> <7v1ukppear.fsf@alter.siamese.dyndns.org> <4FF830D6.7080708@web.de> <7vsjd2n1wt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 17:09:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Snt6y-0005t4-2T
	for gcvg-git-2@plane.gmane.org; Sun, 08 Jul 2012 17:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133Ab2GHPIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jul 2012 11:08:39 -0400
Received: from mout.web.de ([212.227.17.12]:61738 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752010Ab2GHPIi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2012 11:08:38 -0400
Received: from [192.168.178.48] ([91.3.160.91]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0LnSGg-1S9dCV17AU-00hlk2; Sun, 08 Jul 2012 17:08:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <7vsjd2n1wt.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:Ih47M+AhSDkxwSfoJHzbch96QfUDrcp54zd5vzdj99p
 m5xTtJ+sAHA7+8+UyqRm3Kr8kEUbbp7TYDcsNZRhpQxPyyfXvi
 lA1tipYO6SOq7FPRObBBBFJUfPMd50sjMD/UMvezcFrfVWdyXs
 u+cLol7n2l/Rae/H0btKkyG/ZvcE84wQBbUZiRUWfz1lh7t58u
 b2nBzUuvEuQ4BfVqDl1aA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201181>

Am 08.07.2012 09:32, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>>> One possible sane behaviour of "git rm $path" might be:
>>>
>>>  - If --force is given, remove it from the index and from the
>>>    working tree (i.e. "rm -rf $path"), but use the "gitfile"
>>>    facility to save $path/.git away to $GIT_DIR/modules/$name; error
>>>    out if the submodule directory $path cannot be removed like this.
>>>    We would probably want to remove "submodule.<name>.*" entries in
>>>    .gitmodules for <name> for which "submodule.<name>.path" matches
>>>    the $path.
>>>
>>>  - If --cached is given, remove it from the index if the version in
>>>    the index match either HEAD or the $path/.git/HEAD, without
>>>    touching the working tree.  This is consistent with what happens
>>>    to a regular file.
>>>
>>>  - If neither --force nor --cached is given, run an equivalent of
>>>    (cd $path && git status), and also check if $path/.git/HEAD
>>>    matches the index version.  Error out if the submodule directory
>>>    is dirty (again I am not sure about this part).  If the submodule
>>>    directory is clean, do the same as the case with --force.
>>
>> What you describe here is exactly how I think "git submodule rm" and
>> "git rm --recurse-submodules" should behave.
> 
> If you have a directory A with a file B in it (i.e. A/B), "git rm A"
> is refused and you have to say "git rm -r A".  So I can see why the
> above description of the mine is wrong with respect to "-r" option
> (all cases should fail if you did not give "-r" option).

I think that depends on how you see submodules in the context of
the superproject. If you see the submodule entry as an abstraction
describing the whole work tree below it with a single SHA1, "-r"
isn't necessary (but won't harm either). Only if you think that the
individual files of a submodule make sense in the superproject's
context, you'd need "-r". I think we always use the first approach:
you either get all files which are in a submodule's work tree, or
none. So I don't think we should require "-r" here, as a submodule
is a single object of the superproject. And for the same reason
"git rm A/B" issues an error: the file A/B doesn't exist in the
superproject.

> But I do not think "git rm" needs "--recurse-submodules".  Wasn't
> "--recurse-submodules" the option to control, when you tell Git to
> do something to submodule "A", what should happen to submodules
> contained in the submodule "A" (e.g. "A/B" that appears at path "B"
> that itself is a separate project bound as a submodule to "A")?

Nope. Only the "--recursive" option to the git submodule script
works like that (and almost everyone seems to use that option by
default anyway). But for all commands that understand the
"--recurse-submodule" option (currently these are clone, fetch,
merge, pull and push) that means "include submodules in what you
do and don't stop at the first level but recurse all the way down".
Without this option they won't even touch the first level of
submodules.

> I am OK if you choose to implement the behaviour described above
> only in "git submodule rm A" and not plain "git rm -r A", but if you
> are going that route, I do not see how it is an improvement for it
> to remove the index entry for A from the index if your "git rm -r A"
> does not remove working tree files for submodule A.  The user asked
> to remove A with a command that would remove both index entry and
> working tree file for a regular file (or a directory), the command
> may decide it is not prudent to do so for whatever reason.  Perhaps
> the entity being asked to remove has local changes the user may
> regret losing.  Perhaps we decided that such an opration to cause a
> large structural change should not be done with a plain "rm" but
> should be done with "git submodule rm".  The reasons do not matter
> much, but for the end result to be consistent, shouldn't the command
> keep the index entry intact if it does not remove the working tree?

All other core commands happily change the index without updating
the submodule's work tree. My first patch intended to make "git rm"
behave the same: Don't care if the submodule's work tree is still
there, but just record in the index what the user told you. Right
now it *always* throws an error no matter if the submodule is
modified or not, while a "rm" should either just work on unmodified
content or leave submodules alone. That's what I'm trying to fix.

To me checking out a commit before the submodule was added should
leave work tree and index in the same state with respect to the
submodule as when I do a "git rm sub". In the former case the
submodule directory is still there with all files but it won't be
present in the index (and .gitmodules) anymore. And checkout
doesn't care at all about any modifications in the submodule before
updating. "git rm" will behave just the same after my patch (of
course I'm talking about the upcoming v2 without checking the HEAD).

But I agree with you that rm should consider modifications of the
work tree of a submodule (unless "-f") before actually removing its
work tree. But I don't think we should teach "git rm" to do that
without an explicit "--recurse-submodules" for the following reasons:

* Change in behavior:
  Currently "git rm submod" always errors out when the submodule is
  populated. Would it remove an unmodified submodule from index and
  work tree and only error out if it would throw away local changes
  it will surprise users who expect the submodule work tree being
  left untouched by rm (and all other core commands).

* Consistency:
  rm would be the first core command to touch submodules work trees
  without being given the "--recurse-submodules" option (clone being
  the only command actually touching the work tree when that option
  is used by populating all submodules, all other just update refs
  and the object database in submodules). I'd rather have one config
  option teaching all work tree changing commands to always update
  submodules work trees later, when enough of them learned the
  "--recurse-submodules" option.

* Workflow issues:
  All current git core commands leave submodules untouched. So you
  might have to run a "git submodule update" after checking out a
  new branch in which you want to remove a submodule before "git rm"
  will remove it without "-f". No other core command demands that.

But if other people think these issues aren't as important as I
think they are, I'll happily teach "git rm" to do that by default.

The important change for me is the next step which teaches "git rm"
the "--recurse-submodules" option (no matter if enabled as default
or not). If this change here doesn't make sense to you I'll drop it
and start implementing the checking and removal of submodules. That
can then be used by "git submodule rm".
