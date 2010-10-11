From: Jim Meyering <jim@meyering.net>
Subject: [PATCH next] don't let mailmap provoke use of freed memory
Date: Mon, 11 Oct 2010 17:41:16 +0200
Message-ID: <87tyksd9er.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 11 17:41:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5KVJ-0006Ho-Eq
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 17:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755258Ab0JKPlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 11:41:25 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:42538 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755230Ab0JKPlY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 11:41:24 -0400
Received: from mx.meyering.net (unknown [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id D6E0F940150
	for <git@vger.kernel.org>; Mon, 11 Oct 2010 17:41:17 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 88FCAF79; Mon, 11 Oct 2010 17:41:16 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158768>


On an x86_64 system (F13-based), I ran these commands in an empty directory:

    git init
    printf '%s\n' \
      '<jdoe@example.com> <jdoe@example.COM>' \
      'John <jdoe@example.com>' > .mailmap
    git shortlog < /dev/null

Here's the result:

    (reading log message from standard input)
    *** glibc detected *** git: free(): invalid pointer: 0x0000000000f53730 ***
    ======= Backtrace: =========
    /lib64/libc.so.6[0x31ba875676]
    git[0x48c2a5]
    git[0x4b9858]
    ...
    zsh: abort (core dumped)  git shortlog

What happened?

Some .mailmap entry is of the <email1> <email2> form,
while a subsequent one looks like "User Name <Email2>,
and the two email addresses on the right are not identical
but are "equal" when using a case-insensitive comparator.

Then, when add_mapping is processing the latter line, new_email is NULL
and we free me->email, yet do not replace it with a new strdup'd string.
Thus, when later we attempt to use the buffer behind that ->email pointer,
we reference freed memory.

The solution is to free ->email and ->name only if we're about to replace them.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 mailmap.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index f80b701..02fcfde 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -79,12 +79,14 @@ static void add_mapping(struct string_list *map,
 	if (old_name == NULL) {
 		debug_mm("mailmap: adding (simple) entry for %s at index %d\n", old_email, index);
 		/* Replace current name and new email for simple entry */
-		free(me->name);
-		free(me->email);
-		if (new_name)
+		if (new_name) {
+			free(me->name);
 			me->name = xstrdup(new_name);
-		if (new_email)
+		}
+		if (new_email) {
+			free(me->email);
 			me->email = xstrdup(new_email);
+		}
 	} else {
 		struct mailmap_info *mi = xmalloc(sizeof(struct mailmap_info));
 		debug_mm("mailmap: adding (complex) entry for %s at index %d\n", old_email, index);
--
1.7.3.1.104.gc752e
