From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename core.unreliableHardlinks to core.createObject
Date: Mon, 27 Apr 2009 16:48:13 -0700
Message-ID: <7vws95vete.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0904251042490.3101@localhost.localdomain>
 <200904252052.10327.j6t@kdbg.org> <7vhc0cw6w8.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0904261940170.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0904271400180.10279@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0904270806130.22156@localhost.localdomain>
 <7vljpl3m8i.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0904271314130.22156@localhost.localdomain>
 <alpine.DEB.1.00.0904280031100.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 28 01:48:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyaYn-0007F6-A0
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 01:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760041AbZD0XsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 19:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759942AbZD0XsX
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 19:48:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57182 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760088AbZD0XsW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 19:48:22 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8052BAEDE7;
	Mon, 27 Apr 2009 19:48:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B9101AEDE6; Mon,
 27 Apr 2009 19:48:14 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0904280031100.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Tue, 28 Apr 2009 00:32:25 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E34FE012-3385-11DE-A89A-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117739>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> diff --git a/Makefile b/Makefile
> index 5c8e83a..9ca1826 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -172,8 +172,8 @@ all::
>  # information on a not yet closed file that lstat would return for the same
>  # file after it was closed.
>  #
> -# Define UNRELIABLE_HARDLINKS if your operating systems has problems when
> -# hardlinking a file to another name and unlinking the original file right
> +# Define OBJECT_CREATION_USES_RENAMES if your operating systems has problems
> +# when hardlinking a file to another name and unlinking the original file right

With the configuration variable for this relatively obscure feature in
place, I wonder if we can simply get rid of the hardcoded compilation
preference.  After all, even on your eeepc, I presume that you have some
filesystems in native format where you do not have the breakages, and some
others mounted with unfsd breakage.  When diagnosing a possible issue on
somebody else's box, having to look into .git/config to see which codepath
is used is bad enough, but it is even worse to have a default that can be
different with compilation switch.

It would essentially boil down to this hunk; instead of introducing
OBJECT_CREATION_MODE, we default to hardlinks, and let the configuration
override it (and do nothing else).

> diff --git a/environment.c b/environment.c
> index 10578d2..801a005 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -43,10 +43,10 @@ unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
>  enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
>  enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
>  enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
> -#ifndef UNRELIABLE_HARDLINKS
> -#define UNRELIABLE_HARDLINKS 0
> +#ifndef OBJECT_CREATION_MODE
> +#define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
>  #endif
> -int unreliable_hardlinks = UNRELIABLE_HARDLINKS;
> +enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
