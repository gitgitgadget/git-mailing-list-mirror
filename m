From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 6/8] upload-pack: optionally allow fetching from the tips
 of hidden refs
Date: Wed, 30 Jan 2013 10:45:40 -0800
Message-ID: <1359571542-19852-7-git-send-email-gitster@pobox.com>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 19:46:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0cg6-0004fU-Fr
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 19:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755207Ab3A3SqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 13:46:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33772 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756655Ab3A3Sp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 13:45:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DF17C40F;
	Wed, 30 Jan 2013 13:45:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ZzGc
	vYQFMoIgIJcOLba7fmjBQCA=; b=dfBfTJJdBcftnMGsrDSrWstpDJt4sS8ui75F
	W1NHka9cer4ZIS3ORUnlujfnjA5sXqtet51yu4hkKc3TT/38MeIH4WMVUmOBXEkd
	KitZmGe4Ce6mVu/EWLxi7F67/5zsmZfXHANecI1T9/rGT4MxjZhXHnrLlzDDIVbH
	20vZdWE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	nsW30b87dOhHmBhTAhdD5YPIbFj+ZE5lNwdF6RkKfHcFD/9P2yIYeLnFq+y0BKOs
	682s5pBFjdi2PBWWeZDzXQ2wNILSI1HutMeVqYeXWJxO62VPwyF3njQPnl8FJstN
	Ant+xQp+1VF4ciAG/aivpkt6zlcJ7EuJwHxrFQJ2Jyw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2A9BC40E;
	Wed, 30 Jan 2013 13:45:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 06410C40D; Wed, 30 Jan 2013
 13:45:55 -0500 (EST)
X-Mailer: git-send-email 1.8.1.2.589.ga9b91ac
In-Reply-To: <1359571542-19852-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 47F1F7E0-6B0D-11E2-AC8B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215047>

With uploadpack.allowtipsha1inwant configuration option set, future
versions of "git fetch" that allow an exact object name (likely to
have been obtained out of band) on the LHS of the fetch refspec can
make a request with a "want" line that names an object that may not
have been advertised due to transfer.hiderefs configuration.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |  8 +++++++-
 upload-pack.c            | 25 +++++++++++++++++++------
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f57c802..2dce021 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2066,13 +2066,19 @@ transfer.hiderefs::
 	and is hidden from `git ls-remote`, `git fetch`, `git push :`,
 	etc.  An attempt to update or delete a hidden ref by `git push`
 	is rejected, and an attempt to fetch a hidden ref by `git fetch`
-	will fail.
+	will fail.  See also `uploadpack.allowtipsha1inwant`.
 
 transfer.unpackLimit::
 	When `fetch.unpackLimit` or `receive.unpackLimit` are
 	not set, the value of this variable is used instead.
 	The default value is 100.
 
+uploadpack.allowtipsha1inwant::
+	When `transfer.hiderefs` is in effect, allow `upload-pack`
+	to accept a fetch request that asks for an object at the tip
+	of a hidden ref (by default, such a request is rejected).
+	see also `transfer.hiderefs`.
+
 url.<base>.insteadOf::
 	Any URL that starts with this value will be rewritten to
 	start, instead, with <base>. In cases where some site serves a
diff --git a/upload-pack.c b/upload-pack.c
index 6b10843..37977e2 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -26,6 +26,7 @@ static const char upload_pack_usage[] = "git upload-pack [--strict] [--timeout=<
 #define SHALLOW		(1u << 16)
 #define NOT_SHALLOW	(1u << 17)
 #define CLIENT_SHALLOW	(1u << 18)
+#define HIDDEN_REF	(1u << 19)
 
 static unsigned long oldest_have;
 
@@ -33,6 +34,7 @@ static int multi_ack;
 static int no_done;
 static int use_thin_pack, use_ofs_delta, use_include_tag;
 static int no_progress, daemon_mode;
+static int allow_tip_sha1_in_want;
 static int shallow_nr;
 static struct object_array have_obj;
 static struct object_array want_obj;
@@ -487,6 +489,12 @@ static int get_common_commits(void)
 	}
 }
 
+static int is_our_ref(struct object *o)
+{
+	return o->flags &
+		((allow_tip_sha1_in_want ? HIDDEN_REF : 0) | OUR_REF);
+}
+
 static void check_non_tip(void)
 {
 	static const char *argv[] = {
@@ -523,7 +531,7 @@ static void check_non_tip(void)
 		o = get_indexed_object(--i);
 		if (!o)
 			continue;
-		if (!(o->flags & OUR_REF))
+		if (!is_our_ref(o))
 			continue;
 		memcpy(namebuf + 1, sha1_to_hex(o->sha1), 40);
 		if (write_in_full(cmd.in, namebuf, 42) < 0)
@@ -532,7 +540,7 @@ static void check_non_tip(void)
 	namebuf[40] = '\n';
 	for (i = 0; i < want_obj.nr; i++) {
 		o = want_obj.objects[i].item;
-		if (o->flags & OUR_REF)
+		if (is_our_ref(o))
 			continue;
 		memcpy(namebuf, sha1_to_hex(o->sha1), 40);
 		if (write_in_full(cmd.in, namebuf, 41) < 0)
@@ -566,7 +574,7 @@ error:
 	/* Pick one of them (we know there at least is one) */
 	for (i = 0; i < want_obj.nr; i++) {
 		o = want_obj.objects[i].item;
-		if (!(o->flags & OUR_REF))
+		if (!is_our_ref(o))
 			die("git upload-pack: not our ref %s",
 			    sha1_to_hex(o->sha1));
 	}
@@ -646,7 +654,7 @@ static void receive_needs(void)
 			    sha1_to_hex(sha1_buf));
 		if (!(o->flags & WANTED)) {
 			o->flags |= WANTED;
-			if (!(o->flags & OUR_REF))
+			if (!is_our_ref(o))
 				has_non_tip = 1;
 			add_object_array(o, NULL, &want_obj);
 		}
@@ -725,8 +733,10 @@ static int mark_our_ref(const char *refname, const unsigned char *sha1, int flag
 {
 	struct object *o = lookup_unknown_object(sha1);
 
-	if (ref_is_hidden(refname))
+	if (ref_is_hidden(refname)) {
+		o->flags |= HIDDEN_REF;
 		return 1;
+	}
 	if (!o)
 		die("git upload-pack: cannot find object %s:", sha1_to_hex(sha1));
 	o->flags |= OUR_REF;
@@ -745,9 +755,10 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 		return 0;
 
 	if (capabilities)
-		packet_write(1, "%s %s%c%s%s agent=%s\n",
+		packet_write(1, "%s %s%c%s%s%s agent=%s\n",
 			     sha1_to_hex(sha1), refname_nons,
 			     0, capabilities,
+			     allow_tip_sha1_in_want ? " allow-tip-sha1-in-want" : "",
 			     stateless_rpc ? " no-done" : "",
 			     git_user_agent_sanitized());
 	else
@@ -781,6 +792,8 @@ static void upload_pack(void)
 
 static int upload_pack_config(const char *var, const char *value, void *unused)
 {
+	if (!strcmp("uploadpack.allowtipsha1inwant", var))
+		allow_tip_sha1_in_want = git_config_bool(var, value);
 	return parse_hide_refs_config(var, value, unused);
 }
 
-- 
1.8.1.2.589.ga9b91ac
