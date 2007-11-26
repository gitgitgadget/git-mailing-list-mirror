From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Sun, 25 Nov 2007 17:16:29 -0800
Message-ID: <7vbq9hiz6a.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711252236350.4725@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 26 02:16:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwSam-0005zl-Hl
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 02:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756137AbXKZBQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 20:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754622AbXKZBQh
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 20:16:37 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:47026 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbXKZBQh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 20:16:37 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id D8DCA2F0;
	Sun, 25 Nov 2007 20:16:57 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 40AAE99CA1;
	Sun, 25 Nov 2007 20:16:55 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711252236350.4725@wbgn129.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 25 Nov 2007 22:37:20 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66033>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
> new file mode 100644
> index 0000000..073ff7f
> --- /dev/null
> +++ b/Documentation/git-fast-export.txt
> ...
> +DESCRIPTION
> +-----------
> +This program dumps the given revisions in a form suitable to be piped
> +into gitlink:git-fast-import[1].
> +
> +You can use it as a human readable bundle replacement (see
> +gitlink:git-bundle[1]), or as a kind of an interactive
> +gitlink:git-filter-branch[1].
> +
> +
> +OPTIONS
> +-------
> +--progress=<n>::
> +	Insert 'progress' statements every <n> objects, to be shown by
> +	gitlink:git-fast-import[1] during import.
> +
> +--signed-tags=(ignore|warn|strip|abort)::
> +	Specify how to handle signed tags.  Since any transformation
> +	after the export can change the tag names (which can also happen
> +	when excluding revisions) the signatures will not match.
> ++
> +When asking to 'abort' (which is the default), this program will die
> +when encountering a signed tag.  With 'strip', the tags will be made
> +unsigned, with 'ignore', they will be silently ignored (i.e. not exported)
> +and with 'warn', they will be exported, but you will see a warning.

I am not sure if abort should be the default.

If a straight dump-restore is made without rewriting, the result will be
identical to the original, right?

The reason I mention a straight dump-restore is because ...

> +$ git fast-export master~5..master |
> +	sed "s|refs/heads/master|refs/heads/other|" |
> +	git fast-import

... I find this a quite unrealistic example to assume that the data
stream does not have some string and convert blindly without parsing.

On the other hand, we _could_ also have a separate filter that works on
input stream for fast-import, but that filter should know what the
fast-import input stream looks like (a simple sed does not cut it).  

So unless the future direction is to deprecate filter-branch and replace
it with such a fast-import based filter in between fast-export and
fast-import, I think the use of fast-export is to make verbatim copy
without munging the contents, which leads me to think --signed-tag
option should default to "export it as-is".

... which seem to be missing from the available values to the option.

> diff --git a/builtin-fast-export.c b/builtin-fast-export.c
> new file mode 100755
> index 0000000..48d0c54
> --- /dev/null
> +++ b/builtin-fast-export.c
> ...
> +/*
> + * TODO:
> + * - tags (--signed-tags=(ignore|warn|strip|abort)
> + */

This comment is stale?
