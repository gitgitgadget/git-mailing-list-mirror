From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCHv3] fetch: Use the remote's ref name to decide how to describe
 new refs.
Date: Mon, 16 Apr 2012 16:21:14 -0400
Message-ID: <4F8C7F3A.9070801@xiplink.com>
References: <1334591542-25136-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Mon Apr 16 22:21:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJsQI-0003Vs-II
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 22:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970Ab2DPUVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 16:21:12 -0400
Received: from smtp142.dfw.emailsrvr.com ([67.192.241.142]:52700 "EHLO
	smtp142.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168Ab2DPUVL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 16:21:11 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp4.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id A5A2EB0DA0
	for <git@vger.kernel.org>; Mon, 16 Apr 2012 16:21:10 -0400 (EDT)
X-Virus-Scanned: OK
Received: from smtp146.ord.emailsrvr.com (smtp146.ord.emailsrvr.com [173.203.6.146])
	by smtp4.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTPS id 69B8DB1000
	for <git@vger.kernel.org>; Mon, 16 Apr 2012 16:21:10 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp16.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 26B9D3B80ED;
	Mon, 16 Apr 2012 16:20:36 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp16.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id AA2B23B8110;
	Mon, 16 Apr 2012 16:20:35 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
In-Reply-To: <1334591542-25136-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195687>

Apologies - this breaks quite a few tests!

For example, t1507-rev-parse-upstream.sh test 5 segfaults.

I'll take another stab at it...

		M.


On 12-04-16 11:52 AM, marcnarc@xiplink.com wrote:
> From: Marc Branchaud <marcnarc@xiplink.com>
> 
> Also, only call a new ref a "branch" if it's under refs/heads/.
> 
> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
> ---
> 
> Re-rolled to work with the remote's ref names.
> 
> As before, this is atop of Jens's submodule-recursion fix.
> 
> Technically there are now 3 different changes in this patch:
> 	1. Switch to using remote ref names.
> 	2. Use prefixcomp() consistently.
> 	3. Only call a new ref a "branch" if its' under refs/heads.
> 
> Should I split this up?
> 
> 		M.
> 
> 
>  builtin/fetch.c |   13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index cfb43df..063c63b 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -293,14 +293,23 @@ static int update_local_ref(struct ref *ref,
>  		const char *msg;
>  		const char *what;
>  		int r;
> -		if (!strncmp(ref->name, "refs/tags/", 10)) {
> +		/*
> +		 * Nicely describe what we're fetching.
> +		 * Base this on the remote's ref names, as they're
> +		 * more likely to follow a standard layout.
> +		 */
> +		if (!prefixcmp(ref->peer_ref->name, "refs/tags/")) {
>  			msg = "storing tag";
>  			what = _("[new tag]");
>  		}
> -		else {
> +		else if (!prefixcmp(ref->peer_ref->name, "refs/heads/")) {
>  			msg = "storing head";
>  			what = _("[new branch]");
>  		}
> +		else {
> +			msg = "storing ref";
> +			what = _("[new ref]");
> +		}
>  
>  		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
>  		    (recurse_submodules != RECURSE_SUBMODULES_ON))
