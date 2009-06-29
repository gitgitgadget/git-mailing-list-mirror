From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mailinfo: Remove only one set of square brackets
Date: Mon, 29 Jun 2009 09:09:38 -0700
Message-ID: <7v8wjbc98d.fsf@alter.siamese.dyndns.org>
References: <4A488F07.10002@op5.se>
	<1246269351-26929-1-git-send-email-ae@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Jun 29 18:11:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLJQQ-0001e8-TB
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 18:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756317AbZF2QJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 12:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754367AbZF2QJg
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 12:09:36 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:52982 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753789AbZF2QJf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 12:09:35 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090629160939.IZRB17670.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 29 Jun 2009 12:09:39 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9s9e1c00B4aMwMQ03s9eix; Mon, 29 Jun 2009 12:09:38 -0400
X-VR-Score: -300.00
X-Authority-Analysis: v=1.0 c=1 a=gm673s5H4ZoA:10 a=CDGEgIx3jfoXWOpLQgwA:9
 a=Z6ZrlLey-vwi-PKfW_8A:7 a=004iQhy1pj73HpuHK7QTiwhyrkEA:4
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122445>

Andreas Ericsson <ae@op5.se> writes:

> git-format-patch prepends patches with a [PATCH x/n] prefix, but
> mailinfo used to remove any number of square-bracket pairs and
> the content between them. This prevents one from using a commit
> subject like this:
>
>   [ and ] must be allowed as input
>
> Removing the square bracket pair from this rather clumsily
> constructed subject line loses important information, so we must
> take care not to.
>
> This patch causes the subject stripping to stop after it has
> encountered one pair of square brackets.
>
> One possible downside of this patch is that the patch-handling
> programs will now fail at removing author-added square-brackets
> to be removed, such as
>
>   [RFC][PATCH x/n]
>
> However, since format-patch only adds one set of square brackets,
> this behaviour is quite easily undesrstood and defended while the
> previous behaviour is not.
>
> Signed-off-by: Andreas Ericsson <ae@op5.se>
> ---

All good points, and I like this one, including its Subject: line.

>  builtin-mailinfo.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
> index 92637ac..fb5ad70 100644
> --- a/builtin-mailinfo.c
> +++ b/builtin-mailinfo.c
> @@ -221,6 +221,8 @@ static void cleanup_subject(struct strbuf *subject)
>  {
>  	char *pos;
>  	size_t remove;
> +	int brackets_removed = 0;
> +
>  	while (subject->len) {
>  		switch (*subject->buf) {
>  		case 'r': case 'R':
> @@ -235,10 +237,15 @@ static void cleanup_subject(struct strbuf *subject)
>  			strbuf_remove(subject, 0, 1);
>  			continue;
>  		case '[':
> +			/* remove only one set of square brackets */
> +			if (brackets_removed)
> +				break;
> +
>  			if ((pos = strchr(subject->buf, ']'))) {
>  				remove = pos - subject->buf;
>  				if (remove <= (subject->len - remove) * 2) {
>  					strbuf_remove(subject, 0, remove + 1);
> +					brackets_removed = 1;
>  					continue;
>  				}
>  			} else
> -- 
> 1.6.3.3.354.gfb24
