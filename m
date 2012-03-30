From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default: current vs upstream
Date: Fri, 30 Mar 2012 16:07:12 -0700
Message-ID: <7vlimhk7rz.fsf@alter.siamese.dyndns.org>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
 <20120329095236.GA11911@sigill.intra.peff.net>
 <7vbonfqezs.fsf@alter.siamese.dyndns.org>
 <20120329221154.GA1413@sigill.intra.peff.net>
 <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
 <20120330071358.GB30656@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 31 01:07:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDkv0-0007lw-86
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 01:07:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934753Ab2C3XHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 19:07:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41297 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934769Ab2C3XHP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 19:07:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEED95E2B;
	Fri, 30 Mar 2012 19:07:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8QnF35iPDEZZy017VfjdgoXIrpM=; b=FTBEkj
	Utgw7UKRFLBe2MUE61ePxJDxGH0Y2yK53Os+6XEI1/Q9Z+BXp1Gx/ZSTgAdtLcJ0
	t51Y2nKWhORp9Aph2Jdn69x5BjWb4ekpP8R312AmX8Z+gDWw+wL6spGYoEaW5llC
	G+S7ugeQ23Yqy9HaIo8OZtOceMr27Vk7s83HU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ehm80SsK07rFoFjlJnLavuIvV3Ug27Jq
	KN5Qkmo52Mfud9a/ocbJa7/pcjBCwm1Y9n5l9SDXKVOqOqVtaD0+eMclvmZnG878
	jNAuAogsEFC/OuYrnJgqnTNjB08rUFoBH9y3mzAtz0xBvYw/Xp/wGcNOfMTH9FZI
	YEp6Y4i8qzM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B59D55E2A;
	Fri, 30 Mar 2012 19:07:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A81F65E29; Fri, 30 Mar 2012
 19:07:13 -0400 (EDT)
In-Reply-To: <20120330071358.GB30656@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 30 Mar 2012 03:13:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1628969C-7ABD-11E1-B6CB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194422>

Jeff King <peff@peff.net> writes:

> Has somebody volunteered to make the necessary fixes to "push.default =
> upstream" in the first place? At the very least we need the fixes you
> mentioned in your mail[2] before it can become the default.
> ...
> [2] http://article.gmane.org/gmane.comp.version-control.git/194295

There were two issues I raised in that message.  It turns out that we
already have the code for the first one.  The second one should look
something like this:

-- >8 --
Subject: push: detect nonsense "upstream" check more carefully

The user can say "git push" without specifying any refspec.  When using
"upstream" semantics via the push.default configuration, the user wants to
update the "upstream" branch, which is the branch at a remote repository
the current branch is set to integrate with, with this command.

There are cases that "git push" do not make sense when push.default is set
to "upstream":

 - The current branch does not have branch.$name.remote configured.  By
   definition, "git push" that does not name where to push to will not
   know where to push to.  The user may explicitly say "git push $there",
   but again, by definition, no branch at repository $there is set to
   integrate with the current branch in this case and we wouldn't know
   which remote branch to update.

 - The current branch does have branch.$name.remote configured, but it
   does not specify branch.$name.merge that names what branch at the
   remote this branch integrates with. "git push" knows where to push in
   this case (or the user may explicitly say "git push $remote" to tell us
   where to push), but we do not know which remote branch to update.

 - The current branch does have both branch.$name.remote and
   branch.$name.merge configured, but the user said "git push $there",
   where $there does not match what "branch.$name.remote" is configured
   to.  By definition, no branch at repository $there is set to integrate
   with the current branch in this case and we wouldn't know which remote
   branch to update.

The first two cases were already checked correctly, but the third case was
not checked and we ended up updating the branch named branch.$name.merge
at repository $there, which was totally bogus.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/push.c |   32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index d315475..3e18cd3 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -65,6 +65,16 @@ static void set_refspecs(const char **refs, int nr)
 	}
 }
 
+static int push_url_of_remote(struct remote *remote, const char ***url_p)
+{
+	if (remote->pushurl_nr) {
+		*url_p = remote->pushurl;
+		return remote->pushurl_nr;
+	}
+	*url_p = remote->url;
+	return remote->url_nr;
+}
+
 static void setup_push_upstream(struct remote *remote)
 {
 	struct strbuf refspec = STRBUF_INIT;
@@ -76,7 +86,7 @@ static void setup_push_upstream(struct remote *remote)
 		    "\n"
 		    "    git push %s HEAD:<name-of-remote-branch>\n"),
 		    remote->name);
-	if (!branch->merge_nr || !branch->merge)
+	if (!branch->merge_nr || !branch->merge || !branch->remote_name)
 		die(_("The current branch %s has no upstream branch.\n"
 		    "To push the current branch and set the remote as upstream, use\n"
 		    "\n"
@@ -87,6 +97,18 @@ static void setup_push_upstream(struct remote *remote)
 	if (branch->merge_nr != 1)
 		die(_("The current branch %s has multiple upstream branches, "
 		    "refusing to push."), branch->name);
+	if (strcmp(branch->remote_name, remote->name)) {
+		struct remote *branch_dest = remote_get(branch->remote_name);
+		const char **branch_dest_url, **dest_url;
+
+		if (!push_url_of_remote(remote, &dest_url) ||
+		    !push_url_of_remote(branch_dest, &branch_dest_url) ||
+		    strcmp(dest_url[0], branch_dest_url[0]))
+			die(_("You are pushing to remote '%s', which is not the "
+			      "upstream of your\ncurrent branch '%s'.\n"),
+			    remote->name, branch->name);
+	}
+
 	strbuf_addf(&refspec, "%s:%s", branch->name, branch->merge[0]->src);
 	add_refspec(refspec.buf);
 }
@@ -196,13 +218,7 @@ static int do_push(const char *repo, int flags)
 			setup_default_push_refspecs(remote);
 	}
 	errs = 0;
-	if (remote->pushurl_nr) {
-		url = remote->pushurl;
-		url_nr = remote->pushurl_nr;
-	} else {
-		url = remote->url;
-		url_nr = remote->url_nr;
-	}
+	url_nr = push_url_of_remote(remote, &url);
 	if (url_nr) {
 		for (i = 0; i < url_nr; i++) {
 			struct transport *transport =
