From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC PATCH] stash: accept options also when subcommand 'save' is omitted
Date: Tue, 18 Aug 2009 15:01:52 +0200
Message-ID: <vpqws51l1hb.fsf@bauges.imag.fr>
References: <1250599567-31428-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 15:04:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdOMJ-0002QR-E3
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 15:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757212AbZHRNEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 09:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754191AbZHRNEG
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 09:04:06 -0400
Received: from imag.imag.fr ([129.88.30.1]:34386 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752543AbZHRNEF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 09:04:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n7ID1w5M022783
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Aug 2009 15:01:58 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MdOK0-0007zo-VS; Tue, 18 Aug 2009 15:01:52 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MdOK0-0000Tc-UA; Tue, 18 Aug 2009 15:01:52 +0200
In-Reply-To: <1250599567-31428-1-git-send-email-Matthieu.Moy@imag.fr> (Matthieu Moy's message of "Tue\, 18 Aug 2009 14\:46\:07 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 18 Aug 2009 15:01:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126395>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> This allows in particular 'git stash --keep-index' which is shorter than
> 'git stash save --keep-index', and not ambiguous.

Hmm, googling a bit, I just noticed that there's already something in
pu:
ea41cfc4f (Make 'git stash -k' a short form for 'git stash save --keep-index')
which also does the trick, while adding a -k alias for --keep-index.

Not sure which hack is best between my

> +case "$1" in
> +    -*)
> +	set "save" "$@"
> +	;;
> +esac
> +

And the proposed

 *)
-	if test $# -eq 0
-	then
-		save_stash &&
+	case $#,"$1" in
+	0,|1,-k|1,--keep-index)
+		save_stash "$@" &&
 		say '(To restore them type "git stash apply")'
-	else
+		;;
+	*)
 		usage
-	fi
+	esac
 	;;
 esac

Mine has at least two advantages:

* It won't require changing the code again when new options are added
  to 'git stash save'.

* It works with 'git stash -k -q' for example, while the other
  proposal checks that $# == 1, which won't work if there are more
  than one option.

But I may have missed its drawbacks ;-)

--
Matthieu
