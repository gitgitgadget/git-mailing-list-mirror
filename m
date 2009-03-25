From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] Document details of transport function APIs
Date: Tue, 24 Mar 2009 23:47:06 -0700
Message-ID: <7v63hy9k0l.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0903242303250.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 07:48:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmMuw-00014F-R3
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 07:48:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757505AbZCYGrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 02:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757594AbZCYGrQ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 02:47:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37651 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757041AbZCYGrP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 02:47:15 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F0C32A4D66;
	Wed, 25 Mar 2009 02:47:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B4DE8A4D65; Wed,
 25 Mar 2009 02:47:07 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0903242303250.19665@iabervon.org> (Daniel
 Barkalow's message of "Tue, 24 Mar 2009 23:04:10 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C4305172-1908-11DE-9656-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114570>

Daniel Barkalow <barkalow@iabervon.org> writes:

> In particular, explain which of the fields of struct ref is used for
> what purpose in the input to and output from each function.
>
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
>  transport.h |   38 ++++++++++++++++++++++++++++++++++++++
>  1 files changed, 38 insertions(+), 0 deletions(-)
>
> diff --git a/transport.h b/transport.h
> index 489e96a..2e1650a 100644
> --- a/transport.h
> +++ b/transport.h
> @@ -18,11 +18,49 @@ struct transport {
>  	int (*set_option)(struct transport *connection, const char *name,
>  			  const char *value);
>  
> +	/**
> +	 * Returns a list of the remote side's refs. In order to allow
> +	 * the transport to try to share connections, for_push is a
> +	 * hint as to whether the ultimate operation is a push or a fetch.
> +	 *

It is unclear what this "hint" is intended to be used for, what the
transport is and isn't allowed to use it for, and what existing transports
typically use it for.

> +	/**
> +	 * Push the objects and refs. Send the necessary objects, and
> +	 * then tell the remote side to update each ref in the list
> +	 * from old_sha1 to new_sha1.
> +	 *
> +	 * Where possible, set the status for each ref appropriately.
> +	 *
> +	 * If, in the process, the transport determines that the
> +	 * remote side actually responded to the push by updating the
> +	 * ref to a different value, the transport should modify the
> +	 * new_sha1 in the ref. (Note that this is a matter of the
> +	 * remote accepting but rewriting the change, not rejecting it
> +	 * and reporting that a different update had already taken
> +	 * place)
> +	 **/

It this even a sane thing to allow?  How would it interact with the
"pretend we immediately turned around and fetched them into the remote
tracking branches" local updates we usually do?

>  	int (*push_refs)(struct transport *transport, struct ref *refs, int flags);
>  	int (*push)(struct transport *connection, int refspec_nr, const char **refspec, int flags);
>  
> +	/** get_refs_list(), fetch(), and push_refs() can keep
> +	 * resources (such as a connection) reserved for futher
> +	 * use. disconnect() releases these resources.
> +	 **/
>  	int (*disconnect)(struct transport *connection);
>  	char *pack_lockfile;
>  	signed verbose : 2;

It is just a style thing, but all of our multi-line comments are

   /*
    * of
    * this
    * form
    */

and these new comments are formatted slightly differently with double
asterisks on only the first and the last lines.  In addition, th last
comment block uses a yet another different style, which is a bit of
eyesore.
