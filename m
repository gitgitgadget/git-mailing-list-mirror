From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFD} Use regex's in :/ revision naming machinery
Date: Mon, 5 Apr 2010 16:00:59 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1004051551180.21411@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 01:05:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyvM1-0008VW-SS
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 01:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756896Ab0DEXEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 19:04:47 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52342 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756867Ab0DEXEq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Apr 2010 19:04:46 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o35N4erN018730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 5 Apr 2010 16:04:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o35N4eRT014433;
	Mon, 5 Apr 2010 16:04:40 -0700
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.45 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144073>


So this is very much debatable, but I'm including a patch for the 
discussion to start.

I never use ':/', and part of it is that it's so horribly cumbersome. I'd 
_like_ to use it to do things like 

	gitk :/slabh..

which would (right now) show what happened since I merged the 'slabh' 
branch. But that doesn't work, I would need to write it as

	gitk :/"Merge branch 'slabh'"..

at which point it really isn't all that useful any more - in order to 
figure out the string I need to use, I had to look up the commit, so the 
whole :/ format was useless. I might as well just have used the SHA1 value 
instead.

The thing is, I'm not quite sure _who_ uses :/ as things are now, so maybe 
there is some reason for that incredibly annoying interface.

But with this trivial (LARGELY UNTESTED!) patch, I get the behaviour _I_ 
want, and I can do my simpler version instead.

It also allows me to do silly things like this:

	git show :/'Signed-off-by: Linus'

which shows the last commit that was signed off by me. Is that really 
useful? Not bloody likely. But it shows how much more flexible the whole 
notion of "let's grep the commit message" is than having to match exactly 
the beginning of it.

		Linus

PS. Do note the "largely untested" part. I think this patch is kind of 
cool, but it might be totally broken. I did run the test-suite on it, and 
it still says "failed  0", but that's probably more indicative of limited 
test coverage of :/ than anything else.

---
 sha1_name.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index bf92417..7570f1a 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -692,12 +692,17 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 	struct commit_list *list = NULL, *backup = NULL, *l;
 	int retval = -1;
 	char *temp_commit_buffer = NULL;
+	regex_t regex;
 
 	if (prefix[0] == '!') {
 		if (prefix[1] != '!')
 			die ("Invalid search pattern: %s", prefix);
 		prefix++;
 	}
+
+	if (regcomp(&regex, prefix, REG_EXTENDED))
+		die("Invalid search pattern: %s", prefix);
+
 	for_each_ref(handle_one_ref, &list);
 	for (l = list; l; l = l->next)
 		commit_list_insert(l->item, &backup);
@@ -721,12 +726,13 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 		}
 		if (!(p = strstr(p, "\n\n")))
 			continue;
-		if (!prefixcmp(p + 2, prefix)) {
+		if (!regexec(&regex, p + 2, 0, NULL, 0)) {
 			hashcpy(sha1, commit->object.sha1);
 			retval = 0;
 			break;
 		}
 	}
+	regfree(&regex);
 	free(temp_commit_buffer);
 	free_commit_list(list);
 	for (l = backup; l; l = l->next)
