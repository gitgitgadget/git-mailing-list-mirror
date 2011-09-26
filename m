From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git apply/am whitespace errors
Date: Mon, 26 Sep 2011 13:39:03 -0700
Message-ID: <7vr53311js.fsf@alter.siamese.dyndns.org>
References: <CALFxCvxxbsgZnhqK9nN7h=1ASJzfDJ7aVF+rM-8RUyKhpv8FzQ@mail.gmail.com>
 <7vzkhr142r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: neubyr <neubyr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 22:39:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8HxR-0005jR-JN
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 22:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207Ab1IZUjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 16:39:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48402 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750976Ab1IZUjG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 16:39:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E248C5AF2;
	Mon, 26 Sep 2011 16:39:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hsqPqeOBi4+ifOoddAEY9TsFjiA=; b=LUTlvc
	aPSJxCBPp0gqlJTriHLqKMhw1IIaOXM2hNesuuv8x0TsgrVZzL++0TVpSk/sH5CM
	aI0REW8i7NA1HW5FlDQ/IslZQPPlEeT6TFDdnHkP2JDT01XmrLODEa5XMMkE+ZOO
	Hgr/YAqWKjk7GRmzAT0sU4rXlVUOVmDo18se0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UmDBuFMeE9FtxJ+ZjZMAe99tneXNxi+I
	kIxSm5nWfTva7/y9aXbZU5OHO79+nRH9PJMg7QZvlVjY0Ifdz3QHowhO1+yzAKhS
	TZg0Qj8Sa86A/G9qBHgJn5GHWpptukw+vdmPS3ai67BtHqeCT9r/zT51DaOpMomm
	xYtvcdU2kLM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA0FA5AF0;
	Mon, 26 Sep 2011 16:39:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 566BF5AEF; Mon, 26 Sep 2011
 16:39:05 -0400 (EDT)
In-Reply-To: <7vzkhr142r.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 26 Sep 2011 12:44:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9376F074-E87F-11E0-8A6D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182162>

Subject: apply --whitespace=error: correctly report new blank lines at end

Earlier 77b15bb (apply --whitespace=warn/error: diagnose blank at EOF,
2009-09-03) cheated by reporting the line number of the hunk that contains
the offending line that adds new blank lines at the end of the file. All
other types of whitespace errors are reported with the line number in the
patch file that has the actual offending text.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is an interim workaround. fragment->linenr was added for the
   specific purpose of reporting this type of error in the quoted patch,
   and the field is not used for any other purpose, so it may be a better
   fix to either rename it to hunk_linenr and use it directly without
   introducing a new local variable in apply_one_fragment(), or pass
   "linenr" as a parameter to parse_fragment() and pass it down the
   callchain all the way through, or something like that.

 builtin/apply.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index f2edc52..092429a 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2447,6 +2447,8 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 	char *old, *oldlines;
 	struct strbuf newlines;
 	int new_blank_lines_at_end = 0;
+	int found_new_blank_lines_at_end = 0;
+	int hunk_linenr = frag->linenr;
 	unsigned long leading, trailing;
 	int pos, applied_pos;
 	struct image preimage;
@@ -2540,14 +2542,18 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 				error("invalid start of line: '%c'", first);
 			return -1;
 		}
-		if (added_blank_line)
+		if (added_blank_line) {
+			if (!new_blank_lines_at_end)
+				found_new_blank_lines_at_end = hunk_linenr;
 			new_blank_lines_at_end++;
+		}
 		else if (is_blank_context)
 			;
 		else
 			new_blank_lines_at_end = 0;
 		patch += len;
 		size -= len;
+		hunk_linenr++;
 	}
 	if (inaccurate_eof &&
 	    old > oldlines && old[-1] == '\n' &&
@@ -2629,7 +2635,8 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 		    preimage.nr + applied_pos >= img->nr &&
 		    (ws_rule & WS_BLANK_AT_EOF) &&
 		    ws_error_action != nowarn_ws_error) {
-			record_ws_error(WS_BLANK_AT_EOF, "+", 1, frag->linenr);
+			record_ws_error(WS_BLANK_AT_EOF, "+", 1,
+					found_new_blank_lines_at_end);
 			if (ws_error_action == correct_ws_error) {
 				while (new_blank_lines_at_end--)
 					remove_last_line(&postimage);
-- 
1.7.7.rc3
