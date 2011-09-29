From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Git is not scalable with too many refs/*
Date: Thu, 29 Sep 2011 20:27:43 +0200
Message-ID: <4E84B89F.4060304@lsrfire.ath.cx>
References: <4DF6A8B6.9030301@op5.se> <CAP8UFD3TWQHU0wLPuxMDnc3bRSz90Yd+yDMBe03kofeo-nr7yA@mail.gmail.com> <201109281338.04378.mfick@codeaurora.org> <201109281610.49322.mfick@codeaurora.org> <c76d7f65203c0fc2c6e4e14fe2f33274@quantumfyre.co.uk> <960aacbf-8d4d-4b2a-8902-f6380ff9febd@email.android.com> <7c0105c6cca7dd0aa336522f90617fe4@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Fick <mfick@codeaurora.org>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Thu Sep 29 20:28:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9LLB-0006mi-MA
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 20:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756868Ab1I2S1y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Sep 2011 14:27:54 -0400
Received: from india601.server4you.de ([85.25.151.105]:55448 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756627Ab1I2S1x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 14:27:53 -0400
Received: from [192.168.2.104] (p4FFD9870.dip.t-dialin.net [79.253.152.112])
	by india601.server4you.de (Postfix) with ESMTPSA id F1DAC2F805F;
	Thu, 29 Sep 2011 20:27:50 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0) Gecko/20110922 Thunderbird/7.0
In-Reply-To: <7c0105c6cca7dd0aa336522f90617fe4@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182421>

Am 29.09.2011 04:19, schrieb Julian Phillips:
> Does the following help?
>=20
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 5e356a6..f0f4ca1 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -605,7 +605,7 @@ static int add_one_ref_to_rev_list_arg(const char
> *refname,
>                                        int flags,
>                                        void *cb_data)
>  {
> -       add_one_rev_list_arg(cb_data, refname);
> +       add_one_rev_list_arg(cb_data, strdup(sha1_to_hex(sha1)));
>         return 0;
>  }

Hmm.  Can we get rid of the multiple ref lookups fixed by the above
*and* the overhead of dealing with a textual argument list at the same
time by calling add_pending_object directly, like this?  (Factoring
out add_pending_sha1 should be a separate patch..)

Ren=C3=A9

---
 builtin/checkout.c |   39 ++++++++++++---------------------------
 revision.c         |   11 ++++++++---
 revision.h         |    1 +
 3 files changed, 21 insertions(+), 30 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5e356a6..84e0cdc 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -588,24 +588,11 @@ static void update_refs_for_switch(struct checkou=
t_opts *opts,
 		report_tracking(new);
 }
=20
-struct rev_list_args {
-	int argc;
-	int alloc;
-	const char **argv;
-};
-
-static void add_one_rev_list_arg(struct rev_list_args *args, const cha=
r *s)
-{
-	ALLOC_GROW(args->argv, args->argc + 1, args->alloc);
-	args->argv[args->argc++] =3D s;
-}
-
-static int add_one_ref_to_rev_list_arg(const char *refname,
-				       const unsigned char *sha1,
-				       int flags,
-				       void *cb_data)
+static int add_pending_uninteresting_ref(const char *refname,
+					 const unsigned char *sha1,
+					 int flags, void *cb_data)
 {
-	add_one_rev_list_arg(cb_data, refname);
+	add_pending_sha1(cb_data, refname, sha1, flags | UNINTERESTING);
 	return 0;
 }
=20
@@ -685,19 +672,17 @@ static void suggest_reattach(struct commit *commi=
t, struct rev_info *revs)
  */
 static void orphaned_commit_warning(struct commit *commit)
 {
-	struct rev_list_args args =3D { 0, 0, NULL };
 	struct rev_info revs;
-
-	add_one_rev_list_arg(&args, "(internal)");
-	add_one_rev_list_arg(&args, sha1_to_hex(commit->object.sha1));
-	add_one_rev_list_arg(&args, "--not");
-	for_each_ref(add_one_ref_to_rev_list_arg, &args);
-	add_one_rev_list_arg(&args, "--");
-	add_one_rev_list_arg(&args, NULL);
+	struct object *object =3D &commit->object;
=20
 	init_revisions(&revs, NULL);
-	if (setup_revisions(args.argc - 1, args.argv, &revs, NULL) !=3D 1)
-		die(_("internal error: only -- alone should have been left"));
+	setup_revisions(0, NULL, &revs, NULL);
+
+	object->flags &=3D ~UNINTERESTING;
+	add_pending_object(&revs, object, sha1_to_hex(object->sha1));
+
+	for_each_ref(add_pending_uninteresting_ref, &revs);
+
 	if (prepare_revision_walk(&revs))
 		die(_("internal error in revision walk"));
 	if (!(commit->object.flags & UNINTERESTING))
diff --git a/revision.c b/revision.c
index c46cfaa..2e8aa33 100644
--- a/revision.c
+++ b/revision.c
@@ -185,6 +185,13 @@ static struct object *get_reference(struct rev_inf=
o *revs, const char *name, con
 	return object;
 }
=20
+void add_pending_sha1(struct rev_info *revs, const char *name,
+		      const unsigned char *sha1, unsigned int flags)
+{
+	struct object *object =3D get_reference(revs, name, sha1, flags);
+	add_pending_object(revs, object, name);
+}
+
 static struct commit *handle_commit(struct rev_info *revs, struct obje=
ct *object, const char *name)
 {
 	unsigned long flags =3D object->flags;
@@ -832,9 +839,7 @@ struct all_refs_cb {
 static int handle_one_ref(const char *path, const unsigned char *sha1,=
 int flag, void *cb_data)
 {
 	struct all_refs_cb *cb =3D cb_data;
-	struct object *object =3D get_reference(cb->all_revs, path, sha1,
-					      cb->all_flags);
-	add_pending_object(cb->all_revs, object, path);
+	add_pending_sha1(cb->all_revs, path, sha1, cb->all_flags);
 	return 0;
 }
=20
diff --git a/revision.h b/revision.h
index 3d64ada..4541265 100644
--- a/revision.h
+++ b/revision.h
@@ -191,6 +191,7 @@ extern void add_object(struct object *obj,
 		       const char *name);
=20
 extern void add_pending_object(struct rev_info *revs, struct object *o=
bj, const char *name);
+extern void add_pending_sha1(struct rev_info *revs, const char *name, =
const unsigned char *sha1, unsigned int flags);
=20
 extern void add_head_to_pending(struct rev_info *);
=20
--=20
1.7.7.rc1
