From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH/RFC v2] Squashed changes for multiple worktrees vs. submodules
Date: Fri, 5 Dec 2014 08:32:00 +0200
Message-ID: <CAF7_NFQzPDF+7NS2VwopK8Oei=9NzWEAGM5fko-St5KvvmLa9A@mail.gmail.com>
References: <1417390076-2953-1-git-send-email-max@max630.net>
	<547E24E4.7050100@web.de>
	<20141202221611.GB9128@wheezy.local>
	<5480BEB9.8070109@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Dec 05 07:41:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwma4-0004CI-C9
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 07:41:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbaLEGcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 01:32:04 -0500
Received: from mail-wg0-f53.google.com ([74.125.82.53]:51696 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbaLEGcB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 01:32:01 -0500
Received: by mail-wg0-f53.google.com with SMTP id l18so66476wgh.26
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 22:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=NJJo0735EW6W1iEYRgOGuFI5e8AAh7611mnUtrRnyJ8=;
        b=bzIIaFE0Y9+AKyZw6Zng0XHT9Jgg+8fFXeFQ95b+8nQZEOIzSfWbJXtckDWabVkQFP
         GDjzFceoi+QtXVSwMP4DkabjjnQO1dAA5LDpB8++oZ69W8oI1++4zDqemIBQq/zKQBVT
         N/KXW478V33TZqwzcYhzMagNfkRgUtexr2vqgAw5dOuWFSGEpdO2TK22fXjMUIqJNy/p
         6VLyZISom/9zIjAPvtSWw9oxmBJbZU52NngpBkT8o7YkQrebO4ulgytE1wxEEIQHafcn
         Z/Bn4oz0wDdAQ6VUQNhsHnV1oDwUTjGUYVUUkFOVqJJdkfsvyPrOC0+LP33COUIymQzK
         cY8A==
X-Received: by 10.194.189.240 with SMTP id gl16mr20888812wjc.119.1417761120459;
 Thu, 04 Dec 2014 22:32:00 -0800 (PST)
Received: by 10.180.75.179 with HTTP; Thu, 4 Dec 2014 22:32:00 -0800 (PST)
In-Reply-To: <5480BEB9.8070109@web.de>
X-Google-Sender-Auth: OmCsWNfYrcAOnmvbCg9kxpKcq7s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260858>

On Thu, Dec 4, 2014 at 10:06 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> But I'd need to have separate settings for
> our CI server, e.g. to checkout the sources without the
> largish documentation submodule in one test job (=worktree)
> while checking out the whole documentation for another job
> building the setup in another worktree.

Currently I'm estimating approach when submodules which have .git
file or directory inside are updated, and those which do not have it are not.
I have added a config variable submodule.updateIgnoringConfigUrl (because
usually the submodule.<name>.url is what turns on the update). It looks working,
maybe I even add setting the variable when chackout --to is used.

> And if I understand the "checkout: reject if the branch is
> already checked out elsewhere" thread correctly, I won't be
> able to build "master" in two jobs at the same time?

You are alerady second person complaining about it, but I don't really see
how this can be a problem. Make a branch 'master2', it's another 40 bytes.

> So two reasons against using multiple worktrees on our CI
> server to save quite some disk space :-(

My use is not to save space (working tree files often takes more than
the repository
itself), but for development, I have like 3-5 checkouts usually, which
used to be local
clones, but not having to keep synching them is really life changing.

> Thanks. But I changed my mind about the details (now that I
> know about .git/config and multiple worktrees). I think you'd
> have to connect a .git directory in the submodule to the
> common git dir directly, as you cannot use the core.worktree
> setting (which could be different between commits due to
> renames) when putting it into <worktree>/.git/modules. And
> then you couldn't remove or rename a submodule anymore,
> because that fails when it contains a .git directory.

I need to think more about it.

> Seems like we should put a "Warning: may do unexpected things
> when used with submodules" (with some examples about what might
> happen) in the multiple worktrees documentation. And I don't
> believe anymore that teaching submodules to use the common git
> dir makes that much sense after I know about the restrictions
> it imposes.

btw, I thought even about making it an error to add/remove/(de)initialize
submodule not in the main working tree. But I'm afraid it would not be
considered appropriate for merging.

-- 
Max
