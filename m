From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: --amend -m '' silently fails to wipe message
Date: Thu, 07 Apr 2016 12:56:26 -0700
Message-ID: <xmqq1t6hyyz9.fsf@gitster.mtv.corp.google.com>
References: <20160406171503.GA2345@dinwoodie.org>
	<20160407044219.GA29710@sigill.intra.peff.net>
	<20160407044837.GA28859@sigill.intra.peff.net>
	<xmqqshyxz3ss.fsf@gitster.mtv.corp.google.com>
	<20160407190210.GA4478@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org,
	Chris Webb <chris@arachsys.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 07 21:56:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoG2k-0007sF-MJ
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbcDGT4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:56:34 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58574 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753175AbcDGT4d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:56:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B4D40534C2;
	Thu,  7 Apr 2016 15:56:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MojoJmvxSybs8OGs22NrsUMF4go=; b=BSamv3
	C7HEM4ZcUIT0rGsAUb1oej1pfsz3N7CHXO+3g7Fs62pQFq0jpexUikI294KXa6St
	34z/oVRhJeC2CvBT8xZAAgOtTa1BrpwMyNyai0wRzsPMYZJMtGc5Fd88C4+28B0k
	g+IwjAFPjj4rrfSQ1Lm61wVRdl+qtzsh+qTBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X5b1JlCV2ctA4w28MKO0eeTTDxr4NNFH
	ftqoUpJxxfFfCQlN4m3Y9mr4nAvC15Dizm8iM36Qpec/X/mv49/oTVTVYElfgGHv
	hWEvOurf6gAWNP8JCDlyJoI4SCKbOlK8BWXDVxSF2+5VOwQzJY5SuC0B/NfAla2z
	FeEu5WLp3Rs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AC1CA534C1;
	Thu,  7 Apr 2016 15:56:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2F7CF534C0;
	Thu,  7 Apr 2016 15:56:27 -0400 (EDT)
In-Reply-To: <20160407190210.GA4478@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 7 Apr 2016 15:02:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D057A60C-FCFA-11E5-BDEC-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290979>

Jeff King <peff@peff.net> writes:

> Yes, FWIW, those were the sites and reasons I identified last night.
> Your patch looks like the right thing to me.

Thanks, let's do this then.  I'd already anticipated your sign-off ;-).

-- >8 --
From: Jeff King <peff@peff.net>
Subject: commit: do not ignore an empty message given by -m ''

When f9568530 (builtin-commit: resurrect behavior for multiple -m
options, 2007-11-11) converted a "char *message" to "struct strbuf
message" to hold the messages given with the "-m" option, it
incorrectly changed the checks "did we get a message with the -m
option?" to "is message.len 0?".  Later, we noticed one breakage
from this change and corrected it with 25206778 (commit: don't start
editor if empty message is given with -m, 2013-05-25).

However, "we got a message with -m, even though an empty one, so we
shouldn't be launching an editor" was not the only breakage.

 * "git commit --amend -m '' --allow-empty", even though it looks
   strange, is a valid request to amend the commit to have no
   message at all.  Due to the misdetection of the presence of -m on
   the command line, we ended up keeping the log messsage from the
   original commit.

 * "git commit -m "$msg" -F file" should be rejected whether $msg is
   an empty string or not, but due to the same bug, was not rejected
   when $msg is empty.

 * "git -c template=file -m "$msg"" should ignore the template even
   when $msg is empty, but it didn't and instead used the contents
   from the template file.

Correct these by checking have_option_m, which the earlier 25206778
introduced to fix the same bug.

Reported-by: Adam Dinwoodie <adam@dinwoodie.org>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
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
