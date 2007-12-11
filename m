From: Junio C Hamano <gitster@pobox.com>
Subject: Re: v1.5.4 plans
Date: Mon, 10 Dec 2007 23:00:55 -0800
Message-ID: <7v7ijlhg0o.fsf@gitster.siamese.dyndns.org>
References: <7vsl2i6ea4.fsf@gitster.siamese.dyndns.org>
	<7vhcixtnm4.fsf@gitster.siamese.dyndns.org>
	<7vfxye4yv7.fsf@gitster.siamese.dyndns.org>
	<7vve78qhtf.fsf@gitster.siamese.dyndns.org>
	<7vmysijhwq.fsf_-_@gitster.siamese.dyndns.org>
	<20071210234941.GE22254@coredump.intra.peff.net>
	<7vtzmqhvgq.fsf@gitster.siamese.dyndns.org>
	<7vzlwhhli5.fsf@gitster.siamese.dyndns.org>
	<20071211063941.GB21718@coredump.intra.peff.net>
	<7vd4tdhgnd.fsf@gitster.siamese.dyndns.org>
	<20071211065400.GA25985@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 11 08:01:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1z7W-0006ZN-Gf
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 08:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbXLKHBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 02:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbXLKHBM
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 02:01:12 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52679 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbXLKHBL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 02:01:11 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3ADE84E2A;
	Tue, 11 Dec 2007 02:01:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8ECC14E28;
	Tue, 11 Dec 2007 02:01:04 -0500 (EST)
In-Reply-To: <20071211065400.GA25985@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 11 Dec 2007 01:54:00 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67810>

Jeff King <peff@peff.net> writes:

> Perhaps it would be even more readable to simply split the printing of
> the commit message and the diff. Tracking this bug was a bit confusing.
> Ideally, print_summary would just say:
>
>   print_commit_message(commit);
>   print_diff(commit, "^commit");
>
> where obviously each of those takes a few lines to say properly. But the
> use of a combination "show the log and maybe the diff" function seems
> like a shell holdover, trying to avoid spawning too many processes.

Perhaps, but that's post 1.5.4.  There is no short-hand to call the
single commit diff-tree and not give any commit header afair.

Anyway, format-commit-message() makes it much more readable ;-)

diff --git a/builtin-commit.c b/builtin-commit.c
index b6b81d5..9cb7589 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -660,12 +660,16 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 	rev.verbose_header = 1;
 	rev.show_root_diff = 1;
 	rev.commit_format = get_commit_format("format:%h: %s");
-	rev.always_show_header = 1;
+	rev.always_show_header = 0;
 
 	printf("Created %scommit ", initial_commit ? "initial " : "");
 
-	log_tree_commit(&rev, commit);
-	printf("\n");
+	if (!log_tree_commit(&rev, commit)) {
+		struct strbuf buf = STRBUF_INIT;
+		format_commit_message(commit, "%h: %s", &buf);
+		printf("%s\n", buf.buf);
+		strbuf_release(&buf);
+	}
 }
 
 int git_commit_config(const char *k, const char *v)
