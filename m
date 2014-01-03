From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: [PATCH/RFC] Introduce git submodule add|update --attach
Date: Fri, 3 Jan 2014 09:49:01 +0100
Message-ID: <CALas-iiF7Og8qjWoYeop3GofG_kR7w5DDcNkA1y3eQhu1Srxkw@mail.gmail.com>
References: <1388368184-18418-1-git-send-email-ceztko@gmail.com>
 <xmqqppoap2qb.fsf@gitster.dls.corp.google.com> <CALas-ihAkUGOZsmWRHN7fG+5D0OnpWmSNtrMH2mwNm51gcYdRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 03 09:49:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vz0Rg-00074g-SS
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 09:49:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbaACItX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 03:49:23 -0500
Received: from mail-ob0-f171.google.com ([209.85.214.171]:56790 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbaACItW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 03:49:22 -0500
Received: by mail-ob0-f171.google.com with SMTP id wp18so15395649obc.2
        for <git@vger.kernel.org>; Fri, 03 Jan 2014 00:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4oSTaTqa4bAsA0TEz4LNdwCE+UC6WQ3a7o0DTUDJvKs=;
        b=N4EpFksbu5M97O6xmH0CKwRmq4louW+DCj/+bOBCcyQxCR7SZzMw0NpSfNIIwpAqAf
         xhl4T1p1S1QnzSN//XZ+D9cBgYSmpfI5mQKUIxVVL7DBU+EOJ0KVDnAU1kJLMlguetJ9
         u26c9ABgbgh4bgUd3f6TK4dpCikZhKGuNCZpaBFFHjDoH/PiBwgq8DWa0qcXAaxQZ5ef
         p0JZCMlVYTHrpDK2TeJAEnqKnQnRHNK/wpNDoSg/XyViJ+k2jUDquzCxCxP7+VhsRQzX
         /9L+odlqU0UzOCsXlbI/QYadP4mPyHfpbb1vM23v+Aab1o0rD50UW3Q0KtSBgGNImCwL
         5TDg==
X-Received: by 10.60.73.36 with SMTP id i4mr22342337oev.1.1388738961780; Fri,
 03 Jan 2014 00:49:21 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Fri, 3 Jan 2014 00:49:01 -0800 (PST)
In-Reply-To: <CALas-ihAkUGOZsmWRHN7fG+5D0OnpWmSNtrMH2mwNm51gcYdRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239911>

2014/1/3 Francesco Pretto <ceztko@gmail.com>:
> Concluding, my point is that at the current state submodules in git
> seem to be flawed because of the inconsistent HEAD state between "add"
> and "update" users. With my patch applied the attached HEAD behavior
> would be fully supported. At some point "git submodule add" (without
> the "--attached" switch) could be also modified to produce a detached
> HEAD by default, removing any remaining inconsistency.

Junio, please let me amend this affirmation as it's inaccurate.
According to the current *upstream* features this should the supported
use case for submodules:
- there's a maintainer "add" user that adds the submodule. He will
need to track the upstream submodule revision sha1, so he will clone
the repository with an *attached* HEAD;
- there's a developer "update" use that just clone the submodule
repository and track the sha1 decided by the maintainer "add" user. He
won't need to track upstream submodule revision sha1 so cloning the
repository with a *detached* HEAD. Subsequent "merge" or "rebase"
update operations will keep the HEAD detached.

We should *not* modify/break this default workflow in any way.

The current documentation seems to be misleading when saying that
"This [the update command] will make the submodules HEAD be detached
**unless** --rebase or --merge is specified", as it seems to imply
that the update operation will result in a repository with the HEAD
attached. The repository will be indeed updated merging changes, but
the HEAD will stay detached.

Now, the use case I would like git to support is this:
- there's a maintainer "add" user that adds the submodule. He won't
track the upstream submodule revision sha1, so
"submodule.<module>.ignore" will be set to "all". He will still clone
the repository with an *attached* HEAD;
- there's a developer "update" user. He will clone the submodule
repository with an *attached* HEAD. Subsequent "merge" or "rebase"
update operations will keep the HEAD attached.

To fully support this workflow in my patch I want to:
- introduce a "submodule.<module>.attach" property so "update" users
will clone the submodule repository with an attached HEAD;
- introduce "--attach|--dettach" switches to "update" commmant to
eventually override "submodule.<module>.attach" property value in the
command line;
- introduce "--attach" (but better rename it to "--keep-attached" or
something else) switch to the "add" operation. This "--keep-attached"
will:
    * set "submodule.<module>.attach" to true;
    * set "submodule.<module>.ignore" to all.

Being the workflow complementary, and the behavior fully optional, I
think the proposed feature should be solid. Give me some time to
produce an improved patch and let see if I can convince you.

Regards,
Francesco
