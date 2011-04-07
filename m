From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: BUG? in --dirstat when rearranging lines in a file
Date: Thu, 7 Apr 2011 07:56:02 -0700
Message-ID: <BANLkTinEipewx2+Cx7Us0BSoSbjjU9uE6A@mail.gmail.com>
References: <201104071549.37187.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Apr 07 16:57:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7qdq-00008Q-L2
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 16:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754170Ab1DGO4u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Apr 2011 10:56:50 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41103 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754071Ab1DGO4t convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Apr 2011 10:56:49 -0400
Received: from mail-iy0-f174.google.com (mail-iy0-f174.google.com [209.85.210.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p37EuNin022394
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Thu, 7 Apr 2011 07:56:23 -0700
Received: by iyb14 with SMTP id 14so2538413iyb.19
        for <git@vger.kernel.org>; Thu, 07 Apr 2011 07:56:22 -0700 (PDT)
Received: by 10.42.155.136 with SMTP id u8mr1469625icw.403.1302188182150; Thu,
 07 Apr 2011 07:56:22 -0700 (PDT)
Received: by 10.231.11.4 with HTTP; Thu, 7 Apr 2011 07:56:02 -0700 (PDT)
In-Reply-To: <201104071549.37187.johan@herland.net>
X-Spam-Status: No, hits=-102.985 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171063>

On Thu, Apr 7, 2011 at 6:49 AM, Johan Herland <johan@herland.net> wrote=
:
>
> Consider the following sequence of commands:
> [...]
> $ git diff --stat
> =A0dir/file | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
> $ git diff --dirstat
> $ # WTF!?

So the "--dirstat" thing really is different - it has never done a
full patch, it really only does a line hash count and then estimates
the amount of deleted/new code from that.

> Is this a bug or a feature? :)

It's a "bueature" or a "featug". The dirstat code counts "damage" as
you noticed, and it does that because it's easy and often relevant. It
can be computed without actually generating the whole diff, the same
way we do rename-detection without actually generating the diff, by
just looking at "hash and count each line" information. In fact, it
uses the same "diffcore_count_changes()" function for it.

So the reason I wouldn't call it a bug is that it very much is on
purpose. Generating a real diff is much more expensive, and instead
using the line hashes gives us a quick and efficient O(n) way to
gather up differences. But because it does the difference by basically
just comparing hashes of the lines without taking _ordering_ into
account, it gives you a "how many lines do these files have in common"
rather than a real diff.

So git internally has *three* different "difference" engines:

 - the "delta" algorithm that we use for packing (and binary diffs)
 - the traditional line-based diff for normal diffs
 - the "rename/copy/dirstat damage detectior" that doesn't take line
ordering into account, only some unordered "heap of data contents"
comparison.

You could think of the damage detection as a "rename detection within
a file". It's actually quite nice for "git diff -M --dirstat", where
it means that pure code movement - whether inside a file or by
renaming a file - doesn't count as damage.

(Of course, moving a piece of code _from_ one file to another still
counts as damage, so it's not really ignoring pure code movement).

NOTE! Speed isn't the only reason we do that "unordered heap of data
contents" comparison. For rename detection, we really don't want
moving a big function around in a file to be counted as "rewriting the
file". So there are actually other reasons to like these semantics.
That said, honestly, for dirstat, the big issue was that it made it
really really simple. Look at how small the dirstat patch was (commit
7df7c019c2a4), and realize that it's because it just re-used the
existing damage counting code.

                            Linus
