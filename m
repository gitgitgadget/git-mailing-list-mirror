From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>
Subject: Re: [PATCH RFC] new config option remote.<name>.pushexec
Date: Wed, 17 Jan 2007 17:44:10 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070117164410.GA5950@cepheus>
References: <20070116150259.GA2439@cepheus> <Pine.LNX.4.63.0701161614070.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070116162645.GA18894@informatik.uni-freiburg.de> <20070116200847.GB29100@spearce.org> <Pine.LNX.4.63.0701162129430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 17 17:44:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Dtq-0006f8-CW
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 17:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbXAQQoQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 17 Jan 2007 11:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbXAQQoQ
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 11:44:16 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:53529 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932539AbXAQQoO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jan 2007 11:44:14 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1H7DtU-0001sI-Ti; Wed, 17 Jan 2007 17:44:13 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id l0HGiAM0020589;
	Wed, 17 Jan 2007 17:44:10 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id l0HGiA1J020588;
	Wed, 17 Jan 2007 17:44:10 +0100 (MET)
To: git@vger.kernel.org
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <zeisberg@informatik.uni-freiburg.de>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0701162129430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37014>

git push --exec=3D... is fine, but having it to specify every time is
annoying.

This sets the default remote program for pushing to remote <name>.

Signed-off-by: Uwe Kleine-K=F6nig <zeisberg@informatik.uni-freiburg.de>
---
 Documentation/config.txt |    4 ++++
 builtin-push.c           |   11 +++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

This patch fixes two of three shortcomings pointed out at initial
sending.  The compiler warning is gone (but I'm not 100% sure if it is
fixed correctly or if only my compiler doesn't warn) and the commandlin=
e
can overwrite the value now without a warning.

I tried to do the symmetric part for fetch, but that shell script is to=
o
complicated for me and so I let this part to s.o. being more familiar
with git-fetch.sh.

Best regards
Uwe

diff --git a/Documentation/config.txt b/Documentation/config.txt
index da7fde5..bd4f72a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -356,6 +356,10 @@ remote.<name>.push::
 	The default set of "refspec" for gitlink:git-push[1]. See
 	gitlink:git-push[1].
=20
+remote.<name>.pushexec::
+	The default program to execute on the remote side when pulling.  See
+	option \--exec of gitlink:git-push[1].
+
 repack.usedeltabaseoffset::
 	Allow gitlink:git-repack[1] to create packs that uses
 	delta-base offset.  Defaults to false.
diff --git a/builtin-push.c b/builtin-push.c
index 7a3d2bb..8ca5aee 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -143,6 +143,7 @@ static const char *config_repo;
 static int config_repo_len;
 static int config_current_uri;
 static int config_get_refspecs;
+static int config_get_pushexec;
=20
 static int get_remote_config(const char* key, const char* value)
 {
@@ -157,6 +158,15 @@ static int get_remote_config(const char* key, cons=
t char* value)
 		else if (config_get_refspecs &&
 			 !strcmp(key + 7 + config_repo_len, ".push"))
 			add_refspec(xstrdup(value));
+		else if (config_get_pushexec &&
+			 !strcmp(key + 7 + config_repo_len, ".pushexec")) {
+			if (!execute) {
+				char *ex =3D xmalloc(strlen(value) + 8);
+				sprintf(ex, "--exec=3D%s", value);
+				execute =3D ex;
+			} else
+				error("more than one pushexec given, using the first");
+		}
 	}
 	return 0;
 }
@@ -168,6 +178,7 @@ static int get_config_remotes_uri(const char *repo,=
 const char *uri[MAX_URI])
 	config_current_uri =3D 0;
 	config_uri =3D uri;
 	config_get_refspecs =3D !(refspec_nr || all || tags);
+	config_get_pushexec =3D (execute =3D=3D NULL);
=20
 	git_config(get_remote_config);
 	return config_current_uri;
--=20
1.5.0.rc1.g581a

--=20
Uwe Kleine-K=F6nig

main(){char*a=3D"main(){char*a=3D%c%s%c;printf(a,34,a,34%c";printf(a,34=
,a,34
,10);a=3D",10);a=3D%c%s%c;printf(a,34,a,34,10);}%c";printf(a,34,a,34,10=
);}
