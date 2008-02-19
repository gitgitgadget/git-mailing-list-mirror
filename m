From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/12] process_tree/blob: check for NULL
Date: Tue, 19 Feb 2008 13:31:06 -0800
Message-ID: <7vodaciqg5.fsf@gitster.siamese.dyndns.org>
References: <12033676833730-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832769-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832231-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832653-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676833341-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Tue Feb 19 22:32:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRa4b-0004Fq-Me
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 22:32:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754588AbYBSVbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 16:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760648AbYBSVbX
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 16:31:23 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63831 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754425AbYBSVbW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 16:31:22 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D09879BC;
	Tue, 19 Feb 2008 16:31:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 B976679B6; Tue, 19 Feb 2008 16:31:14 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74456>

Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:

> As these functions are directly called with the result
> from lookup_tree/blob, they must handle NULL.
>
> Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> ---
>  list-objects.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/list-objects.c b/list-objects.c
> index 4ef58e7..c8b8375 100644
> --- a/list-objects.c
> +++ b/list-objects.c
> @@ -18,6 +18,8 @@ static void process_blob(struct rev_info *revs,
>  
>  	if (!revs->blob_objects)
>  		return;
> +	if (!obj)
> +		die("bad blob object");
>  	if (obj->flags & (UNINTERESTING | SEEN))
>  		return;
>  	obj->flags |= SEEN;
> @@ -69,6 +71,8 @@ static void process_tree(struct rev_info *revs,
>  
>  	if (!revs->tree_objects)
>  		return;
> +	if (!obj)
> +		die("bad tree object");
>  	if (obj->flags & (UNINTERESTING | SEEN))
>  		return;
>  	if (parse_tree(tree) < 0)

I think these are in line with process_tree() that barfs like this:

	if (parse_tree(tree) < 0)
		die("bad tree object %s", sha1_to_hex(obj->sha1));

in the existing codepath, but these new die() callsites lose
information.

It would be nicer if we can report what entry (name) in which
tree object (sha1) lead to this die().  The same comment applies
to [09/12].

Nevertheless, this is an improvement compared to accessing
NULL->flags and dying with segv.  I'll queue.

Thanks.
