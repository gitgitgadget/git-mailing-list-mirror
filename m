From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: /* compiler workaround */ - what was the issue?
Date: Fri, 6 May 2016 19:05:51 +0100
Message-ID: <572CDCFF.9050607@ramsayjones.plus.com>
References: <AA5B2B1715BAF7438221293187A417A7BDE9D11D@desmdswms002.des.grplnk.net>
 <17E04501C9474282B87758C7998A1F5B@PhilipOakley>
 <xmqqtwic9o88.fsf@gitster.mtv.corp.google.com>
 <CACsJy8CBuU8H8r_f4KsnLkhLtfRv0nDo4hGS31LVn0e1Y_3OAQ@mail.gmail.com>
 <51C902B1F7464CF2B58EB0E495F86BB5@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 20:06:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayk8b-0004kc-7b
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 20:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758780AbcEFSF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 14:05:57 -0400
Received: from avasout07.plus.net ([84.93.230.235]:47979 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756380AbcEFSFz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 14:05:55 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout07 with smtp
	id r65r1s0022D2Veb0165s2j; Fri, 06 May 2016 19:05:53 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=pGLkceISAAAA:8 a=ybZZDoGAAAAA:8 a=xtxXYLxNAAAA:8 a=EBOSESyhAAAA:8
 a=T28VAxbOeHHkhyd23_AA:9 a=QEXdDO2ut3YA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <51C902B1F7464CF2B58EB0E495F86BB5@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293842>



On 06/05/16 14:15, Philip Oakley wrote:
> From: "Duy Nguyen" <pclouds@gmail.com>
>> On Fri, May 6, 2016 at 4:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> "Philip Oakley" <philipoakley@iee.org> writes:
>>>
>>>>     int saved_namelen = saved_namelen; /* compiler workaround */
>>>>
>>>> Which then becomes an MSVC compile warning C4700: uninitialized local
>>>> variable.
>>>>
>>>> I'm wondering what was the compiler workaround being referred to? i.e. why
>>>> does it need that tweak? There's no mention of the reason in the commit
>>>> message.
>>>
>>> That was a fairly well-known workaround for GCC that issues a false
>>> warning that variable is used before initialized.  I thought we
>>> stopped using it several years ago in new code after doing a bulk
>>> sanitizing
>>
>> I guess that's 803a777 (cat-file: Fix an gcc -Wuninitialized warning -
>> 2013-03-26) and more commits around that time. The split-index commit
>> is in 2014. I must have missed the trend.
>>
>>> (I think the new recommended workaround was to initialise
>>> such a variable to the nil value like '0' for integers).
>>
>> Yep. First Jeff removed the " = xxx" part from "xxx = xxx" then Ramsay
>> added the " = NULL" back. So we probably just do "int saved_namelen =
>> 0;" in this case.
>> -- 
> Thanks,
> 
> I'll try and work up a patch - probably next week as I'm away for the weekend.

Yeah, I don't remember why these were left over from the previous
attempt to clean these up (maybe they conflicted with in-flight
topics?), but I have had a patch hanging around ... :-D

The patch below applies to master (I haven't checked for any more
additions).

ATB,
Ramsay Jones

-- >8 --
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] -Wuninitialized: remove a gcc specific workaround

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 builtin/rev-list.c | 2 +-
 fast-import.c      | 4 ++--
 merge-recursive.c  | 2 +-
 read-cache.c       | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 275da0d..deae1f3 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -377,7 +377,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		mark_edges_uninteresting(&revs, show_edge);
 
 	if (bisect_list) {
-		int reaches = reaches, all = all;
+		int reaches = 0, all = 0;
 
 		revs.commits = find_bisection(revs.commits, &reaches, &all,
 					      bisect_find_all);
diff --git a/fast-import.c b/fast-import.c
index 9fc7093..ca66d80 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2935,7 +2935,7 @@ static void cat_blob(struct object_entry *oe, unsigned char sha1[20])
 
 static void parse_get_mark(const char *p)
 {
-	struct object_entry *oe = oe;
+	struct object_entry *oe = NULL;
 	char output[42];
 
 	/* get-mark SP <object> LF */
@@ -2952,7 +2952,7 @@ static void parse_get_mark(const char *p)
 
 static void parse_cat_blob(const char *p)
 {
-	struct object_entry *oe = oe;
+	struct object_entry *oe = NULL;
 	unsigned char sha1[20];
 
 	/* cat-blob SP <object> LF */
diff --git a/merge-recursive.c b/merge-recursive.c
index 06d31ed..9cecc24 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1897,7 +1897,7 @@ int merge_recursive(struct merge_options *o,
 {
 	struct commit_list *iter;
 	struct commit *merged_common_ancestors;
-	struct tree *mrtree = mrtree;
+	struct tree *mrtree = NULL;
 	int clean;
 
 	if (show(o, 4)) {
diff --git a/read-cache.c b/read-cache.c
index d9fb78b..978d6b6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1870,7 +1870,7 @@ static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce,
 {
 	int size;
 	struct ondisk_cache_entry *ondisk;
-	int saved_namelen = saved_namelen; /* compiler workaround */
+	int saved_namelen = 0;
 	char *name;
 	int result;
 
-- 
2.8.0
