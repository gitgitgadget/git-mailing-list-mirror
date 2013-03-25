From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] transport: drop "int cmp = cmp" hack
Date: Mon, 25 Mar 2013 12:50:54 -0700
Message-ID: <7vfvzjxnq9.fsf@alter.siamese.dyndns.org>
References: <20130321110338.GA18552@sigill.intra.peff.net>
 <20130321111333.GD18819@sigill.intra.peff.net>
 <CAPc5daVOksx56js_ascEr348PTLAZB9OeBrf3sELJUpdyB_kMg@mail.gmail.com>
 <20130324093212.GA28234@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 25 20:51:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKDQU-0001nq-KC
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 20:51:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933003Ab3CYTu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 15:50:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58259 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932993Ab3CYTu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 15:50:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED7DCABC0;
	Mon, 25 Mar 2013 15:50:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=djQw2kbLtGap0Riv9VJL9xc8yQ8=; b=c4UMeD
	RMlnYOKaFg/69e5+kQ1RaBitDfr98jRFBvZi/Tmz2DWC5PVzJq0GPoL4wkrzCFq7
	oKMohZ/OuM4mGQBOmpEtyVwVeQ9eFyA4aJ7l2zBYO8/Q8xe6yBdxGoW+7S6gMBnw
	v6pBMm7M9vKm+ncvI8Opcdc+MeVetLux9jo28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WF4CHQlyRn4Ns3w/SxXtddW32YlT45oP
	xG5+bWbM98TMiK3GIF79fGdhFJWyMzzGs+HRapH0HJMq4v6q1aF26gnY5yIsWMAF
	OSxYIhCauKUu1xBH+5Ekvxn9EPIH8l8Dc2ExqoJSoqwgfcnDqTBtNlGBTLp0ER34
	dqZyK32Zb0E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1A4CABBF;
	Mon, 25 Mar 2013 15:50:56 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B504ABBC; Mon, 25 Mar 2013
 15:50:56 -0400 (EDT)
In-Reply-To: <20130324093212.GA28234@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 24 Mar 2013 05:32:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4EF69E90-9585-11E2-983D-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219070>

Jeff King <peff@peff.net> writes:

> On Sat, Mar 23, 2013 at 09:00:05PM -0700, Junio C Hamano wrote:
>
>> On Thu, Mar 21, 2013 at 4:13 AM, Jeff King <peff@peff.net> wrote:
>> >
>> > According to 47ec794, this initialization is meant to
>> > squelch an erroneous uninitialized variable warning from gcc
>> > 4.0.1.  That version is quite old at this point, and gcc 4.1
>> > and up handle it fine, with one exception. There seems to be
>> > a regression in gcc 4.6.3, which produces the warning;
>> > however, gcc versions 4.4.7 and 4.7.2 do not.
>> >
>> 
>> transport.c: In function 'get_refs_via_rsync':
>> transport.c:127:29: error: 'cmp' may be used uninitialized in this
>> function [-Werror=uninitialized]
>> transport.c:109:7: note: 'cmp' was declared here
>> 
>> gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
>
> Right, that's the same version I noted above. Is 4.6.3 the default
> compiler under a particular release of Ubuntu, or did you use their
> gcc-4.6 package?

I'll check later with one of my VMs.  The copy of U 12.04 I happened
to have handy has that version installed.

By the way, I find this piece of code less than pleasant:

 * It uses "struct ref dummy = { NULL }, *tail = &dummy", and then
   accumulates things by appending to "&tail" and then returns
   dummy.next.  Why doesn't it do

	struct ref *retval = NULL, **tail = &retval;

   and pass tail around to append things, like everybody else?  Is
   this another instance of "People do not understand linked list"
   problem?  Perhaps fixing that may unconfuse the compiler?

 * Its read_loose_refs() is a recursive function that sorts the
   results from readdir(3) and iterates over them, expecting its
   recursive call to fail _only_ when the entry it read is not a
   directory that it needs to recurse into.

   It is not obvious if the resulting list is sorted correctly with
   this loop structure when you have branches "foo.bar", "foo/bar",
   and "foo=bar".  I think the loop first reads "foo", "foo.bar" and
   "foo=bar", sorts them in that order, and starts reading
   recursively, ending up with "foo/bar" first and then "foo.bar"
   and finally "foo=bar".  Later, the tail of the same list is
   passed to insert_packed_refs(), which does in-place merging of
   this list and the contents of the packed_refs file.  These two
   data sources have to be sorted the same way for this merge to
   work correctly, but there is no validating the order of the
   entries it reads from the packed-refs file.  At least, it should
   barf when the file is not sorted.  It could be lenient and accept
   a mal-sorted input, but I do not think that is advisable.

I'll apply the attached on 'maint' for now, as rsync is not worth
spending too many cycles on worrying about; I need to go to the
bathroom to wash my eyes after staring this code for 20 minutes X-<.

 transport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/transport.c b/transport.c
index 87b8f14..e6f9346 100644
--- a/transport.c
+++ b/transport.c
@@ -106,7 +106,8 @@ static void insert_packed_refs(const char *packed_refs, struct ref **list)
 		return;
 
 	for (;;) {
-		int cmp, len;
+		int cmp = 0; /* assigned before used */
+		int len;
 
 		if (!fgets(buffer, sizeof(buffer), f)) {
 			fclose(f);
