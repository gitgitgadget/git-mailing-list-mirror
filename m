From: Junio C Hamano <gitster@pobox.com>
Subject: Re: segfault for git log --graph --no-walk --grep a
Date: Fri, 08 Feb 2013 16:47:01 -0800
Message-ID: <7va9rexqii.fsf@alter.siamese.dyndns.org>
References: <201302090052.22053.thom311@gmail.com>
 <7vsj56xsg5.fsf@alter.siamese.dyndns.org>
 <7vobfuxrns.fsf@alter.siamese.dyndns.org>
 <20130209002710.GA5570@sigill.intra.peff.net>
 <7vfw16xqvj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Haller <thom311@gmail.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 09 01:47:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3ybN-00039D-N1
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 01:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324Ab3BIArI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 19:47:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53724 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932205Ab3BIArE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 19:47:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33C55B36F;
	Fri,  8 Feb 2013 19:47:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nAMZNMWNjLtlcEEkEx02oC1tsNA=; b=p3r4pt
	a4gNI6b/EWzsne/uwoCETOX9B/lh5VZY11T2uT1iWJt2/FcD5mHNwyngghR51FZk
	EEJqw3pn1LvbJ277mYGTVQIXxqViZVGYbVcAqsiCaqdfDU8G1/I7SGZfCnTpDlQD
	jwP4d1FPMp+cAlSc8VyHoFiK1wwHdQVRmRRIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nuuc0f2NCio6p+M0ikoqJR3XnysyPucR
	5BW3EgTWdYga9sdMGpdGTLSUmU1KADUfv7mx4jdqyCh65Xqb+pvBSgiSSnY3SpTV
	8HJZsHjAl5erBIGxjPmjTBrmidCNa7haNVBFumRDFt1B9Ouq6ebYmrW0dQsdVprl
	c1/zNPg3cVo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01D8EB36E;
	Fri,  8 Feb 2013 19:47:04 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3551AB36A; Fri,  8 Feb 2013
 19:47:03 -0500 (EST)
In-Reply-To: <7vfw16xqvj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 08 Feb 2013 16:39:12 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 38512CBA-7252-11E2-AB18-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215836>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Fri, Feb 08, 2013 at 04:22:15PM -0800, Junio C Hamano wrote:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>> 
>>> > Thomas Haller <thom311@gmail.com> writes:
>>> >
>>> >> it happens in file revision.c:2306 because "commit->buffer" is zero:
>>> >>
>>> >>                 retval = grep_buffer(&opt->grep_filter,
>>> >>                                      commit->buffer, strlen(commit->buffer));
>>> >
>>> > I think this has been fixed at be5c9fb9049e (logmsg_reencode: lazily
>>> > load missing commit buffers, 2013-01-26); I haven't merged it to any
>>> > of the maintenance releases, but the tip of 'master' should have it
>>> > already.
>>> 
>>> Ah, no, this shares the same roots as the breakage the said commit
>>> fixed, and the solution should use the same idea, but not fixed.
>>
>> Yeah, I think this needs separate treatment. However, this is a perfect
>> example of the "case-by-case" I mention in the final two paragraphs
>> there.
>>
>> What's the right encoding to be grepping in? The original, what we will
>> output in, or even something else? IOW, I wonder if this should be using
>> logmsg_reencode in the first place (the obvious reason not to want to do
>> so is speed, but logmsg_reencode is written to only have an impact in
>> the case that we do indeed need to reencode).
>
> Yeah, that actually is a good point.  We should be using logmsg_reencode
> so that we look for strings in the user's encoding.

Perhaps like this.  Just like the previous one (which should be
discarded), this makes the function always use the temporary strbuf,
so doing this upfront actually loses more code than it adds ;-)

 revision.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/revision.c b/revision.c
index d7562ee..07bf728 100644
--- a/revision.c
+++ b/revision.c
@@ -2269,6 +2269,9 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 {
 	int retval;
 	struct strbuf buf = STRBUF_INIT;
+	char *message;
+	const char *encoding;
+
 	if (!opt->grep_filter.pattern_list && !opt->grep_filter.header_list)
 		return 1;
 
@@ -2279,32 +2282,24 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 		strbuf_addch(&buf, '\n');
 	}
 
-	/* Copy the commit to temporary if we are using "fake" headers */
-	if (buf.len)
-		strbuf_addstr(&buf, commit->buffer);
+	encoding = get_log_output_encoding();
+	message = logmsg_reencode(commit, encoding);
+	strbuf_addstr(&buf, message);
+	if (message != commit->buffer)
+		free(message);
 
 	if (opt->grep_filter.header_list && opt->mailmap) {
-		if (!buf.len)
-			strbuf_addstr(&buf, commit->buffer);
-
 		commit_rewrite_person(&buf, "\nauthor ", opt->mailmap);
 		commit_rewrite_person(&buf, "\ncommitter ", opt->mailmap);
 	}
 
 	/* Append "fake" message parts as needed */
-	if (opt->show_notes) {
-		if (!buf.len)
-			strbuf_addstr(&buf, commit->buffer);
+	if (opt->show_notes)
 		format_display_notes(commit->object.sha1, &buf,
-				     get_log_output_encoding(), 1);
-	}
+				     encoding, 1);
+
+	retval = grep_buffer(&opt->grep_filter, buf.buf, buf.len);
 
-	/* Find either in the commit object, or in the temporary */
-	if (buf.len)
-		retval = grep_buffer(&opt->grep_filter, buf.buf, buf.len);
-	else
-		retval = grep_buffer(&opt->grep_filter,
-				     commit->buffer, strlen(commit->buffer));
 	strbuf_release(&buf);
 	return retval;
 }
