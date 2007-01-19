From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>
Subject: [PATCH] make --exec=... option to git-push configurable
Date: Fri, 19 Jan 2007 13:46:16 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070119124616.GA3012@cepheus>
References: <20070119124300.GA2995@cepheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 19 13:46:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7t8R-0002Fr-Le
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 13:46:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbXASMqU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 19 Jan 2007 07:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965109AbXASMqU
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 07:46:20 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:34967 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965105AbXASMqT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jan 2007 07:46:19 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1H7t8M-0001AF-HE; Fri, 19 Jan 2007 13:46:18 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id l0JCkGSQ012741;
	Fri, 19 Jan 2007 13:46:16 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id l0JCkGBf012740;
	Fri, 19 Jan 2007 13:46:16 +0100 (MET)
To: git@vger.kernel.org
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <zeisberg@informatik.uni-freiburg.de>,
	git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <20070119124300.GA2995@cepheus>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37178>

Having to specify git push --exec=3D... is annoying if you cannot have
git-receivepack in your PATH on the remote side (or don't want to).

This introduces the config item remote.<name>.receivepack to override
the default value (which is "git-receive-pack").

Signed-off-by: Uwe Kleine-K=F6nig <zeisberg@informatik.uni-freiburg.de>
---

This is the already known patch with s/pushexec/receivepack/

Just now I realized that I missed to add a In-Reply-To: to the first
mail.  I hope you can match it anyhow.

 Documentation/config.txt |    4 ++++
 builtin-push.c           |   11 +++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index da7fde5..f1f409d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -356,6 +356,10 @@ remote.<name>.push::
 	The default set of "refspec" for gitlink:git-push[1]. See
 	gitlink:git-push[1].
=20
+remote.<name>.receivepack::
+	The default program to execute on the remote side when pulling.  See
+	option \--exec of gitlink:git-push[1].
+
 repack.usedeltabaseoffset::
 	Allow gitlink:git-repack[1] to create packs that uses
 	delta-base offset.  Defaults to false.
diff --git a/builtin-push.c b/builtin-push.c
index ba7981f..6b3c03b 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -143,6 +143,7 @@ static const char *config_repo;
 static int config_repo_len;
 static int config_current_uri;
 static int config_get_refspecs;
+static int config_get_receivepack;
=20
 static int get_remote_config(const char* key, const char* value)
 {
@@ -157,6 +158,15 @@ static int get_remote_config(const char* key, cons=
t char* value)
 		else if (config_get_refspecs &&
 			 !strcmp(key + 7 + config_repo_len, ".push"))
 			add_refspec(xstrdup(value));
+		else if (config_get_receivepack &&
+			 !strcmp(key + 7 + config_repo_len, ".receivepack")) {
+			if (!execute) {
+				char *ex =3D xmalloc(strlen(value) + 8);
+				sprintf(ex, "--exec=3D%s", value);
+				execute =3D ex;
+			} else
+				error("more than one receivepack given, using the first");
+		}
 	}
 	return 0;
 }
@@ -168,6 +178,7 @@ static int get_config_remotes_uri(const char *repo,=
 const char *uri[MAX_URI])
 	config_current_uri =3D 0;
 	config_uri =3D uri;
 	config_get_refspecs =3D !(refspec_nr || all || tags);
+	config_get_receivepack =3D (execute =3D=3D NULL);
=20
 	git_config(get_remote_config);
 	return config_current_uri;
--=20
1.5.0.rc1.g581a


--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3De+%5E+%28i+pi%29
