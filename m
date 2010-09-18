From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/3] RFC: blame,cat-file --textconv: Don't assume mode is ``S_IFREF | 0664''
Date: Sat, 18 Sep 2010 21:04:00 +0200
Message-ID: <vpqmxrevppb.fsf@bauges.imag.fr>
References: <cover.1284830388.git.kirr@landau.phys.spbu.ru>
	<cover.1284830388.git.kirr@landau.phys.spbu.ru>
	<7ab60e32582447ad792602ff405dcee464ef1414.1284830388.git.kirr@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Sat Sep 18 21:09:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ox2mu-0005xj-Hh
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 21:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756533Ab0IRTIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 15:08:43 -0400
Received: from imag.imag.fr ([129.88.30.1]:40611 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756530Ab0IRTIm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 15:08:42 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o8IJ40jp007677
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 18 Sep 2010 21:04:00 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Ox2hc-0007lz-N2; Sat, 18 Sep 2010 21:04:00 +0200
In-Reply-To: <7ab60e32582447ad792602ff405dcee464ef1414.1284830388.git.kirr@landau.phys.spbu.ru> (Kirill Smelkov's message of "Sat\, 18 Sep 2010 21\:25\:06 +0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sat, 18 Sep 2010 21:04:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156470>

Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:

> I don't know blame code well, and I'm not sure I'm doing it right or
> otherwise without mistakes. Thus an RFC.

I don't know the code well either, but I didn't see any obvious
problem in your code.

> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -1068,7 +1068,7 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
>  		struct cache_entry *ce;
>  		int pos;
>  		if (namelen > 2 && name[1] == '/')
> -			return get_sha1_oneline(name + 2, sha1);
> +			return get_sha1_oneline(name + 2, sha1);    /* XXX also mode? */

(This is the case where we're parsing ":/foo")

Currently, the mode is set a few lines above:

	oc->mode = S_IFINVALID;

I guess this is OK since :/foo will return a commit sha1, not a file
sha1.

> @@ -1095,6 +1095,7 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
>  				break;
>  			if (ce_stage(ce) == stage) {
>  				hashcpy(sha1, ce->sha1);
> +				oc->mode = ce->ce_mode; /* XXX ok? */

I'd say this is OK, you're setting the mode from the index. What was
the reason for your question mark?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
