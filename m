From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diffcore-rename: don't consider unmerged path as source
Date: Mon, 21 Mar 2011 01:06:25 -0700
Message-ID: <7vk4fsucce.fsf@alter.siamese.dyndns.org>
References: <1300412548-1724-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 09:06:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1a8R-0000H4-2t
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 09:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517Ab1CUIGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 04:06:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49579 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826Ab1CUIGf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 04:06:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6AF724261;
	Mon, 21 Mar 2011 04:08:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2PIDudqDvxG/xF3/5EcHyZ1bE7I=; b=Xbr40G
	ulPVdj7/rTJsAIRUwvPHoLV77s9X1ckJQIaCR3BUJ+2cp3y/ioNBOaVv+iVGN6Em
	TqIOpUQlVWcqeG8i9EzzofoQeHcpUuxZ6LW/k24TpgAkKCOLKzkA6VyIE+mQrL+j
	FKIeZ8cmmfR0EqBbVhapKKAcPnkf2Cfzk5trE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ooHiCuRvY3wXDWiKQ/qI2ia8jJkRXK/5
	Ap59ZiTvt61XPmaSJrsd5ho1SJ3J1/KJDe4foe/LX1sXM8nxZUbgVjCx8fIYQNwh
	A5nmDFmZWnavrR2LRZjfcuBppRYrG+/frZWRGWnZ45h9X5he8NyAyY5aFbM3CzLX
	jeLfqX474AU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 47F5A4260;
	Mon, 21 Mar 2011 04:08:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3AE2E425F; Mon, 21 Mar 2011
 04:08:05 -0400 (EDT)
In-Reply-To: <1300412548-1724-1-git-send-email-martin.von.zweigbergk@gmail.com> (Martin
 von Zweigbergk's message of "Thu, 17 Mar 2011 21:42:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5BD5237A-5392-11E0-BFFD-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169557>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> This is the first time I look at the diff code, so please review
> carefully. I think the changes make sense, but I really don't know the
> code enough to be sure.
>
> Also not sure about the "while at it" stuff...
>
> The test cases assume that the paths will be printed in a certain
> order. Can I rely on that?

I re-read the patch and found that the core of the patch, i.e. the change
to diffcore-rename.c, is basically sound.

I'd like to see the commit log message to describe the cause of the
breakage better.  Perhaps something like this:

  Since e9c8409 (diff-index --cached --raw: show tree entry on the LHS for
  unmerged entries., 2007-01-05), an unmerged entry should be detected by
  using DIFF_PAIR_UNMERGED(p), not by noticing both one and two sides of
  the filepair records mode=0 entries. However, it forgot to update some
  parts of the rename detection logic.

  This only makes difference in the "diff --cached" codepath where an
  unmerged filepair carries information on the entries that came from the
  tree.  It probably hasn't been noticed for a long time because nobody
  would run "diff -M" during a conflict resolution, but "git status" uses
  rename detection when it internally runs "diff-index" and "diff-files"
  and gives nonsense results.

  In an unmerged pair, "one" side can have a valid filespec to record the
  tree entry (e.g. what's in HEAD) when running "diff --cached". This can
  be used as a rename source to other paths in the index that are not
  unmerged. The path that is unmerged by definition does not have the
  final content yet (i.e. "two" side cannot have a valid filespec), so it
  can never be a rename destination.

  Use the DIFF_PAIR_UNMERGED() to detect unmerged filepair correctly, and
  allow the valid "one" side of an unmerged filepair to be considered a
  potential rename source, but never to be considered a rename destination.

Please split changes to wt-status.c (indentation and symbolic constant)
and builtin/commit.c (symbolic constant) to a single commit that is
separate from this fix, as we would want to backport the fix to older
maintenance tracks.

Also, please don't add a new test script 7510 that conflicts what is
already in flight ('pu' has t/t7510-commit-notes.sh).  Instead, tack
something like the following (and your diff-index tests) at the end of
t/t7060-wtstatus.sh, as you should be able to do this without actually
running a merge.

Answering the last question in the comment part of your message, the paths
are supposed to be shown in the name order, so your comparison (and the
comparison below) should be the right thing to do.

Thanks.



test_expect_success 'rename & unmerged setup' '
	git rm -f -r . &&
	cat "$TEST_DIRECTORY/README" >ONE &&
	git add ONE &&
	test_tick &&
	git commit -m "One commit with ONE" &&

	echo Modified >TWO &&
	cat ONE >>TWO &&
	cat ONE >>THREE &&
	git add TWO THREE &&
	sha1=$(git rev-parse :ONE) &&
	git rm --cached ONE &&
	(
		echo "100644 $sha1 1	ONE" &&
		echo "100644 $sha1 2	ONE" &&
		echo "100644 $sha1 3	ONE"
	) | git update-index --index-info &&
	echo Further >>THREE
'

test_expect_success 'rename & unmerged status' '
	git status -suno >actual &&
	cat >expect <<-EOF &&
	UU ONE
	AM THREE
	A  TWO
	EOF
	test_cmp expect actual
'
