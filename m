From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] for-each-ref: fix off by one read.
Date: Mon, 12 Nov 2007 16:05:37 -0800
Message-ID: <7vfxzb1032.fsf@gitster.siamese.dyndns.org>
References: <20071112053725.4f0d1940.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 01:06:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrjHz-0005st-9a
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 01:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbXKMAFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 19:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752232AbXKMAFn
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 19:05:43 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:53162 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbXKMAFn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 19:05:43 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id E21252F9;
	Mon, 12 Nov 2007 19:06:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 76FCB9519B;
	Mon, 12 Nov 2007 19:06:01 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64737>

Christian Couder <chriscool@tuxfamily.org> writes:

> diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
> index 598d4e1..89ea37c 100644
> --- a/builtin-for-each-ref.c
> +++ b/builtin-for-each-ref.c
> @@ -306,7 +306,7 @@ static const char *find_wholine(const char *who, int wholen, const char *buf, un
>  		if (!eol)
>  			return "";
>  		eol++;
> -		if (eol[1] == '\n')
> +		if (*eol == '\n')
>  			return ""; /* end of header */
>  		buf = eol;
>  	}

Good eyes.  This would have broken if

 (1) we had a header field that consists of a single character
     and then LF.  We would have mistaken such a line as the end
     of header; or

 (2) we had a commit or a tag that consists solely of header and
     no body.  We would have read past the terminating NUL.

Thanks.
