From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Allow callers of unpack_trees() to handle failure
Date: Sun, 02 Dec 2007 22:24:19 -0800
Message-ID: <7v63zgqorw.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0712030032400.5349@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Dec 03 07:24:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz4jT-0000VV-8E
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 07:24:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263AbXLCGYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 01:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754253AbXLCGYZ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 01:24:25 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:47184 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754230AbXLCGYY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 01:24:24 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 523FE2EF;
	Mon,  3 Dec 2007 01:24:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id D832B997D3;
	Mon,  3 Dec 2007 01:24:42 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712030032400.5349@iabervon.org> (Daniel
	Barkalow's message of "Mon, 3 Dec 2007 00:32:42 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66874>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Return an error from unpack_trees() instead of calling die(), and exit
> with an error in read-tree. The merge function can return negative to
> abort.
>
> This will be used in builtin-checkout -m.
>
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
>  builtin-read-tree.c |    3 +-
>  unpack-trees.c      |   85 ++++++++++++++++++++++++++++----------------------
>  2 files changed, 50 insertions(+), 38 deletions(-)
>
> diff --git a/builtin-read-tree.c b/builtin-read-tree.c
> index 43cd56a..4f680c3 100644
> --- a/builtin-read-tree.c
> +++ b/builtin-read-tree.c
> @@ -269,7 +269,8 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
>  		parse_tree(tree);
>  		init_tree_desc(t+i, tree->buffer, tree->size);
>  	}
> -	unpack_trees(nr_trees, t, &opts);
> +	if (unpack_trees(nr_trees, t, &opts))
> +		return 128;

Magic 128 when everybody else in the patch returns -1 for error?

Otherwise the changes seem sensible, as long as the callers are paying
attention to the return values, which I admit that I did not check.
