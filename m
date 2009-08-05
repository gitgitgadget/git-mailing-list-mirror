From: Nicolas Pitre <nico@cam.org>
Subject: Re: Making git push output quieter
Date: Wed, 05 Aug 2009 15:51:27 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908051545300.16073@xanadu.home>
References: <200908042327.10912.aacid@kde.org>
 <3af572ac0908041520l327482f1u45121b6b991a3673@mail.gmail.com>
 <200908052113.06373.aacid@kde.org> <20090805192658.GI1033@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Albert Astals Cid <aacid@kde.org>,
	Junio C Hamano <gitster@pobox.com>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 21:51:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYmWd-00048e-75
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 21:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbZHETve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 15:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751903AbZHETve
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 15:51:34 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18653 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbZHETvd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 15:51:33 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KNX00MXI5B7HXW0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 05 Aug 2009 15:40:20 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090805192658.GI1033@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124957>

On Wed, 5 Aug 2009, Shawn O. Pearce wrote:

> Albert Astals Cid <aacid@kde.org> wrote:
> > A Dimecres, 5 d'agost de 2009, Pau Garcia i Quiles va escriure:
> > > On Tue, Aug 4, 2009 at 11:27 PM, Albert Astals Cid<aacid@kde.org> wrote:
> > > > Hi, at KDE we are starting to try to use git and one of the things that's
> > > > bothering me is that git push is too verbose for our scripts.
> ...
> > > Have you tried redirecting only stdout to /dev/null, and keeping
> > > stderr to yourself ?
> > 
> > Everything goes to stderr.
> 
> Sadly our use of isatty to determine if progress/verbosity should
> be used is inconsistent.  pack-objects.c, which is what you are
> talking about above, is using stderr to determine if progress should
> be enabled, but other code like transport.c, which is used on the
> client side, is using stdout.  Hence the suggestion above to redirect
> stdout to /dev/null to try and shutoff the spew.
> 
>   $ git grep isatty
>   builtin-commit.c:		if (isatty(0))
>   builtin-config.c:			stdout_is_tty = isatty(1);
>   builtin-pack-objects.c:	progress = isatty(2);
>   builtin-revert.c:	if (isatty(0))
>   builtin-shortlog.c:	if (!nongit && !rev.pending.nr && isatty(0))
>   builtin-unpack-objects.c:	quiet = !isatty(2);
>   color.c:		stdout_is_tty = isatty(1);
>   compat/winansi.c:	if (!isatty(fileno(stream)))
>   compat/winansi.c:	if (!isatty(fileno(stream)))
>   pack-redundant.c:	if (!isatty(0)) {
>   pager.c:	if (!isatty(1))
>   pager.c:	if (isatty(2))
>   transport.c:	args.no_progress = args.quiet || (!transport->progress && !isatty(1));
>   wt-status.c:	 * will have checked isatty on stdout).
> 
> I'm thinking this might be a reasonable patch to apply, Junio/Nico?
> 
> --8<--
> pack-objects: Display progress only if stdout is tty
> 
> Client transports underneath git fetch display progress output only
> if stdout is a tty, allowing redirection of stdout to /dev/null (or
> a pipe) to silence progress but still report actual errors on stderr.
> 
> Doing the same in pack-objects means push, bundle creation and
> repack can use the same trick to silence noisy progress progress,
> but still obtain real errors.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  builtin-pack-objects.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index 961b639..0b9234a 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -2110,7 +2110,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  	if (!pack_compression_seen && core_compression_seen)
>  		pack_compression_level = core_compression_level;
>  
> -	progress = isatty(2);
> +	progress = isatty(1);

Doesn't this break progress reporting on a push since stdout is never a 
tty in that case?  Same issue on a fetch although in that case the 
progress level is provided explicitly by the caller.



>  	for (i = 1; i < argc; i++) {
>  		const char *arg = argv[i];
>  
> -- 
> 1.6.4.70.g9c084
> 
> 
> -- 
> Shawn.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
