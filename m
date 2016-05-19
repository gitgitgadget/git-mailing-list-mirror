From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/6] upload-pack: provide a hook for running pack-objects
Date: Wed, 18 May 2016 20:14:33 -0400
Message-ID: <20160519001433.GB22543@sigill.intra.peff.net>
References: <20160518223712.GA18317@sigill.intra.peff.net>
 <20160518224537.GF22443@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 02:15:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3Bcg-0006es-8n
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 02:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbcESAOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 20:14:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:41602 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751140AbcESAOg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 20:14:36 -0400
Received: (qmail 5282 invoked by uid 102); 19 May 2016 00:14:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 20:14:35 -0400
Received: (qmail 28093 invoked by uid 107); 19 May 2016 00:14:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 20:14:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 May 2016 20:14:33 -0400
Content-Disposition: inline
In-Reply-To: <20160518224537.GF22443@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295030>

On Wed, May 18, 2016 at 06:45:37PM -0400, Jeff King wrote:

> @@ -93,6 +94,14 @@ static void create_pack_file(void)
>  	int i;
>  	FILE *pipe_fd;
>  
> +	if (!pack_objects_hook)
> +		pack_objects.git_cmd = 1;
> +	else {
> +		argv_array_push(&pack_objects.args, pack_objects_hook);
> +		argv_array_push(&pack_objects.args, "git");
> +		pack_objects.use_shell = 1;
> +	}

I waffled on the "shell" thing here. It's more flexible, and matches
other commands we let the user specify (like diff.external). But it also
makes it harder to do more hook-like things, like "run this hook if it
exists and has the executable bit set".

So should it just be a path to a single command/script?

With the shell thing, you can set it to:

  test -e /path/to/script && /path/to/script ...

if you want, but that's a little more arcane (and incurs an extra shell
invocation that we could otherwise skip).

And on the same note, if it _were_ just path-to-script, would we want it
to skip the hook if it's missing or not executable? For normal hooks, if
that's the case, we know it's because the user doesn't want to use the
hook. But here, the user has taken an overt action to tell us about the
hook; would it be surprising if we silently skipped it because it wasn't
available?

I like that it would "fail open", so a misconfiguration doesn't break a
server. But maybe people would find that off-putting.

-Peff
