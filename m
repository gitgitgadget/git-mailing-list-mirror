From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/17] path.c: drop git_path_submodule
Date: Tue, 11 Aug 2015 05:53:18 -0400
Message-ID: <20150811095318.GB10238@sigill.intra.peff.net>
References: <20150810092731.GA9027@sigill.intra.peff.net>
 <20150810093627.GJ30981@sigill.intra.peff.net>
 <xmqqfv3qu5a7.fsf@gitster.dls.corp.google.com>
 <xmqqbneeu4ys.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 11:53:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZP6FV-0002Np-0F
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 11:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078AbbHKJx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 05:53:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:43520 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964968AbbHKJxX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 05:53:23 -0400
Received: (qmail 25156 invoked by uid 102); 11 Aug 2015 09:53:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Aug 2015 04:53:23 -0500
Received: (qmail 14070 invoked by uid 107); 11 Aug 2015 09:53:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Aug 2015 05:53:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Aug 2015 05:53:18 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbneeu4ys.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275678>

On Mon, Aug 10, 2015 at 03:57:31PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Jeff King <peff@peff.net> writes:
> >
> >> There are no callers of the slightly-dangerous static-buffer
> >> git_path_submodule left. Let's drop it.
> >
> > There are a few callers added on 'pu', though.
> 
> Actually there is only one.  Here is a proposed evil merge.

Thanks for catching. I (obviously) only checked against 'next' and not
'pu'. Rather than the evil merge, we could also just drop this patch.
And then either leave it be, or fix this one up as a separate topic once
merged. Though it really looks like this call site is potentially
dangerous, with the assignment (I think it is OK, though, because
read_info_alternates does not use git_path itself).

> diff --git a/submodule.c b/submodule.c
> index dfe8b7b..7ab08a1 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -120,34 +120,35 @@ void stage_updated_gitmodules(void)
>  static int add_submodule_odb(const char *path)
> [...]
>  {
>  	struct alternate_object_database *alt_odb;
> -	const char *objects_directory;
> +	struct strbuf objects_directory = STRBUF_INIT;
>  	int ret = 0;
>  
> -	objects_directory = git_path_submodule(path, "objects/");
> -	if (!is_directory(objects_directory)) {
> +	strbuf_git_path_submodule(&objects_directory, "objects/", "%s", path);
> +	if (!is_directory(objects_directory.buf)) {
>  		ret = -1;
>  		goto done;
>  	}

Hmph, the change in 6659e74 would have been a lot nicer if
strbuf_git_path_submodule were already available. Most of what you are
doing here is undoing that commit's strbuf/buf transition. :-/

>  	/* avoid adding it twice */
>  	for (alt_odb = alt_odb_list; alt_odb; alt_odb = alt_odb->next)
> -		if (alt_odb->name - alt_odb->base == strlen(objects_directory) &&
> -				!strcmp(alt_odb->base, objects_directory))
> +		if (alt_odb->name - alt_odb->base == objects_directory.len &&
> +				!strcmp(alt_odb->base, objects_directory.buf))
>  			goto done;

Not really relevant to what we're talking about here, but this is the
first time I've lookd at add_submodule_odb. It really looks like the
whole second half of the function could be replaced with a call to
link_alt_odb_entry.

-Peff
