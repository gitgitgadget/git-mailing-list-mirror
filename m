From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] fast-export: Make sure we show actual ref names instead of "(null)"
Date: Mon, 22 Jun 2009 11:34:00 -0700
Message-ID: <7vk534azjb.fsf@alter.siamese.dyndns.org>
References: <1245676001-14734-1-git-send-email-newren@gmail.com>
	<1245676001-14734-3-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	kusmabite@gmail.com
To: newren@gmail.com
X-From: git-owner@vger.kernel.org Mon Jun 22 20:34:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIoLK-00077i-Hv
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 20:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090AbZFVSd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 14:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754131AbZFVSd7
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 14:33:59 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:61135 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090AbZFVSd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 14:33:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090622183401.VBLM17135.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 22 Jun 2009 14:34:01 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 76a01c00P4aMwMQ036a0pn; Mon, 22 Jun 2009 14:34:01 -0400
X-VR-Score: 0.00
X-Authority-Analysis: v=1.0 c=1 a=LFfzx-UKobkA:10 a=pGLkceISAAAA:8
 a=z9UNlR3YnSPBLdSQgx8A:9 a=qwbzNKyAEJM5qlUpGs-JApGmEEEA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122052>

newren@gmail.com writes:

> From: Elijah Newren <newren@gmail.com>
>
> Under some cases (e.g. 'git fast-export --parents master -- COPYING' run
> in git.git), the output included the lines
>   reset (null)
>   commit (null)
> instead of
>   reset refs/heads/master
>   commit refs/heads/master
> This simple change fixes that.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> (No change to this patch since the first series.)
> As noted above, run 'git fast-export --parents master -- COPYING' in
> git.git to see this bug triggered.

Isn't this easier to read?

> Under some cases (e.g. 'git fast-export --parents master -- COPYING' run
> in git.git), the output included the lines
>
>   reset (null)
>   commit (null)
>
> instead of
>
>   reset refs/heads/master
>   commit refs/heads/master
>
> This simple change fixes that.

The last line does not add much value.  I would have preferred to see
something like this while reviewing, so that I did not have to dig that
information out from the source myself:

	This is because the code expects commit->util to point at the ref
	but that is only set by the revision traversal machinery when
	show_source is asked, in a way similar to "--source" option of
	"git log" family of commands.

But otherwise, good catch.  Thanks.

>  builtin-fast-export.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-fast-export.c b/builtin-fast-export.c
> index 891e2d4..9aa409b 100644
> --- a/builtin-fast-export.c
> +++ b/builtin-fast-export.c
> @@ -531,6 +531,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
>  	get_tags_and_duplicates(&revs.pending, &extra_refs);
>  
>  	revs.topo_order = 1;
> +	revs.show_source = 1;
>  	if (prepare_revision_walk(&revs))
>  		die("revision walk setup failed");
>  	revs.diffopt.format_callback = show_filemodify;
> -- 
> 1.6.0.6
