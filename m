From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/3] tests: Prepare --textconv tests for correctly-failing conversion program
Date: Sat, 18 Sep 2010 21:14:57 +0200
Message-ID: <vpqiq22vp72.fsf@bauges.imag.fr>
References: <cover.1284830388.git.kirr@landau.phys.spbu.ru>
	<cover.1284830388.git.kirr@landau.phys.spbu.ru>
	<26d0544dac2515e76bee0608881cfd8c23bf1ebf.1284830388.git.kirr@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Jeff King <peff@peff.net>
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Sat Sep 18 21:20:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ox2xu-0002J9-Vc
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 21:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757226Ab0IRTTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 15:19:41 -0400
Received: from imag.imag.fr ([129.88.30.1]:41840 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756207Ab0IRTTj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 15:19:39 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o8IJEwi5009161
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 18 Sep 2010 21:14:58 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Ox2sD-0007rl-VI; Sat, 18 Sep 2010 21:14:58 +0200
In-Reply-To: <26d0544dac2515e76bee0608881cfd8c23bf1ebf.1284830388.git.kirr@landau.phys.spbu.ru> (Kirill Smelkov's message of "Sat\, 18 Sep 2010 21\:25\:04 +0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sat, 18 Sep 2010 21:14:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156471>

Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:

> Recently I've spot a bug

We usually avoid the first person in commit messages. The cover letter
is a good place to tell about your personal story, but the commit
message is what will remain, what people will read after a blame or
bisect. They won't care whether you've "recently" found a bug, or in
which circumstances you've found it.

I'd write stg like (which would probably go to PATCH 2/3 instead of
here):

-----8<----
git blame --textconv is wrongly calling the textconv filter on
symlinks: symlinks are stored as blobs whose content is the target of
the link, and blame calls the textconv filter on a temporary file
filled-in with the content of this blob.

For example:

>     $ git blame -C -C regular-file.pdf
>     Error: May not be a PDF file (continuing anyway)
>     Error: PDF file is damaged - attempting to reconstruct xref table...
>     Error: Couldn't find trailer dictionary
>     Error: Couldn't read xref table
>     Warning: program returned non-zero exit code #1
>     fatal: unable to read files to diff
-----8<----

> So git-blame is wrong here, and I'm going to write problem-demonstration
> tests + try to fix it, but first we have to convert existing textconv
> converter, so it will mimic pdftext behaviour -- if there is no '^bin:'
> in input -- it's not a "binary" file and helper exits with error.

What's interesting here is not that you mimick pdftext behavior, but
that you allow to easily distinguish file content and symlink target.

Here's my try:

-----8<----
The textconv filter is sometimes incorrectly ran on a temporary file
whose content is the target of a symbolic link, instead of actual file
content. Prepare to test this by marking the content of the file to
convert with "bin:", and let the helper die if "bin:" is not found in
the file content.
-----8<----

> No other semantic changes at this stage.

Otherwise, the code looks OK.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
