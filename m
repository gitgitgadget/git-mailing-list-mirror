From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix git init --shared=all on FreeBSD 4.11
Date: Mon, 03 Mar 2008 16:31:12 -0800
Message-ID: <7v1w6rfhyn.fsf@gitster.siamese.dyndns.org>
References: <20080303234406.GA28158@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 01:32:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWL5H-0001kn-GU
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 01:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757551AbYCDAbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 19:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbYCDAbf
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 19:31:35 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42202 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759492AbYCDAbV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 19:31:21 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A7B8F25F9;
	Mon,  3 Mar 2008 19:31:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C257A25F8; Mon,  3 Mar 2008 19:31:15 -0500 (EST)
In-Reply-To: <20080303234406.GA28158@steel.home> (Alex Riesen's message of
 "Tue, 4 Mar 2008 00:44:06 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76004>

Alex Riesen <raa.lkml@gmail.com> writes:

> At least FreeBSD 4.11p2 does not allow changing SUID/GUID bits to
> a non-root user.

Sorry, but I do not understand this change.

> diff --git a/path.c b/path.c
> index af27161..4865e98 100644
> --- a/path.c
> +++ b/path.c
> @@ -265,6 +265,7 @@ int adjust_shared_perm(const char *path)
>  		return 0;
>  	if (lstat(path, &st) < 0)
>  		return -1;
> +	st.st_mode &= 07777 & ~(S_ISUID|S_ISGID);
>  	mode = st.st_mode;

If the thing is a directory, we say later in the code that we want to see
S_ISGID set, like this:

	...
	if (S_ISDIR(mode))
		mode |= S_ISGID;
	if ((mode & st.st_mode) != mode && chmod(path, mode) < 0)
		return -2;
	return 0;

and then we compare with st.st_mode so that we do not chmod() what's
already good  Your change means we will always try to chmod all the
directories, and your explanation suggests that such a chmod to do g+s on
directories would also fail (and your patch does not fix it -- we actively
try to make sure directories have g+s set).

	Side note. the wording in your message, "does not allow changing",
	is very unclear.  Do you mean "non-root cannot do u+s,g+s"?  Or do
	you mean "non-root cannot do u+s,g+s, non-root cannot do u-s,g-s
	either"?

For regular files, I do not think we have any reason to set u+s or g+s
ourselves, and we do not try to do so either.  As long as the original
st.st_mode does not have such bits set, the mode we will pass to chmod for
regular would not try to set them.  If you already had u+s,g+s when you
read st.st_mode that's a different story, but then I do not know why you
had such a file to begin with.

I do not mind a change to make sure we do u-s,g-s on regular files, but I
do not think it is necessary, and I am curious why you had files with such
perm bits to begin with.
