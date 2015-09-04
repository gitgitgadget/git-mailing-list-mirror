From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: More builtin git-am issues..
Date: Fri, 4 Sep 2015 16:47:10 -0700
Message-ID: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 01:47:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZY0ha-0001uH-3C
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 01:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934130AbbIDXrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 19:47:12 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:34225 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934125AbbIDXrL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 19:47:11 -0400
Received: by iofb144 with SMTP id b144so40588919iof.1
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 16:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:cc:content-type;
        bh=5Ss6l3FWpB2jLruoGiB/3sYWTDSD2aa4x1/yDG2CPGc=;
        b=Wca6bzd7poWgaMheD6iTrZW2NqPVh0GrvhF6Qw5WAc4bYn9bMVeMRxfmNA7fnnUlRu
         drCPnpbIqCxkypq6NleJNa41EyBVV1p5QLmxIBIAAUll8KTqG28tNM76FXNyKFS+yjRc
         IkBOAkLlOwPpayMk3FcyEL7qZd9A6lTFx9stpASC2NxQ2mCRjEITOKfvw/cnl6E51iD+
         4TW4xthtKAtTJz/DlWcp3FGKVqoXqkJuNH4Z1U+HsvQe9nP/dPAL2JQjFuC8YDNOBlnm
         4G/FLg0LzASeqKw4NWYUc4wPMp/SXCao5RFUEAOegtVPwuVQM8mrZ+zxsS6HywxyjSkp
         njWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:date:message-id:subject:from:to:cc:content-type;
        bh=5Ss6l3FWpB2jLruoGiB/3sYWTDSD2aa4x1/yDG2CPGc=;
        b=GSDnmdivzJpRDZS+RijHCpk7iJE/P4vJ7xEe1A+sI4EAh42cH5uSJeEJj7aVHR1TUw
         N9oAnp+JFIUG/X+ZD65A6S9VlXbklY3IIeKENBF95ipkKKLNBs5gji06G5s2nzGF+aJo
         eFxDj0Y2edzDfDRZ8roCmExnjq8TjgxER4AT0=
X-Received: by 10.107.15.170 with SMTP id 42mr8928553iop.137.1441410430463;
 Fri, 04 Sep 2015 16:47:10 -0700 (PDT)
Received: by 10.36.124.195 with HTTP; Fri, 4 Sep 2015 16:47:10 -0700 (PDT)
X-Google-Sender-Auth: GEmtUSam1FskRc_FYHj_OOzIbUQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277348>

Ok, this may not be new either, but I'm trying to be careful when
using "git am" these days, because I know it got rewritten.

And I _think_ the whitespace handling for adding sign-offs got scrogged.

I just applied the usual patch-bomb from Andrew, and several of the
commits (but not all) end up looking like this:

    Cc: <stable@vger.kernel.org> [3.15+]
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

note the extraneous whitespace line between Andrew's sign-off and mine.

What's odd is that the emails I'm applying literally don't have that
extra empty line, so it's git that somehow decides to add it.  Only
for a few cases, though.

The pattern *seems* to be that git now looks at the *first* line of
the sign-off block and decides that "this is a sign-off block if that
first line has a sign-ff on it, ie this is fine:

    Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
    Cc: Pavel Emelyanov <xemul@parallels.com>
    Cc: Dave Hansen <dave.hansen@intel.com>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

but the failing cases have a comment by Andrew:

    [akpm@linux-foundation.org: coding-style fixes]
    Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
    Cc: Xishi Qiu <qiuxishi@huawei.com>
    Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
    Cc: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
    Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
    Cc: Gu Zheng <guz.fnst@cn.fujitsu.com>
    Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
    Cc: Vlastimil Babka <vbabka@suse.cz>
    Cc: Mel Gorman <mgorman@techsingularity.net>
    Cc: David Rientjes <rientjes@google.com>
    Cc: <stable@vger.kernel.org>        [4.2.x]
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

ie that "[akpm@linux-foundation.org: coding-style fixes]" makes git am
now decide that the previous block of text was not a sign-off block,
so it adds an empty line before adding my sign-off. But very obviously
it *was* a sign-off block.

Maybe this isn't new at all, and it's just that I notice because I'm
looking for "git am" oddities.  Something is clearly wrong in
"has_conforming_footer()".

I *think* it's this part:

                if (!(found_rfc2822 ||
                      is_cherry_picked_from_line(buf + i, k - i - 1)))
                        return 0;

which basically returns 0 for _any_ line in the footer that doesn't
match the found_rfc2822 format.

I really think that if we find any "Signed-off-by:" in that last
chunk, we should not add a whitespace.

Comments?

                    Linus
