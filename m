From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] git push: Push nothing if no refspecs are given or
 configured
Date: Fri, 6 Mar 2009 11:37:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903061126550.10279@pacific.mpi-cbg.de>
References: <20090305221529.GA25871@pvv.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Andreas Ericsson <ae@op5.se>
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 11:37:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfXQo-0003E4-GW
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 11:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbZCFKgC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 05:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbZCFKgA
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 05:36:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:60096 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751233AbZCFKf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 05:35:59 -0500
Received: (qmail invoked by alias); 06 Mar 2009 10:35:56 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp012) with SMTP; 06 Mar 2009 11:35:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/53mdZ24b5ClQcQxBK2to3Pos7YPbbqAQhN4slDp
	cTKi5U+JWB+A2k
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090305221529.GA25871@pvv.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112417>

Hi,

Disclaimer: if you are offended by constructive criticism, or likely to 
answer with insults to the comments I offer, please stop reading this mail 
now (and please do not answer my mail, either). :-)

Still with me?  Good.  Nice to meet you.

Just for the record: responding to a patch is my strongest way of saying 
that I appreciate your work.

On Thu, 5 Mar 2009, Finn Arne Gangstad wrote:

> Previously, git push [remote] with no arguments would behave like
> "git push <remote> :" if no push refspecs were configured for the remote.
> It may be too easy for novice users to write "git push" or
> "git push origin" by accident, so git will now push nothing, and give an
> error message in such cases.
> 
> Teach git push a new option "--matching" that keeps the old behavior of
> pushing all matching branches when none are configured.

As others have commented, you cannot just go and fsck existing users over.  
That is just not flying well.

IMHO you should always consider the downsides of your patch in addition to 
the upsides, and not only for yourself, but also for others.

> @@ -63,10 +63,11 @@ the remote repository.
>  The special refspec `:` (or `{plus}:` to allow non-fast forward updates)
>  directs git to push "matching" branches: for every branch that exists on
>  the local side, the remote side is updated if a branch of the same name
> -already exists on the remote side.  This is the default operation mode
> +already exists on the remote side. Nothing will be pushed

The two spaces after the full stop were not actually a typo.

>  if no explicit refspec is found (that is neither on the command line
>  nor in any Push line of the corresponding remotes file---see below).
>  
> +
>  --all::

Please do not change the style of the surrounding text.  We do not have 
double empty lines there.

> diff --git a/builtin-push.c b/builtin-push.c
> index 122fdcf..ffc648d 100644
> --- a/builtin-push.c
> +++ b/builtin-push.c
> @@ -48,6 +48,12 @@ static void set_refspecs(const char **refs, int nr)
>  	}
>  }
>  
> +
> +static int has_multiple_bits(unsigned int x)
> +{
> +	return (x & (x - 1)) != 0;
> +}
> +
>  static int do_push(const char *repo, int flags)

To spare you searching: HAS_MULTI_BITS(x) (it is defined in 
git-compat-util.h).

And by removing your function, you also remove another double empty line.

> @@ -71,17 +77,24 @@ static int do_push(const char *repo, int flags)
>  		return error("--mirror can't be combined with refspecs");
>  	}
>  
> -	if ((flags & (TRANSPORT_PUSH_ALL|TRANSPORT_PUSH_MIRROR)) ==
> -				(TRANSPORT_PUSH_ALL|TRANSPORT_PUSH_MIRROR)) {
> -		return error("--all and --mirror are incompatible");
> +	if (has_multiple_bits(flags & (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR | TRANSPORT_PUSH_MATCHING))) {
> +		return error("--all, --mirror and --matching are incompatible");

These are awfully long lines.  Not so good.

>  	}
>  
> -	if (!refspec
> -		&& !(flags & TRANSPORT_PUSH_ALL)
> -		&& remote->push_refspec_nr) {
> -		refspec = remote->push_refspec;
> -		refspec_nr = remote->push_refspec_nr;
> +	if ((flags & TRANSPORT_PUSH_MATCHING)  && refspec) {
> +		return error("--matching cannot be combined with refspecs");
>  	}
> +
> +

Yet another double empty line.

> +	if (!refspec && !(flags & TRANSPORT_PUSH_ALL)) {
> +		if (remote->push_refspec_nr) {
> +			refspec = remote->push_refspec;
> +			refspec_nr = remote->push_refspec_nr;
> +		} else if (!(flags & TRANSPORT_PUSH_MATCHING)) {
> +			return error("No refspecs given and none configured for %s, nothing to push.", remote->name);
> +		}

Long line and surplus curly brackets.

Just to make it clear, because many people misunderstand my comments: I 
would not have spent my precious time writing this email if I did not 
think that --matching is something we want to have.

Ciao,
Dscho
