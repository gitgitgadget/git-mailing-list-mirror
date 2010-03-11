From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do not strip empty lines / trailing spaces from a commit
 message template
Date: Thu, 11 Mar 2010 12:46:51 -0800
Message-ID: <7vaaueziv8.fsf@alter.siamese.dyndns.org>
References: <4B97C157.4020806@gmail.com>
 <20100311081213.GA13575@sigill.intra.peff.net>
 <20100311083148.GA13786@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 11 21:47:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NppHj-0007EC-PH
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 21:47:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670Ab0CKUrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 15:47:05 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39829 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab0CKUrB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 15:47:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E922A1562;
	Thu, 11 Mar 2010 15:47:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nz7s9nWSG1w0rXftb3k/81IaioY=; b=wJVfso
	9e+s/g4ZsRgTux+AcLDvfSbVOW4aOcqw/jZ+wdr3MHJeHwrSOp7rOzPjYT+tFW9/
	gGqx/qWCzTjgshCGYPG8+yy6GY8LU2b6Elj1CTcjmHDZ1gMJ/dbPLN3ggAbI/EOU
	MpdBETbpwV/4l4nQ2vH7t0aR1S6Wwb+jHkYa8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=olOa1YEjH3E344eGz3QtSN1l1/kRuKcI
	qzjSt2/eHoYN370tsKUtEqPMnTwYwax/HqHXzo6cK9gh5MTJcuznvZLv8BnQItuM
	5mboRJvehwySq93FR/XqsqTu6ej2gd5engyHSpokBAeFumPT4BEjfzTWyqibcwd7
	X8MYf1jb5ZI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CE3FA1561;
	Thu, 11 Mar 2010 15:46:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44249A1560; Thu, 11 Mar
 2010 15:46:53 -0500 (EST)
In-Reply-To: <20100311083148.GA13786@sigill.intra.peff.net> (Jeff King's
 message of "Thu\, 11 Mar 2010 03\:31\:48 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3BA7647E-2D4F-11DF-AA7E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141998>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 11, 2010 at 03:12:13AM -0500, Jeff King wrote:
>
>> >  	if (fp == NULL)
>> >  		die_errno("could not open '%s'", git_path(commit_editmsg));
>> >  
>> > -	if (cleanup_mode != CLEANUP_NONE)
>> > +	if (cleanup_mode != CLEANUP_NONE && strcmp(hook_arg1, "template"))
>> >  		stripspace(&sb, 0);
>> 
>> And the code looks OK, though admittedly I am not too familiar with this
>> chunk of code (at first I was confused that you would have to look at
>> hook_arg1, but apparently there is no other variable that contains the
>> result of that big if-else chain).


I suspect that the attached would be much easier to read and understand.

> BTW, a subtle point for anyone else reviewing this patch: we also call
> stripspace in message_is_empty to skip over an untouched template. But
> that code path is stil OK, because we stripspace the whole message that
> comes back from the user before calling message_is_empty(), so the
> result should be the same for an untouched template.
>
> -Peff

Thanks for a patch and a review.

> How about a test to check the new behavior?

Speaking of tests, t2203 will segfault with your patch.  I don't think the
following does, though.

 builtin-commit.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 8a68dd3..14488d5 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -534,6 +534,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	const char *hook_arg1 = NULL;
 	const char *hook_arg2 = NULL;
 	int ident_shown = 0;
+	int clean_message_contents = (cleanup_mode != CLEANUP_NONE);
 
 	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
 		return 0;
@@ -571,6 +572,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		if (strbuf_read_file(&sb, template_file, 0) < 0)
 			die_errno("could not read '%s'", template_file);
 		hook_arg1 = "template";
+		clean_message_contents = 0;
 	}
 
 	/*
@@ -584,7 +586,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	if (fp == NULL)
 		die_errno("could not open '%s'", git_path(commit_editmsg));
 
-	if (cleanup_mode != CLEANUP_NONE && strcmp(hook_arg1, "template"))
+	if (clean_message_contents)
 		stripspace(&sb, 0);
 
 	if (signoff) {
