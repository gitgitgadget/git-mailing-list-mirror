From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Preserve the protection mode for the Git config files
Date: Wed, 22 Jul 2009 11:14:21 -0700
Message-ID: <7vab2wlh4y.fsf@alter.siamese.dyndns.org>
References: <20090721152435.16642.47207.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 20:14:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTgKr-0001yG-Vw
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 20:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbZGVSO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 14:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbZGVSO1
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 14:14:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52579 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157AbZGVSO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 14:14:26 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 72BE2D21E;
	Wed, 22 Jul 2009 14:14:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 42451D21B; Wed, 22 Jul 2009
 14:14:22 -0400 (EDT)
In-Reply-To: <20090721152435.16642.47207.stgit@pc1117.cambridge.arm.com>
 (Catalin Marinas's message of "Tue\, 21 Jul 2009 16\:24\:36 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7D9ACB84-76EB-11DE-8FD1-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123764>

Catalin Marinas <catalin.marinas@arm.com> writes:

> Every time an option is set, the config file protection mode is changed
> to 0666 & ~umask even if it was different before. This patch is useful
> if people store passwords (SMTP server in the StGit case) and do not
> want others to read the .gitconfig file.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  lockfile.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/lockfile.c b/lockfile.c
> index eb931ed..87ee233 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -134,7 +138,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
>  	if (!(flags & LOCK_NODEREF))
>  		resolve_symlink(lk->filename, sizeof(lk->filename)-5);
>  	strcat(lk->filename, ".lock");
> -	lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
> +	lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, st.st_mode);
>  	if (0 <= lk->fd) {
>  		if (!lock_file_list) {
>  			sigchain_push_common(remove_lock_file_on_signal);

Your log message talks about .git/config and nothing else, but I think
this codepath affects everything that is created under the lock, such as
the index and refs.

Later in the function we call adjust_shared_perm(), and I had to wonder if
this change have an adverse effect in a shared repository setting.

For example, in a repository shared (with core.sharedrepository = true)
between users whose umask is 002, if somebody makes a ref unreadable by
others by mistake, the current code fixes the mistake in a later update,
but with your patch, the ref will kept unreadable.

This change in behaviour is justifiable only because the only thing the
user who said "core.sharedrepository = true" cares about is that refs are
readable by the group members (otherwise s/he would have used a more
explicit setting like "core.sharedrepository = 0660", and the
adjust_shared_perm() code will do the right thing, with or without your
patch).

The patch description must defend itself a bit better, perhaps by saying
something like this at the end.

	This patch touches the codepath that affects not just .git/config
	but other files like the index and the loose refs, so they also
	inherit the original protection bits.  In a private repository,
	this is not an issue exactly because the repository is private,

	In a shared repository, a later call made in this function to
	adjust_shared_perm() widens the permission bits as configured.
	Because adjust_shared_perm() is designed to do so from any mode
	limited by user's umask, even though this patch changes the
	behaviour in the strict sense, it should not affect the outcome in
	a negative way and what is explicitly marked as allowed in the
	configuration will still be allowed.
