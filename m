From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] fast-export: Omit tags that tag trees
Date: Mon, 22 Jun 2009 11:33:53 -0700
Message-ID: <7vr5xcazji.fsf@alter.siamese.dyndns.org>
References: <1245676001-14734-1-git-send-email-newren@gmail.com>
	<1245676001-14734-2-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	kusmabite@gmail.com
To: newren@gmail.com
X-From: git-owner@vger.kernel.org Mon Jun 22 21:00:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIoke-0002W4-Ri
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 21:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbZFVTAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 15:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbZFVTAJ
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 15:00:09 -0400
Received: from fed1rmmtai101.cox.net ([68.230.241.4]:33524 "EHLO
	fed1rmmtai101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbZFVTAI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 15:00:08 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090622183353.NECT2915.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Mon, 22 Jun 2009 14:33:53 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 76Zt1c00F4aMwMQ046ZttR; Mon, 22 Jun 2009 14:33:53 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=iHwTGI-g0wwA:10 a=pGLkceISAAAA:8
 a=XuYsSuC0UejSej4H98AA:9 a=0dQm3evl-3Ax0KjfW-cA:7
 a=3N4waCrc58NGW95rmCSy75G5dD0A:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122054>

newren@gmail.com writes:

> From: Elijah Newren <newren@gmail.com>
>
> Commit c0582c53bcf4e83bba70e1ad23abbad31f96ebc8 introduced logic to just
> omit tags that point to tree objects.  However, a case was missed
> resulting in a tag being output which pointed at "mark :0", which would
> cause fast-import to crash.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> Includes changes suggested by Stephen Boyd (squashing commits together
> and moving the NEEDSWORK comment to where it is still relevant) and
> Johannes Sixt (fixing the testcase to remain in the right directory
> even if git init fails and to catch failures in git fast-export).
>
>  builtin-fast-export.c  |    8 +++++++-
>  t/t9301-fast-export.sh |    8 +++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/builtin-fast-export.c b/builtin-fast-export.c
> index 6cef810..891e2d4 100644
> --- a/builtin-fast-export.c
> +++ b/builtin-fast-export.c
> @@ -407,9 +407,15 @@ static void handle_tags_and_duplicates(struct string_list *extra_refs)
>  	for (i = extra_refs->nr - 1; i >= 0; i--) {
>  		const char *name = extra_refs->items[i].string;
>  		struct object *object = extra_refs->items[i].util;
> +		struct tag *tag;
>  		switch (object->type) {
>  		case OBJ_TAG:
> -			handle_tag(name, (struct tag *)object);
> +			tag = (struct tag *)object;
> +			if (tag->tagged->type == OBJ_TREE) {
> +				/* Ignore this tag altogether */
> +				return;
> +			}
> +			handle_tag(name, tag);
>  			break;

This seems to be the only callsite of handle_tag(), and I wonder why the
above special case is not in the called function instead.

If a newer version of fast-import ever supports a tag that points at
non-commits, a patch to add the corresponding support on the export side
logically should go to handle_tag(), no?
