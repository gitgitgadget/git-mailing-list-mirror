From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/11] git-fetch: Release objects used by a prior transport
Date: Fri, 09 Nov 2007 14:27:45 -0800
Message-ID: <7vve8bqcke.fsf@gitster.siamese.dyndns.org>
References: <20071109110626.GF19368@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 23:28:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqcKl-0001LG-60
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 23:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755271AbXKIW1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 17:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845AbXKIW1v
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 17:27:51 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:54960 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755270AbXKIW1u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 17:27:50 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 343322FB;
	Fri,  9 Nov 2007 17:28:12 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 2E95893C9A;
	Fri,  9 Nov 2007 17:28:09 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64267>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Some transports allocate objects in the internal object hashtable
> during the fetch process (e.g. the HTTP commit walker and also the
> native protocol).  These shouldn't be visible to another transport
> call running in the same fetch process when we fetch the tags during
> automated tag following.  By deallocating the object table (if it
> has anything in it) we ensure the second transport execution will
> be from a clean slate.
>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  builtin-fetch.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/builtin-fetch.c b/builtin-fetch.c
> index 847db73..18f123e 100644
> --- a/builtin-fetch.c
> +++ b/builtin-fetch.c
> @@ -337,7 +337,10 @@ static void store_updated_refs(const char *url, struct ref *ref_map)
>  
>  static int fetch_refs(struct transport *transport, struct ref *ref_map)
>  {
> -	int ret = transport_fetch_refs(transport, ref_map);
> +	int ret;
> +
> +	free_all_objects();
> +	ret = transport_fetch_refs(transport, ref_map);
>  	if (!ret)
>  		store_updated_refs(transport->url, ref_map);
>  	transport_unlock_pack(transport);

This sounds a very heavy-handed approach.

Is it the callers responsibility to know what function does call
free_all_objects() and makes sure there is no pointer to objects
obtained before the call that is used after the call returns?
