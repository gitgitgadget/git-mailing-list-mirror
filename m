From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff --color-words -U0: fix the location of hunk headers
Date: Fri, 30 Oct 2009 11:40:55 -0700
Message-ID: <7vr5sklo7c.fsf@alter.siamese.dyndns.org>
References: <1256732672-11817-1-git-send-email-markus.heidelberg@web.de>
 <200910291222.42598.markus.heidelberg@web.de>
 <alpine.DEB.1.00.0910291425010.3687@felix-maschine>
 <200910291729.23562.markus.heidelberg@web.de>
 <7v3a50n6hw.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0910301831190.5383@felix-maschine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: markus.heidelberg@web.de, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 30 19:41:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3wPU-0003ek-Dp
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 19:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932827AbZJ3SlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 14:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932795AbZJ3SlE
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 14:41:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47732 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932792AbZJ3SlD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 14:41:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 92EA68CBBC;
	Fri, 30 Oct 2009 14:41:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NGvh625D4XcGwuZdtaxBX0fsKeI=; b=bBPGDS
	h3QP1gp20L6TYriGvEyOMZ4yD4yXUKQvvIEUiBr03C6uYQylyNh7sSd3T6sBT+F7
	0ZgjKgKrrQXwTpN8mViLjsTZkKqpj0iqayzkql4TQzK/MA9D1E6MXGsnbHyt5fpe
	cDdChwXuPWyW9nVXqnEZqSigAiCBvJMf7jy0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hosmCB3W9OfK0xdrTF9PScuval9tflbt
	TVy+68+JMTK9C0+N+MzfzAqpVD7H7JM7PGqcolW877/C6XvdQF2FiaQio45OTVL9
	NZ24uGIv4VeB5I6vm9hizgrEq83awJnQdRWLSFurh1r4KDYKFztBkWf0IYLwsSmb
	j5eaL86Dmwg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 68F838CBBB;
	Fri, 30 Oct 2009 14:41:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0DA2A8CBB7; Fri, 30 Oct 2009
 14:40:56 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0910301831190.5383@felix-maschine> (Johannes
 Schindelin's message of "Fri\, 30 Oct 2009 18\:32\:21 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C593B400-C583-11DE-B065-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131725>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The reason I did not do that was to avoid a full subroutine call, as I 
> expected this code path to be very expensive.

This is only done for the "word diff" mode, and my gut feeling is that it
is not such a big issue.  But you can always inline it if it is
performance critical.

The current structure shows how this code evolved.  fn_out_consume() used
to be "this is called every time a line worth of diff becomes ready from
the lower-level diff routine, and here is what we do to output line
oriented diff using that line."

When we introduced the "word diff" mode, we could have done three things.

 * change fn_out_consume() to "this is called every time a line worth of
   diff becomes ready from the lower-level diff routine.  This function
   knows two sets of helpers (one for line-oriented diff, another for word
   diff), and each set has various functions to be called at certain
   places (e.g. hunk header, context, ...).  The function's role is to
   inspect the incoming line, and dispatch appropriate helpers to produce
   either line- or word- oriented diff output."

 * introduce fn_out_consume_word_diff() that is "this is called every time
   a line worth of diff becomes ready from the lower-level diff routine,
   and here is what we do to prepare word oriented diff using that line."
   without touching fn_out_consume() at all.

 * Do neither of the above, and keep fn_out_consume() to "this is called
   every time a line worth of diff becomes ready from the lower-level diff
   routine, and here is what we do to output line oriented diff using that
   line."  but sprinkle a handful of 'are we in word-diff mode?  if so do
   this totally different thing' at random places.

My clean-up "something like this" patch was to at least abstract the
details of "this totally different thing" out from the main codepath, in
order to improve readability.

We can of course refactor this by introducing fn_out_consume_word_diff(),
i.e. the second route above.  Then we do not have to check "are we in word
diff mode" for every line of diff and that would give you even better
performance.
