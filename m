From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Rebase/cherry-picking idea
Date: Mon, 26 Nov 2007 14:15:29 +0100
Message-ID: <451492C9-F3EA-4C37-A1AD-59FC72E0A0A2@wincent.com>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com> <C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr> <D21294CA-6FD0-40F5-B0D6-5155865DA69A@wincent.com> <CDF48716-F198-4B33-A5F5-8A2DE1F177EB@wincent.com> <474AC136.8060906@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Nov 26 14:16:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwdoX-0006c7-Ty
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 14:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804AbXKZNPf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Nov 2007 08:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752731AbXKZNPf
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 08:15:35 -0500
Received: from wincent.com ([72.3.236.74]:38552 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752724AbXKZNPe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Nov 2007 08:15:34 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAQDFUq5006764;
	Mon, 26 Nov 2007 07:15:31 -0600
In-Reply-To: <474AC136.8060906@viscovery.net>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66071>

El 26/11/2007, a las 13:51, Johannes Sixt escribi=F3:

> Wincent Colaiuta schrieb:
>> El 26/11/2007, a las 12:27, Wincent Colaiuta escribi=F3:
>>> So I think that misleading noise needs to be suppressed or =20
>>> reworded when rebasing. Will look into it.
>> How about something like this? It would obviously be nice if we =20
>> could avoid adding another option to builtin-revert; perhaps when/=20
>> if git-rebase becomes a builtin we can avoid that. The other =20
>> alternative, and probably one I like I bit more, would be to auto-=20
>> detect that a rebase is in progress by looking inside the GIT_DIR, =20
>> although that would also alter the behaviour of manual invocations =20
>> of git-revert and git-cherry-pick during an interactive rebase (do =20
>> people actually do that?). What do you think?
>
> Introduce an environment variable _GIT_CHERRY_PICK_HELP (note the =20
> leading underscore), which git-rebase sets; if it's set, git-cherry-=20
> pick uses that text instead of the usual one.

Good idea, quite a bit less cruddy:

diff --git a/builtin-revert.c b/builtin-revert.c
index a0586f9..5a57574 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -229,7 +229,7 @@ static int revert_or_cherry_pick(int argc, const =20
char **argv)
  	unsigned char head[20];
  	struct commit *base, *next, *parent;
  	int i;
-	char *oneline, *reencoded_message =3D NULL;
+	char *oneline, *reencoded_message =3D NULL, *help_message;
  	const char *message, *encoding;
  	const char *defmsg =3D xstrdup(git_path("MERGE_MSG"));

@@ -352,11 +352,13 @@ static int revert_or_cherry_pick(int argc, const =
=20
char **argv)
  		}
  		if (close(msg_fd) || commit_lock_file(&msg_file) < 0)
  			die ("Error wrapping up %s", defmsg);
+		help_message =3D getenv("_GIT_CHERRY_PICK_HELP");
  		fprintf(stderr, "Automatic %s failed.  "
  			"After resolving the conflicts,\n"
  			"mark the corrected paths with 'git add <paths>' "
-			"and commit the result.\n", me);
-		if (action =3D=3D CHERRY_PICK) {
+			"and %s.\n", me,
+			help_message ? help_message : "commit the result");
+		if (action =3D=3D CHERRY_PICK && !help_message) {
  			fprintf(stderr, "When commiting, use the option "
  				"'-c %s' to retain authorship and message.\n",
  				find_unique_abbrev(commit->object.sha1,
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index bf44b6a..e5f9810 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -117,6 +117,7 @@ pick_one () {
  		sha1=3D$(git rev-parse --short $sha1)
  		output warn Fast forward to $sha1
  	else
+		export _GIT_CHERRY_PICK_HELP=3D"run 'git rebase --continue'"
  		output git cherry-pick "$@"
  	fi
  }
@@ -187,6 +188,7 @@ pick_one_preserving_merges () {
  			fi
  			;;
  		*)
+			export _GIT_CHERRY_PICK_HELP=3D"run 'git rebase --continue'"
  			output git cherry-pick "$@" ||
  				die_with_patch $sha1 "Could not pick $sha1"
  			;;
