From: Jonathon Mah <jmah@me.com>
Subject: Re: [PATCH] parse_object: clear "parsed" when freeing buffers
Date: Thu, 24 Jan 2013 13:16:29 -0800
Message-ID: <6B8655CE-5CC2-4228-B49D-21A30622D1B6@me.com>
References: <8988071A-1DF3-463E-8AF9-AE4EA200D786@me.com> <20130124070715.GD610@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 24 22:17:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyUBE-0001A9-Fn
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 22:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945934Ab3AXVRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 16:17:19 -0500
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:51822 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1945923Ab3AXVRM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 16:17:12 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApMBAFKjAVHNmv/T/2dsb2JhbAANN75ggxEBAQEDAScTPwULCw0BCi5XBhOIFBKqO5NOkBphA4hhjkeEcYM/ihU
Received: from unknown (HELO [10.128.129.247]) ([205.154.255.211])
  by ipmail07.adl2.internode.on.net with ESMTP; 25 Jan 2013 07:47:07 +1030
In-Reply-To: <20130124070715.GD610@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1499)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214458>

On 2013-01-23, at 23:07, Jeff King <peff@peff.net> wrote:

> On Wed, Jan 23, 2013 at 01:25:04PM -0800, Jonathon Mah wrote:
> 
>> Several areas of code would free buffers for object structs that
>> contained them ("struct tree" and "struct commit"), but without clearing
>> the "parsed" flag. parse_object would clear the flag for "struct tree",
>> but commits would remain in an invalid state (marked as parsed but with
>> a NULL buffer). Because the objects are uniqued (ccdc6037fee), the
>> invalid objects stay around and can lead to bad behavior.
>> 
>> In particular, running pickaxe on all refs in a repository with a cached
>> textconv could segfault. If the textconv cache ref was evaluated first
>> by cmd_log_walk, a subsequent notes_cache_match_validity call would
>> dereference NULL.
> 
> Just to be sure I understand, what is going on is something like this?
> 
>  Log reads all refs, including notes. After showing the notes commit,
>  log frees the buffer to save memory.  Later, doing the diff on a
>  commit causes us to use the notes_cache mechanism. That will look at
>  the commit at the tip of the notes ref, which log has already
>  processed. It will call parse_commit, but that will do nothing, as the
>  parsed flag is already set, but the commit buffer remains NULL.
> 
> I wonder if this could be the source of the segfault here, too:
> 
>  http://thread.gmane.org/gmane.comp.version-control.git/214322/focus=214355

Indeed, that description matches what I see. The other segfault seems to be in the same place too.

The segfault hits with the following stack (optimization off):

0   git-log         parse_commit_header + 39 (pretty.c:738)
1   git-log         format_commit_one + 3102 (pretty.c:1138)
2   git-log         format_commit_item + 177 (pretty.c:1203)
3   git-log         strbuf_expand + 172 (strbuf.c:247)
4   git-log         format_commit_message + 196 (pretty.c:1263)
5   git-log         notes_cache_match_validity + 215 (notes-cache.c:22)
6   git-log         notes_cache_init + 212 (notes-cache.c:41)
7   git-log         userdiff_get_textconv + 176 (userdiff.c:301)
8   git-log         get_textconv + 66 (diff.c:2233)
9   git-log         has_changes + 53 (diffcore-pickaxe.c:205)
10  git-log         pickaxe + 299 (diffcore-pickaxe.c:40)
11  git-log         diffcore_pickaxe_count + 344 (diffcore-pickaxe.c:275)
12  git-log         diffcore_pickaxe + 58 (diffcore-pickaxe.c:289)
13  git-log         diffcore_std + 162 (diff.c:4673)
14  git-log         log_tree_diff_flush + 43 (log-tree.c:721)
15  git-log         log_tree_diff + 566 (log-tree.c:826)
16  git-log         log_tree_commit + 63 (log-tree.c:847)
17  git-log         cmd_log_walk + 172 (log.c:301)
18  git-log         cmd_log + 186 (log.c:568)
19  git-log         run_builtin + 475 (git.c:273)
20  git-log         handle_internal_command + 199 (git.c:434)
21  git-log         main + 149 (git.c:523)
22  libdyld.dylib   start + 1

commit->message was freed and nulled earlier in a call to cmd_log_walk. This test reproduces it reliably on my machine:

diff --git a/t/t4042-diff-textconv-caching.sh b/t/t4042-diff-textconv-caching.sh
index 91f8198..d7e26ca 100755
--- a/t/t4042-diff-textconv-caching.sh
+++ b/t/t4042-diff-textconv-caching.sh
@@ -106,4 +106,15 @@ test_expect_success 'switching diff driver produces correct results' '
 	test_cmp expect actual
 '
 
+cat >expect <<EOF
+./helper other (refs/notes/textconv/magic)
+one
+EOF
+# add empty commit on master to make bug more reproducible
+test_expect_success 'pickaxe with cached textconv' '
+	git commit --allow-empty -m another &&
+	git log -S other --pretty=tformat:%s%d --all >actual &&
+	test_cmp expect actual
+'
+
 test_done




Jonathon Mah
me@JonathonMah.com
