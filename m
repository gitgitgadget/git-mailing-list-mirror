From: =?UTF-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: Re: branch.<branch>.merge and --format='%(upstream)'
Date: Wed, 17 Jun 2009 00:34:07 +0200
Message-ID: <1245191647-21353-1-git-send-email-santi@agolina.net>
References: <7v7hzcdvvr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 00:34:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGhET-0001yF-UO
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 00:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758699AbZFPWdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 18:33:49 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758063AbZFPWds
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 18:33:48 -0400
Received: from mail-fx0-f211.google.com ([209.85.220.211]:42593 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582AbZFPWdr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 18:33:47 -0400
Received: by fxm7 with SMTP id 7so1022880fxm.37
        for <git@vger.kernel.org>; Tue, 16 Jun 2009 15:33:48 -0700 (PDT)
Received: by 10.103.243.9 with SMTP id v9mr4809738mur.69.1245191628701;
        Tue, 16 Jun 2009 15:33:48 -0700 (PDT)
Received: from localhost (p5B0D49E4.dip.t-dialin.net [91.13.73.228])
        by mx.google.com with ESMTPS id j2sm16350283mue.12.2009.06.16.15.33.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Jun 2009 15:33:48 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.406.gd6a466
In-Reply-To: <7v7hzcdvvr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121722>


2009/6/16 Junio C Hamano <gitster@pobox.com>
>
> Jeff King <peff@peff.net> writes:
>
> > On Tue, Jun 16, 2009 at 01:08:02PM +0200, Santi B=C3=A9jar wrote:
> >
> >>   I've noticed that having branch.<branch>.merge set with the bran=
ch
> >> name, and not with the full ref, cause problems with
> >> --format=3D'%(upstream)'  and also with the "branch -av" and "git
> >> status" upstream branch outputs. But git-fetch and git-pull works =
ok,
> >> so it is a valid setting.
> >
> > Actually, it is broken in a lot of places. for-each-ref relies on t=
he
> > same code as "git status", "git checkout", etc, which will all fail=
 to
> > display tracking info. I believe the same code is also used for upd=
ating
> > tracking branches on push. So I'm not sure if it was ever intended =
to be
> > a valid setting.
>
> It wasn't.  Some places may accept them gracefully by either being ex=
tra
> nice or by accident.

And what about the comments in my reply. And in the branch.<name>.merge
docs says: The value is handled like the remote part of a refspec.

In fact I found it trying to implement a patch to get the local trackin=
g
for a given remote and branch. But it only works if you spell the branc=
h with
its full form:

$ git remote tracking origin master # does not work
$ git remote tracking origin refs/heads/master # does work
refs/remotes/origin/master

so I thought it would be better to resolve the %(upstream) first.

So if you know how to resolve this and or the %(upstream) issue, please=
 tell me.

Anyway, here you have the WIP patch to get the tracking branch, I'm not=
 sure
about the UI (or the script interface?), it is also a RFC.

---8<----
Subject: [RFC/PATCH]: Output tracking branch from remote and branch
---

Hi,

  as said above it is a RFC, specially for the UI, and also can anyone =
help
me with the:

$ git remote tracking origin master # does not work

case?

Thanks,
Santi

P.D: This case will be used in the "git pull --rebase remote branch" ca=
se.

 builtin-remote.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 709f8a6..03bcc27 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -665,6 +665,38 @@ static int remove_branches(struct string_list *bra=
nches)
 	return result;
 }
=20
+static int tracking(int argc, const char **argv)
+{
+	struct option options[] =3D {
+		OPT_END()
+	};
+	struct remote *remote;
+	static const char **refs =3D NULL;
+	int ref_nr =3D 0;
+	int i =3D 0;
+	struct refspec *refspec;
+
+	if (argc < 3)
+		usage_with_options(builtin_remote_usage, options);
+	remote =3D remote_get(argv[1]);
+	if (!remote)
+		die("No such remote: %s", argv[1]);
+	refs =3D xcalloc(argc + 1, sizeof(const char *));
+	for (i =3D 2; i < argc; i++) {
+		refs[ref_nr++] =3D argv[i];
+	}
+	refs[ref_nr] =3D NULL;
+	memset(&refspec, 0, sizeof(*refspec));
+	refspec =3D parse_fetch_refspec(ref_nr, refs);
+	for (i =3D 0; i < ref_nr ; i++) {
+		if (!remote_find_tracking(remote, &refspec[i]))
+			printf("%s\n", refspec[i].dst);
+		else
+			return 1;
+	}
+	return 0;
+}
+
 static int rm(int argc, const char **argv)
 {
 	struct option options[] =3D {
@@ -1348,6 +1380,8 @@ int cmd_remote(int argc, const char **argv, const=
 char *prefix)
 		result =3D show_all();
 	else if (!strcmp(argv[0], "add"))
 		result =3D add(argc, argv);
+	else if (!strcmp(argv[0], "tracking"))
+		result =3D tracking(argc, argv);
 	else if (!strcmp(argv[0], "rename"))
 		result =3D mv(argc, argv);
 	else if (!strcmp(argv[0], "rm"))
--=20
1.6.3.2.406.gd6a466
