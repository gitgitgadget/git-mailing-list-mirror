From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Sharing merge conflict resolution between multiple developers
Date: Tue, 12 Aug 2014 11:29:04 +1200
Message-ID: <CAFOYHZAaF+Dve1DwUUd-k6Nh3+nOZzNVUQAD0quN4crRAjfCLQ@mail.gmail.com>
References: <CAFOYHZCiKC4TR4jFVUB=W5qbDG8XvB2Obx1ZfTH8OF3E_c5BnA@mail.gmail.com>
	<xmqqd2c67tok.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 01:29:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGz1h-0003rT-Je
	for gcvg-git-2@plane.gmane.org; Tue, 12 Aug 2014 01:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbaHKX3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2014 19:29:07 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:35324 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbaHKX3G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2014 19:29:06 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so11375487pdj.8
        for <git@vger.kernel.org>; Mon, 11 Aug 2014 16:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NlmRHt4SM7SqInItRsTnTdOXGhrh692iyqDc/yBCO+s=;
        b=R7OBshdkh8hMmdPgmM+asemPl5W8cii36b54/up1HnBgD56KfM++pc+9HBm7adiYUn
         lONUfLNpw2zsm+ia6DlCXmbhqxjnX04ayETNg260qMWYqA1vqgAPsEb9rOQY5Uz0WfZl
         CE5fHyoLWyiZ9a38Vrz2yW8pbJe7o8ljzUifyqqXfAmZbl+02Twy5KIWmDwMP6dz18/0
         pVjzQJ1qDbdIz1h8F00XYV3IHxtfIA3OEnTwK8mSw9dfEZbUGZcq5/53rfMIbWGO9taS
         TfFf47dtHSnXDc8mkQs/zwl375wC82liPlqsstnRyLhS3rzUE8+r0AilhgJ6GsCY/oQI
         qdow==
X-Received: by 10.70.22.163 with SMTP id e3mr318071pdf.157.1407799744783; Mon,
 11 Aug 2014 16:29:04 -0700 (PDT)
Received: by 10.70.98.140 with HTTP; Mon, 11 Aug 2014 16:29:04 -0700 (PDT)
In-Reply-To: <xmqqd2c67tok.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255142>

On Tue, Aug 12, 2014 at 6:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Chris Packham <judge.packham@gmail.com> writes:
>
>> Is there any way where we could share the conflict resolution around
>> but still end up with a single merge commit.
>
> One idea that immediately comes to me is to use something like
> "rerere" (not its implementation and storage, but the underlying
> idea) enhanced with the trick I use to fix-up merges in my daily
> integration cycle (look for "merge-fix" in howto/maintain-git.txt
> in Documentation/).
>
>> developer A:
>>   git merge $upstream
>>   <conflicts>
>
> And then commit this immediately, together with conflict markers
> (i.e. "commit -a"), and discard it with "reset --hard HEAD^" *after*
> storing it somewhere safe.  And then redo the same merge, resolve
> the conflicts and commit the usual way.
>
> The difference between the final conflict resolution and the
> original conflicted state can be used as a reference for others to
> redo the same conflict resolution later elsewhere.  That can most
> easily be done by creating a commit that records the final state
> whose parent is the one you recorded the initial conflicted state.
>
> So, the "recording" phase may go something like this:
>
>     git checkout $this
>     git merge $that
>     git commit -a -m 'merge-fix/$this-$that preimage'
>     git branch merge-fix/$this-$that
>     git reset --hard HEAD^
>     git merge $that
>     edit
>     git commit -a -m 'merge $that to $this'
>     git checkout merge-fix/$this-$that
>     git read-tree -m -u HEAD $this
>     git commit -a -m 'merge-fix/$this-$that postimage'
>
> The rough idea is "git show merge-fix/$this-$that" will show the
> "patch" you can apply on top of the conflicted state other people
> would get by running "git merge $that" while on "$this" branch.

So how would someone else pickup that postimage and use it?

  git checkout $this
  git merge $that
  git fetch $remote ':/merge-fix/$this-$that postimage'
  git show ':/merge-fix/$this-$that postimage' | git apply (or patch -p1)
  edit

>
> "rerere" essentially does the above recording (and replaying)
> per-path and it comes with a clever indexing scheme to identify
> which previous conflict resolution would apply to the conflicts you
> see in your working tree.

I feel a toy patch coming on.
