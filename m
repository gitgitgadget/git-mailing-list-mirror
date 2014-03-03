From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] commit.c: Replace starts_with() with skip_prefix()
Date: Mon, 3 Mar 2014 20:53:47 +0530
Message-ID: <CAOLa=ZRxj-iBiQRXEYvq6MrQyQcyzk32kPij8zzxh4ECbBrnMw@mail.gmail.com>
References: <1393832875-29096-1-git-send-email-karthik.188@gmail.com> <CAPig+cQLoZy=MV_AqPQseMxsrU6T_PqmCifWn1SrOGwF2FcYzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 16:24:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKUj7-0000uO-T5
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 16:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177AbaCCPYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 10:24:09 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:58436 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753980AbaCCPYI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 10:24:08 -0500
Received: by mail-pa0-f46.google.com with SMTP id kp14so3788631pab.5
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 07:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NeSQZptQBkwQVQd/qYvputmZJ87qKEpWsk+gEWrykGk=;
        b=N/iGdC70Im9C7QHiqYRSD4ngvFT9ptPoBwZkFeJDqKzzkPBDN8dHa4CN5B5+ub1Ppj
         AfSowGpYaC1N8jigM3SP400R47pSBNGGQ4r1fcQcfqo1IsCFdVXavnad5jvjPxtXdgox
         ursDPn6KUcMEEveTBuH+8+tId1lRhQJGErwY8I3/z8gpor/EIHPwu4c7uWYbnwyibdCU
         vQfqObAYpR5eGSOhiaN7atk29ONNJFETEgfquPBqPplOfHKJdRNYSNkOZfvzy/oRWAOv
         cBg1Xpxiht5TJDiYyRMb40nKuQopvRnSpgJTrwmqhK8RRN6xBYSXnFEIBOOblkgMee0Z
         vbzg==
X-Received: by 10.66.197.135 with SMTP id iu7mr259594pac.149.1393860247753;
 Mon, 03 Mar 2014 07:24:07 -0800 (PST)
Received: by 10.68.138.138 with HTTP; Mon, 3 Mar 2014 07:23:47 -0800 (PST)
In-Reply-To: <CAPig+cQLoZy=MV_AqPQseMxsrU6T_PqmCifWn1SrOGwF2FcYzg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243229>

Hello Eric,
Thanks for Pointing out everything, i had a thorough look and fixed a
couple of things.
Here is an Updated Patch.
- Removed unnecessary code and variables.
- Replaced all instances of starts_with() with skip_prefix()

Replace starts_with() with skip_prefix() for better reading purposes.
Also to replace "buf + strlen(author )" by skip_prefix(), which is
saved in a new "const char" variable "buf_skipprefix".

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 commit.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/commit.c b/commit.c
index 6bf4fe0..e5dc2e2 100644
--- a/commit.c
+++ b/commit.c
@@ -552,6 +552,7 @@ static void record_author_date(struct
author_date_slab *author_date,
  char *buffer = NULL;
  struct ident_split ident;
  char *date_end;
+ const char *buf_skipprefix;
  unsigned long date;

  if (!commit->buffer) {
@@ -562,18 +563,20 @@ static void record_author_date(struct
author_date_slab *author_date,
  return;
  }

+ buf_skipprefix = skip_prefix(buf, "author ");
+
  for (buf = commit->buffer ? commit->buffer : buffer;
      buf;
      buf = line_end + 1) {
  line_end = strchrnul(buf, '\n');
- if (!starts_with(buf, "author ")) {
+ if (!buf_skipprefix) {
  if (!line_end[0] || line_end[1] == '\n')
  return; /* end of header */
  continue;
  }
  if (split_ident_line(&ident,
-     buf + strlen("author "),
-     line_end - (buf + strlen("author "))) ||
+ buf_skipprefix,
+ line_end - buf_skipprefix) ||
     !ident.date_begin || !ident.date_end)
  goto fail_exit; /* malformed "author" line */
  break;
@@ -1113,7 +1116,7 @@ int parse_signed_commit(const unsigned char *sha1,
  next = next ? next + 1 : tail;
  if (in_signature && line[0] == ' ')
  sig = line + 1;
- else if (starts_with(line, gpg_sig_header) &&
+ else if (skip_prefix(line, gpg_sig_header) &&
  line[gpg_sig_header_len] == ' ')
  sig = line + gpg_sig_header_len + 1;
  if (sig) {
@@ -1193,7 +1196,7 @@ static void parse_gpg_output(struct signature_check *sigc)
  for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
  const char *found, *next;

- if (starts_with(buf, sigcheck_gpg_status[i].check + 1)) {
+ if (skip_prefix(buf, sigcheck_gpg_status[i].check + 1)) {
  /* At the very beginning of the buffer */
  found = buf + strlen(sigcheck_gpg_status[i].check + 1);
  } else {
-- 
1.9.0.138.g2de3478
