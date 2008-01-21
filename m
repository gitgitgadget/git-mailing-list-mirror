From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's not in 'master', and likely not to be in, until 1.5.4
Date: Sun, 20 Jan 2008 23:02:23 -0800
Message-ID: <7vtzl71x1c.fsf@gitster.siamese.dyndns.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	<7v1w8o4ws0.fsf@gitster.siamese.dyndns.org>
	<30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com>
	<7v63xzzszp.fsf@gitster.siamese.dyndns.org>
	<478855B5.9070600@gmail.com>
	<7vbq7ry405.fsf@gitster.siamese.dyndns.org>
	<47885B2C.8020809@gmail.com>
	<7v7iify2wm.fsf@gitster.siamese.dyndns.org>
	<4788BFA8.2030508@gmail.com>
	<7vwsqeubj8.fsf@gitster.siamese.dyndns.org>
	<47891658.3090604@gmail.com>
	<7vbq7qssd7.fsf@gitster.siamese.dyndns.org>
	<47893E1A.5020702@gmail.com>
	<7v4pdislrf.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	<7vir1xmazm.fsf@gitster.siamese.dyndns.org>
	<7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org>
	<7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org>
	<7vr6gb3nv1.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801202114580.2957@woody.linux-foundation.org>
	<7vd4rv3ds5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 08:03:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGqga-0008JR-1S
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 08:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756122AbYAUHCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 02:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753322AbYAUHCm
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 02:02:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59807 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbYAUHCl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 02:02:41 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B8493567;
	Mon, 21 Jan 2008 02:02:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 118C03566;
	Mon, 21 Jan 2008 02:02:35 -0500 (EST)
In-Reply-To: <7vd4rv3ds5.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 20 Jan 2008 22:15:22 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71233>

Junio C Hamano <gitster@pobox.com> writes:

> It's a Heisenbug.  I actually merged it to 'next' but rewound it
> before pushing the result out after seeing a breakage.
>
> "make clean test" to run everything through sometimes fails and
> immediately after that when I do "cd t && sh t75??-???.sh -i -v"
> it happily runs through the end.
>
> I'll be back with more details when I have some.

In t7501-commit.sh, "partial commit that involves removal (1)"
test, it _sometimes_ fails.

    test_expect_success 'partial commit that involves removal (1)' '

        git rm --cached file &&
        mv file elif &&
        git add elif &&
        git diff-index --name-status HEAD >changes &&
        git commit -m "Partial: add elif" elif &&
        git diff-tree --name-status HEAD^ HEAD >current &&
        echo "A     elif" >expected &&
        diff expected current

    '

It removes "file" from the index, adds "elif" to the index, and
tries to commit _only_ the addition of "elif" without recording
the removal of "file" (I added "diff-index" above to see where
it fails, its presense or absense does not change the bug, and
it shows that both addition of elif and removal of file are in
the index).

When the test fails, the resulting commit however does not
record the addition of elif.  The commit records the same tree
as its parent instead.  The index that is left has "elif" but
not "file" (iow, it records the expected state after such a
partial commit).
