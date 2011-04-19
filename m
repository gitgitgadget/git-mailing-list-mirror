From: Ciaran <ciaranj@gmail.com>
Subject: [PATCH RFC] Rename detection and whitespace
Date: Tue, 19 Apr 2011 21:13:19 +0100
Message-ID: <BANLkTikiH7bfWFGjFCDL-SnO9HQR-9Uofw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 22:13:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCHIc-0002av-3T
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 22:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931Ab1DSUNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 16:13:20 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39268 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478Ab1DSUNU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 16:13:20 -0400
Received: by pzk9 with SMTP id 9so32138pzk.19
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 13:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=H/TwwbcUn01dezfIVCYDIbXJFXSIznnd77lPU22zrMo=;
        b=IVp3YfCleGDPO7UFokuXyCdOqnEcll4PRjCEfWNvZ9Vriybbt3mNNhYjb5iSNNJkpA
         y/PAsR4cH+FekArCzFutbp7KMnntjl8YX40SllLD6tsSaB/VkpIEWpsS9hH7yV7HiAxz
         qWD0SO+trrd6QTcVOYxTJL7d6FHD/RLeGBER4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=UZs40gZliOL9/dH5UKogf3SI+SAqUnWcUpprrKUkZ5bP3DtPlIYIrL3oO6j460fSMf
         bCqSJwk2wwNHY+EZa3ALchg4Gsro9guynQKhPlA4cDYF39Do2m+hpgetLhq9DRUxTJQl
         fxv4bNasY1xrdxs3ckUXouboMuzM5GydvWhws=
Received: by 10.68.49.166 with SMTP id v6mr9662215pbn.322.1303243999574; Tue,
 19 Apr 2011 13:13:19 -0700 (PDT)
Received: by 10.68.62.6 with HTTP; Tue, 19 Apr 2011 13:13:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171814>

Hi,

I recently had an issue with a merge where there was a branch of some
code made to do some format standardisation e.g. re-indenting,
normalising of whitespace etc. etc. and another branch to do with
tidying up the codebase (moving some files around etc.)

When we brought the two branches back together git struggled (failed)
to apply the formatting changes to the files that were moved (-s
recursive -X ignore-all-space).  Now in terms of best practice
obviously what we did was stupid, and we should never have
parallelised the two pieces of work and I imagine that this may well
be considered 'known behaviour / won't fix' but I wanted to raise it
and get told that rather than assume it :)

After a minimal amount of investigation I found that with a small
patch I could make my local git instance perform the merge flawlessly
(in my case).

For me I tracked the behaviour down to the blob similarity calculation
that takes place in the diffcore-delta.c#hash_chars method.  In our
case the problem was we were adjusting the whitespace at the front of
each line which meant that the 64 byte segment hashes were
different/mis-aligned between the 2 equivalent files.   This code
already 'normalises' out CRLF/LF differences by skipping any CR
characters when followed by LF so my question is that would it be
considered wrong/evil to ignore *all* whitespace characters when -X
ignore-all-space has been passed.

The behaviour is trivial to reproduce without a merge:
  i) Create a text file with a few lines in it.
 ii) Add the file and commit it.
iii) Insert a space at the front of each line and rename the file
iv) git add -A .
v) git status will now show a 'new file' and a 'deleted file'

With the patch inlined below (not suitable for inclusion, naive in so
many ways (what is whitespace, and should be optional/configurable to
name just two!) git status will report a rename instead.  This
behaviour carries across to merging.

Presumably I'm missing something important, but the improved rename
detection for us was outstanding!

---
 diffcore-delta.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/diffcore-delta.c b/diffcore-delta.c
index 7cf431d..5429b8d 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -146,6 +146,9 @@ static struct spanhash_top *hash_chars(struct
diff_filespec *one)
 		if (is_text && c == '\r' && sz && *buf == '\n')
 			continue;

+		if (is_text && ( c == '\t' || c ==' ' ) )
+			continue;
+
 		accum1 = (accum1 << 7) ^ (accum2 >> 25);
 		accum2 = (accum2 << 7) ^ (old_1 >> 25);
 		accum1 += c;
-- 
1.7.4.1
