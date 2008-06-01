From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] graph API: avoid printing unnecessary padding before
 some octopus merges
Date: Sun, 01 Jun 2008 14:50:34 -0700
Message-ID: <7vskvwakph.fsf@gitster.siamese.dyndns.org>
References: <20080529085752.GA31865@adamsimpkins.net>
 <1212353818-7031-1-git-send-email-adam@adamsimpkins.net>
 <1212353818-7031-2-git-send-email-adam@adamsimpkins.net>
 <1212353818-7031-3-git-send-email-adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Teemu Likonen <tlikonen@iki.fi>
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Sun Jun 01 23:52:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2vTD-0002M8-33
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 23:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375AbYFAVup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 17:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752287AbYFAVup
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 17:50:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49404 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbYFAVuo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 17:50:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A279C38C8;
	Sun,  1 Jun 2008 17:50:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BF3CE38C7; Sun,  1 Jun 2008 17:50:38 -0400 (EDT)
In-Reply-To: <1212353818-7031-3-git-send-email-adam@adamsimpkins.net> (Adam
 Simpkins's message of "Sun, 1 Jun 2008 13:56:58 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C8300FB0-3024-11DD-B393-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83470>

Adam Simpkins <adam@adamsimpkins.net> writes:

> When an octopus merge is printed, several lines are printed before it to
> move over existing branch lines to its right.  This is needed to make
> room for the children of the octopus merge.  For example:
>
> | | | |
> | |  \ \
> | |   \ \
> | |    \ \
> | M---. \ \
> | |\ \ \ \ \
>
> However, this step isn't necessary if there are no branch lines to the
> right of the octopus merge.  Therefore, skip this step when it is not
> needed, to avoid printing extra lines that don't really serve any
> purpose.
>
> Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>
> ---
>  graph.c |   13 ++++++++-----
>  1 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/graph.c b/graph.c
> index 332d1e8..0531716 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -450,16 +450,18 @@ void graph_update(struct git_graph *graph, struct commit *commit)
>  	 * it never finished its output.  Goto GRAPH_SKIP, to print out
>  	 * a line to indicate that portion of the graph is missing.
>  	 *
> -	 * Otherwise, if there are 3 or more parents, we need to print
> -	 * extra rows before the commit, to expand the branch lines around
> -	 * it and make room for it.
> +	 * If there are 3 or more parents, we may need to print extra rows
> +	 * before the commit, to expand the branch lines around it and make
> +	 * room for it.  We need to do this unless there aren't any branch
> +	 * rows to the right of this commit.

Double negation like this is confusing, isn't it?

"We do not have to do this if there isn't any branch row to the right of
this commit" may be better.  "We need to do this only if there is a branch
row (or more) to the right of this commit" would probably be better.

Other than that, the code looks sane to me.
