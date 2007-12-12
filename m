From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Extract and improve whitespace check from "git apply"
Date: Wed, 12 Dec 2007 11:39:59 -0800
Message-ID: <7vsl277ldc.fsf@gitster.siamese.dyndns.org>
References: <1197476582-18956-1-git-send-email-win@wincent.com>
	<1197476582-18956-2-git-send-email-win@wincent.com>
	<1197476582-18956-3-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 20:41:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2XRn-0000f1-9s
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 20:40:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175AbXLLTkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 14:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753772AbXLLTkZ
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 14:40:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62454 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbXLLTkY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 14:40:24 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 43335351D;
	Wed, 12 Dec 2007 14:40:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B6D153519;
	Wed, 12 Dec 2007 14:40:09 -0500 (EST)
In-Reply-To: <1197476582-18956-3-git-send-email-win@wincent.com> (Wincent
	Colaiuta's message of "Wed, 12 Dec 2007 17:23:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68092>

Wincent Colaiuta <win@wincent.com> writes:

> diff --git a/ws.c b/ws.c
> index 52c10ca..884d373 100644
> --- a/ws.c
> +++ b/ws.c
> +unsigned check_whitespace(const char *line, int len, unsigned ws_rule)
> +{
> + ...
> +	if (ws_rule & WS_TRAILING_SPACE) {
> +		/* Lines start with "+" or "-" so length is at least 1 */
> +		if (line[len - 1] == '\n') {
> +			if (isspace(line[len - 2]))
> +				result |= WS_TRAILING_SPACE;
> +		}

I like the direction, but I think it would make much more sense if you
make check_whitespace() not about "a line in a patch that adds a line",
but about "here is a line, check if that is acceptable".  IOW, make line
variable zero-based (and len = strlen(line)).  The change would mean
that existing callers need to be modified to do something like:

	if (line[0] == '+')
        	check_whitespace(line+1, len-1, ...);

but at the same time we could conceivably teach "git show" to show
whitespace errors in a blob, i.e. "git show --show-ws-error HEAD:ws.c"
by using such a check_whitespace().

The highlighting code may need similar changes.  I was actually hoping
you would consolidate the logic there that decides which segment of the
string to highlight, and the logic in check_whitespace() to decide if
there is an error to begin with.  Conceptually, if emit_line_with_ws()
decides there is nothing to highlight with DIFF_WHITESPACE color, that
means there is no whitespace error on the line and vice-versa, no?
