From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 02/13] Use an external program to implement fetching with
 curl
Date: Fri, 7 Aug 2009 01:34:04 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908070111410.2147@iabervon.org>
References: <alpine.LNX.2.00.0908050053580.2147@iabervon.org> <alpine.DEB.1.00.0908051206460.8306@pacific.mpi-cbg.de> <alpine.LNX.2.00.0908051145250.2147@iabervon.org> <7v63d06wjq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 07:34:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZI5p-00042G-46
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 07:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320AbZHGFeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 01:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbZHGFeF
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 01:34:05 -0400
Received: from iabervon.org ([66.92.72.58]:59516 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810AbZHGFeE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 01:34:04 -0400
Received: (qmail 24449 invoked by uid 1000); 7 Aug 2009 05:34:04 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Aug 2009 05:34:04 -0000
In-Reply-To: <7v63d06wjq.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125181>

On Thu, 6 Aug 2009, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Wed, 5 Aug 2009, Johannes Schindelin wrote:
> >
> >> Ooops, I missed this part.  How about making git-remote-https and 
> >> git-remote-ftp hardlinks to git-remote-http?
> >
> > Sure. Is "ln ... || ln -s ... || cp ..." the right way to do this 
> > cross-platform?
> 
> I've queued the first three from this series to 'next' (and the rest to
> 'pu'), as I wanted to give wider testing to the smaller footprint git with
> the libcurl-less-ness they bring in, with Linus's standalone SHA-1.
> 
> Since then two fix-ups (adding git-remote-* to .gitignore and the
> dependency fix to git-http-fetch) were posted to the list, which I also
> rebased in to the series, making the total number of patches merged to
> 'next' from the series 5.
>
> If there are major changes/rewrites/redesign in the remaining part of the
> series that are only in 'pu', please feel free to either send incrementals
> or replacements.

Great. Johannes had a bunch of suggestions for making it less error-prone 
to extend, which I hope to get to this weekend.

> I do not think I've seen any issues raised but unresolved against the part
> from this series already in 'next', other than that this builds three
> copies of git-remote-* programs based on libcurl.  I'll rebase a patch
> like this in after the Makefile fixup ae209bd (http-fetch: Fix Makefile
> dependancies, 2009-08-06) and queue the result to 'next'.

I think there were remaining improvements (e.g., transport-helper.c could 
write commands with strbufs), but nothing that couldn't just as well be 
applied afterwards.

> I suspect that the "install" target may need a patch similar to this one,
> though...

Ah, yes, avoiding the duplication in the build directory isn't a big win 
if the installed location doesn't get links.

> -- >8 --
> Subject: Makefile: do not link three copies of git-remote-* programs
> 
> Instead, link only one and make the rest hardlinks/copies, like we do for
> the built-ins. 
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  Makefile |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 2900057..38924f2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1256,6 +1256,7 @@ ifndef V
>  	QUIET_LINK     = @echo '   ' LINK $@;
>  	QUIET_BUILT_IN = @echo '   ' BUILTIN $@;
>  	QUIET_GEN      = @echo '   ' GEN $@;
> +	QUIET_LNCP     = @echo '   ' LN/CP $@;
>  	QUIET_SUBDIR0  = +@subdir=
>  	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
>  			 $(MAKE) $(PRINT_DIR) -C $$subdir
> @@ -1494,10 +1495,16 @@ git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
>  		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
>  
> -git-remote-http$X git-remote-https$X git-remote-ftp$X: remote-curl.o http.o http-walker.o $(GITLIBS)
> +git-remote-http$X: remote-curl.o http.o http-walker.o $(GITLIBS)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
>  		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
>  
> +git-remote-https$X git-remote-ftp$X: git-remote-http$X
> +	$(QUIET_LNCP)$(RM) $@ && \
> +	ln git-remote-http$X $@ 2>/dev/null || \
> +	ln -s  git-remote-http$X $@ 2>/dev/null || \
> +	cp git-remote-http$X $@

Maybe "$<" for "git-remote-http$X", since that would make the rule portion 
generic.
