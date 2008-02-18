From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Tidy up git mergetool's backup file behaviour and
 variable names
Date: Sun, 17 Feb 2008 19:45:42 -0800
Message-ID: <7vy79jsza1.fsf@gitster.siamese.dyndns.org>
References: <9543203388d64839de78822efb538903fc15bf7f.1203251306.git.charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Mon Feb 18 05:37:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQxlI-0001Cl-Py
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 05:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756148AbYBREg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 23:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756128AbYBREg6
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 23:36:58 -0500
Received: from rune.pobox.com ([208.210.124.79]:39271 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755149AbYBREg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 23:36:57 -0500
Received: from rune.listbox.com (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 600B719A456;
	Sun, 17 Feb 2008 23:37:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id
 3525819C59A; Sun, 17 Feb 2008 22:46:21 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74227>

Charles Bailey <charles@hashpling.org> writes:

> Currently a backup pre-merge file with conflict markers is sometimes
> kept with a .orig extenstion and sometimes removed depending on the
> particular merge tool used.
>
> This patch makes the handling consistent across all merge tools and
> configurable via a new mergetool.keepBackup config variable
>
> Changed the merge file path variable to MERGED for consistency with the
> names of the merge temporary filename variables. This done with the
> intention of having these variables used by user scripts in a subsequent
> custom merge tool patch.

I would have preferred two separate patches, one s/path/MERGED/
and the other save/remove clean-up, which would be much easier
way to review, but this is what we have, so let's work on this
version.

> +mergetool.keepBackup::
> +	After performing a merge, the original file with conflict markers
> +	can be saved as a file with a `.orig` extension.  If this variable
> +	is set to `false` then this file is not preserved.
> +

s/$/  Defaults to true (i.e. keep the backup files)/.

We might also want a command line option to override the user's
usual default specified with this configuration but that can be
left for later rounds.

> @@ -112,11 +112,11 @@ resolve_deleted_merge () {
>  }
>  
>  check_unchanged () {
> -    if test "$path" -nt "$BACKUP" ; then
> +    if test "$MERGED" -nt "$BACKUP" ; then

I think this is the cause of your automated test sometimes
needing 1 sec sleep.  This check should perhaps be done with a
"!  cmp $MERGED $BACKUP >/dev/null", which would succeed if the
user's interaction with the backend tool touched the file.

The rest of the patch looked fine to me.

We might also want to add -y (assume "Yes" answer to "Did you
resolve it" question without actually asking) command line
option to the script, but that would be for later rounds.
