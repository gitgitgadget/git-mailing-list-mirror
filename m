From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] Add support for -i/--interactive to git-clean
Date: Mon, 29 Apr 2013 10:03:41 +0200
Message-ID: <vpqwqrl931e.fsf@grenoble-inp.fr>
References: <7vmwslw1py.fsf@alter.siamese.dyndns.org>
	<2a68239bfd3e6b9ea1842dd8e468ee3d3217af5b.1367079089.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 10:04:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWj41-00050H-NG
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 10:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914Ab3D2IDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 04:03:53 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52542 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753818Ab3D2IDu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 04:03:50 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r3T83eZJ029858
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 29 Apr 2013 10:03:40 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UWj3l-00025q-Nz; Mon, 29 Apr 2013 10:03:41 +0200
In-Reply-To: <2a68239bfd3e6b9ea1842dd8e468ee3d3217af5b.1367079089.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Sun, 28 Apr 2013 00:13:26 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 29 Apr 2013 10:03:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r3T83eZJ029858
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1367827423.39985@goyKBt/S4UPrnR3zAL8EDQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222779>

Jiang Xin <worldhello.net@gmail.com> writes:

> Show what would be done and a confirmation dialog before actually
> cleaning. In the confirmation dialog, the user can input a space
> separated prefix list, and each clean candidate that matches with
> one of prefix, will be excluded from cleaning.

That seems a really weird interface. In particular, that means people
typing "no" or "n" mechanically will have everything not starting with
"n" or "no" deleted. We've learnt from the "git send-email" interface
that people (including me ;-) ) do type "yes" mechanically to some
questions.

You may argue that users are not stupid and know what they do, but the
point of this -i is to protect users against their fingers (typing -f
without thinking) for a potentially very destructive command ...

My feeling is that you're doing a bad compromise between a confirmation
dialog (y/n) and a really interactive command (like "git add -i") with a
rich interface.

> @@ -34,7 +34,17 @@ OPTIONS
>  -f::
>  --force::
>  	If the Git configuration variable clean.requireForce is not set
> -	to false, 'git clean' will refuse to run unless given -f or -n.
> +	to false, 'git clean' will refuse to run unless given -f, -n or
> +	-i.
> +
> +-i::
> +--interactive::
> +  Show what would be done and a confirmation dialog before actually
> +  cleaning. In the confirmation dialog, the user can input a space
> +  separated prefix list, and each clean candidate that matches with
> +  one of prefix, will be excluded from cleaning. When the user feels
> +  it's OK, press ENTER to start cleaning. If the user wants to cancel
> +  the whole cleaning, simply input ctrl-c in the confirmation dialog.

Broken indentation. It seems you've set your tab-width to 2, in which
case you can't see it, but you've indented with 2 spaces where the rest
of the file is indented with tabs.

>  		if (S_ISDIR(st.st_mode)) {
> -			strbuf_addstr(&directory, ent->name);
>  			if (remove_directories || (matches == MATCHED_EXACTLY)) {
> -				if (remove_dirs(&directory, prefix, rm_flags, dry_run, quiet, &gone))
> -					errors++;
> -				if (gone && !quiet) {
> -					qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
> -					printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
> -				}
> +				string_list_append(&dels, ent->name);

The patch would be much easier to read if split into a first refactoring
patch that would introduce this "dels" list, and a second patch that
would introduce -i. Reading this, I wondered why the code was removed,
while it was actually just moved.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
