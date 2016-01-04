From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] git-send-email: do not double-escape quotes from mutt
Date: Mon, 04 Jan 2016 19:11:58 +0100
Message-ID: <vpqsi2dxlht.fsf@anie.imag.fr>
References: <20151227020810.1450-1-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jan 04 19:12:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aG9cE-0007KA-E4
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 19:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627AbcADSMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 13:12:19 -0500
Received: from mx2.imag.fr ([129.88.30.17]:49806 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751590AbcADSMR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 13:12:17 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u04IBupg029792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 4 Jan 2016 19:11:56 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u04IBwTe021535;
	Mon, 4 Jan 2016 19:11:58 +0100
In-Reply-To: <20151227020810.1450-1-normalperson@yhbt.net> (Eric Wong's
	message of "Sun, 27 Dec 2015 02:08:10 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 04 Jan 2016 19:11:56 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u04IBupg029792
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1452535918.72839@38yOkOUJ2hZJkq0wb3IhcQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283312>

Eric Wong <normalperson@yhbt.net> writes:

> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -524,8 +524,14 @@ my %parse_alias = (
>  		if (/^\s*alias\s+(?:-group\s+\S+\s+)*(\S+)\s+(.*)$/) {
>  			my ($alias, $addr) = ($1, $2);
>  			$addr =~ s/#.*$//; # mutt allows # comments
> -			 # commas delimit multiple addresses
> -			$aliases{$alias} = [ split_addrs($addr) ];
> +			# commas delimit multiple addresses
> +			my @addr = split_addrs($addr);
> +
> +			# quotes may be escaped in the file,
> +			# remove them if paired so we do not
> +			# double-escape them later.

I think you meant "remove the escaping" or simply "unescape", not
"remove them", which I'd understand as "remove the quotes".

Other than that, the patch looks good to me, including your proposed
fixup:

--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -530,7 +530,7 @@ my %parse_alias = (
 			# quotes may be escaped in the file,
 			# remove them if paired so we do not
 			# double-escape them later.
-			s/^\\"(.*?)\\"/"$1"/g foreach @addr;
+			s/\\"/"/g foreach @addr;
 			$aliases{$alias} = \@addr

Eric Wong <normalperson@yhbt.net> writes:

> alias qn \"Q. N\\\"ame\" <qn@example.org>   # becomes "Q. N\"ame"
> alias dq \"Dub O.\" \"Q\" <dq@example.org>  # becomes "Dub O. Q"
[...]
> But I'm not sure how to handle the "dq" case or if that even
> happens in practice, as attempting to save an alias with "Dub O." "Q"
> in the From: header, mutt shortens it to the expected \"Dub O. Q\"
> without extra quotes.

I wouldn't worry too much about corner-cases, but perhaps some people do
use escaped quotes inside escaped quotes. I'd say they get what they
deserve ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
