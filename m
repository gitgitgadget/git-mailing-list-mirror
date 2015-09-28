From: Junio C Hamano <gitster@pobox.com>
Subject: Re: broken racy detection and performance issues with nanosecond file times
Date: Mon, 28 Sep 2015 11:17:19 -0700
Message-ID: <xmqqtwqecssw.fsf@gitster.mtv.corp.google.com>
References: <5605D88A.20104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 20:17:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgczP-00009c-6l
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 20:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757431AbbI1SRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 14:17:22 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33504 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757366AbbI1SRV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 14:17:21 -0400
Received: by pacex6 with SMTP id ex6so180984075pac.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 11:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=C4bZLF9b0UblaMSySgyRGC+2rGYS9IE087aKhzKZohU=;
        b=NVqiH9W2HYcIv6+lyOtJ24q8qiejJsL5yw0/UocQkY35twnn62B6Z3jA9xkmN/J9J1
         jnS/uTYkIGxzsYyAy9zp4Oj//mIJGE3ZVW8Ot+SGaFcM2cDiuapruFEMbz71jzlF0wwR
         90NUfK7KMtL3wy/mMHlQa0Auheg+2l15dTyYbUYqEkAlMJKLTzFWbv6LT3hsS+Qr94ok
         KuQxJJbFZ0hqGMGNLIMcFhJHCUaVPp5RFatX4A2QTYLCTML0l1Yi0hCS02GgL0wsFKpa
         xzI3bznjvEm+dqu0SZRTv67h3lgRiwcBA1C9WT6++ihzQbUUYp5DUO6ZKsb+fW+ogs/5
         xF6w==
X-Received: by 10.66.155.231 with SMTP id vz7mr27648825pab.58.1443464240885;
        Mon, 28 Sep 2015 11:17:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:66:24f2:2685:8011])
        by smtp.gmail.com with ESMTPSA id ey17sm20833798pac.26.2015.09.28.11.17.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Sep 2015 11:17:20 -0700 (PDT)
In-Reply-To: <5605D88A.20104@gmail.com> (Karsten Blees's message of "Sat, 26
	Sep 2015 01:28:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278740>

Karsten Blees <karsten.blees@gmail.com> writes:

> Ideas for potential solutions:
> ==============================
>
> Performance issues:
> -------------------
>
> 1. Compare file times in minimum supported precision
>    When comparing file times, use the minimum precision supported by
>    both the writing and reading git implementations.
> 1a. Simplest variant: Don't compare nanoseconds if the field in the
>    cached index entry is 0. JGit already does this [5], but at the
>    same time it is very unfriendly to USE_NSEC-enabled git by storing
>    only milliseconds in the nanosecond field. This "simple" solution
>    implies that git implementations that cannot provide full
>    nanosecond precision must leave the nanosecond field empty.
> 1b. More involved: Store the precision in the index entry.
>    We only need 30 bits to encode nanoseconds, so the high 2 bits of
>    the nanosecond field could be used as follows:
>    00: second precision (i.e. ignore, for backward compatibility)
>    01: millisecond precision
>    10: microsecond precision
>    11: nanosecond precision
>    When reading the index, USE-NSEC-enabled git implementations would
>    do dirty checks with the minimum precision supported by themselves
>    and the creator of the index entry.

Yeah, my gut feeling is that we should make sure that at least 1a is
done by all implementations.

I agree that 1b. is a bit more involved in that all binary that was
built with USE_NSEC that is not aware of these 2-bits need to be
eradicated for a new version to be deployed --- the transition for
users who use multiple implementations will be a pain (those that
use just one implementation of Git can just say "rm -f .git/index &&
git reset --hard" or something after updating to the new version of
Git).

> 2. Don't use ctime in dirty checks if ctime.sec == 0.

OK.  That is slightly less drastic than !trust_ctime, I guess.

> Racy detection:
> ---------------
>
> 3. Minimal racy solution
>    * Do all racy checks with second-precision only.
>    * When committing an index.lock file, reset mtime to the time
>      before git started reading the old index (i.e. time(null) when
>      calling read_cache()).
>
>    I believe this should fix all three racy problems described above,
>    although restraining ourselves to second-precision somewhat
>    thwarts the ability to track nanoseconds in the first place.
>    
>    The problem with this solution is that files changed by git itself
>    will appear racy to the next git process, thus increasing the
>    performance penalty after e.g. a large checkout. Although I think
>    that re-reading the file after the file's mtime is the only way to
>    be really sure it hasn't been changed.

... the last of which is what is done anyway, so I think the above,
especally the second bullet-point, is all sensible.
