From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/21] Support multiple worktrees
Date: Sat, 28 Dec 2013 09:46:57 +0700
Message-ID: <CACsJy8BV39frnQo1BW2p1J7H0pU7LifzcUey61J5Jkc6Wn=2rw@mail.gmail.com>
References: <CACsJy8BV6uerMyHNHviL0Jy8s+_jca8NM-hVfnM=u4cr-=JX1Q@mail.gmail.com>
 <xmqq7gaze00k.fsf@gitster.dls.corp.google.com> <CACsJy8DuXbCTjcVJNH=w6h3zgo0sxRgMfSQXZFtngYy2FLJTDg@mail.gmail.com>
 <7vvbyhjsp4.fsf@alter.siamese.dyndns.org> <CACsJy8DL5=B=jch6j6g_3xj3KRsLXxwMChVHF9MUFvafhWhYag@mail.gmail.com>
 <7vy537k038.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 28 03:47:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwjwN-0002z8-1Y
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 03:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875Ab3L1Cr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 21:47:28 -0500
Received: from mail-qe0-f52.google.com ([209.85.128.52]:39792 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754613Ab3L1Cr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Dec 2013 21:47:27 -0500
Received: by mail-qe0-f52.google.com with SMTP id ne12so9499253qeb.25
        for <git@vger.kernel.org>; Fri, 27 Dec 2013 18:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qUZFdGahdRs6MGLeEp11UW8QbN+W5ijt+TaOYFqn2gU=;
        b=NwnlPk7qkw9/e/GjeqlqRb+baIlmhqbn6mFGd4cXBhhBZg7fbq3jul6olIe4GxEqzA
         WK9GCewacP8j3K0r+GYu+bojx38XJ0IiJIG7dP8mmPRLUF/KJAxNqvteRdfDQGzNIk7R
         eXa5amyG2s8wsqtdCMZXlDxmmoxvIt/10wkhZHuWbquMxd8E+xgOJ708emZ0jLSkn24C
         2NhHpTMGvigA/pQgmD88U1qiBZUemqhAVUZi+gE6MIMQXgPlA+2jyzm8JA6xdz5NGX+q
         W1cfW/nuAdC2om4dfkPt7umqe2PrvC+2W1mT9K4UNGtXuFjouGz0w3HZAxAt9KBTZDda
         auFA==
X-Received: by 10.224.165.12 with SMTP id g12mr83458814qay.89.1388198847293;
 Fri, 27 Dec 2013 18:47:27 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Fri, 27 Dec 2013 18:46:57 -0800 (PST)
In-Reply-To: <7vy537k038.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239760>

On Fri, Dec 27, 2013 at 12:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Sun, Dec 22, 2013 at 1:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> Do we even need to expose them as ref-like things as a part of the
>>> external API/UI in the first place?  For end-user scripts that want
>>> to operate in a real or borrowing worktree, there should be no
>>> reason to touch this "other" repository directly.  Things like "if
>>> one of the wortrees tries to check out a branch that is already
>>> checked out elsewhere, error out" policy may need to consult the
>>> other worktrees via $GIT_COMMON_DIR mechanism but at that level we
>>> have all the control without contaminating end-user facing ref
>>> namespace in a way main/FETCH_HEAD... do.
>>
>> No, external API/UI is just extra bonus. We need to (or should) do so
>> in order to handle $GIT_COMMON_DIR/HEAD exactly like how we do normal
>> refs.
>
> And that is what I consider a confusion-trigger, not a nice bonus.
>
> I do not think it is particularly a good idea to contaminate
> end-user namespace for this kind of "peek another repository"
> special operation.
>
> In order to handle your "multiple worktrees manipulating the same
> branch" case sanely, you need to be aware of not just the real
> repository your worktree is borrowing from, but also _all_ the other
> worktrees that borrow from that same real repository, so a single
> "main" virtual namespace will not cut it. You will be dealing with
> an unbounded set of HEADs, one for each such worktree.

Yes. My problem is, while all secondary worktrees are in
$GIT_DIR/repos and their HEADs can be accessed there with
"repos/xxx/HEAD", the first worktree's HEAD can't be accessed this way
because "HEAD" in a linked checkouts means repos/<my worktree>/HEAD.

> Can't we do this by adding a "with this real repository" layer,
> e.g. "resolve HEAD wrt that repository", somewhat similar to how we
> peek into submodule namespaces?

Hmm.. never thought of it like a "submodule". Thanks for the idea.
-- 
Duy
