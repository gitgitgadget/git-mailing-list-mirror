From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH,RFC] Implement 'git rm --if-missing'
Date: Wed, 16 Jul 2008 11:48:42 -0700
Message-ID: <7vtzepr7g5.fsf@gitster.siamese.dyndns.org>
References: <1216231250-21141-1-git-send-email-ciaran.mccreesh@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ciaran McCreesh <ciaran.mccreesh@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 20:49:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJC4T-0006hc-6O
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 20:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137AbYGPSst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 14:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754113AbYGPSst
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 14:48:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63827 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849AbYGPSst (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 14:48:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6AAF522A7D;
	Wed, 16 Jul 2008 14:48:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A3BB822A76; Wed, 16 Jul 2008 14:48:44 -0400 (EDT)
In-Reply-To: <1216231250-21141-1-git-send-email-ciaran.mccreesh@googlemail.com> (Ciaran
 McCreesh's message of "Wed, 16 Jul 2008 19:00:50 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D2CB06D0-5367-11DD-ACB6-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88715>

Ciaran McCreesh <ciaran.mccreesh@googlemail.com> writes:

> git rm --if-missing will only remove files if they've already been removed from
> disk.

This probably is a borderline with feaping creaturism.  What's the use of
it in a real workflow that you need this for?

"git add -u" may be too broad in that it also adds anything modified, but
so is --if-missing too broad in that it removes anything removed, and if
you are going to limit by giving pathspecs _anyway_, then...

Old timers might just do:

	git diff --name-only --diff-filter=D |
        git update-index --remove --stdin

;-)

> diff --git a/builtin-rm.c b/builtin-rm.c
> index 22c9bd1..4b89705 100644
> --- a/builtin-rm.c
> +++ b/builtin-rm.c
> @@ -125,7 +125,7 @@ static int check_local_mod(unsigned char *head, int index_only)
>  static struct lock_file lock_file;
>  
>  static int show_only = 0, force = 0, index_only = 0, recursive = 0, quiet = 0;
> -static int ignore_unmatch = 0;
> +static int ignore_unmatch = 0, if_missing = 0;

Not your fault in entirety, but we should drop these " = 0"
initializations for static variables in a clean-up patch.

>  static struct option builtin_rm_options[] = {
>  	OPT__DRY_RUN(&show_only),
> @@ -135,6 +135,7 @@ static struct option builtin_rm_options[] = {
>  	OPT_BOOLEAN('r', NULL,             &recursive,  "allow recursive removal"),
>  	OPT_BOOLEAN( 0 , "ignore-unmatch", &ignore_unmatch,
>  				"exit with a zero status even if nothing matched"),
> +	OPT_BOOLEAN( 0 , "if-missing",     &if_missing, "only remove missing files"),

Perhaps the command should error out if some of the named files still
exist in the working tree?

> @@ -168,6 +169,12 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>  		struct cache_entry *ce = active_cache[i];
>  		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen))
>  			continue;
> +		if (if_missing)
> +		{
> +			struct stat st;
> +			if ((lstat(ce->name, &st) == 0) || (errno != ENOENT))
> +				continue;
> +		}

 (1) (Style).  Opening brace comes on the same line as "if ()".

 (2) (Design). How should this new option interact with --cached mode of
     operation?

 (3) (Design). Shouldn't "git rm --if-missing" without any pathspec remove
     all missing paths from the index?

 (4) If lstat fails due to I/O error or something, you do not continue and
     add that path you did not get ENOENT for to the kill-list.  Is that
     desirable?

 (5) I wonder if lstat() is enough here.  

     Consider:

	- current commit has "kernel" symlink to "linux-2.6/" directory but
          you want to remove kernel and move directory linux-2.6 to it, so:

          - you run "rm kernel; mv linux-2.6 kernel"

	  - then you run "git rm --if-missing -- kernel"

     What should the command do?
