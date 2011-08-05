From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC] helping smart-http/stateless-rpc fetch race
Date: Fri, 05 Aug 2011 13:54:06 -0700
Message-ID: <7vbow337gx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 05 22:54:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpRPM-0006Fc-1X
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 22:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755407Ab1HEUyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Aug 2011 16:54:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42255 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752230Ab1HEUyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 16:54:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8EEB364A;
	Fri,  5 Aug 2011 16:54:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=n
	oKbsHAQ51YsVihqqj9mU9VbnWQ=; b=gvhlbmnx3Q7X4uX3/zOO9AyPtCT8U1Dib
	ZGCn7oVWnLdCGCSxKHhT0HUXo3CkI5cSSIR5asl65yg1dmBjrEkAUuPBzKUCKIDh
	lVQuhLCwaAvF/dBc5hPTC4CK7nsGwwmpfD1PhUfgXK5oOMKFCtHyQSTKKiRas+Ks
	/05NSL8seI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Xu8
	GXs8iwC7gxtxpEf/6soO102fawud52HbFhO8LLA2A0tshQFsE2fGnv1xEwlofDne
	sMmX7Hqel1RxJt0KRhrRlU5tyBMIptKKETmS+HwbWNb26HO1xFdOrQWmFx0Cb0Bd
	5Lcu2yxu1gmg7YYuBbHAW+Q9BMRr5Wz+t3uGxKvg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0F983649;
	Fri,  5 Aug 2011 16:54:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9AD583648; Fri,  5 Aug 2011
 16:54:07 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0FC8DD08-BFA5-11E0-8C65-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178814>

A request to fetch from a client over smart HTTP protocol is served in
multiple steps. In the first round, the server side shows the set of refs
it has and their values, and the client picks from them and sends "I want
to fetch the history leading to these commits".

When the server tries to respond to this second request, its refs may have
progressed by a push from elsewhere. By design, we do not allow fetching
objects that are not at the tip of an advertised ref, and the server
rejects such a request. The client needs to try again, which is not ideal
especially for a busy server.

Teach --allow-non-tip option to upload-pack (which is the workhorse driven
by git-daemon and smart http server interface) that lets it server commits
that are not at the tip of any advertised ref, as long as they are
reachable from advertised refs.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I'll leave it to interested parties who are more qualified than I am to
   update remote-curl nor http-backend to actually ask upload-pack to use
   this new logic ;-)

 upload-pack.c |  104 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 95 insertions(+), 9 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index ce5cbbe..76be9ff 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -10,6 +10,7 @@
 #include "revision.h"
 #include "list-objects.h"
 #include "run-command.h"
+#include "sigchain.h"
 
 static const char upload_pack_usage[] = "git upload-pack [--strict] [--timeout=<n>] <dir>";
 
@@ -42,6 +43,7 @@ static int use_sideband;
 static int debug_fd;
 static int advertise_refs;
 static int stateless_rpc;
+static int allow_non_tip;
 
 static void reset_timeout(void)
 {
@@ -498,11 +500,87 @@ static int get_common_commits(void)
 	}
 }
 
+static void check_non_tip(void)
+{
+	static const char *argv[] = {
+		"rev-list", "--stdin", NULL,
+	};
+	static struct child_process cmd;
+	int i;
+	char namebuf[42]; /* ^ + SHA-1 + LF */
+
+	if (!allow_non_tip)
+		goto error;
+
+	cmd.argv = argv;
+	cmd.git_cmd = 1;
+	cmd.no_stderr = 1;
+	cmd.in = -1;
+	cmd.out = -1;
+
+	if (start_command(&cmd))
+		goto error;
+
+	/*
+	 * If rev-list --stdin encounters an unknown commit, it
+	 * terminates, which will cause SIGPIPE in the write loop
+	 * below.
+	 */
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	namebuf[0] = '^';
+	namebuf[41] = '\n';
+	for (i = get_max_object_index(); 0 < i; ) {
+		struct object *o = get_indexed_object(--i);
+		if (!(o->flags & OUR_REF))
+			continue;
+		memcpy(namebuf + 1, sha1_to_hex(o->sha1), 40);
+		if (write_in_full(cmd.in, namebuf, 42) < 0)
+			goto error;
+	}
+	namebuf[40] = '\n';
+	for (i = 0; i < want_obj.nr; i++) {
+		struct object *o = want_obj.objects[i].item;
+		if (o->flags & OUR_REF)
+			continue;
+		memcpy(namebuf, sha1_to_hex(o->sha1), 40);
+		if (write_in_full(cmd.in, namebuf, 41) < 0)
+			goto error;
+	}
+	close(cmd.in);
+
+	sigchain_pop(SIGPIPE);
+
+	/*
+	 * The commits out of the rev-list are not ancestors of
+	 * our ref.
+	 */
+	i = read_in_full(cmd.out, namebuf, 1);
+	if (i)
+		goto error;
+	close(cmd.out);
+
+	/*
+	 * rev-list may have died by encountering a bad commit
+	 * in the history, in which case we do want to bail out
+	 * even when it showed no commit.
+	 */
+	if (finish_command(&cmd))
+		goto error;
+
+	/* All the non-tip ones are ancestors of what we advertised */
+	return;
+
+error:
+	die("git upload-pack: not our ref");
+}
+
 static void receive_needs(void)
 {
 	struct object_array shallows = OBJECT_ARRAY_INIT;
 	static char line[1000];
 	int len, depth = 0;
+	int has_non_tip = 0;
 
 	shallow_nr = 0;
 	if (debug_fd)
@@ -559,26 +637,30 @@ static void receive_needs(void)
 		if (strstr(line+45, "include-tag"))
 			use_include_tag = 1;
 
-		/* We have sent all our refs already, and the other end
-		 * should have chosen out of them; otherwise they are
-		 * asking for nonsense.
-		 *
-		 * Hmph.  We may later want to allow "want" line that
-		 * asks for something like "master~10" (symbolic)...
-		 * would it make sense?  I don't know.
-		 */
 		o = lookup_object(sha1_buf);
-		if (!o || !(o->flags & OUR_REF))
+		if (!o)
 			die("git upload-pack: not our ref %s",
 			    sha1_to_hex(sha1_buf));
 		if (!(o->flags & WANTED)) {
 			o->flags |= WANTED;
+			if (!(o->flags & OUR_REF))
+				has_non_tip = 1;
 			add_object_array(o, NULL, &want_obj);
 		}
 	}
 	if (debug_fd)
 		write_str_in_full(debug_fd, "#E\n");
 
+	/*
+	 * We have sent all our refs already, and the other end
+	 * should have chosen out of them. When we are operating
+	 * in the stateless RPC mode, however, their choice may
+	 * have been based on the set of older refs advertised
+	 * by another process that handled the initial request.
+	 */
+	if (has_non_tip)
+		check_non_tip();
+
 	if (!use_sideband && daemon_mode)
 		no_progress = 1;
 
@@ -720,6 +802,10 @@ int main(int argc, char **argv)
 			stateless_rpc = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--allow-non-tip")) {
+			allow_non_tip = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--strict")) {
 			strict = 1;
 			continue;
