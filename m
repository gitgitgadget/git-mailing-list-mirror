From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Ideas to speed up repacking
Date: Tue, 3 Dec 2013 10:27:09 +0700
Message-ID: <CACsJy8DJU2YTE1iNdb=fvo0fVOgLUK2mKXUhjcoJh8Ac0wW_EA@mail.gmail.com>
References: <201312021630.45767.mfick@codeaurora.org> <xmqqpppepxuu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Martin Fick <mfick@codeaurora.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 04:27:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VngeH-0007uT-Hz
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 04:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037Ab3LCD1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 22:27:41 -0500
Received: from mail-qc0-f172.google.com ([209.85.216.172]:55015 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025Ab3LCD1k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 22:27:40 -0500
Received: by mail-qc0-f172.google.com with SMTP id e16so1598788qcx.3
        for <git@vger.kernel.org>; Mon, 02 Dec 2013 19:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hI+Czl793ejWoknDy9XmstLIe/Smbk5iWmn9YVzhXok=;
        b=r8t5TFsTaadjglDXjUwKFI3ZnT3K4Mo679vUPm8zS5NAS6JQuPr5dxdesAGxrIPKTI
         I5iTXo08j1DrBqMkyyAYzzwCW0YUFW8vSfrERq+UD3U6FnWhcG1/QVGWPOfx3GYCW5n2
         XtKM/tEr7BfoDgxkd43EnNgWDvYZmU4zBZWo/bvhmvYKJHMwnpsZWIE6cjU5UUSlthMm
         hrIbQO6ZtJbFb0xM7uesJ4zuQLVHCgehhpcRXYszq/QfZlCw2Xo7IL0ZOq6gdimGFmoN
         T2SGl2gCofTVOhyzp7fJEgn6UV+81yBkd2J35WypSnWSwLlWQKwVHpa3tH5h6IQKWPeA
         aiKw==
X-Received: by 10.229.105.9 with SMTP id r9mr101545844qco.12.1386041260121;
 Mon, 02 Dec 2013 19:27:40 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Mon, 2 Dec 2013 19:27:09 -0800 (PST)
In-Reply-To: <xmqqpppepxuu.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238671>

On Tue, Dec 3, 2013 at 7:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> * Scenario 4:
>>
>>    Starts with Setup 1.  Add some loose objects to the repo
>> via a local fast forward ref update (I am assuming this is
>> possible without adding any new unreferenced objects?)
>>
>>
>> In all 4 scenarios, I believe we should be able to skip
>> history traversal and simply grab all objects and repack
>> them into a new file?
>
> If nothing else has happened in the repository, perhaps, but I
> suspect that the real problem is how you would prove it.  For
> example, I am guessing that your Scenario 4 could be something like:
>
>     : setup #1
>     $ git repack -a -d -f
>     $ git prune
>
>     : scenario #4
>     $ git commit --allow-empty -m 'new commit'
>
> which would add a single loose object to the repository, advancing
> the current branch ref by one commit, fast-forwarding relative to
> the state you were in after setup #1.
>
> But how would you efficiently prove that it was the only thing that
> happened?

Shawn mentioned elsewhere that we could generate bundle header in and
keep it in pack-XXX.bh file at pack creation time. With that
information we could verify if a ref has been reset, just fast
forwarded or even deleted.

> Also with Scenario #2, how would you prove that the new pack does
> not contain any cruft that is not reachable?  When receiving a pack
> and updating our refs, we only prove that we have all the objects
> needed to complete updated refs---we do not reject packs with crufts
> that are not necessary.

We trust the pack producer to do it correctly, I guess. If a pack
producer guarantees not to store any cruft, it could mark the pack
somehow.
-- 
Duy
