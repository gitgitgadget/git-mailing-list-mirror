From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] daemon: report inaccessible repositories to user
Date: Thu, 22 Apr 2010 17:21:53 -0500
Message-ID: <20100422222153.GA12000@progeny.tock>
References: <z2o3abd05a91004211417v263d5a0eg497341ddf7bd79a5@mail.gmail.com>
 <20100421221953.GA25348@progeny.tock>
 <7vwrw0573t.fsf@alter.siamese.dyndns.org>
 <20100422094153.GA504@progeny.tock>
 <20100422124453.GA30328@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Aghiles <aghilesk@gmail.com>,
	git list <git@vger.kernel.org>, Kim Ebert <kd7ike@gmail.com>,
	Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Fri Apr 23 00:21:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O54mH-0003jj-SS
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 00:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742Ab0DVWVj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 18:21:39 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:43450 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689Ab0DVWVh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 18:21:37 -0400
Received: by ywh32 with SMTP id 32so5157925ywh.33
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 15:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=deHc7mg1FLsjvVCIPuZhK+EYoe9781sbeta20LWYpE8=;
        b=iHRbdKtWywxGQ4dyVDZ6iGD0TcXD7W4yZ3ZpxP3bEdWX/CjDFNqu78wnYv2i6a4C2J
         F0syw3+KNYQEv3YGu0ioenUFLvex97O73yqHuKJwdR9c6l/p/kNFseR6p2Ql3dE8jlz2
         GxckBBWoiwTmf6eweXYGVIVA9qIHfXQBgcxUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=VtgIXCreznly+Y5ERte6l4QCAMhm3CGiislG7pOSx3iN6mVGVuQs81QMP9K+mr7XS4
         ArPKXUyb9/cEQoNt+hqBJtjH7Ri4q4qBC8WXtKaUrpVrjBTYW1uvqm34A9oJKvzRTf9+
         X02g39bsm7zGMrWvszuq4AUYVpzF5bDphNlqg=
Received: by 10.150.213.16 with SMTP id l16mr5356763ybg.108.1271974897013;
        Thu, 22 Apr 2010 15:21:37 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm236157iwn.15.2010.04.22.15.21.35
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 22 Apr 2010 15:21:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100422124453.GA30328@LK-Perkele-V2.elisa-laajakaista.fi>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145573>

This is a follow-up to v1.6.1-rc1~101 (connect.c: add a way for
git-daemon to pass an error back to client, 2008-11-01).  Although
not all clients support that protocol extension yet, it should be safe
to start using it anyway, as explained below.

This patch teaches =E2=80=98git daemon=E2=80=99 to let the client know =
when the
request to access the repository was denied.  Instead of just hanging
up, now the server lets the client know that access was denied, with a
carefully worded error that echoes the request:

  fatal: remote error: /foo/example: unreadable or fetching not allowed=
=2E
  fatal: remote error: /foo/example: unreadable or pushing not allowed.
  fatal: remote error: /foo/example: unreadable or snapshotting not all=
owed.

The failure could be due to one of a few causes.  The message does not
distinguish them:

 - chdir() failure
 - the protocol was disabled
 - not a git repository
 - not marked for export

Non-admin clients have no reason to care --- all of these situations
represent the same =E2=80=9Cnot a public repository=E2=80=9D condition.=
  Server
admins, on the other hand, would care a great deal to know that the
daemon does not reveal information about the machine=E2=80=99s configur=
ation
(such as what directories exist) aside from what requests it is
configured to honor.

The corresponding safety for protocol helpers used over ssh has been
in place since v0.99.9k^2~54 (Server-side support for user-relative
paths, 2005-11-17).

The error message used does _not_ match the output from backends
(which is sent to stderr rather than to the client, anyway) when
enter_repo() fails.  That is fine since =E2=80=98git daemon=E2=80=99 al=
ready checks
that the repository exists by calling enter_repo() itself.

Pre-1.6.1 git versions will treat the error request as a breach of
protocol.  The result is an acceptable if somewhat funny message.

  fatal: protocol error: expected sha/ref, got 'ERR /foo/example:
  unreadable or fetching not allowed.'

Thanks to Dscho, Ilari, and Andreas for help.  Thanks especially to
Ilari for explaining how this should work.

Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Cc: Andreas Ericsson <ae@op5.se>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Ilari Liusvaara wrote:

> There are few subcases of daemon-level errors:
[...]
> So, pretty much the only daemon-level errors with feedback required
> would be one for invalid repository and disabled service. How about:
>=20
> "foo/example: unreadable or anonymous fetching not allowed."
> "foo/example: unreadable or anonymous pushing not allowed."
> "foo/example: unreadable or anonymous snapshotting not allowed."
> "fooserv: requested service unknown."
>=20
> And all of these can be sent over ERR. I don't see need for using
> sidebands.

I omitted the qualifier =E2=80=9Canonymous=E2=80=9D in case we want to =
reuse these
messages for authenticated situations.  I haven=E2=80=99t thought about=
 it
deeply, though.

I would also like to write tests.  To begin with, it might be easiest
to test in inetd mode to avoid allocating a port for it.

Anyway, that shouldn=E2=80=99t hold up giving you a chance to nak the p=
atch. :)

Thanks for the pointers.  ERR packets do seem like the right way to
do this.

Jonathan

 daemon.c |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/daemon.c b/daemon.c
index a90ab10..732a339 100644
--- a/daemon.c
+++ b/daemon.c
@@ -222,6 +222,7 @@ static char *path_ok(char *directory)
 typedef int (*daemon_service_fn)(void);
 struct daemon_service {
 	const char *name;
+	const char *description;
 	const char *config_name;
 	daemon_service_fn fn;
 	int enabled;
@@ -231,6 +232,12 @@ struct daemon_service {
 static struct daemon_service *service_looking_at;
 static int service_enabled;
=20
+static void report_inaccessible(char *dir, struct daemon_service *serv=
ice)
+{
+	packet_write(1, "ERR %s: unreadable or %s not allowed.\n",
+	             dir, service->description);
+}
+
 static int git_daemon_config(const char *var, const char *value, void =
*cb)
 {
 	if (!prefixcmp(var, "daemon.") &&
@@ -252,12 +259,15 @@ static int run_service(char *dir, struct daemon_s=
ervice *service)
=20
 	if (!enabled && !service->overridable) {
 		logerror("'%s': service not enabled.", service->name);
+		report_inaccessible(dir, service);
 		errno =3D EACCES;
 		return -1;
 	}
=20
-	if (!(path =3D path_ok(dir)))
+	if (!(path =3D path_ok(dir))) {
+		report_inaccessible(dir, service);
 		return -1;
+	}
=20
 	/*
 	 * Security on the cheap.
@@ -272,6 +282,7 @@ static int run_service(char *dir, struct daemon_ser=
vice *service)
=20
 	if (!export_all_trees && access("git-daemon-export-ok", F_OK)) {
 		logerror("'%s': repository not exported.", path);
+		report_inaccessible(dir, service);
 		errno =3D EACCES;
 		return -1;
 	}
@@ -286,6 +297,7 @@ static int run_service(char *dir, struct daemon_ser=
vice *service)
 	if (!enabled) {
 		logerror("'%s': service not enabled for '%s'",
 			 service->name, path);
+		report_inaccessible(dir, service);
 		errno =3D EACCES;
 		return -1;
 	}
@@ -362,9 +374,9 @@ static int receive_pack(void)
 }
=20
 static struct daemon_service daemon_service[] =3D {
-	{ "upload-archive", "uploadarch", upload_archive, 0, 1 },
-	{ "upload-pack", "uploadpack", upload_pack, 1, 1 },
-	{ "receive-pack", "receivepack", receive_pack, 0, 1 },
+	{ "upload-archive", "snapshotting", "uploadarch", upload_archive, 0, =
1 },
+	{ "upload-pack", "fetching", "uploadpack", upload_pack, 1, 1 },
+	{ "receive-pack", "pushing", "receivepack", receive_pack, 0, 1 },
 };
=20
 static void enable_service(const char *name, int ena)
--=20
1.7.1.rc2.8.ga54f9
