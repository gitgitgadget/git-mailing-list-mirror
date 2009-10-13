From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC PATCH v2 08/16] remote-helpers: Support custom transport
 options
Date: Tue, 13 Oct 2009 00:23:23 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910122357230.32515@iabervon.org>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org> <1255400715-10508-9-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 06:30:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxZ20-00004s-LR
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 06:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbZJMEYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 00:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbZJMEYA
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 00:24:00 -0400
Received: from iabervon.org ([66.92.72.58]:39629 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497AbZJMEYA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 00:24:00 -0400
Received: (qmail 5473 invoked by uid 1000); 13 Oct 2009 04:23:23 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Oct 2009 04:23:23 -0000
In-Reply-To: <1255400715-10508-9-git-send-email-spearce@spearce.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130125>

On Mon, 12 Oct 2009, Shawn O. Pearce wrote:

> Some transports, like the native pack transport implemented by
> fetch-pack, support useful features like depth or include tags.
> These should be exposed if the underlying helper knows how to
> use them and is based upon the same infrastructure.
>
> Helpers must advertise the options they support, any attempt
> to set an unsupported option will cause a failure.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> CC: Daniel Barkalow <barkalow@iabervon.org>
> ---
>  Documentation/git-remote-helpers.txt |   20 ++++++++++
>  remote-curl.c                        |   16 ++++++-
>  transport-helper.c                   |   70 ++++++++++++++++++++++++++++++++++
>  3 files changed, 103 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
> index e10ce99..334ab30 100644
> --- a/Documentation/git-remote-helpers.txt
> +++ b/Documentation/git-remote-helpers.txt
> @@ -46,6 +46,7 @@ Supported if the helper has the "fetch" capability.
>  'fetch-multiple'::
>  	Fetches multiple objects at once.  The fetch-multiple
>  	command is followed by one or more 'fetch' lines as above,
> +	zero or more 'option' lines for the supported options,
>  	and then a blank line to terminate the batch.  Outputs a
>  	single blank line when the entire batch is complete.
>  	Optionally may output a 'lock <file>' line indicating a
> @@ -69,6 +70,9 @@ CAPABILITIES
>  'fetch-multiple'::
>  	This helper supports the 'fetch-multiple' command.
>  
> +'option' <name>::
> +	This helper supports the option <name> under fetch-multiple.
> +

I'm a bit surprised that the options only apply in a fetch-multiple 
section, rather than getting set at the beginning and applying to 
everything for that run. At least, I think an "option" command should be 
useable outside of a fetch-multiple (or possible future grouping 
construct) and have global scope.

>  REF LIST ATTRIBUTES
>  -------------------
>  
> @@ -76,10 +80,26 @@ None are defined yet, but the caller must accept any which are supplied.
>  
>  FETCH OPTIONS
>  -------------
> +To enable an option the helper must list it in 'capabilities'.
>  
>  'option verbose'::
>  	Print more verbose activity messages to stderr.

I think you mis-split the above part; your previoud patch declared this 
option without declaring any way to use it. Might be worth allowing 
multiple "verboses" and "quiet" or "option verbosity quiet"/"option 
verbosity verbose verbose".

> +'option uploadpack' <command>::
> +	The program to use on the remote side to generate a pack.

I sort of feel like the helper ought to read this one out of the config 
file itself if it wants it. In general, it would be good to have 
transport.c and remote.c out of the business of knowing this sort of 
protocol-specific (albiet specific now to two protocols) information. (Of 
course, the native protocol's transport methods are in transport.c, so 
that's there, but I'd like to move that to a transport-native.c someday.)

> +'option depth' <depth>::
> +	Deepen the history of a shallow repository.
> +
> +'option keep'::
> +	Keep the transferred pack(s) with .keep files.
> +
> +'option followtags'::
> +	Aggressively fetch annotated tags if possible.

I assume this means to fetch tags which annotate objects we have or are 
fetching? (As opposed to fetching any annotated tag we could possibly 
fetch, even if we don't otherwise care about the tag or the thing it 
tags.) It's obvious in the context of git's config options, but I'd like 
this document to avoid assuming that context, and the option could apply 
more generally.

> +
> +'option thin'::
> +	Transfer the data as a thin pack if possible.

Does anyone still use non-default thinness? 

	-Daniel
*This .sig left intentionally blank*
