Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600BCC77B7E
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 15:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbjFAPbI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 11:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbjFAPbA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 11:31:00 -0400
X-Greylist: delayed 611 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Jun 2023 08:30:38 PDT
Received: from new-athena.mit.edu (unknown [18.1.104.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A6D1107
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 08:30:37 -0700 (PDT)
Received: by new-athena.mit.edu (Postfix, from userid 32861)
        id D011616003C; Thu,  1 Jun 2023 11:20:25 -0400 (EDT)
From:   =?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@mit.edu>
To:     newren@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: Problems with 592fc5b349
Date:   Thu,  1 Jun 2023 11:20:25 -0400
Message-Id: <20230601152025.116126-1-asedeno@mit.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CABPp-BHKR5GP2NUFWDMSw-Pnra+yGP0kYAiwu-iWgtu66p-1RQ@mail.gmail.com>
References: <CABPp-BHKR5GP2NUFWDMSw-Pnra+yGP0kYAiwu-iWgtu66p-1RQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, June 1, 2023 at 10:33AM Elijah Newren <newren@gmail.com> wrote:
> Oh, interesting; none of our platform testing caught this.  After a
> little digging, I'm guessing you're on cygwin < 1.7?  However, I'm
> still surprised you noticed, on any platform.  The only use of the
> DT_* defines in cache.h is in the inline function ce_to_dtype().  The
> only places ce_to_dtype() is used are in (1) unpack-trees.c (which
> includes both cache.h and dir.h) and (2) builtin/ls-files.c (which
> also includes both cache.h and dir.h).  So, as far as I can tell, this
> can't cause compilation issues anywhere.  How did you find this?

I build on an ancient Solaris (5.10), for reasons. One day I'll give up
on it, but today is not that day.

> In commits in follow-on series, I moved this inline function to a new
> header, read-cache.h.  name-cache.c does not end up including that
> header, so we could add a #include "dir.h" directive to read-cache.h.

> An alternative fix, if you need something for v2.41.0 (am I guessing
> correctly that you tried out v2.41.0 right after it's release and
> that's when you found this?), would be to move the DT_ defines from
> dir.h to statinfo.h (a header included by both dir.h and cache.h).

Yeah, I built v2.41.0 this morning and saw that my sun4x_510 build
failed with DT_REG not defined in cache.h while building
add-interactive.c I tried the patch I described earlier (add dir.h
to cache.h) and ran into the duplicate `struct dir_entry` in
name-hash.c. I'm testing a patch where I move DT_ definitions into
a new dtype.h, and include it where needed, but statinfo.h seems
resonable.


> ... Or
> perhaps another fix is to stop having two things in the codebase named
> "struct dir_entry", since it's bound to cause confusion for humans if
> not also be a lurking timebomb for some future code file that needs
> access to both.

Agreed, though I did not want to pull on that particular thread for fear
of what else might unravel.

> ... But I still don't understand why any suggestions are
> needed for an immediate fix, since all users of ce_to_dtype() should
> have the necessary headers.  Is there an issue where "inline" is
> ignored, and this function is being defined & compiled for every file
> that includes cache.h, and then the linker removes the duplicates or
> something?

I could believe that gcc 3.4.3 (again, ancient), is not being as clever
as newer compilers here.

-Alejandro
