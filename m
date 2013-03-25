From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Why does 'submodule add' stage the relevant portions?
Date: Mon, 25 Mar 2013 23:57:25 +0100
Message-ID: <5150D655.8000204@web.de>
References: <CALkWK0=PHNmT5zfjEaWh_5=aV7wcPdGgyCWFhjaeVrrWhL0OBw@mail.gmail.com> <51500C67.9040308@web.de> <CALkWK0kJ2QVA6is85Sdwn1mnGVbuNUSGqg_37WBxPYrepHz9ow@mail.gmail.com> <51509ABA.3040804@web.de> <CALkWK0mAkabTNrBjvv4s_YfTN9j2_Aros=7ZcF7j=KAjJE-yaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 23:58:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKGL6-00059W-Q7
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 23:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511Ab3CYW5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 18:57:37 -0400
Received: from mout.web.de ([212.227.15.4]:54929 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810Ab3CYW5g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 18:57:36 -0400
Received: from [192.168.178.41] ([91.3.170.222]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0LqDD6-1UouFT14y0-00dp8A; Mon, 25 Mar 2013 23:57:35
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <CALkWK0mAkabTNrBjvv4s_YfTN9j2_Aros=7ZcF7j=KAjJE-yaw@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:1lDoUob7X8FhDdeqIMDSHqpBzqHFXRveok+0tgcJGJ3
 LiVA9Z2Yj0ehP9hjn3M5pQbTItYMkWmT1ezaDiD1KaCe7Yxq44
 Q5jnHX9xesYAG5KFccf/A2dvRhvc9Lz6JW9R4UE400373sokq+
 2Yz4VgLiEfUr5/9bxeX58EbCWHhUCH80XvcL4ViuQ0Tgf5xFpT
 e1SNv37E6lYaDfKwJJbdA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219114>

Am 25.03.2013 20:57, schrieb Ramkumar Ramachandra:
> Jens Lehmann wrote:
>> Am 25.03.2013 09:59, schrieb Ramkumar Ramachandra:
>>> In my opinion, the 'git submodule add <path>' form is broken, because
>>> it doesn't relocate the object store of the submodule repository (a
>>> bug that we need to fix?).
>>
>> I don't think it is broken. Leaving the .git directory inside the
>> submodule makes perfect sense for some users (e.g. those which never
>> intend to push their submodule somewhere else) and doesn't do any
>> harm unless you want to remove it again in the future (or need to go
>> back to an older commit where the submodule directory would be in
>> the way). We have to think very hard before making such changes to
>> behavior quite some people may rely on, even though I agree some use
>> cases would profit from it and I think we would do it differently if
>> we could start over again.
> 
> Doesn't that sound horribly crippled to you?  Is there any advantage
> to leaving the .git directory inside the submodule?  Isn't it always
> better to relocate it?

It's not crippled at all, that is just the way it was from submodule
day one. And no, it isn't always better to relocate it. E.g. when
you want to be able to just tar away work tree and history someplace
else because you don't have (or don't want) an upstream to push to,
you'd be very surprised a "submodule add" moved your .git directory
someplace else effectively nuking the backup of your history and
refs (guess under what circumstances you'll notice that). While I
believe most submodule users would benefit from such a relocation, I
consider the other use cases as valid and we would introduce silent
breakage on them. On the other hand I made all relevant commands
complain loudly about the .git directory in the submodule's work
tree when it matters, so users can do something about it when they
need it and are told so.

I'm not against changing that per se (we already did that for the
"update" case when cloning submodules), but I'm really not convinced
it is worth the downsides here (which it definitely was in the
"update" case).

>> What I think we need rather soonish is "git submodule to-gitfile",
>> which would help your case too. We should then hint that in those
>> cases where we refuse to remove a submodule when using "git rm" or
>> "git submodule deinit" (or the "git mv" for submodules I'm currently
>> preparing).
> 
> Why a new subcommand?  Is there a problem if we do the relocation at
> the time of 'add'?  Will some user expectation break?

For me relocation at the time of 'add' would be ok with a new option
(and it might also make sense to have a config option changing the
default for users who want that), but not as the default.

And leaving aside 'add', there are tons of submodules out there
which were cloned with older Git who have their .git directory
inside the work tree. So a new subcommand (or at least a helper
script in contrib) to relocate the .git directory would really help
here to migrate these legacy submodules without users having to
worry about data loss.

>>>  I always use the 'git submodule add
>>> <repository> <path>' form, which puts the object store of the
>>> submodule repository in .git/modules of the parent repository.  This
>>> form is nothing like 'git add', but more like a 'git clone': arguably,
>>> 'submodule clone' is a better name for it.
>>
>> Hmm, it does a clone first and then adds the submodule and the change
>> to .gitmodules, so I still believe "add" is the correct term for it.
>> So I really like the color the shed currently has ;-)
> 
> I meant a variant of add that would clone, but not stage.  I was
> arguing for a new subcommand so that I don't have to touch 'submodule
> add', not for a rename.

Ah, now I get it, I was confused by your reference to 'git submodule
add <repository> <path>'. I have to admit I still don't understand
the use case you have for adding a submodule without staging it, but
maybe it is just too late here.

>>> Maybe the WTF "You need to run this command from the toplevel of the
>>> working tree" needs to be fixed first?  I think it's a matter of a
>>> simple pushd, popd before the operation and building the correct
>>> relative path.
>>
>> I won't object such a change (even though I suspect it'll turn out
>> more complicated than that).
> 
> I'll have to investigate.

Ok, looking forward to that as I believe this would be a worthwhile
improvement.

>>>  I'm not sure how it'll work with nested submodules
>>> though.  Then again, I think nested submodules are Wrong; submodules
>>> are probably not the right tool for the job.
>>
>> How did you come to that conclusion? Nested submodules make perfect
>> sense and most people agree that in hindsight --recursive should have
>> been the default, but again we can't simply change that now.
> 
> Okay, I'll do it step-by-step now, with a live example:
> 1. git clone gh:artagnon/dotfiles, a repository with submodules.
> 2. git submodule update --init .elisp/auto-complete, a repository that
> contains submodules.
> 3. .elisp/auto-complete/.gitmodules lists the submodules (lib/fuzzy,
> lib/ert, and lib/popup).  Let's try to initialize them from that
> directory ... No! go back to toplevel.

That has got nothing to do with nested submodules but is the toplevel
requirement you already mentioned.

> 4. Fine.  Where are those submodules?  git submodule status doesn't list them.

Did you try 'git submodule status --recursive'? Without that option
nested submodules won't work well at all (maybe we need a config
option to let the user enable --recursive by default?).

> 5. Okay, let's join the paths by hand and try anyway: git submodule
> update --init .elisp/auto-complete/lib/fuzzy.  Did you forget to 'git
> add'?  Fantastic.

You either use --recursive to include all submodules or have to cd
into the submodules superproject (.elisp/auto-complete here) to do
"git submodule update --init lib/fuzzy".

> 6. How am I supposed to initialize the darn submodules?!
> 7. git submodule update --init --recursive .elisp/auto-complete is the
> ONLY way (is this even documented anywhere?).  But I just wanted to
> initialize one, not all three!

This is not the only way, see above. Patches to update submodules
across nested submodules are welcome.

> 8. Okay, now I want to execute a 'git submodule foreach' on just those
> three submodules.  Seems impossible.

What about 'git submodule foreach --recursive .elisp/auto-complete'?
Or - if that is your only populated submodule - a simple 'git
submodule foreach --recursive' will do it too.

> Fine, I'll do it myself: for i
> in "lib/ert lib/fuzzy lib/popup"; do cd $i; git checkout master; git
> reset --hard origin/master; cd ../..; done

... and check out some arbitrary commit which most probably doesn't
match what is committed in their superproject .elisp/auto-complete.
You asked for it ...

> 9. Whew.  git status.  Changes in auto-complete.  git diff.
> "Submodule .elisp/auto-complete contains modified content".  I'm not
> allowed to see what changed now?

Thought about stepping into .elisp/auto-complete and doing a diff
there to see what is modified? What does 'git status --recursive'
show?

> 10. git checkout master; git reset --hard origin/master in
> auto-complete.  git status.  How do I stage the changes in just
> auto-complete, and not in auto-complete's submodules?

By simply committing .elisp/auto-complete? Unless you record a
submodule commit in its superproject, there is nothing to commit,
right?

>  What is going on, seriously?

Pilot error, mostly omitting the --recursive option and some
- fixable - usability issues. Patches welcome.

> This is just two levels of nesting: with more levels of nesting,
> things only get worse.

Yes, you cannot have the cake and eat it. Either you incorporate
everything into a single repo (e.g. using subtree) and loose the
strong distinction which content belongs to which upstream repo
(which AFAIK is a valid choice unless you want to contribute back
to the submodule's upstream) or you'll have to cope with the
submodule borders showing up from time to time, reminding you
which part of the work tree has another upstream.

>>>>> Now, for the implementation.  Do we have existing infrastructure to
>>>>> stage a hunk non-interactively?  (The ability to select a hunk to
>>>>> stage/ unstage programmatically).  If not, it might be quite a
>>>>> non-trivial thing to write.
>> [...]
>> Not that I know of.
> 
> Damn.  Then, it's certainly not worth the effort.  Atleast not now,
> when there are bigger problems.

Yep, that's what I think too.
