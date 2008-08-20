From: Junio C Hamano <gitster@pobox.com>
Subject: Re: diff --check is stupid about blank lines
Date: Wed, 20 Aug 2008 11:42:34 -0700
Message-ID: <7vskszr0it.fsf@gitster.siamese.dyndns.org>
References: <20080820140517.GA1304@atjola.homenet>
 <20080820172825.GC27773@sigill.intra.peff.net>
 <7v7iabsgfk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 20 20:44:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVsep-0003ho-De
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 20:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755759AbYHTSmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 14:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754810AbYHTSmp
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 14:42:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52442 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109AbYHTSmo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 14:42:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AD35B5AD1F;
	Wed, 20 Aug 2008 14:42:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AAA605AD19; Wed, 20 Aug 2008 14:42:36 -0400 (EDT)
In-Reply-To: <7v7iabsgfk.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 20 Aug 2008 11:13:35 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C542A8E2-6EE7-11DD-A442-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93012>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> ... The problem seems to be the conditional at
>> diff.c:1622:
>>
>>         if ((data.ws_rule & WS_TRAILING_SPACE) &&
>>             data.trailing_blanks_start) {
>>                 fprintf(o->file, "%s:%d: ends with blank lines.\n",
>>                         data.filename, data.trailing_blanks_start);
>>                 data.status = 1; /* report errors */
>>         }
>>
>> that should probably be "if we care about trailing space, and the last
>> thing we saw was a trailing blank, _and_ the last hunk adds to
>> end-of-file, then...".
>
> Instead, data.trailing_blanks_start is supposed to be reset to 0 every
> time we see non-blank newline, a copied context line, or new hunk.
>
> So if this triggers with -U0 I'd understand, but otherwise I do not see
> how.

Ahhh, what idiot wrote the logic for checking trailing blank lines in
checkdiff_consume().

It does not ask for any context lines.  Sheesh.

This should fix it.


diff --git i/diff.c w/diff.c
index 10d5440..5923fe2 100644
--- i/diff.c
+++ w/diff.c
@@ -1628,6 +1628,7 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 		xdemitcb_t ecb;
 
 		memset(&xecfg, 0, sizeof(xecfg));
+		xecfg.ctxlen = 1; /* at least one context line */
 		xpp.flags = XDF_NEED_MINIMAL;
 		xdi_diff_outf(&mf1, &mf2, checkdiff_consume, &data,
 			      &xpp, &xecfg, &ecb);
