From: Jaime Soriano Pastor <jsorianopastor@gmail.com>
Subject: Re: [PATCH] read-cache.c: Ensure unmerged entries are removed
Date: Thu, 14 Aug 2014 00:10:21 +0200
Message-ID: <CAPuZ2NFcJ5FFeJP=0-oG59fs=3ztenoPOGWOZKfZDdHpLGOYeA@mail.gmail.com>
References: <1407857491-16633-1-git-send-email-jsorianopastor@gmail.com>
	<1407857491-16633-2-git-send-email-jsorianopastor@gmail.com>
	<xmqq8umt5z8i.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 00:10:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHgkU-0007Lp-MU
	for gcvg-git-2@plane.gmane.org; Thu, 14 Aug 2014 00:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754AbaHMWKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 18:10:23 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:48237 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbaHMWKW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 18:10:22 -0400
Received: by mail-pa0-f42.google.com with SMTP id lf10so430656pab.29
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 15:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qXvagL437eE24bPoH4MVWYtCpd8Ag95Dchk+Ql+9drE=;
        b=mbXpKP79vVtlQDQFGmWoD7WZx5KIGyR/PzZgkNY8Rx/dQCVC2iKEuOh41mW3A7U6Vy
         nTjXy21lfTlZ+jV8qimRYvoHqqEKm+wEigDDgbiGeCA2zbshXIqaJsAVza9StC+gLYk0
         VZM/q7gz6m7SKyNppu3l3LDAmjvnY/f0j5dYImDtucTNN2a2UnwAzFRCPydR1jk0xo9W
         1BI+0ha+wLCcFVaWqkErTntERLeQM4w7+URV2Po7w8AbKQIu5KVnL2xfkdzEUagh9yXI
         L+Loi2iYsZADlDF+5vBMY1fCj5V5G0JNJNOTUje9yMPDbsfq+HCDhAMuSJKX9gKBHTmL
         5ryA==
X-Received: by 10.66.122.3 with SMTP id lo3mr432273pab.7.1407967821774; Wed,
 13 Aug 2014 15:10:21 -0700 (PDT)
Received: by 10.70.43.170 with HTTP; Wed, 13 Aug 2014 15:10:21 -0700 (PDT)
In-Reply-To: <xmqq8umt5z8i.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255256>

On Tue, Aug 12, 2014 at 8:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Jaime Soriano Pastor <jsorianopastor@gmail.com> writes:
>
> > Wrong implementations of tools that modify the index can left
> > some files as merged and unmerged at the same time. Avoid undesiderable
> > behaviours by handling this situation.
>
> It is understandable that the way _you_ decided to "handle the
> situation" is so obvious to be spelled out to _you_, but that is the
> most important design decision that needs to be described here.  Do
> you silently remove higher-stage entries when an entry at stage 0
> exists?  Do you silently remove stage 0 entry when higher-stage
> entries exist?  Do you error out without doing neither?
>

Sorry, I didn't explain my decission enough, and my knowledge of git
internals is not so good.
The idea of my proposal is to remove higher stage entries when, after
replacing an existing entry at stage 0, there are still entries in
higher stages.

In the problematic cases I've seen (specially git add and git reset
--hard) the final state of both, merged and unmerged files, is that
only an entry in stage 0 exists.
Also, the current implementation of git checkout -f silently removes
higher stage entries in this case.

>
> Silently removing these at runtime may not be something we would
> want to do; after all, we do not know if the broken tool actually
> wanted to have the higher stage entries, or the merged entry.
>

Yes, I have to agree on that, the user should have the final decission
about what stage entry to use, although I'm not sure if in the
previously commented cases there could be such an additional loss as
the operations that can be modified are already intended to silently
remove stage entries.

> Ideally, I think we should error out and let the users figure out
> how to proceed (we may of course need to make sure they have the
> necessary tools to do so, e.g. "git cat-file blob 0:$path" to
> resurrect the contents and "git update-index --cacheinfo" to stuff
> the contents into the stages).
>

I have also tried a couple of implementations of this patch with die()
and warning().
The implementation with die() would have a message like "There are
other staged versions for merged file", and maybe some recomendation
about how to see the blobs.
The warning implementation could return -1, what would prevent git add
to remove the higher-stage entries, but would still make git reset
--hard to clean the index as it seems that it does it anyway if it
manages to finish the call to read_index_unmerged.
Another option would be to print the deleted entries as a warning but
deleting them anyway.

Which option would be better? And what could be a good message?

BTW, I didn't know "git cat-file blob 0:$path", but I only manage to
get "Not a valid object name" fatals. How is it supposed to be used?

Thanks.
