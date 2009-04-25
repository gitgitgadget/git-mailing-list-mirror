From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Add an option not to use link(src, dest) &&
 unlink(src) when that is unreliable
Date: Sat, 25 Apr 2009 09:49:11 -0700
Message-ID: <7vbpqkznjs.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de>
 <200904232116.10769.j6t@kdbg.org>
 <alpine.DEB.1.00.0904251155130.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 25 18:55:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lxl9h-0001m9-GU
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 18:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860AbZDYQtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 12:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753276AbZDYQtV
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 12:49:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41908 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbZDYQtV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 12:49:21 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 092AEADDBE;
	Sat, 25 Apr 2009 12:49:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 41B95ADDBD; Sat,
 25 Apr 2009 12:49:12 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0904251155130.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Sat, 25 Apr 2009 11:57:14 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0596193A-31B9-11DE-B88F-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117561>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It seems that accessing NTFS partitions with ufsd (at least on my EeePC)
> has an unnerving bug: if you link() a file and unlink() it right away,
> the target of the link() will have the correct size, but consist of NULs.
>
> It seems as if the calls are simply not serialized correctly, as single-stepping
> through the function move_temp_to_file() works flawlessly.
>
> As ufsd is "Commertial software" (sic!), I cannot fix it, and have to work
> around it in Git.
>
> At the same time, it seems that this fixes msysGit issues 222 and 229 to
> assume that Windows cannot handle link() && unlink().
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Acked-by: Johannes Sixt <j6t@kdbg.org>

Hannes, are you ok with this?

> diff --git a/environment.c b/environment.c
> index 4696885..10578d2 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -43,6 +43,10 @@ unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
>  enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
>  enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
>  enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
> +#ifndef UNRELIABLE_HARDLINKS
> +#define UNRELIABLE_HARDLINKS 0
> +#endif
> +int unreliable_hardlinks = UNRELIABLE_HARDLINKS;

Hmm, this ifndef/define/endif is somewhat yucky to see especially in a .c
source file.  Sorry, I do not think of a better alternative, though.

	int unreliable_hardlinks = defined(UNRELIABLE_HARDLINKS)

would not work either X-<.

> diff --git a/sha1_file.c b/sha1_file.c
> index 8fe135d..bb6eecf 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2225,7 +2225,9 @@ int move_temp_to_file(const char *tmpfile, const char *filename)
>  {
>  	int ret = 0;
>  
> -	if (link(tmpfile, filename))
> +	if (unreliable_hardlinks)
> +		ret = ~EEXIST; /* anything but EEXIST */

It is a bit too far away from the:

	if (ret && ret != EEXIST)

you are trying to trigger with this hack, and without seeing that "if" in
the context anybody would go "Huh?".  It is a good sign that this is
fragile (the later "if" may be rewritten by somebody else without
realizing this hack exists).  Besides, it is (rather, "happens to be at
this moment") "anything non-zero but EEXIST".

I have a feeling that it would be much less fragile to write it like this,
as a label warns anybody touching the code to check where else the control
flow may come from.

diff --git a/sha1_file.c b/sha1_file.c
index 8fe135d..11969fc 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2225,7 +2225,9 @@ int move_temp_to_file(const char *tmpfile, const char *filename)
 {
 	int ret = 0;
 
-	if (link(tmpfile, filename))
+	if (unreliable_hardlinks)
+		goto try_rename;
+	else if (link(tmpfile, filename))
 		ret = errno;
 
 	/*
@@ -2240,6 +2242,7 @@ int move_temp_to_file(const char *tmpfile, const char *filename)
 	 * left to unlink.
 	 */
 	if (ret && ret != EEXIST) {
+	try_rename:
 		if (!rename(tmpfile, filename))
 			goto out;
 		ret = errno;
