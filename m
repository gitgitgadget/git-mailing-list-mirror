From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] tig-0.11
Date: Thu, 10 Apr 2008 00:02:13 -0400
Message-ID: <20080410040213.GA29618@sigill.intra.peff.net>
References: <20080406200533.GA20537@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Thu Apr 10 06:03:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjo0G-000516-D1
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 06:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbYDJECQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Apr 2008 00:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbYDJECQ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 00:02:16 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4297 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750695AbYDJECP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 00:02:15 -0400
Received: (qmail 7039 invoked by uid 111); 10 Apr 2008 04:02:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 10 Apr 2008 00:02:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Apr 2008 00:02:13 -0400
Content-Disposition: inline
In-Reply-To: <20080406200533.GA20537@diku.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79165>

On Sun, Apr 06, 2008 at 10:05:33PM +0200, Jonas Fonseca wrote:

> stay up to date. Finally, add a blame view accessible from the comman=
d
> line (tig blame [rev] file), status view as well as the tree view (by
> pressing 'B').

Hi Jonas,

Thanks for all your hard work.  I have really been enjoying the new
blame view; blame was the only reason I ever used git-gui, and now I ca=
n
stay in the terminal all the time.

One feature that I have often wanted when using the blame view is to
restart the blame from the parent commit of a blamed commit. That is,
given a line like:

  2007-08-22 19:36 Jonas Fonseca       776bf2a   15=E2=94=82 #include "=
config.h"

I look at 776bf2a, and realize that there was some other interesting
form of the line _before_ that commit. So I want to start reblaming at
776bf2a^.

Below is an initial attempt at a patch, but it has some problems:

  - the interface is a bit klunky. Since commits may have multiple
    parents, it seemed wrong to always just choose the first parent.
    I chose '1' to reblame from the first parent and '2' from the secon=
d
    (and obviously 3-9 could do the same).

    My thought was that the same functionality could be applied to the
    commit viewer to jump to the parent. But maybe grabbing a string an=
d
    appending it to the commit id would make the most sense.

  - it reloads the blame view with new parameters, which will put the
    cursor back at line 1. It would be nice to stay at approximately th=
e
    same line (approximate because the line numbers will change; just
    staying at the same line number makes sense to me).

    I tried a few things, but it looks like we throw out the line
    numbers when we do a reload. I tried saving the line number and
    trying to scroll to it afterwards, but there is some trickery
    required because we have to wait until the view is loaded again. Is
    there any sane way to do this within the current framework?

  - opening a blame view, blaming a parent, and then opening the diff
    viewer can cause a segfault. I assume I'm violating some assumption
    through my open_view() call. Since the patch is only about 15 lines=
,
    I'm hoping there's something obvious you can comment on.

-Peff

---
diff --git a/tig.c b/tig.c
index a3d2232..7a5497a 100644
--- a/tig.c
+++ b/tig.c
@@ -371,6 +371,8 @@ sq_quote(char buf[SIZEOF_STR], size_t bufsize, cons=
t char *src)
 	REQ_(STATUS_MERGE,	"Merge file using external tool"), \
 	REQ_(TREE_PARENT,	"Switch to parent directory in tree view"), \
 	REQ_(EDIT,		"Open in editor"), \
+	REQ_(PARENT_ONE,	"Go to first parent"), \
+	REQ_(PARENT_TWO,	"Go to second parent"), \
 	REQ_(NONE,		"Do nothing")
=20
=20
@@ -771,6 +773,8 @@ static struct keybinding default_keybindings[] =3D =
{
 	{ 'M',		REQ_STATUS_MERGE },
 	{ ',',		REQ_TREE_PARENT },
 	{ 'e',		REQ_EDIT },
+	{ '1',		REQ_PARENT_ONE },
+	{ '2',		REQ_PARENT_TWO },
=20
 	/* Using the ncurses SIGWINCH handler. */
 	{ KEY_RESIZE,	REQ_SCREEN_RESIZE },
@@ -3678,6 +3682,32 @@ blame_request(struct view *view, enum request re=
quest, struct line *line)
 		open_view(view, REQ_VIEW_DIFF, flags);
 		break;
=20
+	case REQ_PARENT_ONE:
+	case REQ_PARENT_TWO:
+		if (!blame->commit) {
+			report("No commit loaded yet");
+			break;
+		}
+
+		if (!strcmp(blame->commit->id, "000000000000000000000000000000000000=
0000")) {
+			report("No commit selected");
+			break;
+		}
+
+		string_ncopy(opt_ref, blame->commit->id, 40);
+		switch (request) {
+		case REQ_PARENT_ONE:
+			string_add(opt_ref, 40, "^1");
+			break;
+		case REQ_PARENT_TWO:
+			string_add(opt_ref, 40, "^2");
+			break;
+		default:
+			break;
+		}
+		open_view(view, REQ_VIEW_BLAME, flags|OPEN_RELOAD);
+		break;
+
 	default:
 		return request;
 	}
