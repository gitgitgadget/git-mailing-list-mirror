From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] grep: lookahead optimization can be used with -L option
Date: Tue, 12 Jan 2010 00:31:38 -0800
Message-ID: <7v1vhv4tcl.fsf_-_@alter.siamese.dyndns.org>
References: <7vtyv4cpna.fsf@alter.siamese.dyndns.org>
 <87ljgfgbl0.fsf@catnip.gol.com>
 <fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com>
 <877hrzga16.fsf@catnip.gol.com>
 <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain>
 <7v3a2mzzg4.fsf@alter.siamese.dyndns.org>
 <20100104053125.GA5083@coredump.intra.peff.net>
 <7vbphaquwl.fsf@alter.siamese.dyndns.org>
 <20100104064408.GA7785@coredump.intra.peff.net>
 <alpine.LFD.2.00.1001040659150.3630@localhost.localdomain>
 <fc339e4a1001040757n31298f3h724eacfafb68c63e@mail.gmail.com>
 <alpine.LFD.2.00.1001040801290.3630@localhost.localdomain>
 <7vvdf9402f.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001110739280.13040@localhost.localdomain>
 <alpine.LFD.2.00.1001110748560.13040@localhost.localdomain>
 <7vtyusr4r7.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001110830070.13040@localhost.localdomain>
 <7v63774tfd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Miles Bader <miles@gnu.org>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 09:31:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUcAP-0007yK-3b
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 09:31:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526Ab0ALIbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 03:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753200Ab0ALIbw
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 03:31:52 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59875 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166Ab0ALIbv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 03:31:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E8938ECA8;
	Tue, 12 Jan 2010 03:31:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MHkN3MHXCUBn82744Z032wT1X+8=; b=nCIqil
	UmmtuKdyo+Aycd+yvGTakx7YIMeTc2Y+WIOiN3Q2vwnlExZs+lHjrs1CeiNiZ76U
	0Am8uqD8ly5pcIkKcAAvrouEMpC299mouuhR1/Ekoqpm3Wqxyoig0aQrVhQn4aUo
	eEiGpx6aaLE1hCkLtUTzXTTNr/uNIwXuCcBBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FZ7ayS7wOilkJaYQW0oNChDpCDPFU0BG
	JzhEOkYo0oJOKU7J26E9DJLuJEiSsmZ3dSkANWumQbEpRwGIEW0Fvn7F+1FTFHaA
	hueLfa/M/e7D/a9nnL+QSwBNGcGzHX8bXLNoOfk0SGCG0fYotY5oz/KeDQFpaIXA
	e5lDy4a6jdE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E32A8ECA7;
	Tue, 12 Jan 2010 03:31:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F0A9A8ECA6; Tue, 12 Jan
 2010 03:31:39 -0500 (EST)
In-Reply-To: <7v63774tfd.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 12 Jan 2010 00\:29\:58 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EB7C3A74-FF54-11DE-BD96-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136704>

This is not an "inverted logic" option ("-v") that shows lines
that do not match given pattern as hits, and skipping lines that
cannot possibly match wouldn't change its outcome.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Should be squashed in to the "lookahead" patch.

 grep.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/grep.c b/grep.c
index 048b982..03ffcd4 100644
--- a/grep.c
+++ b/grep.c
@@ -614,7 +614,7 @@ static int should_lookahead(struct grep_opt *opt)
 
 	if (opt->extended)
 		return 0; /* punt for too complex stuff */
-	if (opt->invert || opt->unmatch_name_only)
+	if (opt->invert)
 		return 0;
 	for (p = opt->pattern_list; p; p = p->next) {
 		if (p->token != GREP_PATTERN)
-- 
1.6.6.280.ge295b7.dirty
