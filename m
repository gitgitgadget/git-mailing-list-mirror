From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/1] format-patch: add an option to record base tree info
Date: Sun, 21 Feb 2016 20:19:56 -0800
Message-ID: <xmqqmvqt8jgz.fsf@gitster.mtv.corp.google.com>
References: <1456109938-8568-1-git-send-email-xiaolong.ye@intel.com>
	<1456109938-8568-2-git-send-email-xiaolong.ye@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Xiaolong Ye <xiaolong.ye@intel.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 05:20:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXhye-0000Pe-F6
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 05:20:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345AbcBVEUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 23:20:00 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52800 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753342AbcBVET7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 23:19:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 885F847C29;
	Sun, 21 Feb 2016 23:19:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+Y15MiNZfZRl5g/tDr3zBEn4UZQ=; b=vzbWcZ
	O0rf5uuiyRh0T3qvaLhajfPw42GuyI1LKr5pGxkdOgNGCAubIgjXHewFy4kkDAjx
	mbGax/AL7Z6pR6vPU6IVUDcKCI5Sa1wE0wKeTVvGYBsC/KhMWJto8QZUK32GTBdq
	M4Ph7BTFzubko7huAObqbISUXx8eoVQSvSaUA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZlsXU4tYNYdsrbTpK3tmIjiHuXXknONd
	bA4VQOzAgFShbSsdZBXRZXyGNosyR7+FOSwJ2pIJxMjH9RArPOro1BvwuHLcWhQj
	3urSWwoaSFxwXM4KA2VYxKkYkaQ9IhDZ6gBVxmB0zaoqdPIyokWId/W/0KQJljbH
	cDwnjb5gEp0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7194D47C28;
	Sun, 21 Feb 2016 23:19:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CCA9A47C25;
	Sun, 21 Feb 2016 23:19:57 -0500 (EST)
In-Reply-To: <1456109938-8568-2-git-send-email-xiaolong.ye@intel.com>
	(Xiaolong Ye's message of "Mon, 22 Feb 2016 10:58:58 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8856D9AC-D91B-11E5-880A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286877>

Xiaolong Ye <xiaolong.ye@intel.com> writes:

> It would be helpful for maintainers or reviewers to know the base tree
> info of the patches created by git format-patch. Teach git format-patch
> a --base-tree-info option to record these info.
>
> Signed-off-by: Xiaolong Ye <xiaolong.ye@intel.com>
> ---

I have a mixed feeling about this one, primarily because this was
already tried quite early in the life of "format-patch" command.

    http://thread.gmane.org/gmane.comp.version-control.git/9694/focus=9757

Only the name is different (it was called "applies-to" and named a
tree object).

The approach the patch I am responding to takes, which is to touch
diff.[ch], is probably flawed.  Even if we assume, for the sake of
reviewing, that "which commit (or tree) this patch applies to" is a
good thing to add, this is useful only to the very first patch in
the series.  Hence its output should come from some function in
builtin/log.c that iterates over commits and done for only the first
one in a series, not by the diff machinery that is called by that
loop iterating over commits.

It is unclear what your goal is, and "would be helpful" is just as
convincing as saying it would be helpful to record the phase of the
moon when the commit was made.  A typical patch rarely touches all
the files in the project, so there will be multiple commits in the
existing history of the project to which the patch would apply
cleanly.  Is it your goal to insist on one exact commit the patch is
applied to?  Or are you OK as long as the patch is applied to the
same set of blobs the diff was taken from?  A developer may have a
few unrelated and private commits on top of Linus's released
version, on top of which she builds a series.  As long as the paths
touched by the patches in this series do not overlap with the paths
touched by the initial few unrelated and private commits, such a
series should be testable directly on top of Linus's released
version, without forcing her to first rebase the series to remove
these initial few unrelated and private commits from her history
before running "format-patch --base-commit" (your patch is recording
the commit object name, and it shouldn't call it tree-info), but you
are forcing her to do so because these private commits will not be
available to those who apply her patches.

If you are OK with accepting a patch application to a tree with the
same blobs the diff was taken from, then the format-patch output
already has all the necessary information.  For each "diff --git"
part, there is the "index $old..$new" line that records preimage and
postimage blob object ID, so you should be able to find a tree that
has the matching blobs in the paths mentioned in the patch, and it
is guaranteed that the patch would apply cleanly to such a tree.

Of course, that requires the recipient of the patch to have the all
the blobs mentioned as the preimage in the patch, but it would be a
reasonable assumption, as your patch assumes that the recipient has
the commit, and if he has a commit by definition he would have all
the blobs recorded by that commit.

Incidentally, the "index $old..$new" lines are what make "am -3"
possible.
