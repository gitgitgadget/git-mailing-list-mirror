From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH] merge-recursive: Fix copy-paste mistake
Date: Wed, 24 Sep 2014 14:52:51 +0200
Message-ID: <5422BEA3.5050107@gmail.com>
References: <1411332586-18275-1-git-send-email-stefanbeller@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 24 14:52:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWm40-0003kB-CW
	for gcvg-git-2@plane.gmane.org; Wed, 24 Sep 2014 14:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512AbaIXMwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2014 08:52:53 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:63597 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbaIXMwv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2014 08:52:51 -0400
Received: by mail-wg0-f46.google.com with SMTP id a1so5890510wgh.5
        for <git@vger.kernel.org>; Wed, 24 Sep 2014 05:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=Jzm8gXfn+01veR5GR7A/Hss6ebzpWjezOI37sx/d7W8=;
        b=YR0KxtUWauEZwgQnzbKxUDcJ3G6LGz2FiVJ3sX92fInycWChD40jc3j7bA5GBCIIQb
         hIkERecpjQsycICyO5warzrFzqCo+2k118i/Vg1/Fye91TgTxZF07HaXnQxgY0hsi+S2
         6IsTu8R5SICzZKKwCDgAW6mFU8WmvkqbeaemvpIglRYDl9XZYATvQQ8r+PKs/4V4cqNP
         xM/txrPvulsOEOK10kJwmK3c96zVHbHJ3fUlsz+McIl3K2uuntS72+eAPQLu2XGlddmz
         LX74DQCT3u7nTUdZiPNvfvd6QnvF9x6qBBvasFxZUEVizqT5h/ILcN7dvNzfgIYBF/ci
         cQQA==
X-Received: by 10.194.58.244 with SMTP id u20mr8033581wjq.36.1411563169625;
        Wed, 24 Sep 2014 05:52:49 -0700 (PDT)
Received: from [192.168.1.7] (p5B095D86.dip0.t-ipconnect.de. [91.9.93.134])
        by mx.google.com with ESMTPSA id lk6sm6067718wjb.26.2014.09.24.05.52.48
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Sep 2014 05:52:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <1411332586-18275-1-git-send-email-stefanbeller@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257457>

On 21.09.2014 22:49, Stefan Beller wrote:
> I'd be happy to have a test for this bug(?) attached to
> t6031-merge-recursive.sh, but I did not manage to
> come up with a test in a reasonable amount of time.

So I am just sending out my progress on the testing for this
as I may be short on time within the next days/weeks.

If anyone is interested to write a test for this one, 
you may pickup (parts of) the following.

At first a rough script, which makes sure the code in question 
is executed.

--8<--
#!/bin/sh

# for repetitive testing, delete everything:
rm -rf .git file .gitattributes file_with_more_descriptive_name
git init

# run the actual test
git commit --allow-empty -m 'initial'

echo -n "content of file:" '\r\n' > file
echo -n "line 1" '\r\n' >> file
echo -n "line 2" '\r\n' >> file
git add file
git commit -m 'commit file with \r\n line endings'

git checkout -b secondbranch

git rm file
git commit -m "eventually rm file"

git checkout master

echo "content of file:" > file
echo "line 1" >> file
echo "line 2" >> file

echo "file text=auto" > .gitattributes
git add file .gitattributes
git commit -m  "Add text=auto to .gitattributes; Normalize file ending"

git add file
git commit -m 'save file with \r\f line ending'

echo
echo
echo
echo

git merge secondbranch -m "merging branches with (modify/delete); modify caused only by normalisation" -X renormalize

--8<--

Here comes a patch, to be applied to git.git, 
which puts printfs all over the place, visualizing the code flow


>From 1985955b3ab2bad5ac73cbee92d19f63cdbaa3c9 Mon Sep 17 00:00:00 2001
From: Stefan Beller <stefanbeller@gmail.com>
Date: Wed, 24 Sep 2014 14:51:55 +0200
Subject: [PATCH] lots of printfs for debugging [PATCH] merge-recursive: Fix
 copy-paste mistake

---
 merge-recursive.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 8ad4be8..9b09a67 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1541,10 +1541,22 @@ static int blob_unchanged(const unsigned char *o_sha,
 	struct strbuf a = STRBUF_INIT;
 	int ret = 0; /* assume changed for safety */
 
+	printf("in blob_unchanged path=%s\n", path);
+
+
 	if (sha_eq(o_sha, a_sha))
 		return 1;
+	else
+		printf("continue as o_sha and a_sha are different\n");
+
 	if (!renormalize)
 		return 0;
+	else
+		printf("continue as not to renormalize\n");
+
+	printf("testing the patch\n");
+
+
 
 	assert(o_sha && a_sha);
 	if (read_sha1_strbuf(o_sha, &o) || read_sha1_strbuf(a_sha, &a))
@@ -1554,6 +1566,27 @@ static int blob_unchanged(const unsigned char *o_sha,
 	 * performed.  Comparison can be skipped if both files are
 	 * unchanged since their sha1s have already been compared.
 	 */
+
+	printf("o.len %d a.len %d\n", o.len, a.len);
+	printf("o.buf=|%s|\n a.buf=|%s|\n", o.buf, a.buf);
+	struct strbuf dsta = STRBUF_INIT;
+	struct strbuf dsto = STRBUF_INIT;
+
+	renormalize_buffer(path, a.buf, a.len, &dsta);
+	printf("dsta=|%s|\n",dsta.buf);
+	renormalize_buffer(path, a.buf, a.len, &dsta);
+	printf("dsta=|%s|\n",dsta.buf);
+
+
+	renormalize_buffer(path, o.buf, o.len, &dsto);
+	printf("dsto=|%s|\n",dsto.buf);
+	renormalize_buffer(path, o.buf, o.len, &dsto);
+	printf("dsto=|%s|\n",dsto.buf);
+
+
+	printf("dsto.len=%d, dsta.len=%d\n", dsto.len, dsta.len);
+
+
 	if (renormalize_buffer(path, o.buf, o.len, &o) |
 	    renormalize_buffer(path, a.buf, a.len, &a))
 		ret = (o.len == a.len && !memcmp(o.buf, a.buf, o.len));
@@ -1682,10 +1715,24 @@ static int merge_content(struct merge_options *o,
 
 }
 
+
+//~ struct stage_data {
+	//~ struct {
+		//~ unsigned mode;
+		//~ unsigned char sha[20];
+	//~ } stages[4];
+	//~ struct rename_conflict_info *rename_conflict_info;
+	//~ unsigned processed:1;
+//~ };
+
 /* Per entry merge function */
 static int process_entry(struct merge_options *o,
 			 const char *path, struct stage_data *entry)
 {
+
+	printf("processing entry %s has rename_conflict_info %p\n", path, entry->rename_conflict_info);
+	//~ print_index_entry("\tpath: ", entry);
+
 	int clean_merge = 1;
 	int normalize = o->renormalize;
 	unsigned o_mode = entry->stages[1].mode;
@@ -1694,9 +1741,10 @@ static int process_entry(struct merge_options *o,
 	unsigned char *o_sha = stage_sha(entry->stages[1].sha, o_mode);
 	unsigned char *a_sha = stage_sha(entry->stages[2].sha, a_mode);
 	unsigned char *b_sha = stage_sha(entry->stages[3].sha, b_mode);
-
+	printf("%s %s %s\n", o_sha, a_sha, b_sha);
 	entry->processed = 1;
 	if (entry->rename_conflict_info) {
+		printf("in entry->rename_conflict_info condition\n");
 		struct rename_conflict_info *conflict_info = entry->rename_conflict_info;
 		switch (conflict_info->rename_type) {
 		case RENAME_NORMAL:
@@ -1724,6 +1772,8 @@ static int process_entry(struct merge_options *o,
 			break;
 		}
 	} else if (o_sha && (!a_sha || !b_sha)) {
+		printf("deleted in one, normalize=%d \n", normalize);
+
 		/* Case A: Deleted in one */
 		if ((!a_sha && !b_sha) ||
 		    (!b_sha && blob_unchanged(o_sha, a_sha, normalize, path)) ||
-- 
2.1.0.238.gce1d3a9
