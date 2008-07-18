From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Enable git rev-list to parse --quiet
Date: Thu, 17 Jul 2008 23:10:19 -0700
Message-ID: <7vy73zd8ok.fsf@gitster.siamese.dyndns.org>
References: <20080718040459.13073.76896.stgit@marcab.local.tull.net>
 <7v8wvzeojm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nick Andrew <nick@nick-andrew.net>
X-From: git-owner@vger.kernel.org Fri Jul 18 08:11:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJjBl-0007LV-DP
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 08:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbYGRGK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 02:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752333AbYGRGK2
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 02:10:28 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59517 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343AbYGRGK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 02:10:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 31CF030841;
	Fri, 18 Jul 2008 02:10:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 538A230840; Fri, 18 Jul 2008 02:10:21 -0400 (EDT)
In-Reply-To: <7v8wvzeojm.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 17 Jul 2008 22:42:21 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 362CF4BC-5490-11DD-805E-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88994>

Junio C Hamano <gitster@pobox.com> writes:

> Nick Andrew <nick@nick-andrew.net> writes:
> ...
>> After fix:
>
> Thanks for noticing, but this replaces one breakage with another.
>
> Your new behaviour is a new "tell me if it is an empty set" option, and it
> means quite different thing from what --quiet does.

And here is how I would do it if I were interested in such a feature.

-- >8 --
rev-list --check-empty

This new option squelches the output entirely and signals if the specified
set is empty by its exit status.  E.g.

    $ git rev-list --check-empty HEAD..HEAD

will exit with a non-zero status, and

    $ git rev-list --check-empty HEAD^..HEAD

will exit with zero status.

---
 builtin-rev-list.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 507201e..4f9cce9 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -52,6 +52,7 @@ static const char rev_list_usage[] =
 
 static struct rev_info revs;
 
+static int check_empty;
 static int bisect_list;
 static int show_timestamp;
 static int hdr_termination;
@@ -161,6 +162,8 @@ static void show_commit(struct commit *commit)
 
 static void finish_commit(struct commit *commit)
 {
+	if (check_empty)
+		exit(0);
 	if (commit->parents) {
 		free_commit_list(commit->parents);
 		commit->parents = NULL;
@@ -171,6 +174,8 @@ static void finish_commit(struct commit *commit)
 
 static void finish_object(struct object_array_entry *p)
 {
+	if (check_empty)
+		exit(0);
 	if (p->item->type == OBJ_BLOB && !has_sha1_file(p->item->sha1))
 		die("missing blob object '%s'", sha1_to_hex(p->item->sha1));
 }
@@ -593,6 +598,10 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	for (i = 1 ; i < argc; i++) {
 		const char *arg = argv[i];
 
+		if (!strcmp(arg, "--check-empty")) {
+			check_empty = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--header")) {
 			revs.verbose_header = 1;
 			continue;
@@ -650,6 +659,9 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
+	if (check_empty)
+		quiet = 1;
+
 	if (revs.tree_objects)
 		mark_edges_uninteresting(revs.commits, &revs, show_edge);
 
@@ -699,6 +711,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	traverse_commit_list(&revs,
 		quiet ? finish_commit : show_commit,
 		quiet ? finish_object : show_object);
-
+	if (check_empty)
+		exit(1);
 	return 0;
 }
