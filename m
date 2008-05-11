From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-apply: check for empty files when detecting
 creation patch
Date: Sat, 10 May 2008 19:36:02 -0700
Message-ID: <7vlk2h8t4d.fsf@gitster.siamese.dyndns.org>
References: <1210257579-30975-1-git-send-email-imre.deak@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Imre Deak <imre.deak@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 04:37:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv1RK-00039x-RJ
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 04:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069AbYEKCgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 22:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753041AbYEKCgT
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 22:36:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43369 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbYEKCgS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 22:36:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DFF5B1002;
	Sat, 10 May 2008 22:36:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A11C1369F; Sat, 10 May 2008 22:36:10 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 07E8D854-1F03-11DD-9DC6-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81725>

Imre Deak <imre.deak@gmail.com> writes:

> When we can only guess if we have a creation patch, we do
> this by treating the patch as such if there weren't any old
> lines. Zero length files can be patched without old lines
> though, so do an extra check for file size.

You described what your patch does, but you did not explain why it is a
good addition.  One way to do so is to illustrate in what occasion what
the existing code does is insufficient.

> +static size_t existing_file_size(const char *file)
> +{
> +	size_t st_size = -1;
> +
> +	if (file == NULL)
> +		return -1;
> +	if (cached) {
> +		struct cache_entry *ce;
> +		int pos;
> +
> +		pos = cache_name_pos(file, strlen(file));
> +		if (pos < 0)
> +			return -1;
> +		ce = active_cache[pos];
> +		st_size = ntohl(ce->ce_size);

ntohl()?  I thought ce->ce_* are host-native byte order these days...

> +	} else {
> +		struct stat st;
> +
> +		if (lstat(file, &st) < 0)
> +			return -1;

Doesn't this break the use case where "git-apply --stat" is used as an
improved diffstat outside a git repository?

> @@ -1143,13 +1170,18 @@ static int parse_single_patch(char *line, unsigned long size, struct patch *patc
>  	if (patch->is_delete < 0 &&
>  	    (newlines || (patch->fragments && patch->fragments->next)))
>  		patch->is_delete = 0;
> +	/* FIXME: How can be there context if it's a creation / deletion? */
>  	if (!unidiff_zero || context) {
>  		/* If the user says the patch is not generated with
>  		 * --unified=0, or if we have seen context lines,
>  		 * then not having oldlines means the patch is creation,
>  		 * and not having newlines means the patch is deletion.
> +		 *
> +		 * It's also possible that a zero length file is added
> +		 * to.
>  		 */
> -		if (patch->is_new < 0 && !oldlines) {
> +		if (patch->is_new < 0 && !oldlines &&
> +		    existing_file_size(patch->old_name) != 0) {
>  			patch->is_new = 1;
>  			patch->old_name = NULL;
>  		}

The user did not say the patch was produced without context, or we do have
context.  The latter cannot be a creation patch so the new logic is not
appropriate.  But let's forget that problem for now and look at the case
where the patch did _not_ have any context, i.e. only added and deleted
lines.

If the patch did not have context, and the user did not ask for -u0 patch
when it was produced, it could be a creation patch, but if there are
deleted lines it cannot be.  That is the original logic.

After your patch, the original logic is allowed to decide that the patch
is a creation _only if_ you happen to already have a file that is _to be
created_ in the work tree with some existing contents, or the file does
not exist.  I do not see a sane logic behind that.  If you were making
sure that the work tree does _not_ have the file, then I would understand,
even though I think it is wrong for "apply --stat" case.  If you see a
file in the work tree, and if you assume the patch would apply to the
work tree, then the patch cannot be creation!

In general, it is not right to look at the work tree to decide how to
interpret what the patch means to begin with, but maybe you are trying to
use work tree status as a hint to disambiguate a corner case that the
information in a patch we are reading is insufficient, in which case it
might be Ok.  But I cannot tell what that corner case is.

I am lost.  Please explain what you are trying to fix first before
explaining how you attempted to fix it.
