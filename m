From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] combine-diff: suppress a clang warning
Date: Sun, 03 Feb 2013 16:24:52 -0800
Message-ID: <7vip696i3v.fsf@alter.siamese.dyndns.org>
References: <cover.1359901732.git.john@keeping.me.uk>
 <6995fd5e4d9cb3320ab80c983f1b25ae8a399284.1359901732.git.john@keeping.me.uk>
 <7vwqup890o.fsf@alter.siamese.dyndns.org>
 <20130203203150.GU1342@serenity.lan>
 <7v8v7585sr.fsf@alter.siamese.dyndns.org>
 <20130203231549.GV1342@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Feb 04 01:25:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U29s6-0002ZQ-9p
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 01:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061Ab3BDAY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 19:24:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45596 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753998Ab3BDAYz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 19:24:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69525BE32;
	Sun,  3 Feb 2013 19:24:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iCfEfQxem+YB/1ChgaOlJkMth7Q=; b=mHb+ZS
	2WWiBIFHilJjdHmfu0aCBnlJ9KCpY50+Eb+KdVtGX+XzGWx8frSaezHmI4M07+dc
	YC+itjgkm2IWQISlrDk8GyhI1O+3e60Ae0eHGndLq+z3z+iY45hw9nBUS3FnSQge
	eDSEFHiyLipIQmBovvgNU+sA0dKKgQGfJfU/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qax0/POBGWM/zXnu77WN+99DUKMFO46f
	RqUCjfDaIU3Qw05gdFyez9Nd6DzzZEd39n0VcGYomii8hio6W97y8/8RTeZKeqMW
	f6adhqm32pzrlHtkMRRJtG3aSsqeatPqK1zEsJaS9tZiKMfTU1TGMprGGjPXnx1/
	kML+thouxfw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E5F6BE31;
	Sun,  3 Feb 2013 19:24:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB5ACBE30; Sun,  3 Feb 2013
 19:24:53 -0500 (EST)
In-Reply-To: <20130203231549.GV1342@serenity.lan> (John Keeping's message of
 "Sun, 3 Feb 2013 23:15:49 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4BE03EC8-6E61-11E2-84C6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215345>

John Keeping <john@keeping.me.uk> writes:

>> If we were to be touching that area of code, I'd rather see a change
>> to make it more robust against such a corner case.  If it results in
>> squelching misguided clang warnings against programmers who should
>> not be writing in C, that is a nice side effect, but I loathe to see
>> any change whose primary purpose is to squelch pointless warnings.
>
> This seems like a sensible change.
>
> I generally like to get rid of the pointless warnings so that the useful
> ones can't hide in the noise.  Perhaps "CFLAGS += -Wno-string-plus-int"
> would be better for this particular warning, but when there's only one
> bit of code that triggers it, tweaking that seemed simpler.

Thanks for a sanity check.  Ideally it should also have test cases
to show "git diff --cc --raw blob1 blob2...blob$n" for n=4 and n=40
(or any two values clearly below and above the old hardcoded limit)
behave sensibly, exposing the old breakage, which I'll leave as a
LHF (low-hanging-fruit).  Hint, hint...

-- >8 --
Subject: [PATCH] combine-diff: lift 32-way limit of combined diff

The "raw" format of combine-diff output is supposed to have as many
colons as there are parents at the beginning, then blob modes for
these parents, and then object names for these parents.

We weren't however prepared to handle a more than 32-way merge and
did not show the correct number of colons in such a case.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 combine-diff.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index bb1cc96..7f6187f 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -982,14 +982,10 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	free(sline);
 }
 
-#define COLONS "::::::::::::::::::::::::::::::::"
-
 static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct rev_info *rev)
 {
 	struct diff_options *opt = &rev->diffopt;
-	int i, offset;
-	const char *prefix;
-	int line_termination, inter_name_termination;
+	int line_termination, inter_name_termination, i;
 
 	line_termination = opt->line_termination;
 	inter_name_termination = '\t';
@@ -1000,17 +996,14 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
 		show_log(rev);
 
 	if (opt->output_format & DIFF_FORMAT_RAW) {
-		offset = strlen(COLONS) - num_parent;
-		if (offset < 0)
-			offset = 0;
-		prefix = COLONS + offset;
+		/* As many colons as there are parents */
+		for (i = 0; i < num_parent; i++)
+			putchar(':');
 
 		/* Show the modes */
-		for (i = 0; i < num_parent; i++) {
-			printf("%s%06o", prefix, p->parent[i].mode);
-			prefix = " ";
-		}
-		printf("%s%06o", prefix, p->mode);
+		for (i = 0; i < num_parent; i++)
+			printf("%06o ", p->parent[i].mode);
+		printf("%06o", p->mode);
 
 		/* Show sha1's */
 		for (i = 0; i < num_parent; i++)
-- 
1.8.1.2.628.geb8a6d5
