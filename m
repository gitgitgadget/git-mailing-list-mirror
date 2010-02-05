From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] make git push --dry-run --porcelain exit with
 status 0 even if updates will be rejected
Date: Fri, 5 Feb 2010 14:56:44 -0500
Message-ID: <20100205195644.GE24474@coredump.intra.peff.net>
References: <20100205150638.GB14116@coredump.intra.peff.net>
 <1265398462-17316-3-git-send-email-larry@elder-gods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Fri Feb 05 20:56:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdUIL-0005Je-Rz
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 20:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933753Ab0BET4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 14:56:44 -0500
Received: from peff.net ([208.65.91.99]:47741 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932429Ab0BET4n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 14:56:43 -0500
Received: (qmail 27671 invoked by uid 107); 5 Feb 2010 19:56:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 05 Feb 2010 14:56:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Feb 2010 14:56:44 -0500
Content-Disposition: inline
In-Reply-To: <1265398462-17316-3-git-send-email-larry@elder-gods.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139074>

On Fri, Feb 05, 2010 at 02:34:22PM -0500, Larry D'Anna wrote:

> diff --git a/builtin-send-pack.c b/builtin-send-pack.c
> index 76c7206..dfd7470 100644
> --- a/builtin-send-pack.c
> +++ b/builtin-send-pack.c
> @@ -478,6 +478,11 @@ int send_pack(struct send_pack_args *args,
>  		return ret;
>  	for (ref = remote_refs; ref; ref = ref->next) {
>  		switch (ref->status) {
> +		case REF_STATUS_REJECT_NONFASTFORWARD:
> +		case REF_STATUS_REJECT_NODELETE:
> +			if (args->porcelain && args->dry_run)
> +				break;
> +			return -1;
>  		case REF_STATUS_NONE:
>  		case REF_STATUS_UPTODATE:
>  		case REF_STATUS_OK:

Why just these two status flags? Based on your reasoning elsewhere, I
would assume the logic should be:

  - if we had some transport-related error, return failure

  - if not, then return success, as any ref's failure is already
    indicated in the porcelain output

So shouldn't it just be:

  if (args->porcelain && args->dry_run)
          return 0;

after we check for transport errors but before the loop that you are
modifying.

> -static int push_had_errors(struct ref *ref)
> +static int push_had_errors(struct ref *ref, int flags)
>  {
>  	for (; ref; ref = ref->next) {
>  		switch (ref->status) {
> +		case REF_STATUS_REJECT_NONFASTFORWARD:
> +		case REF_STATUS_REJECT_NODELETE:
> +			if (flags & TRANSPORT_PUSH_DRY_RUN && flags & TRANSPORT_PUSH_PORCELAIN)
> +				break;
> +			else
> +				return 1;

Ditto here.

-Peff
