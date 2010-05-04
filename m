From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] blame: add a range option to -L
Date: Tue, 04 May 2010 20:11:47 +0200
Message-ID: <vpqk4rj8rks.fsf@bauges.imag.fr>
References: <1272909995-3198-1-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
X-From: git-owner@vger.kernel.org Tue May 04 20:18:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9Mh9-0008A5-Jf
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 20:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760136Ab0EDSRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 14:17:45 -0400
Received: from imag.imag.fr ([129.88.30.1]:32845 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753600Ab0EDSRo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 14:17:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o44IBmhW028393
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 4 May 2010 20:11:48 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1O9May-0000KK-67; Tue, 04 May 2010 20:11:48 +0200
In-Reply-To: <1272909995-3198-1-git-send-email-wfp5p@virginia.edu> (Bill Pemberton's message of "Mon\,  3 May 2010 14\:06\:35 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 04 May 2010 20:11:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146335>

Bill Pemberton <wfp5p@virginia.edu> writes:

>  		term = parse_loc(term + 1, sb, lno, *bottom + 1, top);
> -		if (*term)
> -			usage(blame_usage);
> +		x = *top;

Why not use parse_loc(..., &x) if you want the value to end up in x ?

> +		*top = *bottom - x;
> +		*bottom += x;

The existing code seems to assume that top >= bottom, but swaps top
and bottom otherwise:

	if (bottom && top && top < bottom) {
		long tmp;
		tmp = top; top = bottom; bottom = tmp;
	}

So, I'd write

*top = *bottom + x;
*bottom -= x;

> +		if (*bottom < 1)
> +			*bottom = 1;

I guess you've assumed that bottom was the small number here,
otherwise, you're checking for overflow, not for actually negative
numbers. Either you apply my proposal above or you should
s/bottom/top/ here, right?

(the existing code already have this a few lines after the call to
this functions, it doesn't harm to do it again, but better do it on
the right function)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
