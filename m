From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix potential infinite loop given large unsigned integer
Date: Sun, 09 Aug 2009 00:38:08 -0700
Message-ID: <7v3a81a13z.fsf@alter.siamese.dyndns.org>
References: <a3f15ee60908082141l7b2134cg5ddcef17c45fc888@mail.gmail.com>
 <7vy6pta4rd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Flynn <parseerror@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 09:39:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ma2zg-0008KS-A6
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 09:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbZHIHir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 03:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbZHIHiq
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 03:38:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37093 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbZHIHiq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 03:38:46 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A61063D98;
	Sun,  9 Aug 2009 03:38:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB0BC3D97; Sun,  9 Aug
 2009 03:38:29 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ABF66004-84B7-11DE-9EE7-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125326>

Junio C Hamano <gitster@pobox.com> writes:

> Ryan Flynn <parseerror@gmail.com> writes:
>
>> given n, tried to find i greater than n via i=1, iterate i *= 10.
>> given n sufficiently close to UINT_MAX this will overflow; which can
>> produce i==0, which results in an infinite loop. iteratively dividing
>> n /= 10 does not have this problem, and though division is slower than
>> multiplication this only runs once per `git format-patch
>> --cover-letter`
>>
>> Signed-off-by: pizza <parseerror@gmail.com>
>
> Pizza?
>
> This is somewhat amusing.
>
>  - digits_in_number() is called only with opt->total that is "int";
>
>  - opt->total is the total number of patches.
>
>  - the return value is used like this:
>
>      sprintf(buf, "%0*d", digits_in_number(opt->total), opt->nr);
>
>    and opt->nr runs from 1 to opt->total; the use of "d" would be already
>    wrong anyway even if you computed digits_in_number() correctly.
>
> Perhaps we should get rid of this function altogether?

Or perhaps something stupid like this...

 builtin-log.c |    6 +++++-
 log-tree.c    |   12 +-----------
 revision.h    |    2 +-
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 3817bf1..321e8f5 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -1096,8 +1096,12 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	total = nr;
 	if (!keep_subject && auto_number && total > 1)
 		numbered = 1;
-	if (numbered)
+	if (numbered) {
+		static char num_buf[64];
 		rev.total = total + start_number - 1;
+		sprintf(num_buf, "%d", rev.total);
+		rev.num_width = strlen(num_buf);
+	}
 	if (in_reply_to || thread || cover_letter)
 		rev.ref_message_ids = xcalloc(1, sizeof(struct string_list));
 	if (in_reply_to) {
diff --git a/log-tree.c b/log-tree.c
index 6f73c17..0d32a6c 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -158,16 +158,6 @@ static void append_signoff(struct strbuf *sb, const char *signoff)
 	strbuf_addch(sb, '\n');
 }
 
-static unsigned int digits_in_number(unsigned int number)
-{
-	unsigned int i = 10, result = 1;
-	while (i <= number) {
-		i *= 10;
-		result++;
-	}
-	return result;
-}
-
 static int has_non_ascii(const char *s)
 {
 	int ch;
@@ -212,7 +202,7 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 		snprintf(buffer, sizeof(buffer),
 			 "Subject: [%s %0*d/%d] ",
 			 opt->subject_prefix,
-			 digits_in_number(opt->total),
+			 opt->num_width,
 			 opt->nr, opt->total);
 		subject = buffer;
 	} else if (opt->total == 0 && opt->subject_prefix && *opt->subject_prefix) {
diff --git a/revision.h b/revision.h
index fb74492..21e4d9d 100644
--- a/revision.h
+++ b/revision.h
@@ -84,7 +84,7 @@ struct rev_info {
 	unsigned int	abbrev;
 	enum cmit_fmt	commit_format;
 	struct log_info *loginfo;
-	int		nr, total;
+	int		nr, total, num_width;
 	const char	*mime_boundary;
 	const char	*patch_suffix;
 	int		numbered_files;
