From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Be more verbose when checkout takes a long time
Date: Sat, 23 Feb 2008 13:36:08 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802231323590.21332@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 23 22:37:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT23Q-0006M6-Mg
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 22:37:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755737AbYBWVgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 16:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755397AbYBWVgd
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 16:36:33 -0500
Received: from smtp1.linux-foundation.org ([207.189.120.13]:60965 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755250AbYBWVgc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Feb 2008 16:36:32 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1NLa9bU010352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 23 Feb 2008 13:36:11 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1NLa82h016134;
	Sat, 23 Feb 2008 13:36:09 -0800
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.099 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74856>


So I find it irritating when git thinks for a long time without telling me 
what's taking so long. And by "long time" I definitely mean less than two 
seconds, which is already way too long for me.

This hits me when doing a large pull and the checkout takes a long time, 
or when just switching to another branch that is old and again checkout 
takes a while.

Now, git read-tree already had support for the "-v" flag that does nice 
updates about what's going on, but it was delayed by two seconds, and if 
the thing had already done more than half by then it would be quiet even 
after that, so in practice it meant that we migth be quiet for up to four 
seconds. Much too long.

So this patch changes the timeout to just one second, which makes it much 
more palatable to me.

The other thing this patch does is that "git checkout" now doesn't disable 
the "-v" flag when doing its thing, and only disables the output when 
given the -q flag. Quite frankly, I'm not really sure why it disabled 
error messages in the first place: it used to do

	merge_error=$(git read-tree .. 2>&1) || (
		case "$merge" in
		'')
			echo >&2 "$merge_error"
			exit 1 ;;
		...

which obviously meant that the "-v" flag was useless, because it was 
suppressed by the fact that any outpu just went to "merge_error" and then 
printed just once if we didn't do a merge.

Now, I'm sure this had a good reason (for the "git checkout -m" case), but 
it did make the common case of git-checkout really annoying. So I just 
removed that whole "suppress error messages from git-read-tree" thing. 
People who use -m all the time probably disagree with this patch. I dunno.

Anyway, with this I no longer get that annoying pregnant pause when doing 
big branch switches.

Comments?

		Linus

---
 git-checkout.sh |    3 +--
 unpack-trees.c  |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index bd74d70..4b07fc4 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -210,10 +210,9 @@ then
     git read-tree $v --reset -u $new
 else
     git update-index --refresh >/dev/null
-    merge_error=$(git read-tree -m -u --exclude-per-directory=.gitignore $old $new 2>&1) || (
+    git read-tree $v -m -u --exclude-per-directory=.gitignore $old $new || (
 	case "$merge" in
 	'')
-		echo >&2 "$merge_error"
 		exit 1 ;;
 	esac
 
diff --git a/unpack-trees.c b/unpack-trees.c
index ec558f9..0f62609 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -301,7 +301,7 @@ static void check_updates(struct cache_entry **src, int nr,
 		}
 
 		progress = start_progress_delay("Checking out files",
-						total, 50, 2);
+						total, 50, 1);
 		cnt = 0;
 	}
 
