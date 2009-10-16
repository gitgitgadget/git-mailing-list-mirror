From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Q: supplying large sets of path to git commands
Date: Fri, 16 Oct 2009 15:08:07 -0700
Message-ID: <7vtyxzrnzs.fsf@alter.siamese.dyndns.org>
References: <85647ef50910160340s5b608d9cmb13679d7c6a987cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 00:08:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyuyE-0003bS-Uq
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 00:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbZJPWIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 18:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752178AbZJPWIL
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 18:08:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61944 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbZJPWIK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 18:08:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7650E5BE70;
	Fri, 16 Oct 2009 18:08:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nv5WvjO3Trgh3MTcXNcSPXIpPRI=; b=I7fz+g
	0d3IvG+RqrpACHqxbOZJM8YFbXJ7re3O6B1BOfwxidBUcU82tT/KpR8ZyKGh2X1P
	wxwejAxh+zpq7V50jR0xMLpgeB7+I24CPJIYKJZmqR8snab04325syfft3ZRY2MK
	09DNaYzPFXkgRt9xo/lkk1/rS8QaPAiKNAsQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SaWPjEnMNms/XJPUxJ/1oBtMhrLNHrdJ
	vujJJxEH+1nys5hr0b3AUbxVuHDaOYd5mQmIpe02lB+edTPdrBXHOx2OVHg2OQ5K
	oIJvf0R+z2jvbGs3z+4P0wdD9VgzPlftqySDNVNiqPK0vdzhEilQ4XEVGxiNEDQz
	OBDC6K5194U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 59AB65BE69;
	Fri, 16 Oct 2009 18:08:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5EB105BE67; Fri, 16 Oct
 2009 18:08:09 -0400 (EDT)
In-Reply-To: <85647ef50910160340s5b608d9cmb13679d7c6a987cd@mail.gmail.com>
 (Constantine Plotnikov's message of "Fri\, 16 Oct 2009 14\:40\:23 +0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 65384D16-BAA0-11DE-9367-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130530>

Constantine Plotnikov <constantine.plotnikov@gmail.com> writes:

> Some git commands like git check-attr supports receiving paths from
> stdin.

Here is how one might implement it for diff/log family of commands that
use "setup_revisions()".

I didn't test it (of course) beyond running 

    ./git diff --name-only HEAD | ./git diff --stdin-paths --stat -p

in order to include the patch text in this message, and running

    ./git diff --name-only | ./git log --stdin-paths --no-merges --stat

---
 Documentation/git-rev-list.txt     |    1 +
 Documentation/rev-list-options.txt |    7 ++++
 revision.c                         |   59 +++++++++++++++++++++++++++++++++--
 3 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 3341d1b..8fa276c 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -46,6 +46,7 @@ SYNOPSIS
 	     [ \--reverse ]
 	     [ \--walk-reflogs ]
 	     [ \--no-walk ] [ \--do-walk ]
+	     [ \--stdin-paths | \--stdin-paths-z ]
 	     <commit>... [ \-- <paths>... ]
 
 DESCRIPTION
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index bf66116..9960de8 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -317,6 +317,13 @@ The following options select the commits to be shown:
 
 	Commits modifying the given <paths> are selected.
 
+--stdin-paths::
+--stdin-paths-z::
+
+	Additionally read <paths> (see above) from the standard input,
+	one path per line terminated with linefeed (or NUL when
+	--stdin-paths-z is used).
+
 --simplify-by-decoration::
 
 	Commits that are referred by some branch or tag are selected.
diff --git a/revision.c b/revision.c
index 9fc4e8d..4caccdb 100644
--- a/revision.c
+++ b/revision.c
@@ -1218,6 +1218,38 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 	ctx->argc -= n;
 }
 
+enum append_stdin_mode {
+	APPEND_STDIN = 1,
+	APPEND_STDIN_Z = 2,
+};
+
+static const char **grab_pathspec(const char *prefix, const char **argv,
+				  enum append_stdin_mode append_stdin)
+{
+	const char **nargv;
+	int cnt, alloc, term;
+	struct strbuf line = STRBUF_INIT;
+
+	if (!append_stdin)
+		return get_pathspec(prefix, argv);
+
+	for (cnt = 0; argv[cnt]; cnt++)
+		; /* first count */
+	alloc = alloc_nr(cnt);
+	nargv = xmalloc(sizeof(*nargv) * alloc);
+	for (cnt = 0; argv[cnt]; cnt++)
+		nargv[cnt] = argv[cnt]; /* then copy */
+
+	term = (append_stdin == APPEND_STDIN_Z) ? '\0' : '\n';
+	while (strbuf_getline(&line, stdin, term) != EOF) {
+		ALLOC_GROW(nargv, cnt, alloc);
+		nargv[cnt++] = strbuf_detach(&line, NULL);
+	}
+	ALLOC_GROW(nargv, cnt, alloc);
+	nargv[cnt] = NULL;
+	return get_pathspec(prefix, nargv);
+}
+
 /*
  * Parse revision information, filling in the "rev_info" structure,
  * and removing the used arguments from the argument list.
@@ -1228,17 +1260,26 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 int setup_revisions(int argc, const char **argv, struct rev_info *revs, const char *def)
 {
 	int i, flags, left, seen_dashdash;
+	enum append_stdin_mode append_stdin = 0;
 
-	/* First, search for "--" */
+	/* First, search for "--", "--stdin-paths", and "--stdin-paths-z" */
 	seen_dashdash = 0;
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
+
+		if (!strcmp(arg, "--stdin-paths"))
+			append_stdin = APPEND_STDIN;
+		else if (!strcmp(arg, "--stdin-paths-z"))
+			append_stdin = APPEND_STDIN_Z;
+
 		if (strcmp(arg, "--"))
 			continue;
 		argv[i] = NULL;
 		argc = i;
 		if (argv[i + 1])
-			revs->prune_data = get_pathspec(revs->prefix, argv + i + 1);
+			revs->prune_data = grab_pathspec(revs->prefix,
+							 argv + i + 1,
+							 append_stdin);
 		seen_dashdash = 1;
 		break;
 	}
@@ -1283,6 +1324,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				revs->no_walk = 0;
 				continue;
 			}
+			if (!strcmp(arg, "--stdin-paths") ||
+			    !strcmp(arg, "--stdin-paths-z"))
+				continue; /* already handled */
 
 			opts = handle_revision_opt(revs, argc - i, argv + i, &left, argv);
 			if (opts > 0) {
@@ -1308,12 +1352,19 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 			for (j = i; j < argc; j++)
 				verify_filename(revs->prefix, argv[j]);
 
-			revs->prune_data = get_pathspec(revs->prefix,
-							argv + i);
+			revs->prune_data = grab_pathspec(revs->prefix,
+							 argv + i,
+							 append_stdin);
 			break;
 		}
 	}
 
+	if (!revs->prune_data && append_stdin) {
+		const char *empty_argv[1] = { NULL };
+		revs->prune_data = grab_pathspec(revs->prefix, empty_argv,
+						 append_stdin);
+	}
+
 	if (revs->def == NULL)
 		revs->def = def;
 	if (revs->show_merge)
