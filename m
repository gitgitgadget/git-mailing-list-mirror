From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [TESTCASE] Failing 'git am' when core.autocrlf=true
Date: Thu, 23 Aug 2007 10:18:54 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708230956190.30176@woody.linux-foundation.org>
References: <46CD94AB.7070709@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Marius Storm-Olsen <marius@trolltech.com>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Aug 23 19:19:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOGKm-00015N-90
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 19:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758780AbXHWRTB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 13:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758707AbXHWRTA
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 13:19:00 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59079 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751272AbXHWRTA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2007 13:19:00 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7NHIthT018256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 23 Aug 2007 10:18:56 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7NHIsQ7018908;
	Thu, 23 Aug 2007 10:18:55 -0700
In-Reply-To: <46CD94AB.7070709@trolltech.com>
X-Spam-Status: No, hits=-3.251 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.28__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56508>



On Thu, 23 Aug 2007, Marius Storm-Olsen wrote:
> 
> I have an issue with git-rebase failing on a repository using
>     core.autocrlf=true
> 
> I've tracked it down to git-am failing with core.autocrlf=true and passing
> with core.autocrlf=false. I've tried digging deeper into the code, but for
> some reason ce_match_stat_basic() (read-cache.c:~187) reports the size of the
> file in the index to be 0 (when core.autocrlf=true), which is why git-am bails
> out on the patch. (ce->ce_size == 0, while st->st_size == the correct size on
> disk)

Very interesting.

Adding some instrumentation to "git-am.sh" (namely a lot of

	git diff --quiet || exit

lines to figure out exactly *where* the index gets out of sync with the 
working tree), I get this trace:

	trace: built-in: git 'mailsplit' '-d4' '-o.dotest' '-b' '--'
	trace: built-in: git 'diff-index' '--cached' '--name-only' 'HEAD'
	trace: built-in: git 'diff' '--quiet'
	trace: built-in: git 'mailinfo' '-u' '.dotest/msg' '.dotest/patch'
	trace: built-in: git 'stripspace'
	trace: built-in: git 'diff' '--quiet'
	trace: built-in: git 'apply' '--allow-binary-replacement' '--index' '.dotest/patch'
	trace: built-in: git 'diff' '--quiet'
	trace: built-in: git 'diff' '--quiet'
	trace: built-in: git 'write-tree'
	trace: built-in: git 'diff' '--quiet'

ie everything was fine after the "apply" phase, but the index and the 
working tree went out-of-kilter after "git write-tree".

The reason? "git write-tree" doesn't read the config file, so it never 
even reads the "core.autocrlf=true" variable. As a result, it seems to 
screw up the index matching when it does the cache_tree_fully_valid() 
(which will fail due to "git apply --index" having invalidated the tree 
SHA1's) followed by cache_tree_update().

> Can anyone please enlighten me on why this may happen?

This patch should fix it. 

Junio - it fixes the test for me, but quite frankly, I don't see why 
write-tree would *ever* change any non-tree index entries. But it does. I 
think there's another bug somewhere, or I'm missing something.

		Linus

---
 builtin-write-tree.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-write-tree.c b/builtin-write-tree.c
index 88f34ba..b89d02e 100644
--- a/builtin-write-tree.c
+++ b/builtin-write-tree.c
@@ -72,6 +72,7 @@ int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
 	const char *prefix = NULL;
 	unsigned char sha1[20];
 
+	git_config(git_default_config);
 	while (1 < argc) {
 		const char *arg = argv[1];
 		if (!strcmp(arg, "--missing-ok"))
