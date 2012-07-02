From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git blame gives an ambiguous short revision
Date: Mon, 02 Jul 2012 00:28:03 -0700
Message-ID: <7vehou39mk.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.02.1207010825370.1873@hadrien>
 <7vipe63a4r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
X-From: git-owner@vger.kernel.org Mon Jul 02 09:28:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Slb3N-0005f2-PV
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jul 2012 09:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754589Ab2GBH2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 03:28:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36564 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752826Ab2GBH2G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 03:28:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E95B6565;
	Mon,  2 Jul 2012 03:28:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oV8OJH05UzREC4I+I6FrFhK3hvw=; b=Fz/vu8
	uMZ4lfKhHFCWMNvV5mpJcfZQRhQgfttHiw5zSuVBlMNIkU5F2seQcYjFm3J+IIqR
	YtlI4JrYGeeC5M24ZVjekQB2wUrlRSus5pPG8xLLJpyjdba+Broi2AIHOAu5m0ol
	LDRp0JLuV85yGvJGQarQV5Oaznzzay+uH0+ts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EMbEZeEjoW1Dw8SNN3AcMJqBmqo2bXE9
	lnROuw6KWD7eYcNw0FE7OyEbmqqze7HreVSlq0o4Ax5vBnAV94ncWK5YVpdTDCMy
	SmBya8CerjqGR+M468hfxFn4ZqMucMv0Vvb5FhtKX244g/LG+ssk6tzQ6TuSR+E/
	+XlcHoH3SdI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 963226564;
	Mon,  2 Jul 2012 03:28:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9EC666563; Mon,  2 Jul 2012
 03:28:04 -0400 (EDT)
In-Reply-To: <7vipe63a4r.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 02 Jul 2012 00:17:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 76586918-C417-11E1-AFE5-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200848>

Junio C Hamano <gitster@pobox.com> writes:

> I think it should be an easy patch to add a post-processing phase
> after all lines are blamed to automatically compute an appropriate
> value of abbreviation to ensure the uniqueness, but the current
> blame output does not bother to do so.

Something like this, perhaps, but I didn't test the patch beyond "it
compiles".

 builtin/blame.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 24d3dd5..960c58d 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1837,6 +1837,16 @@ static int read_ancestry(const char *graft_file)
 	return 0;
 }
 
+static int update_auto_abbrev(int auto_abbrev, struct origin *suspect)
+{
+	const char *uniq = find_unique_abbrev(suspect->commit->object.sha1,
+					      auto_abbrev);
+	int len = strlen(uniq);
+	if (auto_abbrev < len)
+		return len;
+	return auto_abbrev;
+}
+
 /*
  * How many columns do we need to show line numbers, authors,
  * and filenames?
@@ -1847,12 +1857,16 @@ static void find_alignment(struct scoreboard *sb, int *option)
 	int longest_dst_lines = 0;
 	unsigned largest_score = 0;
 	struct blame_entry *e;
+	int compute_auto_abbrev = (abbrev < 0);
+	int auto_abbrev = default_abbrev;
 
 	for (e = sb->ent; e; e = e->next) {
 		struct origin *suspect = e->suspect;
 		struct commit_info ci;
 		int num;
 
+		if (compute_auto_abbrev)
+			auto_abbrev = update_auto_abbrev(auto_abbrev, suspect);
 		if (strcmp(suspect->path, sb->path))
 			*option |= OUTPUT_SHOW_NAME;
 		num = strlen(suspect->path);
@@ -1880,6 +1894,10 @@ static void find_alignment(struct scoreboard *sb, int *option)
 	max_orig_digits = decimal_width(longest_src_lines);
 	max_digits = decimal_width(longest_dst_lines);
 	max_score_digits = decimal_width(largest_score);
+
+	if (compute_auto_abbrev)
+		/* one more abbrev length is needed for the boundary commit */
+		abbrev = auto_abbrev + 1;
 }
 
 /*
@@ -2353,10 +2371,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 parse_done:
 	argc = parse_options_end(&ctx);
 
-	if (abbrev == -1)
-		abbrev = default_abbrev;
-	/* one more abbrev length is needed for the boundary commit */
-	abbrev++;
+	if (0 < abbrev)
+		/* one more abbrev length is needed for the boundary commit */
+		abbrev++;
 
 	if (revs_file && read_ancestry(revs_file))
 		die_errno("reading graft file '%s' failed", revs_file);
