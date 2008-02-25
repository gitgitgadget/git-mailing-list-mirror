From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Instituting feature and infrastructure enhancement proposal
 window?
Date: Sun, 24 Feb 2008 17:37:15 -0800
Message-ID: <7vir0dsto4.fsf@gitster.siamese.dyndns.org>
References: <7v8x1ataiu.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802241226340.21332@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Feb 25 02:38:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTSIn-0001F0-Qc
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 02:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756846AbYBYBhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 20:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753846AbYBYBhk
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 20:37:40 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61194 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756856AbYBYBh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 20:37:28 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0E78E282B;
	Sun, 24 Feb 2008 20:37:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 31D502828; Sun, 24 Feb 2008 20:37:23 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0802241226340.21332@woody.linux-foundation.org>
 (Linus Torvalds's message of "Sun, 24 Feb 2008 12:42:47 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74980>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> And on exactly that note:
>
>>  * diff --dirstat (Linus)
>
> I actually actively use this (not just for -rc releases, but I find it 
> nice to do occasionally in other cases too), so it would be really nice if 
> at least the initial version got merged soon. Even if it gets the binary 
> case wrong,...

I am planning to do this (dropping the "damange" one I
previously showed and queued in 'pu') and merge to 'master' for
now.

-- >8 --
[PATCH] diff --dirstat: saner handling of binary and unmerged files

We do not account binary nor unmerged files when --shortstat is
asked for (or the summary stat at the end of --stat).  

The new option --dirstat should work the same way as it is about
summarizing the changes of multiple files by adding them up.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index dd374d4..bcc323f 100644
--- a/diff.c
+++ b/diff.c
@@ -1016,7 +1016,10 @@ static long gather_dirstat(struct diffstat_dir *dir, unsigned long changed, cons
 			this = gather_dirstat(dir, changed, f->name, newbaselen);
 			sources++;
 		} else {
-			this = f->added + f->deleted;
+			if (f->is_unmerged || f->is_binary)
+				this = 0;
+			else
+				this = f->added + f->deleted;
 			dir->files++;
 			dir->nr--;
 			sources += 2;
@@ -1053,6 +1056,8 @@ static void show_dirstat(struct diffstat_t *data, struct diff_options *options)
 	/* Calculate total changes */
 	changed = 0;
 	for (i = 0; i < data->nr; i++) {
+		if (data->files[i]->is_binary || data->files[i]->is_unmerged)
+			continue;
 		changed += data->files[i]->added;
 		changed += data->files[i]->deleted;
 	}
