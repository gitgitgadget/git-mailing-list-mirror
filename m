From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] fetch-pack: use args.shallow to detect shallow clone instead of args.depth
Date: Thu, 19 Aug 2010 20:40:36 +1000
Message-ID: <1282214437-16384-2-git-send-email-pclouds@gmail.com>
References: <201008180854.18474.ComputerDruid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, computerdruid@gmail.com, joey@kitenet.net
X-From: git-owner@vger.kernel.org Thu Aug 19 13:27:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om3HM-0002Y3-QP
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 13:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785Ab0HSL1H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 07:27:07 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:46447 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670Ab0HSL1F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 07:27:05 -0400
Received: by pxi10 with SMTP id 10so659820pxi.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 04:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=p8IYpS9Rz64ktSyfWg5vNwSRBM63YWeOv0tJp6bNozA=;
        b=SZlzWN+GUAKexJhNo3EqbMRkxvHUQ1HsUfUgJ/eWawEeKdmkrBuCaAJ+gkKLWtmSKK
         MFmb9KKeHYL2B3rWSb+QQjwGgLMEJvKYFgkhacjfPGAKtycICwN9KxJbp/KLzquINrws
         TItbv04PAZjqS6v+ET6u/+iBxWyPbbX28n7+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=gZdAZ1pI37udXBXpZErFYepvZ6rXpOrxLjzEVksPkyX2mXgLAPMuG+59feIu56igCy
         Qn2o/S+G09IVQmWQNepwa/BhvLpFwNOWSPBN3/x8A5x7ceDnZvP0dr8HtAEOYsRQtdRg
         1B79yvIuI26zV04JzUTJ5S++MBHB0772I9yew=
Received: by 10.142.172.10 with SMTP id u10mr8182281wfe.213.1282217224400;
        Thu, 19 Aug 2010 04:27:04 -0700 (PDT)
Received: from dektop ([121.91.127.5])
        by mx.google.com with ESMTPS id q27sm1633490wfc.6.2010.08.19.04.26.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Aug 2010 04:27:03 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu, 19 Aug 2010 20:40:51 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <201008180854.18474.ComputerDruid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153916>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch-pack.c |   17 ++++++++++-------
 fetch-pack.h         |    3 ++-
 transport.c          |    9 +++++++--
 transport.h          |    1 +
 4 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index dbd8b7b..45d1824 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -167,7 +167,7 @@ enum ack_type {
=20
 static void consume_shallow_list(int fd)
 {
-	if (args.stateless_rpc && args.depth > 0) {
+	if (args.stateless_rpc && args.shallow) {
 		/* If we sent a depth we will get back "duplicate"
 		 * shallow and unshallow commands every time there
 		 * is a block of have lines exchanged.
@@ -283,12 +283,12 @@ static int find_common(int fd[2], unsigned char *=
result_sha1,
=20
 	if (is_repository_shallow())
 		write_shallow_commits(&req_buf, 1);
-	if (args.depth > 0)
+	if (args.shallow)
 		packet_buf_write(&req_buf, "deepen %d", args.depth);
 	packet_buf_flush(&req_buf);
 	state_len =3D req_buf.len;
=20
-	if (args.depth > 0) {
+	if (args.shallow) {
 		char line[1024];
 		unsigned char sha1[20];
=20
@@ -476,7 +476,7 @@ static void filter_refs(struct ref **refs, int nr_m=
atch, char **match)
 		    check_ref_format(ref->name + 5))
 			; /* trash */
 		else if (args.fetch_all &&
-			 (!args.depth || prefixcmp(ref->name, "refs/tags/") )) {
+			 (!args.shallow || prefixcmp(ref->name, "refs/tags/") )) {
 			*newtail =3D ref;
 			ref->next =3D NULL;
 			newtail =3D &ref->next;
@@ -534,7 +534,7 @@ static int everything_local(struct ref **refs, int =
nr_match, char **match)
 		}
 	}
=20
-	if (!args.depth) {
+	if (!args.shallow) {
 		for_each_ref(mark_complete, NULL);
 		if (cutoff)
 			mark_recent_complete_commits(cutoff);
@@ -845,6 +845,9 @@ int cmd_fetch_pack(int argc, const char **argv, con=
st char *prefix)
 			}
 			if (!prefixcmp(arg, "--depth=3D")) {
 				args.depth =3D strtol(arg + 8, NULL, 0);
+				if (args.depth <=3D 0)
+					die("Invalid depth %d", args.depth);
+				args.shallow =3D 1;
 				continue;
 			}
 			if (!strcmp("--no-progress", arg)) {
@@ -928,7 +931,7 @@ struct ref *fetch_pack(struct fetch_pack_args *my_a=
rgs,
 	fetch_pack_setup();
 	if (&args !=3D my_args)
 		memcpy(&args, my_args, sizeof(args));
-	if (args.depth > 0) {
+	if (args.shallow) {
 		if (stat(git_path("shallow"), &st))
 			st.st_mtime =3D 0;
 	}
@@ -941,7 +944,7 @@ struct ref *fetch_pack(struct fetch_pack_args *my_a=
rgs,
 	}
 	ref_cpy =3D do_fetch_pack(fd, ref, nr_heads, heads, pack_lockfile);
=20
-	if (args.depth > 0) {
+	if (args.shallow) {
 		struct cache_time mtime;
 		struct strbuf sb =3D STRBUF_INIT;
 		char *shallow =3D git_path("shallow");
diff --git a/fetch-pack.h b/fetch-pack.h
index fbe85ac..abc1ab7 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -14,7 +14,8 @@ struct fetch_pack_args
 		verbose:1,
 		no_progress:1,
 		include_tag:1,
-		stateless_rpc:1;
+		stateless_rpc:1,
+		shallow:1;
 };
=20
 struct ref *fetch_pack(struct fetch_pack_args *args,
diff --git a/transport.c b/transport.c
index 4dba6f8..cf7030b 100644
--- a/transport.c
+++ b/transport.c
@@ -470,10 +470,14 @@ static int set_git_option(struct git_transport_op=
tions *opts,
 		opts->keep =3D !!value;
 		return 0;
 	} else if (!strcmp(name, TRANS_OPT_DEPTH)) {
-		if (!value)
+		if (!value) {
 			opts->depth =3D 0;
-		else
+			opts->shallow =3D 0;
+		}
+		else {
 			opts->depth =3D atoi(value);
+			opts->shallow =3D 1;
+		}
 		return 0;
 	}
 	return 1;
@@ -529,6 +533,7 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
 	args.quiet =3D (transport->verbose < 0);
 	args.no_progress =3D !transport->progress;
 	args.depth =3D data->options.depth;
+	args.shallow =3D data->options.shallow;
=20
 	for (i =3D 0; i < nr_heads; i++)
 		origh[i] =3D heads[i] =3D xstrdup(to_fetch[i]->name);
diff --git a/transport.h b/transport.h
index c59d973..e6ac4b1 100644
--- a/transport.h
+++ b/transport.h
@@ -8,6 +8,7 @@ struct git_transport_options {
 	unsigned thin : 1;
 	unsigned keep : 1;
 	unsigned followtags : 1;
+	unsigned shallow : 1;
 	int depth;
 	const char *uploadpack;
 	const char *receivepack;
--=20
1.7.1.rc1.69.g24c2f7
