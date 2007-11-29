From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make Git accept absolute path names for files within the work tree
Date: Wed, 28 Nov 2007 16:37:37 -0800
Message-ID: <7vwss1zy26.fsf@gitster.siamese.dyndns.org>
References: <7vmyt0edso.fsf@gitster.siamese.dyndns.org>
	<1196205847-22968-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 01:38:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxXPo-0001Dk-0i
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 01:38:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678AbXK2Aho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 19:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbXK2Aho
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 19:37:44 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:41773 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbXK2Ahn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 19:37:43 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id D1E0D2F0;
	Wed, 28 Nov 2007 19:38:04 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 40EA09ADDA;
	Wed, 28 Nov 2007 19:38:01 -0500 (EST)
In-Reply-To: <1196205847-22968-1-git-send-email-robin.rosenberg@dewire.com>
	(Robin Rosenberg's message of "Wed, 28 Nov 2007 00:24:07 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66479>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> diff --git a/setup.c b/setup.c
> index f512ea0..ffc30bf 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -7,6 +7,25 @@ static int inside_work_tree = -1;
>  const char *prefix_path(const char *prefix, int len, const char *path)
>  {
>  	const char *orig = path;
> +	const char *work_tree = get_git_work_tree();
> +	if (is_absolute_path(path) && work_tree) {

Could you structure this part to read like this, into a separate
function:

static const char *strip_work_tree_path(const char *prefix, int len, const char *path)
{
	...
}

const char *prefix_path(const char *prefix, int len, const char *path)
{
	const char *orig = path;

	if (is_absolute_path(path))
		path = strip_work_tree_path(prefix, len, path);
	...


About the part that would be moved out of line with such a
restructuring,

> +		int n = strlen(work_tree);
> +		if (!strncmp(path, work_tree, n) && (path[n] == '/' || !path[n])) {
> +			if (path[n])
> +				path += n + 1;
> +			else
> +				path += n;
> +
> +			if (prefix && !strncmp(path, prefix, len - 1)) {
> +				if (path[len - 1] == '/')
> +					path += len;
> +				else
> +					if (!path[len - 1])
> +						path += len - 1;
> +			}

This makes me wonder what happens if after stripping the worktree path
path does not match the prefix.
