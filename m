From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Rebase/cherry-picking idea
Date: Mon, 26 Nov 2007 13:34:16 +0100
Message-ID: <CDF48716-F198-4B33-A5F5-8A2DE1F177EB@wincent.com>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com> <C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr> <D21294CA-6FD0-40F5-B0D6-5155865DA69A@wincent.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 13:34:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwdAq-0002FV-0n
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 13:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbXKZMe0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Nov 2007 07:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbXKZMe0
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 07:34:26 -0500
Received: from wincent.com ([72.3.236.74]:38471 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751263AbXKZMeZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Nov 2007 07:34:25 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAQCYHD3005997;
	Mon, 26 Nov 2007 06:34:18 -0600
In-Reply-To: <D21294CA-6FD0-40F5-B0D6-5155865DA69A@wincent.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66065>

El 26/11/2007, a las 12:27, Wincent Colaiuta escribi=F3:

> El 26/11/2007, a las 10:32, Benoit Sigoure escribi=F3:
>
>> On Nov 26, 2007, at 10:02 AM, Wincent Colaiuta wrote:
>>
>>> In using "git-rebase --interactive" to re-order commits you =20
>>> occasionally get conflicts and will see a message like this:
>>>
>>> 	When commiting, use the option '-c %s' to retain authorship and =20
>>> message
>>>
>>> I was thinking that it might be nice to stash away this commit id =20
>>> somewhere in GIT_DIR so that the user didn't have to explicitly =20
>>> remember it, and add a new switch to git-commit that could be used =
=20
>>> to automatically use that stashed commit id, something like:
>>>
>>> 	git commit --retain
>>>
>>> Although I most often see this kind of message in interactive =20
>>> rebasing, the message is generated in builtin-revert.c when cherry-=
=20
>>> picking, so you can also see it in any other situation where =20
>>> you're cherry picking and there's a conflict.
>>>
>>> What do people think? Would this be a nice usability improvement? =20
>>> Or is it adding clutter?
>>
>>
>> I'm not sure but I think this message is just some unwanted =20
>> (misleading) noise, since when you rebase, once you solve the =20
>> conflicts, you git-rebase --continue, you don't git-commit.
>
> Looks like you're right. I just did a simple test and it turns out =20
> that after a conflict, this:
>
> 	git commit -c ...
> 	git rebase --continue
>
> Produces exactly the same history as this:
>
> 	git rebase --continue
>
> So I think that misleading noise needs to be suppressed or reworded =20
> when rebasing. Will look into it.

How about something like this? It would obviously be nice if we could =20
avoid adding another option to builtin-revert; perhaps when/if git-=20
rebase becomes a builtin we can avoid that. The other alternative, and =
=20
probably one I like I bit more, would be to auto-detect that a rebase =20
is in progress by looking inside the GIT_DIR, although that would also =
=20
alter the behaviour of manual invocations of git-revert and git-cherry-=
=20
pick during an interactive rebase (do people actually do that?). What =20
do you think?

diff --git a/builtin-revert.c b/builtin-revert.c
index a0586f9..36e36c3 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -30,7 +30,7 @@ static const char * const cherry_pick_usage[] =3D {
  	NULL
  };

-static int edit, no_replay, no_commit, mainline;
+static int edit, no_replay, no_commit, rebasing, mainline;
  static enum { REVERT, CHERRY_PICK } action;
  static struct commit *commit;

@@ -50,6 +50,7 @@ static void parse_args(int argc, const char **argv)
  		OPT_BOOLEAN('e', "edit", &edit, "edit the commit message"),
  		OPT_BOOLEAN('x', NULL, &no_replay, "append commit name when cherry-=
=20
picking"),
  		OPT_BOOLEAN('r', NULL, &noop, "no-op (backward compatibility)"),
+		OPT_BOOLEAN(0, "rebasing", &rebasing, "use rebase mode"),
  		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
  		OPT_END(),
  	};
@@ -352,11 +353,16 @@ static int revert_or_cherry_pick(int argc, const =
=20
char **argv)
  		}
  		if (close(msg_fd) || commit_lock_file(&msg_file) < 0)
  			die ("Error wrapping up %s", defmsg);
+		if (rebasing)
+			message =3D "run 'git rebase --continue' "
+			    "or 'git rebase --abort'";
+		else
+			message =3D "commit the result";
  		fprintf(stderr, "Automatic %s failed.  "
  			"After resolving the conflicts,\n"
  			"mark the corrected paths with 'git add <paths>' "
-			"and commit the result.\n", me);
-		if (action =3D=3D CHERRY_PICK) {
+			"and %s.\n", me, message);
+		if (action =3D=3D CHERRY_PICK && !rebasing) {
  			fprintf(stderr, "When commiting, use the option "
  				"'-c %s' to retain authorship and message.\n",
  				find_unique_abbrev(commit->object.sha1,
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index bf44b6a..5afb843 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -117,7 +117,7 @@ pick_one () {
  		sha1=3D$(git rev-parse --short $sha1)
  		output warn Fast forward to $sha1
  	else
-		output git cherry-pick "$@"
+		output git cherry-pick --rebasing "$@"
  	fi
  }

@@ -187,7 +187,7 @@ pick_one_preserving_merges () {
  			fi
  			;;
  		*)
-			output git cherry-pick "$@" ||
+			output git cherry-pick --rebasing "$@" ||
  				die_with_patch $sha1 "Could not pick $sha1"
  			;;
  		esac
