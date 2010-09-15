From: Kevin Ballard <kevin@sb.org>
Subject: Re: [RFC PATCH 0/2] Teach fetch and pull to recursively fetch submodules too
Date: Wed, 15 Sep 2010 16:12:44 -0700
Message-ID: <810A496E-68B0-4478-A698-2CFEE6CE354C@sb.org>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org> <4C90AEDE.4070300@web.de>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jens Lehmann <jens.lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Sep 16 01:12:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ow19q-0006a9-41
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 01:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262Ab0IOXMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 19:12:47 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56298 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448Ab0IOXMq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Sep 2010 19:12:46 -0400
Received: by pwi3 with SMTP id 3so279218pwi.19
        for <git@vger.kernel.org>; Wed, 15 Sep 2010 16:12:46 -0700 (PDT)
Received: by 10.114.124.17 with SMTP id w17mr2622408wac.204.1284592366470;
        Wed, 15 Sep 2010 16:12:46 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id d38sm3199454wam.8.2010.09.15.16.12.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Sep 2010 16:12:45 -0700 (PDT)
In-Reply-To: <4C90AEDE.4070300@web.de>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156270>

On Sep 15, 2010, at 4:32 AM, Jens Lehmann wrote:

> Am 15.09.2010 02:18, schrieb Kevin Ballard:
>> The first is `git remote update`, which I am fond of using, causes buggy behavior where it fetches all submodules twice.
> 
> I'll look into that, fetching the same submodule twice should not
> happen. (But I'm not sure what you mean by "buggy behavior where it
> fetches all submodules twice" though, is there something else going
> wrong?)

Nothing else wrong, the bug was simply that it fetches all submodules twice. And if it helps, I only have one remote.

>> The second is this submodule fetch doesn't appear to be recursive.
> 
> That is strange as fetch now executes a 'git fetch' inside each
> populated submodule, which should automagically recurse. So I assume
> that you don't have a .gitmodules file inside your first level of
> submodules which describes the deeper nested ones?

I do indeed have a .gitmodules file. My normal approach of `git submodule update --init --recursive` works perfectly fine to update the entire tree of submodules, even on a brand new clone.

Upon further investigation, judging from the time spent on each submodule, it may indeed be recursing. The odd part then, is that a `git fetch` at the top level reports that it's fetching one of the nested submodules, even though a `git fetch` inside that submodule doesn't report any of its nested submodules being fetched.

Here's an equivalent tree for the submodules I have:

  .--Root-.
 / / /|\ \ \  
A B C D E F G
      |
      H
     /|\
    I J K
     /|\--.
    L M N J'
     /|\
    O P Q

J' is listed in .gitmodules but doesn't actually exist in the tree anymore. I'm not sure if this makes a difference.

When I run `git fetch` at the root level, I see the following:

Fetching submodule A
Fetching submodule B
Fetching submodule C
Fetching submodule H
Fetching submodule D
Fetching submodule E
Fetching submodule F
Fetching submodule G

This exactly matches the ordering of the submodules in .gitmodules, except for the stray fetch of H listed after C. If I cd into C and run `git fetch`, I only see

Fetching submodule H

Similarly if I cd into H and fetch, I only see I, J, and K.

I cannot figure out why it is displaying "Fetching submodule H" at this root level. As I said above, going by how long it spends fetching the submodule, I assume it is actually recursing appropriately.

>> The third issue is `git fetch` doesn't have any business fetching submodules when the submodule reference was never changed as part of the fetch, especially if the main fetch itself didn't even find any changes. It seems to me that the correct behavior would be to look at all the fetched commits to see if any of them change the submodule reference, and only in that case should it automatically fetch any submodules whose references were modified. The stated desire of avoiding "(commits not present)" when doing a diff will still be met, but it will avoid slowing down the normal case of a `git fetch`.
> 
> I was thinking about implementing that optimization too but came to
> the conclusion that you always have to fetch submodules too no matter
> if the superproject has any new commits fetched for them. Because
> when you don't do that you wouldn't get a chance to test and commit
> e.g. a new feature added by a colleague in a submodule and pushed by
> him, as that would not be fetched into your repo before it was
> committed inside the superproject. That leads to a 'chicken or the
> egg' problem.

In my scenario, running `git fetch` will fetch a grand total of 17 submodules. This makes fetching extremely slow. And the normal workflow here is if one of my coworkers commits a change to submodule D, and the submodule is in an appropriate state to be updated in the root project, he will go ahead and update it in that root project. Alternatively, if he's making the change to satisfy a request made by me, he will let me know when it's done and I will update it. Otherwise, I don't want to know when he pushes changes. So the ideal behavior for me is only fetch a submodule if the superproject's fetch actually fetched new trees, and one of those trees references a new commit in this submodule that doesn't already exist. If I want to know about changes that aren't referenced by the superprojec
 t, I would simply run `git submodule update --recursive`.

I'm not sure I understand why you think there's a 'chicken or the egg' problem. If a colleague adds a new feature to a submodule, if he updates the superproject for this and commits, then the behavior of `git fetch` won't make any difference. If he just pushes the submodule and leaves it up to you to update the superproject, then there's still no problem, as it cannot be committed into the superproject without you fetching the submodule. It seems the only reason to proactively fetch commits in a submodule that hasn't been updated in the superproject is so you can be aware that there were new commits pushed in the submodule, if you care to go look at them and potentially update the superproject to include the new commits. I am not convinced that this needs to be done on every `git fetch`. I
 t seems likely that most people running `git fetch` aren't responsible for updating the submodule, and often may explicitly not want to update the submodule. And whatever developer is responsible for updating the submodule when necessary should just be in the habit of running something like `git submodule foreach --recursive 'git fetch'`. Alternately, we could turn the submodule.<name>.fetch property into an enum rather than a boolean, and have one value of the enum be the current behavior (where it always fetches), another value be the new default behavior where it only fetches when necessary to resolve commit references in the superproject, and a third value be to never fetch. This mechanism would also benefit from having a config value that sets the default to use when submodule.<name
 >.fetch doesn't exist.

>> It also seems like there ought to be a config variable one can set for the default behavior if submodule.<name>.fetch is not present in .gitmodules or in .git/config.
> 
> I'll take this as a 'yes' to my question if such an option is wanted.
> 
> 
> In your other mail you wrote that the output of the recursive fetch
> does not prepend the names of the higher level submodules. I did not
> think about that and will post a fix for that problem soon.

As illustrated above, the recursive fetch actually isn't printing out any of the nested submodules, except for my outlier submodule H. If it's supposed to be printing them, it should prepend the submodule name with the parent. If it's not supposed to be printing them, then this isn't an issue. That said, I do think it should be printing them, because otherwise you get the weird behavior where you can see several fetches in a row, but without any "Fetching submodule <blah>" header between them. It makes it look like the same repo needed to be fetched several times and is quite confusing.

-Kevin Ballard
