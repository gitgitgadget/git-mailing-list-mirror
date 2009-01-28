From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add -u: do not fail to resolve a path as deleted
Date: Wed, 28 Jan 2009 15:32:53 -0800
Message-ID: <7viqnzj9ay.fsf@gitster.siamese.dyndns.org>
References: <7vbptrkqvb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 00:35:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSJwD-00061K-Kc
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 00:35:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758312AbZA1XdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 18:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758303AbZA1XdA
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 18:33:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52558 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757899AbZA1Xc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 18:32:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 26D0E94DF1;
	Wed, 28 Jan 2009 18:32:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 55DA294DF0; Wed,
 28 Jan 2009 18:32:55 -0500 (EST)
In-Reply-To: <7vbptrkqvb.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 28 Jan 2009 14:28:08 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FE2F1494-ED93-11DD-B360-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107600>

Junio C Hamano <gitster@pobox.com> writes:

> After you resolve a conflicted merge to remove the path, "git add -u"
> failed to record the removal.  Instead it errored out by saying that the
> removed path is not found in the work tree, but that is what the user
> wanted to do and failing it is illogical.
>
> This fixes it.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  read-cache.c          |    5 +++++
>  t/t2200-add-update.sh |   20 +++++++++++++++++++-
>  2 files changed, 24 insertions(+), 1 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index b1475ff..ddc0586 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1574,6 +1574,11 @@ static void update_callback(struct diff_queue_struct *q,
>  		default:
>  			die("unexpected diff status %c", p->status);
>  		case DIFF_STATUS_UNMERGED:
> +			/*
> +			 * diff-files gives U followed by the work tree state
> +			 * such as M or D, so we can ignore this.
> +			 */
> +			continue;

This is wrong; breaks t3702.
