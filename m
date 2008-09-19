From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] make "git remote" report multiple URLs
Date: Fri, 19 Sep 2008 13:28:33 -0700
Message-ID: <7vej3fswwe.fsf@gitster.siamese.dyndns.org>
References: <7v4p4e0zpg.fsf@gitster.siamese.dyndns.org>
 <1221754262-15772-1-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 19 22:29:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kgmbs-000684-J2
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 22:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755335AbYISU2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 16:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755099AbYISU2j
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 16:28:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38020 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821AbYISU2i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 16:28:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 71A2E6372C;
	Fri, 19 Sep 2008 16:28:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AFBFF63725; Fri, 19 Sep 2008 16:28:35 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8A93481E-8689-11DD-8513-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96312>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> This patch makes "git remote -v" and "git remote show" report multiple URLs
> rather than warn about them. Multiple URLs are OK for pushing into
> multiple repos simultaneously.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---

Nice.  But this makes "git remote show" to give duplicate results, which
you might want to cull.

>  builtin-remote.c |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)
>
> This passes all tests, so I think the new output does not break anything.

Or just there is no existing tests that verify the output from this command.

> diff --git a/builtin-remote.c b/builtin-remote.c
> index 01945a8..ae560e7 100644
> --- a/builtin-remote.c
> +++ b/builtin-remote.c
> @@ -652,10 +652,13 @@ static int get_one_entry(struct remote *remote, void *priv)
>  {
>  	struct string_list *list = priv;
>  
> -	string_list_append(remote->name, list)->util = remote->url_nr ?
> -		(void *)remote->url[0] : NULL;
> -	if (remote->url_nr > 1)
> -		warning("Remote %s has more than one URL", remote->name);
> +	if (remote->url_nr > 0) {
> +		int i;
> +
> +		for (i = 0; i < remote->url_nr; i++)
> +			string_list_append(remote->name, list)->util = (void *)remote->url[i];
> +	} else
> +		string_list_append(remote->name, list)->util = NULL;
>  
>  	return 0;
>  }
> -- 
> 1.6.0.2.249.g97d7f
