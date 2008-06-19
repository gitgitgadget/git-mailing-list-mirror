From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] graph.c: make many functions static
Date: Thu, 19 Jun 2008 12:16:11 -0700
Message-ID: <7vhcbptev8.fsf@gitster.siamese.dyndns.org>
References: <20080619082110.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org, Adam Simpkins <adam@adamsimpkins.net>
To: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 21:17:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9PdT-0004Fw-A5
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 21:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059AbYFSTQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 15:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752659AbYFSTQg
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 15:16:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42982 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbYFSTQf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 15:16:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 827681BB27;
	Thu, 19 Jun 2008 15:16:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 881821BB21; Thu, 19 Jun 2008 15:16:19 -0400 (EDT)
In-Reply-To: <20080619082110.6117@nanako3.lavabit.com> (nanako3@lavabit.com's
 message of "Thu, 19 Jun 2008 08:21:10 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 37BAE89C-3E34-11DD-AD0F-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85516>

しらいしななこ  <nanako3@lavabit.com> writes:

> These function are not used anywhere.  Also removes graph_release()
> that is never called.
>
> Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>

I CCed Adam, who is the primary author in this area.

> ---
>  graph.c |   57 +++++++++++++++++++++++++++++++++++++++++++--------------
>  graph.h |   40 ----------------------------------------
>  2 files changed, 43 insertions(+), 54 deletions(-)
>
> diff --git a/graph.c b/graph.c
> index e2633f8..5f82170 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -4,6 +4,43 @@
>  #include "diff.h"
>  #include "revision.h"
>  
> +/* Internal API */
> + ...
> +static int graph_next_line(struct git_graph *graph, struct strbuf *sb);
> +static void graph_padding_line(struct git_graph *graph, struct strbuf *sb);
> +static void graph_show_strbuf(struct git_graph *graph, struct strbuf const *sb);

I think these are probably fine, not in the sense that nobody calls these
functions _right now_ but in the sense that I do not foresee a calling
sequence outside the graph.c internal that needs to call these directly,
instead of calling graph_show_*() functions that use these.

> @@ -180,14 +217,6 @@ struct git_graph *graph_init(struct rev_info *opt)
>  	return graph;
>  }
>  
> -void graph_release(struct git_graph *graph)
> -{
> -	free(graph->columns);
> -	free(graph->new_columns);
> -	free(graph->mapping);
> -	free(graph);
> -}


But I do not think this is right.  The current lack of caller of this
clean-up function simply means the current users are leaking.  I think
they are all of "set up rev_info, do a lengthy operation and exit" pattern
and clean-up immediately before exit is often omitted as unnecessary, but
if we had a clean-up function for the revision API that function would
call this one.  I'd rather leave this in place, and let libification
minded people figure out the cleanest places and ways to make this
called.

Other three clean-ups looked Ok to me.  Thanks.
