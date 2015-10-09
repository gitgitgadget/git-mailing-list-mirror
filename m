From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Reinstate the helpful message when `git pull --rebase` fails
Date: Fri, 09 Oct 2015 11:15:15 -0700
Message-ID: <xmqqk2qvq570.fsf@gitster.mtv.corp.google.com>
References: <cover.1444336120.git.johannes.schindelin@gmx.de>
	<xmqq612grhg7.fsf@gitster.mtv.corp.google.com>
	<CACRoPnSPVMt+FtK6bwfa7Z3jBheTEkBnhU+B7qL8JrAsSmAmkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Brendan Forster <shiftkey@github.com>,
	Git List <git@vger.kernel.org>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 20:15:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkcCR-0001UM-KJ
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 20:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754917AbbJISPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2015 14:15:19 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33487 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754795AbbJISPR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2015 14:15:17 -0400
Received: by pacex6 with SMTP id ex6so93310677pac.0
        for <git@vger.kernel.org>; Fri, 09 Oct 2015 11:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=/0wbQ1mauPIHnebd8/jjrqeW1nNemM0Oyb/C//IyLmk=;
        b=OuFlKvp3Uvikfk1ncgCmFPLPNrr6wHgBGQzcCgtLXLNVK0rAAeZcBXverdsA+c3KEo
         5pHNKpN4NWgxqFsAB4y6gJtmm+kuLHAO1S+0UouBwO00ovGwqXHuyr1UCDwVOGIw19ns
         +9Mrk637pwcbncGlXgX6oVCzUeY6C+mz8jc/w0fO4W1eeVEN+Jy1KPpyJ0+YqVhCACJC
         EjTR84Nqca6vv++I5Xn24/murCsxiCig8iAAHTIHvmj2f7oevDm9mPF7POym583gU8m9
         XFM80ddRGOFki/7KJ4i6BIl/6FdV8/6NarVbOapoBK73Eo9SK+Fl1qXUBks1xIC+bTZ2
         bU1g==
X-Received: by 10.68.197.97 with SMTP id it1mr16693620pbc.4.1444414517318;
        Fri, 09 Oct 2015 11:15:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:6d9f:e45b:5c65:e644])
        by smtp.gmail.com with ESMTPSA id we9sm3775665pab.3.2015.10.09.11.15.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 Oct 2015 11:15:16 -0700 (PDT)
In-Reply-To: <CACRoPnSPVMt+FtK6bwfa7Z3jBheTEkBnhU+B7qL8JrAsSmAmkQ@mail.gmail.com>
	(Paul Tan's message of "Fri, 9 Oct 2015 09:40:58 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279311>

Paul Tan <pyokagan@gmail.com> writes:

> That said, I do agree that even if we die(), we could try to be more
> helpful by printing additional helpful instructions.
>
>> If that is the case, I'd thinkg that we'd prefer, as a regression
>> fix to correct "that", i.e., let recursive-merge die and let the
>> caller catch its exit status.
>
> We could do that, but I don't think it would be worth the overhead to
> spawn an additional process for every patch just to print an
> additional message should merge_recursive() call die().

For a thing that (1) has to be run every time in the whole operation
and (2) is a very small operation itself whose runtime cost can be
dwarfed by cost of spawning on some platforms, it is clearly better
to run it internally instead of running it via run_command()
interface.  This is especially so if it (3) wants to just kill the
whole operation when it finds a problem anyway.  For example, it
would be crazy to run "update-ref" via run_command() in the "am"
that is rewritten in C.

But does the same reasoning apply to the use of merge-recursive in
"am -3" codepath, where it (1) runs only as a fallback when straight
application of the patch fails, (2) runs a heavy-weight recursive
merge machinery, and (3) now a regression is pointed out that it
wants to do more than just calling die() when there is a problem?

You seem to be viewing the world in black-and-white and thinking
that run_command() is unconditionally bad.  You need to stop doing
that.  Instead, view it as another tool that gives a much better
isolation from the main flow of logic (hence flexiblity) that comes
with a bigger cost.  I am not convinced with your "I don't think it
would be worth".

> Instead, stepping back a bit, I wonder if we can extend coverage of
> the helpful message to all die() calls when running git-am. We could
> just install a die routine with set_die_routine() in builtin/am.c.
> Then, should die() be called anywhere, the helpful error message will
> be printed as well.

That could certainly be a valid approach and may give us a better
end result.  If it works, it could be a change that is localized
with a lot less impact.

Thanks.
