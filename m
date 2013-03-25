From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Why does 'submodule add' stage the relevant portions?
Date: Mon, 25 Mar 2013 19:43:06 +0100
Message-ID: <51509ABA.3040804@web.de>
References: <CALkWK0=PHNmT5zfjEaWh_5=aV7wcPdGgyCWFhjaeVrrWhL0OBw@mail.gmail.com> <51500C67.9040308@web.de> <CALkWK0kJ2QVA6is85Sdwn1mnGVbuNUSGqg_37WBxPYrepHz9ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 19:43:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKCMt-0003Vx-KG
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 19:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932952Ab3CYSnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 14:43:12 -0400
Received: from mout.web.de ([212.227.15.3]:53574 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932611Ab3CYSnL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 14:43:11 -0400
Received: from [192.168.178.41] ([91.3.170.222]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MSJ0V-1UEW8M1BPv-00TAEH; Mon, 25 Mar 2013 19:43:09
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <CALkWK0kJ2QVA6is85Sdwn1mnGVbuNUSGqg_37WBxPYrepHz9ow@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:fI0rOx3UK8aJp36K5Yz0qVpdALxPdeoJ6ABBqG/lapc
 +3lIf7BV4ncypmMtPLl8lOgbvg+WLjLSMz/1bFHfvIHGXhjcIn
 3ZLWPjl46vQsmkBAYVip+4zobxn7ZsQupf9hetzPjmJfP/8vyq
 ay3dsHkTlM5rGPXgPjVJqm6zXWVztgyxqPHUwpXzQ3H+TxlR7D
 vZezfBH++1GIVnvNbkFpg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219063>

Am 25.03.2013 09:59, schrieb Ramkumar Ramachandra:
> Jens Lehmann wrote:
>> Am 24.03.2013 18:38, schrieb Ramkumar Ramachandra:
>>> I find this behavior very inconsistent and annoying.  Why would I want
>>> to commit the submodule change immediately?  Maybe I want to batch it
>>> up with other changes and stage it at a later time.  Why should I have
>>> to unstage them manually now?  I get the other side of the argument:
>>> what if the user commits the .gitmodule change at a different time
>>> from the file change?  In other words, the user should have a way of
>>> saying 'submodule stage' and 'submodule unstage'.
>>
>> Hmm, AFAIK you are the first to bring up such a feature, as in most
>> use cases doing a "git (submodule) add <path>" is expected to stage
>> what you added.
> 
> In my opinion, the 'git submodule add <path>' form is broken, because
> it doesn't relocate the object store of the submodule repository (a
> bug that we need to fix?).

I don't think it is broken. Leaving the .git directory inside the
submodule makes perfect sense for some users (e.g. those which never
intend to push their submodule somewhere else) and doesn't do any
harm unless you want to remove it again in the future (or need to go
back to an older commit where the submodule directory would be in
the way). We have to think very hard before making such changes to
behavior quite some people may rely on, even though I agree some use
cases would profit from it and I think we would do it differently if
we could start over again.

What I think we need rather soonish is "git submodule to-gitfile",
which would help your case too. We should then hint that in those
cases where we refuse to remove a submodule when using "git rm" or
"git submodule deinit" (or the "git mv" for submodules I'm currently
preparing).

>  I always use the 'git submodule add
> <repository> <path>' form, which puts the object store of the
> submodule repository in .git/modules of the parent repository.  This
> form is nothing like 'git add', but more like a 'git clone': arguably,
> 'submodule clone' is a better name for it.

Hmm, it does a clone first and then adds the submodule and the change
to .gitmodules, so I still believe "add" is the correct term for it.
So I really like the color the shed currently has ;-)

> Maybe the WTF "You need to run this command from the toplevel of the
> working tree" needs to be fixed first?  I think it's a matter of a
> simple pushd, popd before the operation and building the correct
> relative path.

I won't object such a change (even though I suspect it'll turn out
more complicated than that).

>  I'm not sure how it'll work with nested submodules
> though.  Then again, I think nested submodules are Wrong; submodules
> are probably not the right tool for the job.

How did you come to that conclusion? Nested submodules make perfect
sense and most people agree that in hindsight --recursive should have
been the default, but again we can't simply change that now.

>>> Now, for the implementation.  Do we have existing infrastructure to
>>> stage a hunk non-interactively?  (The ability to select a hunk to
>>> stage/ unstage programmatically).  If not, it might be quite a
>>> non-trivial thing to write.
>>
>> Have fun when adding two submodules and unstage only one of them
>> later. I think this feature will not work unless you analyze
>> .gitmodules and stage/unstage section-wise.
> 
> Yes, which is why I asked if we have existing infrastructure to make
> this possible.

Not that I know of.
