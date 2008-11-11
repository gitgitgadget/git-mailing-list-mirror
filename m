From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] 3-way merge with file move fails when diff.renames =
 copies
Date: Mon, 10 Nov 2008 16:15:49 -0800
Message-ID: <7vwsfb2k3u.fsf@gitster.siamese.dyndns.org>
References: <1226355970-2542-1-git-send-email-ddkilzer@kilzer.net>
 <7v63mv3zww.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Tue Nov 11 01:17:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzgwo-0004gp-S2
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 01:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593AbYKKAQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 19:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752377AbYKKAQU
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 19:16:20 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48535 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbYKKAQT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 19:16:19 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0E8A17B32C;
	Mon, 10 Nov 2008 19:16:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D860A7B327; Mon,
 10 Nov 2008 19:16:01 -0500 (EST)
In-Reply-To: <7v63mv3zww.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 10 Nov 2008 15:49:03 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F5363846-AF85-11DD-89E7-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100606>

Junio C Hamano <gitster@pobox.com> writes:

> "David D. Kilzer" <ddkilzer@kilzer.net> writes:
>
>> With diff.renames = copies, a 3-way merge (e.g. "git rebase") would
>> fail with the following error:

By the way, I think the real issue with this one is that we currently do
not disable diff.renames configuration while rebase internally runs
"format-patch" to feed "am -3".

The end user configuration for "diff" should not affect the result
produced by the higher level command that is related to "diff" only
because internally it is implemented in terms of it.

For that matter, I have a feeling that format-patch should not even look
at diff.renames, but we seem to have been doing this for a long time so
there is no easy way to fix this thinko.

In any case, here is a much straightforward fix for "rebase".  

Running "am -3" on a copying patch would still need a patch to the
index-info codepath, and my earlier comment on it still stands, but it is
irrelevant/orthogonal to your particular test script.

 git-rebase.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git c/git-rebase.sh w/git-rebase.sh
index 023a6dc..159ccb3 100755
--- c/git-rebase.sh
+++ w/git-rebase.sh
@@ -429,7 +429,7 @@ fi
 if test -z "$do_merge"
 then
 	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
-		"$upstream..$orig_head" |
+		--no-renames "$upstream..$orig_head" |
 	git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG" &&
 	move_to_original_branch
 	ret=$?
