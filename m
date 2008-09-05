From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add --dirstat-by-file diff option
Date: Fri, 05 Sep 2008 13:22:18 -0700
Message-ID: <7viqtauyv9.fsf@gitster.siamese.dyndns.org>
References: <20080905192735.GA12853@zakalwe.fi>
 <20080905194158.GA31826@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heikki Orsila <heikki.orsila@iki.fi>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 05 22:24:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kbhqc-0002W5-Sg
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 22:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179AbYIEUW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 16:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbYIEUW1
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 16:22:27 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36944 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbYIEUW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 16:22:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 714897572D;
	Fri,  5 Sep 2008 16:22:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E34CF7572A; Fri,  5 Sep 2008 16:22:19 -0400 (EDT)
In-Reply-To: <20080905194158.GA31826@coredump.intra.peff.net> (Jeff King's
 message of "Fri, 5 Sep 2008 15:41:58 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 59DEB930-7B88-11DD-A23B-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95038>

Jeff King <peff@peff.net> writes:

> On Fri, Sep 05, 2008 at 10:27:35PM +0300, Heikki Orsila wrote:
>
>> --dirstat-by-file is the same as --dirstat, but it counts
>> "impacted files" instead of "impacted lines" (lines that
>> are added or removed).
>> 
>> The patch also cleans --cumulative option handling.
>> DIFF_OPT_CUMULATIVE_DIRSTAT is used instead of
>> DIFF_FORMAT_CUMULATIVE.
>
> I was going to suggest that this actually be split into two patches for
> readability, but lo and behold, Junio has already committed a fix for
> --cumulative to next. So you probably should rebase your other changes
> (which look reasonable to me) on top of that.

The fix was a maint material (the bug being "'diff --cumulative' is a
no-op"), so it is everywhere not just next.

Heikki, thanks for the patch, and no need to rebase nor resend.

"am -3" works wonders in cases like this, and I can just remove the part
that talk about cumulative from your proposed log message.

---

 Documentation/diff-options.txt |    3 +++
 diff.c                         |   10 +++++++++-
 diff.h                         |    1 +
 3 files changed, 13 insertions(+), 1 deletions(-)

diff --git c/Documentation/diff-options.txt w/Documentation/diff-options.txt
index 6e26832..7788d4f 100644
--- c/Documentation/diff-options.txt
+++ w/Documentation/diff-options.txt
@@ -65,6 +65,9 @@ endif::git-format-patch[]
 	can be set with "--dirstat=limit". Changes in a child directory is not
 	counted for the parent directory, unless "--cumulative" is used.
 
+--dirstat-by-file[=limit]::
+	Same as --dirstat, but counts changed files instead of lines.
+
 --summary::
 	Output a condensed summary of extended header information
 	such as creations, renames and mode changes.
diff --git c/diff.c w/diff.c
index cbd151b..2de86eb 100644
--- c/diff.c
+++ w/diff.c
@@ -1110,9 +1110,13 @@ static void show_dirstat(struct diff_options *options)
 		/*
 		 * Original minus copied is the removed material,
 		 * added is the new material.  They are both damages
-		 * made to the preimage.
+		 * made to the preimage. In --dirstat-by-file mode, count
+		 * damaged files, not damaged lines. This is done by
+		 * counting only a single damaged line per file.
 		 */
 		damage = (p->one->size - copied) + added;
+		if (DIFF_OPT_TST(options, DIRSTAT_BY_FILE) && damage > 0)
+			damage = 1;
 
 		ALLOC_GROW(dir.files, dir.nr + 1, dir.alloc);
 		dir.files[dir.nr].name = name;
@@ -2476,6 +2480,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	else if (!strcmp(arg, "--cumulative")) {
 		options->output_format |= DIFF_FORMAT_DIRSTAT;
 		DIFF_OPT_SET(options, DIRSTAT_CUMULATIVE);
+	} else if (opt_arg(arg, 0, "dirstat-by-file",
+			   &options->dirstat_percent)) {
+		options->output_format |= DIFF_FORMAT_DIRSTAT;
+		DIFF_OPT_SET(options, DIRSTAT_BY_FILE);
 	}
 	else if (!strcmp(arg, "--check"))
 		options->output_format |= DIFF_FORMAT_CHECKDIFF;
diff --git c/diff.h w/diff.h
index 7f53beb..c346888 100644
--- c/diff.h
+++ w/diff.h
@@ -64,6 +64,7 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_OPT_RELATIVE_NAME       (1 << 17)
 #define DIFF_OPT_IGNORE_SUBMODULES   (1 << 18)
 #define DIFF_OPT_DIRSTAT_CUMULATIVE  (1 << 19)
+#define DIFF_OPT_DIRSTAT_BY_FILE     (1 << 20)
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
 #define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag)
