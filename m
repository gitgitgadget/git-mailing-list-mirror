From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH 1/5] Introduces for_each_revision() helper
Date: Thu, 26 Apr 2007 20:59:01 +0100
Message-ID: <46310485.8070605@shadowen.org>
References: <11776168001253-git-send-email-lcapitulino@mandriva.com.br> <11776168001048-git-send-email-lcapitulino@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
To: Luiz Fernando N Capitulino <lcapitulino@mandriva.com.br>
X-From: git-owner@vger.kernel.org Thu Apr 26 21:59:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhA80-0007HA-D5
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 21:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031477AbXDZT7D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 15:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031480AbXDZT7B
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 15:59:01 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:2236 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031477AbXDZT7A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 15:59:00 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1HhA7o-0004Y8-UZ; Thu, 26 Apr 2007 20:59:33 +0100
User-Agent: Icedove 1.5.0.9 (X11/20061220)
In-Reply-To: <11776168001048-git-send-email-lcapitulino@mandriva.com.br>
X-Enigmail-Version: 0.94.2.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45653>

Luiz Fernando N Capitulino wrote:
> This macro may be used to iterate over revisions, so, instead of
> doing:
> 
> 	struct commit *commit;
> 
> 	...
> 
> 	prepare_revision_walk(rev);
> 	while ((commit = get_revision(rev)) != NULL) {
> 		...
> 	}
> 
> New code should use:
> 
> 	struct commit *commit;
> 
> 	...
> 
> 	for_each_revision(commit, rev) {
> 		...
> 	}
> 
>  The only disadvantage is that it's something magical, and the fact that
> it returns a struct commit is not obvious.
> 
>  On the other hand it's documented, has the advantage of making the walking
> through revisions easier and can save some lines of code.
> 
> Signed-off-by: Luiz Fernando N Capitulino <lcapitulino@mandriva.com.br>
> ---
>  revision.h |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/revision.h b/revision.h
> index cdf94ad..bb6f475 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -133,4 +133,15 @@ extern void add_object(struct object *obj,
>  extern void add_pending_object(struct rev_info *revs, struct object *obj, const char *name);
>  extern void add_pending_object_with_mode(struct rev_info *revs, struct object *obj, const char *name, unsigned mode);
>  
> +/* helpers */
> +
> +/**
> + * for_each_revision	-	iterate over revisions
> + * @commit:	pointer to a commit object returned for each iteration
> + * @rev:	revision pointer
> + */
> +#define for_each_revision(commit, rev) \
> +	prepare_revision_walk(rev);    \
> +	while ((commit = get_revision(rev)) != NULL)
> +
>  #endif

If this is constructed like that then I would expect the code below to
be miss-compiled:

	if (condition)
		for_each_revision(commit, rev) {
		}

As it would be effectivly be:

	if (condition)
		prepare_revision_walk(rev);
	while ((commit = get_revision(rev)) != NULL) {
	}

I think you'd want this to be something more like:

#define for_each_revision(commit, rev) \
	for (prepare_revision_walk(rev); \
		(commit = get_revision(rev))) != NULL); ) {

-apw
