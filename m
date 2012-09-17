From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCHv5] clone --single: limit the fetch refspec to fetched branch
Date: Mon, 17 Sep 2012 23:04:09 +0200
Message-ID: <CAN0XMOKCsjfG-DgV_rr99mYXHBSKryL1O46X+7r5ie+=2aKmmA@mail.gmail.com>
References: <CACsJy8BGBwNp-oDsnB1QObrVLU54rtDmGGBF=Muww8ZJjfZScA@mail.gmail.com>
	<1347909706-22888-1-git-send-email-ralf.thielow@gmail.com>
	<7v8vc8v1wd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 23:04:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDiUO-0002Zu-Nk
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 23:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757256Ab2IQVEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 17:04:12 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:54572 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757277Ab2IQVEK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 17:04:10 -0400
Received: by wgbdr13 with SMTP id dr13so6181154wgb.1
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 14:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MgAE6/vn6NVB0UstU93C/HWwsQWEhJCaWYdhZ0nuag8=;
        b=ooK4gQkhi+6fRLaksDUfTOYQ0NnuxybcklE0tCtD24Vkh9iBSzLvaLPwzoD87W1Fj3
         SQ7jPufWiByfEn9CAWDol5Cl3V2n5dUvjiKRo8hVNgd6fCKPhhvHTu6HtNHqtnAxtZyt
         v0Jt1ZoD2XqRETuyr1JKhHBaqgIsV9doVwj5laKkMMtfYfpKC+7fzad35bYf2pRIeTMI
         E4dWy0z3FlhZRN/CqAukG5xN/DRF9G9IOSwLi3tvY1wCwUWbwIYwU6BkPrDVCYsHROlj
         jcT4PmcGvFJhPDM16k04R9ZOOzArvCZ6wWIAwACR/iBZ2QmyIfM2QZkYoXC1uTwK2g4/
         EUTA==
Received: by 10.181.13.208 with SMTP id fa16mr18492187wid.11.1347915849603;
 Mon, 17 Sep 2012 14:04:09 -0700 (PDT)
Received: by 10.194.23.201 with HTTP; Mon, 17 Sep 2012 14:04:09 -0700 (PDT)
In-Reply-To: <7v8vc8v1wd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205748>

On Mon, Sep 17, 2012 at 10:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>> - handle --mirror option (test added)
>
> Handle how?  I personally think erroring out is the right way to
> handle it, but if we care about people who have been misusing the
> combination of single and mirror, the second best way would be to
> imply "mirror" and "single" combination as "bare" and "single"
> without "mirror".
>

With this patch it would be "bare" and "single", and with the next
fetch a "mirror". However, the combination of "single" and "mirror"
doesn't really make sense so I also think we should error it out.

>> - install correct refspec if the value of --branch is a tag (test added)
>
> What is the definition of "correct"?  I see the documentation says
> "--branch can also take tags and treat them like detached HEAD", and
> even though I _think_ allowing tags was a huge mistake, if we claim
> we treat it like detached HEAD, we should do the same when coming up
> with the refspec used for the follow-up "fetch".
>

This patch would install the refspec "+refs/tags/v1.7.10:refs/tags/v1.7.10",
so we would do the same with the follow-up "fetch", not?
This can be seen as "it's not a bug, it's a feature". Why not cloning a
tag of a repo if someone just want to build a tag without having anything else.

> Whatever we decide to do, the semantics we decided to use at least
> need to be described in the commit log message, not just in the
> "changes from the previous iteration".  Updating the
> "Documentation/git-clone.txt" would also be necessary.
>

Ok.

>> +test_expect_success 'refspec contains all branches by default' '
>> +     echo "+refs/heads/*:refs/remotes/origin/*" > expect &&
>> +     git --git-dir=dir_all/.git config --get remote.origin.fetch > actual &&
>> +     test_cmp expect actual
>> +'
>
> I still think these checks that know the current implementation
> details (i.e. what exact configuration variables get what exact
> values) are wrong thing to have in the longer term.  If the desired
> behaviour (i.e. "later fetch do not screw up") can be tested
> directly like the later parts of the test in this patch does, how
> that desired behaviour is implemented should not have to be cast in
> stone with these tests.

You wrote
> I'll let it pass for now, though.
so I haven't removed them yet. I'll delete them.
