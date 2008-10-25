From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Fix git branch -m for symrefs.
Date: Sat, 25 Oct 2008 11:31:01 -0700
Message-ID: <7v8wsca5ne.fsf@gitster.siamese.dyndns.org>
References: <cover.1224939436.git.vmiklos@frugalware.org>
 <a96243124c555cbc4081f733b348252ac200bd53.1224939436.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Oct 25 20:32:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ktnw2-0006VK-P1
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 20:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbYJYSbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 14:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbYJYSbN
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 14:31:13 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52677 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbYJYSbM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 14:31:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 52F928F60F;
	Sat, 25 Oct 2008 14:31:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D926F8F60E; Sat, 25 Oct 2008 14:31:03 -0400 (EDT)
In-Reply-To: <a96243124c555cbc4081f733b348252ac200bd53.1224939436.git.vmiklos@frugalware.org> (Miklos Vajna's message of "Sat, 25 Oct 2008 14:58:41 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 186FF146-A2C3-11DD-8C9A-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99116>

Miklos Vajna <vmiklos@frugalware.org> writes:

> -int delete_ref(const char *refname, const unsigned char *sha1)
> +int delete_ref(const char *refname, const unsigned char *sha1, int flags)
>  {
>  	struct ref_lock *lock;
> -	int err, i, ret = 0, flag = 0;
> +	int err, i = 0, ret = 0, flag = 0;
> +	char *path;
>  
>  	lock = lock_ref_sha1_basic(refname, sha1, 0, &flag);
>  	if (!lock)
>  		return 1;
>  	if (!(flag & REF_ISPACKED)) {

Two variables flag vs flags is a bit confusing, isn't it?  How about
naming the new one "delopt" or something?

The new variable "char *path" at the toplevel can be confined in the scope
of this if () {} block and probably can become "const char *", right?

> @@ -964,10 +971,15 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
>  	struct ref_lock *lock;
>  	struct stat loginfo;
>  	int log = !lstat(git_path("logs/%s", oldref), &loginfo);
> +	const char *symref = NULL;
> +	int is_symref = 0;
>  
>  	if (S_ISLNK(loginfo.st_mode))
>  		return error("reflog for %s is a symlink", oldref);

Possible bug in the context.  When there is no reflog for the ref being
renamed, lstat would fail; it doesn't feel right to have this S_ISLNK()
before checking the result of the lstat which is in "log".

> +	symref = resolve_ref(oldref, orig_sha1, 0, &flag);
> +	if (flag & REF_ISSYMREF)
> +		is_symref = 1;
>  	if (!resolve_ref(oldref, orig_sha1, 1, &flag))
>  		return error("refname %s not found", oldref);

Do we really need two calls to resolve_ref()?  Your new call calls it
without must-exist bit --- why?  Immediately after that, the existing call
will barf if it does not exist anyway.

I agree it is good to have symref aware delete_ref(), but I am not sure
supporting symref in rename_ref() is either needed or necessarily a good
idea.  You also need to worry about a symref pointing at a branch yet to
be born.

In the meantime, I think we should just check (flag & REF_ISSYMREF) after
the existing resolve_ref() we can see in the context above, and error out
saying you cannot rename a symref, and do nothing else.
