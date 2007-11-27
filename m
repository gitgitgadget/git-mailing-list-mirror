From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make Git accept absolute path names for files within the work tree
Date: Mon, 26 Nov 2007 16:24:07 -0800
Message-ID: <7vmyt0edso.fsf@gitster.siamese.dyndns.org>
References: <1196119109-27483-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 01:24:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwoFj-0000qB-6w
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 01:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757411AbXK0AYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 19:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757276AbXK0AYT
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 19:24:19 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40422 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755542AbXK0AYS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 19:24:18 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 6D47A2F0;
	Mon, 26 Nov 2007 19:24:39 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id ED54299FEA;
	Mon, 26 Nov 2007 19:24:36 -0500 (EST)
In-Reply-To: <1196119109-27483-1-git-send-email-robin.rosenberg@dewire.com>
	(Robin Rosenberg's message of "Tue, 27 Nov 2007 00:18:29 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66148>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> Was it this simple?
>
> diff --git a/setup.c b/setup.c
> index 43cd3f9..9b3a9ff 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -6,6 +6,22 @@ static int inside_work_tree = -1;
>  
>  const char *prefix_path(const char *prefix, int len, const char *path)
>  {
> +	if (is_absolute_path(path)) {
> +		const char *work_tree = get_git_work_tree();
> +		int n = strlen(work_tree);
> +		if (!strncmp(path, work_tree, n) && (path[n] == '/' || !path[n])) {
> +			if (path[n])
> +				path += 1;
> +			path += n;
> +			if (prefix && !strncmp(path, prefix, len - 1)) {
> +			    if (path[len - 1] == '/')
> +				    path += len;
> +			    else
> +				    if (!path[len - 1])
> +					    path += len - 1;
> +			}
> +		}
> +	}
>  	const char *orig = path;

Decl after statement.

I do not think there is fundamental reason to object to this change, as
long as the prefixing is done to the path that is trying to name a path
in the working tree.

Also some codepath that does not require any work tree may want to call
prefix_path().  I do not know what would happen in such a case.

Although I didn't look at all the callers, I think the caller from
config.c is not talking about a path in the work tree, and not all users
of config.c need to have work-tree.
