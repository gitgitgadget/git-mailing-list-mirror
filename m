From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Possible Solaris problem in 'checkout_entry()'
Date: Mon, 17 Mar 2008 08:56:27 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803170850090.3020@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0803170756390.3020@woody.linux-foundation.org> <118833cc0803170823q1e1e29a9p18b9a41f6975e268@mail.gmail.com> <alpine.LFD.1.00.0803170832280.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Morten Welinder <mwelinder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 17:04:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbHnL-0002da-MF
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 17:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbYCQQBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 12:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752075AbYCQQBw
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 12:01:52 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43703 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751741AbYCQQBv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Mar 2008 12:01:51 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2HFvbq1018267
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Mar 2008 08:57:38 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2HFuRCb019434;
	Mon, 17 Mar 2008 08:56:28 -0700
In-Reply-To: <alpine.LFD.1.00.0803170832280.3020@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-103.3 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77443>



On Mon, 17 Mar 2008, Linus Torvalds wrote:
>
> IOW, the real "checking" is taking place in "create_file()", so if the 
> unlinking failed (due to a read-only directory or something), that's where 
> we'll do the proper error reporting.

Thinking about this, I'm probably full of sh*t.

My argument is admittedly true in general, but there is one case it is 
*not* true for: if the old entry was a symlink.

IOW, let's imagine that the directory is read-only (or other permission 
issue), and we want to unlink the old symlink, which points somewhere we 
can write to. In that case, the symlink removal is important, because we 
won't necessarily catch the error when we create the file in place later 
(because that will just follow the symlink).

So I retract my statement. We *should* check the result of the unlink.

So maybe something like this (which does the "avoid Solaris-is-crap"
issue too by moving the unlink to being after the directory test).

Untested.

		Linus

---
 entry.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/entry.c b/entry.c
index 44f4b89..222aaa3 100644
--- a/entry.c
+++ b/entry.c
@@ -218,7 +218,6 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 		 * to emulate by hand - much easier to let the system
 		 * just do the right thing)
 		 */
-		unlink(path);
 		if (S_ISDIR(st.st_mode)) {
 			/* If it is a gitlink, leave it alone! */
 			if (S_ISGITLINK(ce->ce_mode))
@@ -226,7 +225,8 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 			if (!state->force)
 				return error("%s is a directory", path);
 			remove_subtree(path);
-		}
+		} else if (unlink(path))
+			return error("unable to unlink old '%s' (%s)", path, strerror(errno));
 	} else if (state->not_new)
 		return 0;
 	create_directories(path, state);
