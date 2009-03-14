From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove unused assignments
Date: Sat, 14 Mar 2009 13:18:02 -0700
Message-ID: <7v7i2rc0zp.fsf@gitster.siamese.dyndns.org>
References: <49BA56D5.5050807@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benjamin Kramer <benny.kra@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 21:19:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiaKk-00088K-QX
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 21:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755653AbZCNUSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2009 16:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754592AbZCNUSK
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 16:18:10 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59567 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbZCNUSI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 16:18:08 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CF65F655C;
	Sat, 14 Mar 2009 16:18:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0FEA86558; Sat,
 14 Mar 2009 16:18:03 -0400 (EDT)
In-Reply-To: <49BA56D5.5050807@googlemail.com> (Benjamin Kramer's message of
 "Fri, 13 Mar 2009 13:51:33 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3ACEB51C-10D5-11DE-A223-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113258>

Benjamin Kramer <benny.kra@googlemail.com> writes:

> These variables were always overwritten or the assigned
> value was unused:
>
> builtin-diff-tree.c::cmd_diff_tree(): nr_sha1
> builtin-for-each-ref.c::opt_parse_sort(): sort_tail
> builtin-mailinfo.c::decode_header_bq(): in
> builtin-shortlog.c::insert_one_record(): len
> connect.c::git_connect(): path
> imap-send.c::v_issue_imap_cmd(): n
> pretty.c::pp_user_info(): filler
> remote::parse_refspec_internal(): llen
>
> Signed-off-by: Benjamin Kramer <benny.kra@googlemail.com>

Thanks.  I eyeballed all of them and they look safe, but this patch made
me wonder...

Did you use some dataflow analysis tool to spot these?

It will never scale if a human has to sanity check output from a
mechanical process like this patch, especially when the human is already a
chokepoint of the whole process (i.e. the maintainer).

We'd need some process improvements in the longer term to handle patches
like this, but I do not think of a good one offhand.

I do not think we want to trust tool output blindly; it will not solve the
issue to give me the recipe for the mechanical process you used, to have
me run it and to make me trust the result without checking.  We would want
to keep some human whose judgement we can trust in the loop to always
check the changes mechanical analysis tools may produce.

I think the only viable long term solution would be to keep doing the
manual verification I did like this round until somebody like you
accumulate enough "trust points" in the community for consistently sending
good patches like this one to allow me to apply patches from these people
blindly, trusting the sender's judgement.

But please disregard all of the above if you spotted these by manual
inspection.

I think the patch to pp_user_info() can go one step further.  The filler
is used at only one place after this patch, as a strong given to one of
the placeholders in strbuf_addf().  We can simply feed a constant to the
function instead, like this:

diff --git a/pretty.c b/pretty.c
index 3a24cd5..efa7024 100644
--- a/pretty.c
+++ b/pretty.c
@@ -135,7 +135,6 @@ void pp_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
 	int namelen;
 	unsigned long time;
 	int tz;
-	const char *filler = "    ";
 
 	if (fmt == CMIT_FMT_ONELINE)
 		return;
@@ -161,7 +160,7 @@ void pp_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
 	} else {
 		strbuf_addf(sb, "%s: %.*s%.*s\n", what,
 			      (fmt == CMIT_FMT_FULLER) ? 4 : 0,
-			      filler, namelen, line);
+			      "    ", namelen, line);
 	}
 	switch (fmt) {
 	case CMIT_FMT_MEDIUM:
