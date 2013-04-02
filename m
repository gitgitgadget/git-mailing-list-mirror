From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] merge: a random object may not necssarily be a commit
Date: Tue, 2 Apr 2013 01:30:04 -0400
Message-ID: <20130402053004.GC22089@sigill.intra.peff.net>
References: <7v7gl3jmx0.fsf_-_@alter.siamese.dyndns.org>
 <1364846239-8802-1-git-send-email-gitster@pobox.com>
 <1364846239-8802-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Yann Droneaud <ydroneaud@opteya.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 07:30:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMtnr-0007DX-Vf
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 07:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760393Ab3DBFaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 01:30:09 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51707 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757146Ab3DBFaI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 01:30:08 -0400
Received: (qmail 6955 invoked by uid 107); 2 Apr 2013 05:31:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Apr 2013 01:31:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Apr 2013 01:30:04 -0400
Content-Disposition: inline
In-Reply-To: <1364846239-8802-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219742>

On Mon, Apr 01, 2013 at 12:57:17PM -0700, Junio C Hamano wrote:

> The user could have said "git merge $(git rev-parse v1.0.0)"; we
> shouldn't mark it as "Merge commit '15999998fb...'" as the merge
> name, even though such an invocation might be crazy.
> 
> We could even read the "tag " header from the tag object and replace
> the object name the user gave us, but let's not lose the information
> by doing so, at least not yet.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/merge.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 0ec8f0d..990e90c 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -516,6 +516,19 @@ static void merge_name(const char *remote, struct strbuf *msg)
>  		strbuf_release(&line);
>  		goto cleanup;
>  	}
> +
> +	if (remote_head->util) {
> +		struct merge_remote_desc *desc;
> +		desc = merge_remote_util(remote_head);
> +		if (desc && desc->obj && desc->obj->type == OBJ_TAG) {
> +			strbuf_addf(msg, "%s\t\t%s '%s'\n",
> +				    sha1_to_hex(desc->obj->sha1),
> +				    typename(desc->obj->type),
> +				    remote);
> +			goto cleanup;
> +		}
> +	}
> +
>  	strbuf_addf(msg, "%s\t\tcommit '%s'\n",
>  		sha1_to_hex(remote_head->object.sha1), remote);

I guess there is no other object type besides OBJ_TAG and OBJ_COMMIT
that would yield something we could merge, but it feels weird that you
check only for OBJ_TAG here, and otherwise still say "commit". Would the
intent be more clear if it just said:

  if (desc && desc->obj && desc->obj->type != OBJ_COMMIT) {
          ...

?

-Peff
