From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH] sha1_file.c: make sure open_sha1_file does not open a directory
Date: Sun,  8 Feb 2015 15:05:32 -0800
Message-ID: <b0993cc1fcac290d7506b24942af300@74d39fa044aa309eaea14b9f57fe79c>
Cc: Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Jonathon Mah <me@jonathonmah.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 00:05:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKavI-0004gz-W5
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 00:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759051AbbBHXFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2015 18:05:45 -0500
Received: from mail-pd0-f173.google.com ([209.85.192.173]:40761 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759046AbbBHXFm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 18:05:42 -0500
Received: by pdev10 with SMTP id v10so9537140pde.7
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 15:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ClyBx8swU4HTKd3U83TD+3chohM2qUQfDTCwToFfuOE=;
        b=dKYfTG2a8Hre4FSTaCOG5k6u3140dHM2wzTCBgWnIOOu+3Euke8Q9sUwsr93gbhLsF
         I/o5Nb1XP2qJ53k/oaT1T1db5fL376Od0GBrM1wItnY+FGHsatTaKpS7VT370A4lf8Mt
         xIrNOIrte5cbC+snyNto3z3mudYSM77pd2lGsGRpmi7YFNUcX9TgNNcH/iGJbTGMSg6P
         gNZPAXDJl7H/ysdae5LFS0dohHWIVy2YTy0l3Ch9HLEc3ffal6NYb3wcik6V3dwz7cs/
         jSRtHL5yyWivK2ZeYSECFlVt8u4c/mNMZBl9nsLPq85/6gkLOSGFkF43dKB+OVtLtEpG
         +fVQ==
X-Received: by 10.68.69.10 with SMTP id a10mr23707769pbu.36.1423436742393;
        Sun, 08 Feb 2015 15:05:42 -0800 (PST)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id jw8sm14298773pbc.73.2015.02.08.15.05.40
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 08 Feb 2015 15:05:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263535>

Since "sha1_file: fix iterating loose alternate objects", it's possible
for the base member of the alt_odb_list structure to be NUL terminated
rather than ending with a '/' when open_sha1_file is called.

Unfortunately this causes a directory to be passed to git_open_noatime
instead of a file which it happily opens and returns whereupon this
open directory file handle is then passed to mmap.

mmap does not like this and fails with an invalid argument error
at which point the pack-objects process dies prematurely.

To avoid this we preserve the last character of the base member,
set it to '/', make the git_open_noatime call and then restore
it to its previous value which allows pack-objects to function properly.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---

*****

While this patch can be applied without "sha1_file: fix iterating
loose alternate objects" you cannot even get to the failure this fixes
without first having that patch applied.

All this stuffing of a single char back and forth into a [-1] index
seems awfully kludgy to me.

However, without this fix and the previous sha1_file fix I would need
to jettison the latest stuff and revert back to 2.1.4.

I suggest that this (or another fix for the problem) go into maint
together with the "sha1_file: fix iterating loose alternate objects"
fix.

*****

 sha1_file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sha1_file.c b/sha1_file.c
index f575b3cf..235f6ad8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1491,8 +1491,11 @@ static int open_sha1_file(const unsigned char *sha1)
 
 	prepare_alt_odb();
 	for (alt = alt_odb_list; alt; alt = alt->next) {
+		char c = alt->name[-1];
+		alt->name[-1] = '/';
 		fill_sha1_path(alt->name, sha1);
 		fd = git_open_noatime(alt->base);
+		alt->name[-1] = c;
 		if (fd >= 0)
 			return fd;
 		if (most_interesting_errno == ENOENT)
--
