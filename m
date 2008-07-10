From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix backwards-incompatible handling of
 core.sharedRepository
Date: Thu, 10 Jul 2008 16:39:33 -0700
Message-ID: <7vr6a1mhqi.fsf@gitster.siamese.dyndns.org>
References: <20080710231853.21448.18643.stgit@rover.dkm.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Heikki Orsila <heikki.orsila@iki.fi>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Jul 11 01:40:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH5kf-0001A7-NY
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 01:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440AbYGJXjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 19:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754566AbYGJXjm
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 19:39:42 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46219 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754433AbYGJXjl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 19:39:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2F29825156;
	Thu, 10 Jul 2008 19:39:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CE89E25154; Thu, 10 Jul 2008 19:39:35 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 76F66C1A-4ED9-11DD-9078-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88056>

Petr Baudis <pasky@suse.cz> writes:

> The 06cbe8550324e0fd2290839bf3b9a92aa53b70ab core.sharedRepository
> handling extension broke backwards compatibility; before, shared=1 meant
> that Git merely ensured the repository is group-writable, not that it's
> _only_ group-writable, which is the current behaviour.

Donn't our existing tests catch this, and if the answer is no because we
don't have any, could you add some?

>  path.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
>
> diff --git a/path.c b/path.c
> index 5983255..75c5915 100644
> --- a/path.c
> +++ b/path.c
> @@ -269,7 +269,7 @@ int adjust_shared_perm(const char *path)
>  	mode = st.st_mode;
>  
>  	if (shared_repository) {
> -		int tweak = shared_repository;
> +		int tweak = (mode & 0777) | shared_repository;
>  		if (!(mode & S_IWUSR))
>  			tweak &= ~0222;
>  		mode = (mode & ~0777) | tweak;

I think this change is good.  shared_repository has always been about
widening the access and not about limiting.
