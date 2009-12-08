From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 1/3] refactor ref status logic for pushing
Date: Tue, 8 Dec 2009 22:35:43 +0800
Message-ID: <20091208223543.c7f88afe.rctay89@gmail.com>
References: <20091208223413.98e99d3e.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Sverre Rabbelier" <srabbelier@gmail.com>,
	"Clemens Buchacher" <drizzd@aon.at>, "Jeff King" <peff@peff.net>,
	"Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 15:36:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI1Aa-00050o-GO
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 15:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755652AbZLHOfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 09:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755646AbZLHOfv
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 09:35:51 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:40509 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755644AbZLHOfu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 09:35:50 -0500
Received: by yxe17 with SMTP id 17so4929341yxe.33
        for <git@vger.kernel.org>; Tue, 08 Dec 2009 06:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=WjabJZMycqldJwM2LVcg6wFula70rYj+Y2Ner3BI6EU=;
        b=Zc4LonakpXtCha0rMbLKb0xc6vQgbqSAax3HWRi9J/pFiytYd9/eyCPylIP3sYce4n
         Dk3gwgUcwOJi37SyRFaDtLDadsbDTd+E1rYSTJQd1d7aGllxBcjeI7kJ219WmimpoT+I
         qxr5IAZmHn6HamSNh6jnddUmqK+nV/htUtgZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=VJRP1+y0/q8zQmRhy6x6acQbIlxbcNWySH4NdMkk9pRJ4OioPkIG41QX9WSAAAWORQ
         /IwYvmqjj/0y7Fxot3L5Dutx9yR7YjMleL6z1rk5rBB3c9jDivkjtj9H9gbID/YVt8nA
         6yG4DPaTyCwX+0yaZpcS/iTOd8Z34DdeJTT08=
Received: by 10.150.173.37 with SMTP id v37mr11460933ybe.298.1260282951092;
        Tue, 08 Dec 2009 06:35:51 -0800 (PST)
Received: from your-cukc5e3z5n (cm67.zeta153.maxonline.com.sg [116.87.153.67])
        by mx.google.com with ESMTPS id 16sm3291359gxk.3.2009.12.08.06.35.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Dec 2009 06:35:50 -0800 (PST)
In-Reply-To: <20091208223413.98e99d3e.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134878>

Move the logic that detects up-to-date and non-fast-forward refs to a
new function in remote.[ch], set_ref_status_for_push().

Make transport_push() invoke set_ref_status_for_push() before invoking
the push_refs() implementation. (As a side-effect, the push_refs()
implementation in transport-helper.c now knows of non-fast-forward
pushes.)

Removed logic for detecting up-to-date refs from the push_refs()
implementation in transport-helper.c, as transport_push() has already
done so for it.

Make cmd_send_pack() invoke set_ref_status_for_push() before invoking
send_pack(), as transport_push() can't do it for send_pack() here.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

In v1, this was spread over two patches. I squashed them into one
(here).

set_ref_status_for_push() used to be called inside the for loop over
remote_refs; now, it has its own for loop.

 builtin-send-pack.c |   50 +++++++++++---------------------------------------
 remote.c            |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 remote.h            |    2 ++
 transport-helper.c  |   13 ++++++-------
 transport.c         |    4 ++++
 5 files changed, 73 insertions(+), 46 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 8fffdbf..38580c3 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -406,50 +406,19 @@ int send_pack(struct send_pack_args *args,
 	 */
 	new_refs = 0;
 	for (ref = remote_refs; ref; ref = ref->next) {
-
-		if (ref->peer_ref)
-			hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
-		else if (!args->send_mirror)
+		if (!ref->peer_ref && !args->send_mirror)
 			continue;

-		ref->deletion = is_null_sha1(ref->new_sha1);
-		if (ref->deletion && !allow_deleting_refs) {
-			ref->status = REF_STATUS_REJECT_NODELETE;
-			continue;
-		}
-		if (!ref->deletion &&
-		    !hashcmp(ref->old_sha1, ref->new_sha1)) {
-			ref->status = REF_STATUS_UPTODATE;
+		switch (ref->status) {
+		case REF_STATUS_REJECT_NONFASTFORWARD:
+		case REF_STATUS_UPTODATE:
 			continue;
+		default:
+			; /* do nothing */
 		}

-		/* This part determines what can overwrite what.
-		 * The rules are:
-		 *
-		 * (0) you can always use --force or +A:B notation to
-		 *     selectively force individual ref pairs.
-		 *
-		 * (1) if the old thing does not exist, it is OK.
-		 *
-		 * (2) if you do not have the old thing, you are not allowed
-		 *     to overwrite it; you would not know what you are losing
-		 *     otherwise.
-		 *
-		 * (3) if both new and old are commit-ish, and new is a
-		 *     descendant of old, it is OK.
-		 *
-		 * (4) regardless of all of the above, removing :B is
-		 *     always allowed.
-		 */
-
-		ref->nonfastforward =
-		    !ref->deletion &&
-		    !is_null_sha1(ref->old_sha1) &&
-		    (!has_sha1_file(ref->old_sha1)
-		      || !ref_newer(ref->new_sha1, ref->old_sha1));
-
-		if (ref->nonfastforward && !ref->force && !args->force_update) {
-			ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
+		if (ref->deletion && !allow_deleting_refs) {
+			ref->status = REF_STATUS_REJECT_NODELETE;
 			continue;
 		}

@@ -673,6 +642,9 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	if (match_refs(local_refs, &remote_refs, nr_refspecs, refspecs, flags))
 		return -1;

+	set_ref_status_for_push(remote_refs, args.send_mirror,
+		args.force_update);
+
 	ret = send_pack(&args, fd, conn, remote_refs, &extra_have);

 	if (helper_status)
diff --git a/remote.c b/remote.c
index e3afecd..c70181c 100644
--- a/remote.c
+++ b/remote.c
@@ -1247,6 +1247,56 @@ int match_refs(struct ref *src, struct ref **dst,
 	return 0;
 }

+void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
+	int force_update)
+{
+	struct ref *ref;
+
+	for (ref = remote_refs; ref; ref = ref->next) {
+		if (ref->peer_ref)
+			hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
+		else if (!send_mirror)
+			continue;
+
+		ref->deletion = is_null_sha1(ref->new_sha1);
+		if (!ref->deletion &&
+			!hashcmp(ref->old_sha1, ref->new_sha1)) {
+			ref->status = REF_STATUS_UPTODATE;
+			continue;
+		}
+
+		/* This part determines what can overwrite what.
+		 * The rules are:
+		 *
+		 * (0) you can always use --force or +A:B notation to
+		 *     selectively force individual ref pairs.
+		 *
+		 * (1) if the old thing does not exist, it is OK.
+		 *
+		 * (2) if you do not have the old thing, you are not allowed
+		 *     to overwrite it; you would not know what you are losing
+		 *     otherwise.
+		 *
+		 * (3) if both new and old are commit-ish, and new is a
+		 *     descendant of old, it is OK.
+		 *
+		 * (4) regardless of all of the above, removing :B is
+		 *     always allowed.
+		 */
+
+		ref->nonfastforward =
+			!ref->deletion &&
+			!is_null_sha1(ref->old_sha1) &&
+			(!has_sha1_file(ref->old_sha1)
+			  || !ref_newer(ref->new_sha1, ref->old_sha1));
+
+		if (ref->nonfastforward && !ref->force && !force_update) {
+			ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
+			continue;
+		}
+	}
+}
+
 struct branch *branch_get(const char *name)
 {
 	struct branch *ret;
diff --git a/remote.h b/remote.h
index 8b7ecf9..6e13643 100644
--- a/remote.h
+++ b/remote.h
@@ -98,6 +98,8 @@ char *apply_refspecs(struct refspec *refspecs, int nr_refspec,

 int match_refs(struct ref *src, struct ref **dst,
 	       int nr_refspec, const char **refspec, int all);
+void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
+	int force_update);

 /*
  * Given a list of the remote refs and the specification of things to
diff --git a/transport-helper.c b/transport-helper.c
index 11f3d7e..6b1f778 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -329,16 +329,15 @@ static int push_refs(struct transport *transport,
 		return 1;

 	for (ref = remote_refs; ref; ref = ref->next) {
-		if (ref->peer_ref)
-			hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
-		else if (!mirror)
+		if (!ref->peer_ref && !mirror)
 			continue;

-		ref->deletion = is_null_sha1(ref->new_sha1);
-		if (!ref->deletion &&
-			!hashcmp(ref->old_sha1, ref->new_sha1)) {
-			ref->status = REF_STATUS_UPTODATE;
+		switch (ref->status) {
+		case REF_STATUS_REJECT_NONFASTFORWARD:
+		case REF_STATUS_UPTODATE:
 			continue;
+		default:
+			; /* do nothing */
 		}

 		if (force_all)
diff --git a/transport.c b/transport.c
index 3eea836..12c4423 100644
--- a/transport.c
+++ b/transport.c
@@ -887,6 +887,10 @@ int transport_push(struct transport *transport,
 			return -1;
 		}

+		set_ref_status_for_push(remote_refs,
+			flags & TRANSPORT_PUSH_MIRROR,
+			flags & TRANSPORT_PUSH_FORCE);
+
 		ret = transport->push_refs(transport, remote_refs, flags);

 		if (!quiet || push_had_errors(remote_refs))
--
1.6.4.4
