From: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
Subject: [PATCH] Add a commit.signoff configuration variable to always use --signoff
Date: Sat, 27 Dec 2008 10:03:16 +0100
Message-ID: <1230368596-6865-1-git-send-email-dato@net.com.org.es>
References: <7v63l6f1mc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Dec 27 10:04:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGV6C-0005Y6-Vy
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 10:04:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbYL0JD1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Dec 2008 04:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751982AbYL0JD0
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 04:03:26 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:4336
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbYL0JDY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 04:03:24 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 966CA801BF66;
	Sat, 27 Dec 2008 10:03:22 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LGV4m-0001oM-58; Sat, 27 Dec 2008 10:03:16 +0100
X-Mailer: git-send-email 1.6.1.307.g07803
In-Reply-To: <7v63l6f1mc.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103992>

Signed-off-by: Adeodato Sim=C3=B3 <dato@net.com.org.es>
---

* Junio C Hamano [Sat, 27 Dec 2008 00:44:59 -0800]:

> > +commit.signoff::
> > +       If set, 'git-commit' will always add a Signed-off-by line.

> It is not a big deal, but my first reaction to the above was "S-o-b b=
y
> whom?  It misses details and does not say where to find them".

> How about "if set, 'git commit' will behave as if '-s' option was giv=
en",
> so that we can leave the details of whose S-o-b line to generate and =
such
> to the description of "git commit -s" manual page?

Changed.

> > I'll send an amended patch (or should I send an incremental/extra
> > one instead?)

I didn't get an answer to this, so I'm sending an amended one, hoping
that's the correct thing to do in this land.

> Another problem that you seem to have missed about M-F-T is that whil=
e you
> solicited responses from general public by CC'ing the list (which all=
owed
> me to respond to you), by forcing the response go only to the list, y=
ou
> excluded people on the To: and Cc: list of your original message from=
 my
> response.  You required them to be subscribed to the list, if they wa=
nt to
> be kept in the loop.

No, not really, because Mutt will add to the M-F-T header all addresses
that appear on the To or Cc headers.

 Documentation/config.txt     |    9 +++++++++
 Documentation/git-commit.txt |    3 ++-
 builtin-commit.c             |    5 +++++
 3 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 52786c7..4d0a79b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -591,6 +591,15 @@ color.ui::
 commit.template::
 	Specify a file to use as the template for new commit messages.
=20
+commit.signoff::
+	If set, 'git commit' will behave as if '-s' option was given.
+	Please use this option with care: by enabling it, you're stating
+	that all your commits will invariably meet the S-o-b
+	requirements for any project you send patches to. It's probably
+	best to only use it from your private repositories' .git/config
+	file, and only for projects who require a S-o-b as proof of
+	provenance of the patch, and not of its correctness or quality.
+
 diff.autorefreshindex::
 	When using 'git-diff' to compare with work tree
 	files, do not consider stat-only change as changed.
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.tx=
t
index b5d81be..abab839 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -96,7 +96,8 @@ OPTIONS
 -s::
 --signoff::
 	Add Signed-off-by line by the committer at the end of the commit
-	log message.
+	log message. This overrides the `commit.signoff` configuration
+	variable.
=20
 -n::
 --no-verify::
diff --git a/builtin-commit.c b/builtin-commit.c
index e88b78f..fc09539 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -929,6 +929,11 @@ static int git_commit_config(const char *k, const =
char *v, void *cb)
 	if (!strcmp(k, "commit.template"))
 		return git_config_string(&template_file, k, v);
=20
+	if (!strcmp(k, "commit.signoff")) {
+		signoff =3D git_config_bool(k, v);
+		return 0;
+	}
+
 	return git_status_config(k, v, cb);
 }
=20
--=20
1.6.1.307.g07803
