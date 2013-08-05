From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG?] gc and impatience
Date: Mon, 5 Aug 2013 21:24:29 +0530
Message-ID: <CALkWK0=fDaVUS7rSQ5LyS1UL2hD8JmA23BnpGeT6pC0EgEd9_w@mail.gmail.com>
References: <CALkWK0k2B5OW9zMrw0jBDDWpufojYDJybXa7jCBdzftNUc7mxA@mail.gmail.com>
 <CACsJy8DRo9Akoydwn9-EPOSyJiPhqAf1=HncYjHvXZwS4S_d7A@mail.gmail.com>
 <CAPc5daXi_ZG6GcK6pWafffyOY4MEZHUMkZxTxiRiU4BaFybqqg@mail.gmail.com>
 <CACsJy8DO4VyCK_xDJDGVx6JLTqjKAf24AUOW3=kZEMEVjAUSVw@mail.gmail.com> <7vk3k0not6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 17:55:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6N7u-0006nI-DA
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 17:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022Ab3HEPzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 11:55:12 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:40491 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545Ab3HEPzK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 11:55:10 -0400
Received: by mail-ob0-f169.google.com with SMTP id wc20so5970308obb.14
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=e2uinsGe9XQpKpN5zzUXABXQxypagWPBY2MeRutOurY=;
        b=E9YeCkF4RjjzGp52BcjP7QGRSBX3l38ZzyrzRdmCI+BCCxTWZu3P6BlOJKLc7cAbq4
         jz+TAIh+1Dk3s5TVSQJ0cqdTByx61+PimaridOho9OUVrmCzw5KKghV7kDB2ioLCcg/h
         f0GVog+ddJWSN0uuNA6tFpXs4+NwCaK2Fxi10CLDx+VZMjjNWsd92PmOncPEcQ/YBSIR
         U51lnekR9b13Ccwpf43ITFEl83bPBH6LwpEVSspNkarfxVT0z99xqeZZh3g9klQMUyMr
         lqPMEMBDUTDX1y0ONDGmOVs7vFN6TYuu5DbeukNdfV2QSgeQABz9GTggpaiExvxdgChU
         /ifg==
X-Received: by 10.42.76.5 with SMTP id c5mr1774075ick.91.1375718110118; Mon,
 05 Aug 2013 08:55:10 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Mon, 5 Aug 2013 08:54:29 -0700 (PDT)
In-Reply-To: <7vk3k0not6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231662>

Junio C Hamano wrote:
> I am a bit hesitant to dismiss with "It's not the right model", as
> the original of accessing the repository from two terminals while
> one clearly is being accessed busily by gc falls into the same
> category.

As to why I think it makes sense: garbage collecting unreferenced
objects has nothing to do with updating refs, or checking out a
worktree.  Think about my earlier "make push.default = current resolve
HEAD early"; why would the user want to update the ref that is being
pushed?  She'd most likely want to continue working on another feature
on some other branch, and that's perfectly fine.

In long-running runtimes, garbage collection is absolutely essential
to the performance. Often, stupidly written garbage collectors that
stop-the-world (the execution of the program), compact the memory
after collection, and then restart the program, can cause the user to
throw that runtime out the window (Emacs has a really stupid one, by
the way).  Most modern runtimes have concurrent garbage collectors
that are allocated very fine-grained slots by the scheduler: so, the
program won't suddenly come to a grinding halt to do garbage
collection. The reason it's so hard to do concurrent gc is because
there can be races between data modification via variables (main
program), and data being moved around in memory for compacting (gc).

Having said all this, the problem is highly simplified in git, because
the object store is a const-store. A particular key (sha-1) is
guaranteed never to point to the wrong data.  Frankly, even if there
is concurrent access to the object store, the worst thing that can
happen is that the gc didn't collect some dangling objects that were
created during the gc run.

Unless you have some irrational fear of introducing some unexpected
behavior in some convoluted corner case, I really don't see what the
problem is.  I'm sure server-side implementations have to do it all
the time: GitHub and Gerrit certainly doesn't say "I'm gc'ing; please
pull after 10 mins".  Perhaps they're more conservative than the
client side about gc (space is cheap), but that's just a sane default.

> It can very well be two terminals, one on one machine each, both
> with the same human end-user interaction.

Someone does an SSH my machine to a submarine in Russia over a slow
connection. I remove an ordinary file, while she's trying to write to
it. When did anyone make any guarantees about no races? What does git
gc specifically have to do with this?

For the record, you can easily mess up your worktree by running two
different worktree updates (checkout/ merge) on two different
terminals: nothing forbidding it. I don't see how _not_ forbidding gc
on two different terminals is better than forbidding it. This is quite
an obscure feature for few super-impatient people, and we haven't even
advertised it in any documentation.

Unless you can present an alternative now (patch-form, please), I
think you're being irrationally conservative about this.
