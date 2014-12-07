From: Onno Kortmann <onno@gmx.net>
Subject: Re: [PATCH] Show number of commits being rebased interactively
Date: Sun, 07 Dec 2014 21:56:29 +0100
Message-ID: <5484BEFD.7060906@gmx.net>
References: <5460E893.7080003@gmx.net> <xmqq388tpyls.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 07 21:56:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xxish-0002aB-CX
	for gcvg-git-2@plane.gmane.org; Sun, 07 Dec 2014 21:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753411AbaLGU4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2014 15:56:35 -0500
Received: from mout.gmx.net ([212.227.15.15]:59615 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752658AbaLGU4e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2014 15:56:34 -0500
Received: from [192.168.6.43] ([95.119.207.42]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0LlESk-1XNpYu13Qs-00azFO; Sun, 07 Dec 2014 21:56:30
 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <xmqq388tpyls.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:RqhdXrVfY58fLzrRzJSek7L1awVG78722uAchAXrWydmFCbhXBb
 a75/cvf200/CbUbkph3Q+O97X3LJ8cB7RAqFIBxsxHYANeFat1YfQyzwvdpc9h1hZXv54xG
 TAgYdTOqsnn+O51vm8S+YHAJegg3C5eM1gDniVQ1RQ7aJJQbu9LH11GMyRGcdMFvW5O1zfy
 9ZbK6Wizqt0kcfqQzAUEQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260997>

Hi,

> These lines above "---" will become the only log message text, which
> is probably not what you intended.  Use "-- >8 --" marker instead
> (that is a perforation line with a pair of scissors on it)?
Thanks, hopefully fixed below.

>> +commitcount=$(git stripspace --strip-comments <"$todo"  | wc -l)
>
> Does this count the number of commits?  I suspect it at least needs
> to filter "x|exec" out.
Very true - after reading this, I learned about the '-x' option
to git-rebase -i :-)
I changed the patch so it now properly looks for '^pick ' patterns. I
hope this should do the trick under all circumstances? In the case
of having 'exec' lines interspersed, the $commitcount becomes a lot
less useful (no comparison to editor line numbers), though.

Cheers,

Onno
8< 8< 8< 8< 8< 8< 8< 8< 8<
Subject: [PATCH] Show number of commits being rebased interactively

During 'rebase -i', one wrong edit in a long rebase session might
inadvertently drop commits. This change shows the total number of
commits in the comments below the commit list. After the rebase
edit, the number can be quickly compared to the line number of
the last commit - by scrolling to the last entry in the rebase
TODO list. This gives peace of mind that no commits have been
lost in the edit.

Signed-off-by: Onno Kortmann <onno@gmx.net>
---
 git-rebase--interactive.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index b64dd28..b26e5e6 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1031,9 +1031,13 @@ test -s "$todo" || echo noop >> "$todo"
 test -n "$autosquash" && rearrange_squash "$todo"
 test -n "$cmd" && add_exec_commands "$todo"

+commitcount=$(git stripspace --strip-comments <"$todo"  | \
+	      sane_grep "^pick " | \
+	      wc -l)
+
 cat >>"$todo" <<EOF

-$comment_char Rebase $shortrevisions onto $shortonto
+$comment_char Rebase $shortrevisions onto $shortonto ($commitcount commit(s))
 EOF
 append_todo_help
 git stripspace --comment-lines >>"$todo" <<\EOF
-- 
2.2.0.rc0.18.g1c09766
