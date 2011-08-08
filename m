From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] helping smart-http/stateless-rpc fetch race
Date: Mon, 08 Aug 2011 10:13:44 -0700
Message-ID: <7vsjpbzv07.fsf@alter.siamese.dyndns.org>
References: <7vbow337gx.fsf@alter.siamese.dyndns.org>
 <CAJo=hJvdMCyU-5wzy0p1r+QJxXU=DJTE+Mu5G6pk9iAwAD51mA@mail.gmail.com>
 <7vbow01ols.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 08 19:13:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqTOk-0006dS-Hi
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 19:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773Ab1HHRNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 13:13:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52829 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751361Ab1HHRNs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 13:13:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75E5340F6;
	Mon,  8 Aug 2011 13:13:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H263SgbwKcDbqcb+SlmuHXQBhAY=; b=UoG/Jm
	ROt4DfZY29LJPRC6qYSq431LYQAU8Craq2kXjXsHnatluQAlnhQ8K69vJOtqbBCj
	A+o7xJxraFRjdwyf7egtBsIrEaxgWziul8uUGMNvwJauTQx8TCvR26cksc+oouhX
	YoR5y2hD4kQx7/lg1YrlGlgqBYKbjQB8NmPrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i3YnKqW1Mb0GTcfnYZTPaXuyd8vMR/Fu
	xmD/Gi/+QxK1V9PYnklbOjTueFjpqaHR06K/FibPaebu/ECwNMWr04gPPu1DhZVs
	CLrvIho5p8LLM7dqf56JP3lncj24h+xO0oVnVrUTPVyFBZoh9haQ3I4oWXoxgLDK
	EQ4z7TVfUtY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DBFD40F5;
	Mon,  8 Aug 2011 13:13:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F6AD40EA; Mon,  8 Aug 2011
 13:13:46 -0400 (EDT)
In-Reply-To: <7vbow01ols.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 07 Aug 2011 22:03:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C68C7FC0-C1E1-11E0-B799-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178963>

Junio C Hamano <gitster@pobox.com> writes:

> Shawn Pearce <spearce@spearce.org> writes:
>
>> Why a new --allow-non-tip flag? Why not always do this with the
>> existing --stateless-rpc flag?
>
> It certainly would be much easier from implementation point of view, but I
> did it that way for two and half reasons:
>
>  (1) It might make sense to give admins who run upload-pack not behind
>      smart-http an option to allow fetching from a non-tip; and
>
>  (2) It also might make sense to let admins who do run upload-pack behind
>      smart-http force re-fetching when the race is encountered.
>
> and the remaining half-reason was that I was too lazy to think things
> through to refute the above two "might make sense" and convince myself
> that they should instead be "is not necessary".

I still haven't convinced myself but here is a simplified one without the
new option (hence no need to touch the smart-http infrastructure).

-- >8 --
Subject: [PATCH] helping smart-http/stateless-rpc fetch race

A request to fetch from a client over smart HTTP protocol is served in
multiple steps. In the first round, the server side shows the set of refs
it has and their values, and the client picks from them and sends "I want
to fetch the history leading to these commits".

When the server tries to respond to this second request, its refs may have
progressed by a push from elsewhere. By design, we do not allow fetching
objects that are not at the tip of an advertised ref, and the server
rejects such a request. The client needs to try again, which is not ideal
especially for a busy server.

Teach upload-pack (which is the workhorse driven by git-daemon and smart
http server interface) that it is OK for a smart-http client to ask for
commits that are not at the tip of any advertised ref, as long as they are
reachable from advertised refs.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 upload-pack.c |  108 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 99 insertions(+), 9 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index ce5cbbe..30cf941 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -10,6 +10,7 @@
 #include "revision.h"
 #include "list-objects.h"
 #include "run-command.h"
+#include "sigchain.h"
 
 static const char upload_pack_usage[] = "git upload-pack [--strict] [--timeout=<n>] <dir>";
 
@@ -498,11 +499,96 @@ static int get_common_commits(void)
 	}
 }
 
+static void check_non_tip(void)
+{
+	static const char *argv[] = {
+		"rev-list", "--stdin", NULL,
+	};
+	static struct child_process cmd;
+	struct object *o;
+	char namebuf[42]; /* ^ + SHA-1 + LF */
+	int i;
+
+	/* In the normal in-process case non-tip request can never happen */
+	if (!stateless_rpc)
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
+		o = get_indexed_object(--i);
+		if (!(o->flags & OUR_REF))
+			continue;
+		memcpy(namebuf + 1, sha1_to_hex(o->sha1), 40);
+		if (write_in_full(cmd.in, namebuf, 42) < 0)
+			goto error;
+	}
+	namebuf[40] = '\n';
+	for (i = 0; i < want_obj.nr; i++) {
+		o = want_obj.objects[i].item;
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
+	/* Pick one of them (we know there at least is one) */
+	for (i = 0; i < want_obj.nr; i++) {
+		o = want_obj.objects[i].item;
+		if (!(o->flags & OUR_REF))
+			break;
+	}
+	die("git upload-pack: not our ref %s",
+	    sha1_to_hex(o->sha1));
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
@@ -559,26 +645,30 @@ static void receive_needs(void)
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
 
-- 
1.7.6.409.ge7a85
