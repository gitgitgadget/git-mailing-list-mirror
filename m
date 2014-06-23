From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 04/16] refactor skip_prefix to return a boolean
Date: Mon, 23 Jun 2014 17:07:55 -0400
Message-ID: <20140623210755.GA15766@sigill.intra.peff.net>
References: <20140618194117.GA22269@sigill.intra.peff.net>
 <20140618194417.GD22622@sigill.intra.peff.net>
 <xmqq1tufcvfl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 23:08:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzBT7-0005lP-R8
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 23:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887AbaFWVH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 17:07:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:49857 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753864AbaFWVH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 17:07:57 -0400
Received: (qmail 14192 invoked by uid 102); 23 Jun 2014 21:07:57 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 Jun 2014 16:07:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jun 2014 17:07:55 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1tufcvfl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252368>

On Mon, Jun 23, 2014 at 11:50:06AM -0700, Junio C Hamano wrote:

> I was re-reading this and noticed another possible bug.
> 
>  builtin/clone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index b12989d..df659dd 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -696,7 +696,7 @@ static void write_refspec_config(const char* src_ref_prefix,
>  	if (option_mirror || !option_bare) {
>  		if (option_single_branch && !option_mirror) {
>  			if (option_branch) {
> -				if (strstr(our_head_points_at->name, "refs/tags/"))
> +				if (starts_with(our_head_points_at->name, "refs/tags/"))
>  					strbuf_addf(&value, "+%s:%s", our_head_points_at->name,
>  						our_head_points_at->name);
>  				else
> 
> Because the pattern is not anchored to the left with a slash, it is
> clear that the original cannot even claim that it was trying to
> munge "foo/refs/tags/" as well.

Yeah, the strstr seems very wrong there. Even with the "/", why would
you want to match "refs/heads/refs/tags/"?

> Which means this is trivially correct, but at the same time I wonder
> what it means for our-head to point at a ref in refs/tags/ hierarchy.

I think it is for "git clone --branch=v1.0". We create a refspec pulling
v1.0 to its local tag in that case (as opposed to to something in
"refs/remotes/origin/").  So I really think this does want to be
starts_with.

-Peff
