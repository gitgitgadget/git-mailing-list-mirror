From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/2] bisect per-worktree
Date: Mon, 03 Aug 2015 14:14:42 -0700
Message-ID: <xmqqvbcw6pml.fsf@gitster.dls.corp.google.com>
References: <1438387012-29229-1-git-send-email-dturner@twopensource.com>
	<55BC4438.8060709@alum.mit.edu>
	<CAPc5daVnfit8pkjc2HCSn0erW-q++We8gx8tPsb_ptd5H+CpJg@mail.gmail.com>
	<55BC6C5C.1070707@alum.mit.edu>
	<1438631396.7348.33.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 23:15:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMN4Z-0007bz-77
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 23:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbbHCVO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 17:14:58 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36168 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932420AbbHCVOo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 17:14:44 -0400
Received: by pacgq8 with SMTP id gq8so33278573pac.3
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 14:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=8j/94dHACoTb2rsBvrFEqPq8i9GzeIxyp25745cbIhM=;
        b=pjcO5t77XroFqCmwSxrNC5xL+ZZmN/VutnlZB8GW+WObbKIZ94tR8ZCxQurh4fmRrL
         y8vgBpmKO403Ot+VCcx1zUvR5S4+ncOxzD5wSJ/LmdOLFUmK2jbokPf+7d2LbxBRA4Lo
         gkR6VSjpiT1EGtg1cb3e5MdX1EvPlzhw4A7HwU0BhAmdc21ibUkRBlNSs495dENm4hE3
         neXxI1nc5P083J3E4Vxn+3jmpFnWslZi9cnFqs9PTNsLCHIxrPeyBNlv/yj9y1ru9+n3
         ObsW9lIel+2eddlsVKFtQC9Y9vb3s4awFEX1mHsaS5Bzt+b8maDGVcZHVhk1seheG53N
         ZFCA==
X-Received: by 10.68.162.99 with SMTP id xz3mr117334pbb.73.1438636483783;
        Mon, 03 Aug 2015 14:14:43 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:38a2:7ad5:137e:6e11])
        by smtp.gmail.com with ESMTPSA id wv4sm18582197pac.2.2015.08.03.14.14.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 03 Aug 2015 14:14:42 -0700 (PDT)
In-Reply-To: <1438631396.7348.33.camel@twopensource.com> (David Turner's
	message of "Mon, 03 Aug 2015 15:49:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275204>

David Turner <dturner@twopensource.com> writes:

> I think making this configurable is (a) overkill and (b) dangerous.
> It's dangerous because the semantics of which refs are per-worktree is
> important to the correct operation of git, and allowing users to mess
> with it seems like a big mistake.  Instead, we should figure out a
> simple scheme and define it globally.
>
> I think refs/worktree -> refs/worktrees/[worktree]/ would do fine as a
> fixed scheme, if we go that route.

OK.

> We would need two separate views of the refs hierarchy, though: one used
> by prune (and pack-refs) that is non-mapped (that is, includes
> per-worktree refs for each worktree), and one for general use that is
> mapped.   Maybe this is just a flag to the ref traversal functions.

True.  Alternatively we could just view refs/worktree/* as if they
are symbolic refs that point into refs/worktrees/$my_worktree/*, but
that would imply making the latter always visible to all worktrees,
which would hurt when people use it to interact with outside world
(namely, refs in other people's private area should probably not be
advertised).

> As I understand it, we don't presently do many transactions that include
> both pseudorefs or per-worktree refs and other refs.  And we definitely
> don't want to move pseudorefs into the database since there's so much
> code that assumes they're files.  Also, the vast majority of refs are
> common, rather than per-worktree.  In fact, the only per-worktree refs
> I've seen mentioned so far are the bisect refs and NOTES_MERGE_REF and
> HEAD.  Of these, only HEAD is needed for pruning. Are there more that I
> haven't thought of?

I myself have come up with nothing other than the above.  Let's hear
from others.

> So I'm not sure the gain from moving per-worktree refs into the database
> is that great.

I am on the same wavelength as you are on this.

> There are some downsides of moving per-worktree refs into the database:
> ...

All good points except #3, which I cannot judge if it is good or bad.

> ...
> Simply treating refs/worktree as per-worktree, while the rest of refs/
> is not, would be a few dozen lines of code.  The full remapping approach
> is likely to be a lot more.

We may be over-engineering with Michael's and even with the more
simpler refs/worktree/* -> refs/worktrees/$mine/* fixed mapping;
I tend to agree with you.
