From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Zsh completion regression
Date: Thu, 12 Jan 2012 15:56:28 +0100
Message-ID: <vpq62ghj7fn.fsf@bauges.imag.fr>
References: <1kdr5xk.1sopzul1hygnbrM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	szeder@ira.uka.de (SZEDER =?iso-8859-1?Q?G=E1bor?=)
To: lists@haller-berlin.de (Stefan Haller)
X-From: git-owner@vger.kernel.org Thu Jan 12 15:56:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlM5B-0005ZQ-Uz
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 15:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859Ab2ALO4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 09:56:43 -0500
Received: from mx2.imag.fr ([129.88.30.17]:51968 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753855Ab2ALO4m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 09:56:42 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q0CEsxgl012822
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 12 Jan 2012 15:54:59 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RlM4r-0002CQ-6M; Thu, 12 Jan 2012 15:56:29 +0100
In-Reply-To: <1kdr5xk.1sopzul1hygnbrM%lists@haller-berlin.de> (Stefan Haller's
	message of "Thu, 12 Jan 2012 12:52:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 12 Jan 2012 15:55:00 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q0CEsxgl012822
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1326984900.96903@xmQVzi4pvAgjWosWeLreNQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188449>

lists@haller-berlin.de (Stefan Haller) writes:

> I'm using zsh   4.3.11.
>
> When I type "git log mas<TAB>", it completes to "git log master\ " (a
> backslash, a space, and then the cursor).

Same here (although I've been too lazy to bisect myself).

The following patch makes the situation better, but is not really a fix:

--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -525,7 +525,7 @@ __gitcomp ()
 __gitcomp_nl ()
 {
        local s=$'\n' IFS=' '$'\t'$'\n'
-       local cur_="$cur" suffix=" "
+       local cur_="$cur" suffix=""
 
        if [ $# -gt 2 ]; then
                cur_="$3"

With this, the trailing space isn't added, but e.g. "git checkout
master<TAB>" does not add the trailing space, at all.

The problem is a little bit below:

	IFS=$s
	COMPREPLY=($(compgen -P "${2-}" -S "$suffix" -W "$1" -- "$cur_"))

The -S "$suffix" adds a space to the completion, but ZSH escapes the
space (which sounds sensible in general, but is not at all what we
expect). My completion-fu isn't good enough to get any further either
unfortunately.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
