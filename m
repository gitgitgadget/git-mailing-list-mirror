From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] remote-hg: fix path when cloning with tilde expansion
Date: Fri, 9 Aug 2013 23:19:30 +0200
Message-ID: <CALWbr2y5H_dfHAFW_qN+j8YtF4F9+VcG8G503hr4YN2Qv69CXA@mail.gmail.com>
References: <CAMP44s1Jqao0YvBSh18t1C2LwAF4_u2GaTNx1RwdW+pmCFcxvQ@mail.gmail.com>
	<1376068387-28510-1-git-send-email-apelisse@gmail.com>
	<7veha266nq.fsf@alter.siamese.dyndns.org>
	<CALWbr2w2JjEr_hYX9ighu_-=iTV6etG=78g4AbKko64EsecxFA@mail.gmail.com>
	<7vy58a4mcy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 23:19:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7u5v-0006lQ-FY
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 23:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031192Ab3HIVTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 17:19:31 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:34478 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031152Ab3HIVTb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 17:19:31 -0400
Received: by mail-qc0-f174.google.com with SMTP id c1so2432387qcz.19
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 14:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VMJ0XWNCd5E8yUFpphYcvaShIKvbTri9uqfgg5/soFc=;
        b=Z79+7QJpO0PKBaFpfBbQNIrL5hDtgxU//XLfvW2DNJms/Pbiq69uZkF4ShXKWZ5/qk
         EF3PvvMaPa/fg3atDu4c92a5XqvojIHy0ybjH9B4Mob8P6Ykw04tWSx868ALd70RgLLg
         zBIvWCKWdUay/THoWJ+IHCf7mmIv5EM/9ix76gyn3IBDWP9tjWF2RBu8o3GE48tKdgl+
         iiS35kNuyGP81iykVYlZttEjo4TFnnCsfZVKpWCx5Wjr6XnofCTyVMfrgmGtidKkWsQp
         GSiDULn8Ml7R0vHIq3DmJ+ehbrkAmY3lKImEK3Pf+Ml7QffUmIJZQvZkIDoeJqgV0MZt
         9sUw==
X-Received: by 10.224.54.210 with SMTP id r18mr12931419qag.62.1376083170417;
 Fri, 09 Aug 2013 14:19:30 -0700 (PDT)
Received: by 10.49.104.211 with HTTP; Fri, 9 Aug 2013 14:19:30 -0700 (PDT)
In-Reply-To: <7vy58a4mcy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232032>

Confusion everywhere :-)

On Fri, Aug 9, 2013 at 10:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Antoine Pelisse <apelisse@gmail.com> writes:
>
>> So when we run:
>>
>> git clone hg::~/my/repo
>>
>> Git will remove the "hg::" part, and Mercurial will expand tilde and
>> clone $HOME/my/repo.
>
> Now you confused me.  If the implementation were for us to remove
> the hg:: prefix and let Mercurial do whatever it wants to do with
> the rest, you are right that we will not have to do any expansion
> like your patch.  But you sent a patch to do so, so apparently it
> is not what happens.  So where does it go wrong?
>
> Puzzled...

OK, I think I see why you are puzzled.

Cloning works fine because we "fix the path" *after* the clone is done
successfully, for the following reason:
If you run:

   git clone hg::./my_repo my_new_repo

The remote path will be hg::./my_repo, so we have to fix this path
(otherwise you won't be able to run git fetch from inside
my_new_repo). It's currently done by checking if ./my_repo is an
absolute path or not, and try to make it absolute if required.

But my issue is when I do that:

    git clone hg::~/my_repo my_new_repo

The clone works successfully by cloning $HOME/my_repo, but then, when
we try to fix the repo path, we think that ~/my_repo is not an
absolute path, so we make it absolute: /home/user/~/my_repo which is
now off. So I'm not able to fetch that remote.

What the current patch does, is to expand the tilde before checking if
the path is absolute. So that fixes the bug, but that indeed can be
confusing to another user that would expect hg::~/my_repo/ to *not be*
hg::$HOME/my_repo (because he knows the expansion should not happen in
that case).

>>> By the way, you earlier sent an updated 1/2; is this supposed to be
>>> 2/2 to conclude the two-patch series?
>>
>> Those two patches don't interact with each other, but you can of
>> course join them if it makes it easier for you (and I don't think one
>> is going to have to go "faster" than the other anyway).
>
> Hmph, so there is a different 2/2 that we haven't seen recently on
> the list (meaning you have three patches)?

I have 2 patch (1 from me, 1 from Felipe):
One with the tilde expansion, the other one with shared_path
initialization (which now conflicts with the resend from Felipe)

I will try to provide a better versioning of the patches next time.

Sorry for the confusion,
Thanks,
