From: Junio C Hamano <gitster@pobox.com>
Subject: Re: v1.5.4 plans
Date: Mon, 10 Dec 2007 21:02:26 -0800
Message-ID: <7vzlwhhli5.fsf@gitster.siamese.dyndns.org>
References: <7vy7d43ptc.fsf@gitster.siamese.dyndns.org>
	<7vabpg9x5k.fsf@gitster.siamese.dyndns.org>
	<7vy7cwsi3p.fsf@gitster.siamese.dyndns.org>
	<7vk5o6jbq9.fsf@gitster.siamese.dyndns.org>
	<7v63zjgoel.fsf@gitster.siamese.dyndns.org>
	<7vsl2i6ea4.fsf@gitster.siamese.dyndns.org>
	<7vhcixtnm4.fsf@gitster.siamese.dyndns.org>
	<7vfxye4yv7.fsf@gitster.siamese.dyndns.org>
	<7vve78qhtf.fsf@gitster.siamese.dyndns.org>
	<7vmysijhwq.fsf_-_@gitster.siamese.dyndns.org>
	<20071210234941.GE22254@coredump.intra.peff.net>
	<7vtzmqhvgq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 11 06:03:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1xGq-0000dS-P8
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 06:03:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbXLKFCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 00:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbXLKFCm
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 00:02:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48628 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbXLKFCl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 00:02:41 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D8DB3022;
	Tue, 11 Dec 2007 00:02:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 22BFF2184;
	Tue, 11 Dec 2007 00:02:33 -0500 (EST)
In-Reply-To: <7vtzmqhvgq.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 10 Dec 2007 17:27:17 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67787>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> A few regressions that you did not mention, but I think should be
>> addressed before 1.5.4:
>>
>>  - extra newline in builtin-commit output. You found a case that
>>    needs it, but fixing it is non-trivial, and I wanted to get your
>>    input before preparing a patch. See
>>
>>      http://mid.gmane.org/20071203075357.GB3614@sigill.intra.peff.net
>
> I am actually becoming somewhat fond of the newline that makes the end
> of a session that led to a commit stand out ;-). IOW, I was wondering if
> we can have another for a merge commit case.
>
> But I suspect that it amounts to the change in the same area and of
> similar complexity.

-- >8 --
[PATCH] commit: do not add extra LF at the end of the summary.

The scripted version relied on the nice "auto-strip the terminating LF"
behaviour shell gives to "var=$(cmd)" construct, but we have to roll
that ourselves.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-commit.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index b6b81d5..e5a972c 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -660,12 +660,17 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
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
+		pretty_print_commit(rev.commit_format, commit, &buf,
+				    0, NULL, NULL, 0, 0);
+		printf("%s\n", buf.buf);
+		strbuf_release(&buf);
+	}
 }
 
 int git_commit_config(const char *k, const char *v)
-- 
1.5.3.7-1149-g591a
