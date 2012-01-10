From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] attr: don't confuse prefixes with leading directories
Date: Tue, 10 Jan 2012 12:25:09 -0800
Message-ID: <7v7h0z9ufu.fsf@alter.siamese.dyndns.org>
References: <20120110070300.GA17086@sigill.intra.peff.net>
 <4F0BFE6E.6080904@alum.mit.edu>
 <20120110171100.GA18962@sigill.intra.peff.net>
 <20120110180820.GA15273@sigill.intra.peff.net>
 <20120110182140.GB15273@sigill.intra.peff.net>
 <7vlipf9xbe.fsf@alter.siamese.dyndns.org>
 <20120110192810.GA16018@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 10 21:25:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkiG2-0005Oj-7Z
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 21:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756747Ab2AJUZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 15:25:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50903 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752033Ab2AJUZM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 15:25:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBC9157FD;
	Tue, 10 Jan 2012 15:25:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XycjQ4R0hyxkllbbrLTFVxJ+/Ng=; b=U6qyq+
	1zw6XMTGbwLmi16l2AbPXJsJu37PWyz/3xdb4sDyOYKoZDfZ1hIZbXQhUkgLxaUB
	zlRFB6N63fJF/+HN5O5oFBSWupV+bAgbjrT37l6MTMIDNRCiHtZaALBJI83Ue5z4
	h+GSpAmXK/3Fs42bQ4jcVj7rncHENlyoH3J5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yhns1FXEfGvP2jZAwAmtIKGl1im2TcZY
	xxD+aq2pxin5rPEE1t6SHtdgGCb+cOCtPajZi9Dqmaw4/xbNOezcTn5R/uwrccWt
	W92x8a6HqGEhZb9T/TDE7TmCsd+lkexRJvjZpmMcpZc2498EHcpKeA+Qzw32vMqh
	bQHUnryM8c8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B299357FC;
	Tue, 10 Jan 2012 15:25:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2863657FB; Tue, 10 Jan 2012
 15:25:11 -0500 (EST)
In-Reply-To: <20120110192810.GA16018@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 10 Jan 2012 14:28:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 32094588-3BC9-11E1-B1F6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188290>

Jeff King <peff@peff.net> writes:

> On Tue, Jan 10, 2012 at 11:23:01AM -0800, Junio C Hamano wrote:
>
>> > I'm not sure if the right solution is to change the popping loop to:
>> >
>> >   /* we will never run out of stack, because we always have the root */
>> >   while (attr_stack->origin) {
>> >           ...
>> 
>> Yeah, that makes sense, as that existing check "attr_stack &&" was a
>> misguided defensive coding, that was _not_ defensive at all as we didn't
>> do anything after we stop iterating from that loop and without checking
>> dereferenced attr_stack->origin, which was a simple bogosity.
>> 
>> >
>> > Or to be extra defensive and put:
>> >
>> >   if (!attr_stack)
>> >           die("BUG: we ran out of attr stack!?");
>> >
>> > after the loop, or to somehow handle the case of an empty attr stack
>> > below (which is hard to do, because it can't be triggered, so I have no
>> > idea what it would mean).
>> 
>> And this is even more so.
>
> I wasn't clear: the second one is "even more so" making sense, or "even
> more so" misguided defensive coding?

Sorry for sending a half-baked response.  The initial draft of my response
had just "that makes sense" and nothing else in the first paragraph.

If the original meant to be defensive, it should have had your "extra
defensive" die(), but it didn't.

But the condition to break out of that loop is either we hit an elem that
satisfy the condition (in which case that elem cannot be NULL) or we
successfully saw that attr_stack->origin is NULL (in which case attr_stack
couldn't have been NULL), so it is pointless to check the NULLness of
attr_stack itself. Assertion _before_ going into the while loop might make
sense, but if we look at what bootstrap_attr_stack() does, it should be
pretty obvious that that cannot happen.

An assert(attr_stack->origin) before we use it may make sense, though, in
order to make sure we do not mistakenly pop the root one and expose the
built-in ones whose origin are set to NULL.

diff --git a/attr.c b/attr.c
index ad7eb9c..4d3b61a 100644
--- a/attr.c
+++ b/attr.c
@@ -566,7 +567,9 @@ static void prepare_attr_stack(const char *path, int dirlen)
 
 	/*
 	 * Pop the ones from directories that are not the prefix of
-	 * the path we are checking.
+	 * the path we are checking. Break out of the loop when we see
+	 * the root one (whose origin is an empty string "") or the builtin
+	 * one (whose origin is NULL) without popping it.
 	 */
 	while (attr_stack->origin) {
 		int namelen = strlen(attr_stack->origin);
@@ -586,6 +589,13 @@ static void prepare_attr_stack(const char *path, int dirlen)
 	 * Read from parent directories and push them down
 	 */
 	if (!is_bare_repository() || direction == GIT_ATTR_INDEX) {
+		/*
+		 * bootstrap_attr_stack() should have added, and the
+		 * above loop should have stopped before popping, the
+		 * root element whose attr_stack->origin is set to an
+		 * empty string.
+		 */ 
+		assert(attr_stack->origin);
 		while (1) {
 			char *cp;
 
