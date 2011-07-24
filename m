From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [RFC 0/9] bisect: allow git bisect to be used with repos
 containing damaged trees.
Date: Sun, 24 Jul 2011 18:54:11 +1000
Message-ID: <CAH3Anrp7h+TkGgi1uZsfZKWkK3zDYa=eG2kjHRcmoPKvkZq59w@mail.gmail.com>
References: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
	<4E2BD251.6060306@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Jul 24 10:56:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkuTx-0000tt-NF
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 10:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896Ab1GXIyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 04:54:13 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54097 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527Ab1GXIyM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 04:54:12 -0400
Received: by vws1 with SMTP id 1so2430675vws.19
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 01:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mB3Hu8rgh+1UTMCYjWNWrdPv6BRDVBZ2KVpREM0SyeA=;
        b=F6T6PdzKEfhfI5rHKyD4xixCSMtPMgh82fijfH0UsIBD6vSZNY8HE08nvm1LBhzvXZ
         wC1w+oIf5JbD5XuaWAUkmhxxslX5fSEPVbrhVLMkeUXIA68bRNIRmy/iowDueq/zbSKN
         7+RbSrNEfpIz2lkFmWnH+iA9kfCAdty7aJWIk=
Received: by 10.52.98.198 with SMTP id ek6mr2963521vdb.240.1311497651035; Sun,
 24 Jul 2011 01:54:11 -0700 (PDT)
Received: by 10.52.183.41 with HTTP; Sun, 24 Jul 2011 01:54:11 -0700 (PDT)
In-Reply-To: <4E2BD251.6060306@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177734>

On Sun, Jul 24, 2011 at 6:05 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 24.07.2011 07:57, schrieb Jon Seymour:
>> Currently git bisect assumes that the respository to be undamaged. This limits the usefulness
>> of git bisect when working with damaged repositories.
>
> So, what? Isn't a broken repository also (almost) useless w.r.t. log,
> checkout, rebase, reset, push, fetch...?
>

The broken or missing commits in a broken repository are useless, but
all the other
commits and the things they reach may still be useful.

When trying to recover such things, git bisect could be a useful tool,
since it would allow one to automate discovery of the broken regions
of the graph. Once the broken regions have been isolated, grafts can
be used to cauterize the damaged regions, the remainder can be rescued
with git-filter-branch  and life goes on.

>> This series introduces an option, --ignore-checkout-failure, which can be used with
>> "git bisect start" to indicate that checkout failures should be tolerated for the life
>> of the (new) bisection process. This allows git bisect to be used on damaged repositories. In
>> particular, it allows git bisect to be used to locate commits containing damaged trees.
>
> I have to wonder: why do you care only about git-bisect? If you want to
> be able to use a broken repository, aren't there many more commands that
> fail and for which you also want to have a similar work-around? Or is
> git-bisect the only one where the work-around was missing?
>

git bisect is, in principle, a very useful tool for identifying
regions of damage in a broken repo.

I don't want to have to write another tool that does exactly what git
bisect does except for the checkout function which, for the purpose of
repo rescue, I do not need.

>
> But what is an inconsistent state good for? In general, it makes no
> sense to decide whether the result is "good" or "bad" when you know in
> advance that the checked-out state is inconsistent.
>

The inconsistent state is useful because I can use that state to
progress the bisection. In particular, I can write a test which checks
to see whether this particular commit is broken (can't reach its
parents or its tree). In fact, git status does just nicely for this
purpose.

And by using that test with git bisect I can discover the precise
boundaries of the broken regions of the graph.

Of course, I have no intention of doing any kind of development with a
repo in that state - the point is to only to make an existing tool
even more useful - by helping it deal with broken repos too.

jon.
