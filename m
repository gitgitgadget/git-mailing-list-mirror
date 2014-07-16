From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v8 4/4] cache-tree: Write updated cache-tree after commit
Date: Wed, 16 Jul 2014 17:18:31 +0700
Message-ID: <CACsJy8BsoYP40K7vFoZhgXvy32vkHjhwCMYLFM6ishXcVXdzAA@mail.gmail.com>
References: <1405140276-32162-1-git-send-email-dturner@twitter.com>
 <1405140276-32162-4-git-send-email-dturner@twitter.com> <CACsJy8D0CdS5B5xNSSCk+LToXV9FnHFLkPzJ5f-7NTWiw9yn5w@mail.gmail.com>
 <xmqqr41oylyo.fsf@gitster.dls.corp.google.com> <53C41456.2000006@ramsay1.demon.co.uk>
 <xmqqvbqzygkm.fsf@gitster.dls.corp.google.com> <53C42453.1090109@ramsay1.demon.co.uk>
 <xmqq8unvy4bf.fsf@gitster.dls.corp.google.com> <CACsJy8BvQYyXWB7YfoonfEeqi9gStEZHqKC_JNAhxZbLJas54w@mail.gmail.com>
 <CAPc5daVH=i72Y4dA8TefPLfFB79Cvw7STPnQf_f10cBeYbg2ug@mail.gmail.com>
 <20140715102314.GA8273@lanh> <xmqqbnsqwoxz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 12:19:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7MIn-0000P6-UZ
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 12:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757996AbaGPKTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 06:19:04 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:34407 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755112AbaGPKTD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 06:19:03 -0400
Received: by mail-qg0-f53.google.com with SMTP id q107so534924qgd.12
        for <git@vger.kernel.org>; Wed, 16 Jul 2014 03:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yWnKc/QSS2Tme3q2e7YkIY/f7+Z5Hc+9upx5brn4f5w=;
        b=IR28jGzp+wuDYRCH1ZBt5JxDvvfstnYgr0M7P68Wa3YXQcL6G75xtcxWiG/nE2qF25
         NLiFGRuVSaDAVLPT+Rf2mT7y01Idg8ku46t/a5CU3+G7fVq05kot9Kr41O9E0yRY7R5B
         GG+Ca3+3tec2Pq3qQg56fn6bsyy8w7el6b+txZdGudeimzfOucr/HV0pnfJJzpnpwZZy
         orSJ9A9F6UzTxzLadWrNeFymCVLORt238b8uaoyC9GlD7TQLjJ6M+8igoqvKundEFGOq
         ZE36QsLd4+TbrQSTKB7OxuBYB4Yg/s/wOZX9p4wsR59OSK4XqjlicwQz/bk4aoX4dkif
         Qx/w==
X-Received: by 10.140.109.118 with SMTP id k109mr43026445qgf.98.1405505941682;
 Wed, 16 Jul 2014 03:19:01 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Wed, 16 Jul 2014 03:18:31 -0700 (PDT)
In-Reply-To: <xmqqbnsqwoxz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253660>

On Tue, Jul 15, 2014 at 11:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> What is the real point of "writing into *.lock and renaming"?  It
> serves two purposes: (1) everybody adheres to that convention---if
> we managed to take the lock "index.lock", nobody else will compete
> and interfere with us until we rename it to "index". (2) in the
> meantime, others can still read the old contents in the original
> "index".
>
> With "take lock", "write to a temporary", "commit by rename or
> rollback by delete", we can have the usual transactional semantics.
> While we are working on it, nobody is allowed to muck with the same
> file, because everybody pays attention to *.lock.  People will not
> see what we are doing until we release the lock because we are not
> writing into the primary file.  And people can see what we did in
> its entirety once we are done because we close and rename to commit
> our changes atomically.

True.

> Think what CLOSE_LOCK adds to that and you would appreciate its
> usefulness and at the same time realize its limitation.  By allowing
> us to flush what we wrote to the disk without releasing the lock, we
> can give others (e.g. subprograms we spawn) controlled access to the
> new contents we prepared before we commit the result to the outside
> world.  The access is controlled because we are in control when we
> tell these others to peek into or update the temporary file "*.lock".
>
> The original implementaiton of CLOSE_LOCK is limited in that you can
> do so only once; you take a lock, you do your thing, you close, you
> let (one or more) others see it, and you commit (or rollback).  You
> cannot do another of your thing once you close with the original
> implementation because there was no way to reopen.

This is probably where our opinions differ. Yes, if you are sure
nobody else is looking at the lock file any more, then you can do
whatever you want. And because this is a .lock file, nobody is
supposed to look at it unless you tell them too (in contrast
$GIT_DIR/index can be read at any time). The format of the index makes
it impossible to just edit one byte and be done with it. You always
write a full new file. By sticking to transaction-style update, you
need no extra code, and you have a back up file as a side effect.

> What do you gain by your proposal to lock "index.lock" file?  We
> know we already have "index.lock", so nobody should be competing on
> mucking with its contents with us and we gain nothing by writing
> into index.lock.lock and renaming it to index.lock.  We are in total
> control of the lifetime of index.lock, when we spawn subprograms on
> it to let them write to it, when we ourselves write to it, when we
> spawn subprograms on it to let them read from it, all under the lock
> we have on the "index", i.e. "index.lock".
>
> The only thing use of another temporary file (that does not have to
> be a lock on "index.lock", by the way, because we have total control
> over when and who updates the file while we hold the "index.lock")
> would give you is that it allows you to make the success of the "do
> another of your thing" step optional.  While holding the lock, you
> close and let "add -i" work on it, and after it returns, instead of
> reopening, you write into yet another "index.lock.lock", expecting
> that it might fail and when it fails you can roll it back, leaving
> the contents "add -i" left in "index.lock" intact.  If you do not
> use the extra temporary file, you start from "index.lock" left by
> "add -i", write the updated index into "index.lock" and if you fail
> to write, you have to roll back the entire "index"---you lose the
> option to use the index left by "add -i" without repopulated
> cache-tree.  But in the index update context, I do not think such a
> complexity is not necessary.  If something fails, we should fail and
> roll back the entire "index".

I probably look at the problem from a wrong angle. To me the result of
"commit -p" is precious. I'm not a big user of "commit -p" myself as I
prefer "add -p" but it's the same: it'd be frustrating if after you
have carefully added your chunks, the program aborts and you have to
start over. And not just a few chunks. Think of reviewing .po files
and approve strings by the means of adding them to the index. Perhaps
because _I_ as a developer see this cache-tree update step optional
and react to it unnecessarily. Ordinary users won't see any
difference. And perhaps a better way to save the result of "commit/add
-p" is some sort of index log, not be over-protective at this
"interactive commit" code block.

I don't feel strongly either way. So your call.
-- 
Duy
