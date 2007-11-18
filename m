From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-commit: fix partial-commit support
Date: Sun, 18 Nov 2007 10:44:22 -0800
Message-ID: <7vve7zv1fd.fsf@gitster.siamese.dyndns.org>
References: <1195381287-26823-1-git-send-email-gitster@pobox.com>
	<1195381287-26823-2-git-send-email-gitster@pobox.com>
	<1195381287-26823-3-git-send-email-gitster@pobox.com>
	<1195381287-26823-4-git-send-email-gitster@pobox.com>
	<7vr6inx1m8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 19:44:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Itp8Q-00027y-K3
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 19:44:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753729AbXKRSo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 13:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753601AbXKRSo3
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 13:44:29 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:60106 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197AbXKRSo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 13:44:27 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 2FC542EF;
	Sun, 18 Nov 2007 13:44:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id B577097206;
	Sun, 18 Nov 2007 13:44:47 -0500 (EST)
In-Reply-To: <7vr6inx1m8.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 18 Nov 2007 02:57:19 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65382>

Junio C Hamano <gitster@pobox.com> writes:

> diff --git a/builtin-commit.c b/builtin-commit.c
> index 3e7d281..e487bc0 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c

There was another...

> +static int list_paths(struct path_list *list, const char *with_tree,
> +		      const char *prefix, const char **pattern)
> +{
> +	struct dir_struct dir;
> +	int i;
> +	char *m;
> +
> +	for (i = 0; pattern[i]; i++)
> +		;
> +	m = xcalloc(1, i);
> +
> +	memset(&dir, 0, sizeof(dir));
> +	if (with_tree)
> +		overlay_tree_on_cache(with_tree, prefix);
> +
> +	for (i = 0; i < active_nr; i++) {
> +		struct cache_entry *ce = active_cache[i];
> +		if (ce->ce_flags & htons(CE_UPDATE))
> +			continue;
> +		if (!pathspec_match(pattern, m, ce->name, 0))
> +			continue;
> +		if (excluded(&dir, ce->name))
> +			continue;
> +		path_list_insert(ce->name, list);
> +	}

This "excluded", and the whole "struct dir" business is
unneeded, as we are walking on the index and finding the set of
paths the user cares about.
