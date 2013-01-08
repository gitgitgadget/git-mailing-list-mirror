From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/10] reroll of ap/log-mailmap
Date: Tue, 08 Jan 2013 00:02:49 -0800
Message-ID: <7vzk0kf6fq.fsf@alter.siamese.dyndns.org>
References: <1357603821-8647-1-git-send-email-gitster@pobox.com>
 <CALWbr2w8z2iVx2PxM2sn3yDQzB5rTXc4EuZD9GCKSCofHzEzLQ@mail.gmail.com>
 <7v4nisgm3l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 09:03:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsU9S-0007dH-7V
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 09:03:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986Ab3AHICy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 03:02:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60576 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751639Ab3AHICx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 03:02:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD8DF7223;
	Tue,  8 Jan 2013 03:02:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5BDIcP76nwn41Pb10Xoor1OS6o4=; b=UdvjI0
	k6XFEr6Hba0OeCGJjV0pMY/dcKb42Cemg/sJS5whz6dYVr5izxZ/92ixuCyoG5E9
	4K3tsa7EKlL9PQ+mG8SPgByPHVDhl9W58Z6R9uULGx/mPexKBLftqO/rcx4dGnV3
	rI1AuBUQfhKyaTM/MTSNu5qNTFG1GyEvy12jY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Be/wDzlffdxg1LVldR71dmatcNbO40pd
	C/aXrkVxxd1VtdsMBYz8MX0Y/BvZVqLYiKO5ID9M4LsQhsj/V6e4Xemj6+DIZoKu
	hIZd8XyUMAIvcgVnwbf7pdlH9MZsGFoNObKp22593OYfFLnTRR810xwpZEYoAvHj
	Omyl2bcIkpQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F0547222;
	Tue,  8 Jan 2013 03:02:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DBC6D7221; Tue,  8 Jan 2013
 03:02:50 -0500 (EST)
In-Reply-To: <7v4nisgm3l.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 07 Jan 2013 23:39:10 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CCED48E2-5969-11E2-8F51-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212944>

Junio C Hamano <gitster@pobox.com> writes:

> Antoine Pelisse <apelisse@gmail.com> writes:
>
>> Have you been able to measure a speed increase due to less copies ?
>
> No.
>
> This topic was not strictly my itch, but I did the rewrite because I
> couldn't stand staring at that *_extended() function ;-)

Now I have.  The overall numbers are larger primarily because the
kernel history has more commits than back when I did the previous
commit (thanks for reminding me of that one, by the way), but the
basic trend is the same.

The patch with updated numbers in the log is attached.

I am not absolutely sure about the correctness of the third patch in
the series; a review on the logic that uses the insertion point
search to implement the prefix match is very much appreciated.

Thanks.

-- >8 --
Subject: [PATCH] log --use-mailmap: optimize for cases without --author/--committer search

When we taught the commit_match() mechanism to pay attention to the
new --use-mailmap option, we started to unconditionally copy the
commit object to a temporary buffer, just in case we need the author
and committer lines updated via the mailmap mechanism, and rewrite
author and committer using the mailmap.

It turns out that this has a rather unpleasant performance
implications.  In the linux kernel repository, running

  $ git log --author='Junio C Hamano' --pretty=short >/dev/null

under /usr/bin/time, with and without --use-mailmap (the .mailmap
file is 118 entries long, the particular author does not appear in
it), cost (with warm cache):

  [without --use-mailmap]
  5.42user 0.26system 0:05.70elapsed 99%CPU (0avgtext+0avgdata 2005936maxresident)k
  0inputs+0outputs (0major+137669minor)pagefaults 0swaps

  [with --use-mailmap]
  6.47user 0.30system 0:06.78elapsed 99%CPU (0avgtext+0avgdata 2006288maxresident)k
  0inputs+0outputs (0major+137692minor)pagefaults 0swaps

which incurs about 20% overhead.  The command is doing extra work,
so the extra cost may be justified.

But it is inexcusable to pay the cost when we do not need
author/committer match.  In the same repository,

  $ git log --grep='fix menuconfig on debian lenny' --pretty=short >/dev/null

shows very similar numbers as the above:

  [without --use-mailmap]
  5.32user 0.30system 0:05.63elapsed 99%CPU (0avgtext+0avgdata 2005984maxresident)k
  0inputs+0outputs (0major+137672minor)pagefaults 0swaps

  [with --use-mailmap]
  6.64user 0.24system 0:06.89elapsed 99%CPU (0avgtext+0avgdata 2006320maxresident)k
  0inputs+0outputs (0major+137694minor)pagefaults 0swaps

The latter case is an unnecessary performance regression.  We may
want to _show_ the result with mailmap applied, but we do not have
to copy and rewrite the author/committer of all commits we try to
match if we do not query for these fields.

Trivially optimize this performace regression by limiting the
rewrites for only when we are matching with author/committer fields.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 2cce85a..d7562ee 100644
--- a/revision.c
+++ b/revision.c
@@ -2283,7 +2283,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 	if (buf.len)
 		strbuf_addstr(&buf, commit->buffer);
 
-	if (opt->mailmap) {
+	if (opt->grep_filter.header_list && opt->mailmap) {
 		if (!buf.len)
 			strbuf_addstr(&buf, commit->buffer);
 
-- 
1.8.1.304.gf036638
