From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] modify/delete conflict resolution overwrites untracked
 file
Date: Sun, 14 Dec 2008 19:34:46 -0800
Message-ID: <7vmyeyyuuh.fsf@gitster.siamese.dyndns.org>
References: <20081210201259.GA12928@localhost>
 <20081215004651.GA16205@localhost>
 <7v63lm1c76.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Dec 15 04:36:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC4Fx-0001wk-6U
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 04:36:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbYLODey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 22:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbYLODey
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 22:34:54 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44979 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbYLODex (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 22:34:53 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 82D97185EF;
	Sun, 14 Dec 2008 22:34:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2E34B184AE; Sun,
 14 Dec 2008 22:34:47 -0500 (EST)
In-Reply-To: <7v63lm1c76.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 14 Dec 2008 17:03:57 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 54D6ABA8-CA59-11DD-8E83-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103127>

Junio C Hamano <gitster@pobox.com> writes:

> Clemens Buchacher <drizzd@aon.at> writes:
>
>> On Wed, Dec 10, 2008 at 09:12:59PM +0100, Clemens Buchacher wrote:
>>> If a file was removed in HEAD, but modified in MERGE_HEAD, recursive merge
>>> will result in a "CONFLICT (delete/modify)". If the (now untracked) file
>>> already exists and was not added to the index, it is overwritten with the
>>> conflict resolution contents.
>>
>> The following patch fixes the problem described above, but it also breaks
>> t6023-merge-rename-nocruft.sh, which tries to merge "A" renamed to "B" in
>> HEAD and "A" modified in MERGE_HEAD, while ignoring an untracked file "A" in
>> the working tree. If we want to be able to do this, we have to handle the
>> other case after rename detection.
>
> If the breakage is in merge-recursive but not in merge-resolve, my gut
> feeling is that we should not be touching unpack-trees at all.  With luck
> I may be able to find some time to take a look at this myself but right
> now we are entertaining a guest, so....

-- >8 --
merge-recursive: do not clobber untracked working tree garbage

When merge-recursive wanted to create a new file in the work tree (either
as the final result, or a hint for reference purposes while delete/modify
conflicts), it unconditionally overwrote an untracked file in the working
tree.  Be careful not to lose whatever the user has that is not tracked.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 merge-recursive.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git c/merge-recursive.c w/merge-recursive.c
index a0c804c..2da4333 100644
--- c/merge-recursive.c
+++ w/merge-recursive.c
@@ -447,6 +447,30 @@ static void flush_buffer(int fd, const char *buf, unsigned long size)
 	}
 }
 
+static int would_lose_untracked(const char *path)
+{
+	int pos = cache_name_pos(path, strlen(path));
+
+	if (pos < 0)
+		pos = -1 - pos;
+	while (pos < active_nr &&
+	       !strcmp(path, active_cache[pos]->name)) {
+		/*
+		 * If stage #0, it is definitely tracked.
+		 * If it has stage #2 then it was tracked
+		 * before this merge started.  All other
+		 * cases the path was not tracked.
+		 */
+		switch (ce_stage(active_cache[pos])) {
+		case 0:
+		case 2:
+			return 0;
+		}
+		pos++;
+	}
+	return file_exists(path);
+}
+
 static int make_room_for_path(const char *path)
 {
 	int status;
@@ -462,6 +486,14 @@ static int make_room_for_path(const char *path)
 		die(msg, path, "");
 	}
 
+	/*
+	 * Do not unlink a file in the work tree if we are not
+	 * tracking it.
+	 */
+	if (would_lose_untracked(path))
+		return error("refusing to lose untracked file at '%s'",
+			     path);
+
 	/* Successful unlink is good.. */
 	if (!unlink(path))
 		return 0;
