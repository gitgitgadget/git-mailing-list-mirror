From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Thu, 4 Nov 2010 01:53:01 -0700
Message-ID: <914D7AE3-22D5-4069-B815-2B11A2897BE9@sb.org>
References: <1288847836-84882-1-git-send-email-kevin@sb.org> <vpq39rhzdht.fsf@bauges.imag.fr>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Nov 04 09:53:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDvZM-0007jZ-C6
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 09:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419Ab0KDIxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 04:53:08 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35356 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718Ab0KDIxG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 04:53:06 -0400
Received: by gwj21 with SMTP id 21so1163608gwj.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 01:53:06 -0700 (PDT)
Received: by 10.231.31.135 with SMTP id y7mr225778ibc.38.1288860785872;
        Thu, 04 Nov 2010 01:53:05 -0700 (PDT)
Received: from [10.0.1.14] ([24.130.32.253])
        by mx.google.com with ESMTPS id gy41sm12501431ibb.23.2010.11.04.01.53.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 01:53:05 -0700 (PDT)
In-Reply-To: <vpq39rhzdht.fsf@bauges.imag.fr>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160696>

On Nov 4, 2010, at 1:42 AM, Matthieu Moy wrote:

> Kevin Ballard <kevin@sb.org> writes:
> 
>> Add a new command "shell", which takes an option commit. It simply exits
>> to the shell with the commit (if given) and a message telling the user how
>> to resume the rebase.
> 
> "shell" sounds like you're going to execute something in a shell, not
> that you're going back to the shell. Looking at the commit message, I
> thought you had missed the "exec" command and re-implemented it.
> 
> What about "pause", abbreviated as "p" for the command name?

That sounds like a reasonable suggestion, except "p" is already taken by "pick".
I suppose this command could simply omit the short version.

---8<---
Subject: git-rebase--interactive.sh: Add new command "pause"

Add a new command "pause", which takes an optional comment. It simply exits
to the shell with the comment (if given) and a message telling the user how
to resume the rebase. This is effectively the same thing as "x false" but
much friendlier to the user.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
 git-rebase--interactive.sh |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a27952d..e29fd91 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -566,6 +566,26 @@ do_next () {
 			exit 1
 		fi
 		;;
+	pause)
+		read -r command comment < "$TODO"
+		mark_action_done
+		# can't use $sha1 here for same reason as "exec"
+		line=$(git rev-list --pretty=oneline -1 --abbrev-commit --abbrev=7 HEAD)
+		sha1="${line%% *}"
+		rest="${line#* }"
+		echo "$sha1" > "$DOTEST"/stopped-sha
+		warn "Stopped at $sha1... $rest"
+		if test -n "$comment"; then
+			warn
+			warn "	$comment"
+		fi
+		warn
+		warn "Once you are ready to continue, run"
+		warn
+		warn "	git rebase --continue"
+		warn
+		exit 0
+		;;
 	*)
 		warn "Unknown command: $command $sha1 $rest"
 		if git rev-parse --verify -q "$sha1" >/dev/null
@@ -998,6 +1018,7 @@ first and then run 'git rebase --continue' again."
 #  s, squash = use commit, but meld into previous commit
 #  f, fixup = like "squash", but discard this commit's log message
 #  x <cmd>, exec <cmd> = Run a shell command <cmd>, and stop if it fails
+#  pause = exit to the shell
 #
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.
-- 
1.7.3.2.195.gc69dde
