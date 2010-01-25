From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] grep: expose "status-only" feature via -q
Date: Mon, 25 Jan 2010 15:37:23 -0800
Message-ID: <7vk4v53gek.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 00:37:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZYUx-00039i-DC
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 00:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722Ab0AYXhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 18:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701Ab0AYXha
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 18:37:30 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38923 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537Ab0AYXha (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 18:37:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 53B2894651;
	Mon, 25 Jan 2010 18:37:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=jMx7
	9/PwuZpRa46lcOiveeoS+rE=; b=wVohjmymq5+UfuPVHAHcja9pIjE/jfkuqJ9T
	MYxhVPwMYrLiRyvlPkOSmo9pSbN39X+ncXEsosMffiJXm7HAK8uR6k6AZ4tp6iYz
	YILe4riAng8Ci76LmQpI9QB9T8HcReVoK01ZOElNBxPNW+lRhP540Zbk+FuHXSH7
	XzEEFeo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=XY2
	Umof2HkiWaBa8WunQGPsU34ZR+rEwSE5G7wguuvS+SobbBwIeZB7pGbKvP3WXoir
	q2UDScWZUqd0qVlanLtOIEIJn9fx4EJ7C86GzRxhNFNuSx8Exv2vDvRiZITx0VnH
	jPXZiXqsd1+NZfQSAXyIT8M2zAdK2Vve/GZCCPTU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E96194650;
	Mon, 25 Jan 2010 18:37:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 842C49464F; Mon, 25 Jan
 2010 18:37:25 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 98B38980-0A0A-11DF-9E3A-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138006>

Teach "git grep" a new "-q" option to report the presense of a match via
its exit status without showing any output, similar to how "grep -q"
works.  Internally "grep" engine already knew this "status-only" mode of
operation because it needed to grep inside log message to filter commits
when called from the "git log" machinery, and this patch only exposes it
to the command line tool.

A somewhat unfair benchmark in the Linux kernel directory shows a dramatic
improvement:

    (with patch)
    $ time ../git.git/git grep -q linux HEAD ; echo $?

    real    0m0.030s
    user    0m0.004s
    sys     0m0.004s
    0

    (without patch)
    $ time git grep linux HEAD >/dev/null; echo $?

    real    0m4.432s
    user    0m4.272s
    sys     0m0.076s
    0

This is "somewhat unfair" because I knew a file with such a string comes
very early in the tree traversal (namely, ".gitignore").

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-grep.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index da854fa..64cdfef 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -236,6 +236,8 @@ static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
 				 !strcmp(ce->name, active_cache[nr]->name));
 			nr--; /* compensate for loop control */
 		}
+		if (hit && opt->status_only)
+			break;
 	}
 	free_grep_patterns(opt);
 	return hit;
@@ -293,6 +295,8 @@ static int grep_tree(struct grep_opt *opt, const char **paths,
 			hit |= grep_tree(opt, paths, &sub, tree_name, down);
 			free(data);
 		}
+		if (hit && opt->status_only)
+			break;
 	}
 	strbuf_release(&pathbuf);
 	return hit;
@@ -329,8 +333,11 @@ static int grep_directory(struct grep_opt *opt, const char **paths)
 	setup_standard_excludes(&dir);
 
 	fill_directory(&dir, paths);
-	for (i = 0; i < dir.nr; i++)
+	for (i = 0; i < dir.nr; i++) {
 		hit |= grep_file(opt, dir.entries[i]->name);
+		if (hit && opt->status_only)
+			break;
+	}
 	free_grep_patterns(opt);
 	return hit;
 }
@@ -505,6 +512,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, ')', NULL, &opt, NULL, "",
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_NODASH,
 		  close_callback },
+		OPT_BOOLEAN('q', "quick", &opt.status_only,
+			    "indicate hit with exit status without output"),
 		OPT_BOOLEAN(0, "all-match", &opt.all_match,
 			"show only matches from files that match all patterns"),
 		OPT_GROUP(""),
@@ -628,8 +637,11 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < list.nr; i++) {
 		struct object *real_obj;
 		real_obj = deref_tag(list.objects[i].item, NULL, 0);
-		if (grep_object(&opt, paths, real_obj, list.objects[i].name))
+		if (grep_object(&opt, paths, real_obj, list.objects[i].name)) {
 			hit = 1;
+			if (opt.status_only)
+				break;
+		}
 	}
 	free_grep_patterns(&opt);
 	return !hit;
