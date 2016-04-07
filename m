From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: --amend -m '' silently fails to wipe message
Date: Thu, 07 Apr 2016 11:12:19 -0700
Message-ID: <xmqqshyxz3ss.fsf@gitster.mtv.corp.google.com>
References: <20160406171503.GA2345@dinwoodie.org>
	<20160407044219.GA29710@sigill.intra.peff.net>
	<20160407044837.GA28859@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org,
	Chris Webb <chris@arachsys.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 07 20:12:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoEPt-0007pc-Nw
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 20:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757281AbcDGSMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 14:12:25 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57348 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757091AbcDGSMY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 14:12:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8B79A50788;
	Thu,  7 Apr 2016 14:12:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=baAD9dJqLRD/DXWcHGKZD0h094w=; b=lEj1lm
	/hDaiPqqHU17SU+DSH4qOf6fc3kJ3o+f2Hvlab0CIGGRGaBV5bZ7dOB36rngnryo
	B6quXdm50wCC3HWVUt+ypMjQ9tvytU/FpzkzGVLCcG+aU0ymitI+jZrEGLwWd+L6
	idvoNttszR1DDSjmo7NPW6RUkl43QHb2O6r9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t9fwwcj7h2jBE/VLATeLS0YkzyiGS23M
	ThYHrEuBHZykQzY5ev8X8hxMM9fEQWdo8l3DZwnAHQEXEkZpIJ4vuedDJqfcvjiA
	v0+D0MVtKX+8Zgu1G6FHb8JKSbr5n3NrtpmRKOEfNzr7x6zoC5N5H4saOdo020Sn
	YqR31DChXf4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8354150786;
	Thu,  7 Apr 2016 14:12:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 003DF50785;
	Thu,  7 Apr 2016 14:12:20 -0400 (EDT)
In-Reply-To: <20160407044837.GA28859@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 7 Apr 2016 00:48:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 45526E92-FCEC-11E5-84A4-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290942>

Jeff King <peff@peff.net> writes:

> I guessed that this might have come from the conversion of "message"
> form a pointer (which could be NULL) into a strbuf. And indeed, it looks
> like f956853 (builtin-commit: resurrect behavior for multiple -m
> options, 2007-11-11) did that.

Yikes.  That is a quite ancient breakage.

The funny thing is that we did address the same breakage in 25206778
(commit: don't start editor if empty message is given with -m,
2013-05-25), but didn't notice that there are other breakages of the
same nature.

I think all message.len check can and should be have_option_m
instead.

 - The one in the first hunk is a fix for the issue that "-m ''" is
   ignored and we read from use_message etc., which is the original
   issue in this thread.

 - The second one is a fix for your "git commit -m '' -F f" example
   that does not error out.

 - The last one is a fix for "git -c commit.template=f commit -m ''"
   that still uses the template file 'f'.

 builtin/commit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 98e1527..391126e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -695,7 +695,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		}
 	}
 
-	if (message.len) {
+	if (have_option_m) {
 		strbuf_addbuf(&sb, &message);
 		hook_arg1 = "message";
 	} else if (logfile && !strcmp(logfile, "-")) {
@@ -1172,9 +1172,9 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		f++;
 	if (f > 1)
 		die(_("Only one of -c/-C/-F/--fixup can be used."));
-	if (message.len && f > 0)
+	if (have_option_m && f > 0)
 		die((_("Option -m cannot be combined with -c/-C/-F/--fixup.")));
-	if (f || message.len)
+	if (f || have_option_m)
 		template_file = NULL;
 	if (edit_message)
 		use_message = edit_message;
