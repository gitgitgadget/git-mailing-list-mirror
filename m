From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Fw: git-core: SIGSEGV during {peek,ls}-remote on HTTP remotes.
Date: Sun, 1 Nov 2009 14:43:34 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911011348190.14365@iabervon.org>
References: <20091101.010702.527849118592864646._deepfire@feelingofgreen.ru> <7v8weq50pm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Samium Gromoff <_deepfire@feelingofgreen.ru>, git@vger.kernel.org,
	Tay Ray Chuan <rctay89@gmail.com>,
	Mike Hommey <mh@glandium.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 20:43:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4gL1-0001FX-HK
	for gcvg-git-2@lo.gmane.org; Sun, 01 Nov 2009 20:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325AbZKATnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2009 14:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753209AbZKATnb
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 14:43:31 -0500
Received: from iabervon.org ([66.92.72.58]:52088 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752112AbZKATna (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2009 14:43:30 -0500
Received: (qmail 16037 invoked by uid 1000); 1 Nov 2009 19:43:34 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Nov 2009 19:43:34 -0000
In-Reply-To: <7v8weq50pm.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131874>

On Sat, 31 Oct 2009, Junio C Hamano wrote:

> Samium Gromoff <_deepfire@feelingofgreen.ru> writes:
> 
> > Attached is the SEGV bugreport I sent to debian.
> 
> Thanks for a report.
> 
> There are two issues.
> 
>  * transport-helper.c::get_helper() assumes that the transport structure
>    always has its remote member filled and it can get name out of it.
>    This is the segv in the report.
> 
>  * Even if we work around the above issue, the helper subprocess (in this
>    case, remote-curl helper) insists on being inside a git repository,  To
>    satisfy ls-remote request, you do not have to be in one.
> 
> Attached is a minimum fix/work around, but this is done without being very
> familiar with the current assumptions in the codepaths involved.
> 
> Issues I want area experts to consider before coming up with the final fix
> are:
> 
>  - Should we fix get_helper() in transport-helper.c, instead of touching
>    ls-remote.c like this patch does?
> 
>    This issue really boils down to this question: is it valid for a
>    transport to have NULL in its remote field, and should all the code
>    that touch transport be prepared to deal with such a transport
>    structure?

I think there's no benefit to allowing NULL for the remote; I think you 
can always get a struct remote for what you want to access. So it's 
probably just as well to require it, particularly because, as in the case 
of cmd_ls_remote() below, you'd need a special case to not get a struct 
remote.

Is there any way in which the intended semantics of "transport_get(NULL, 
url)" is not the same as "transport_get(remote_get(url), url)"?

(And, in the extended series, I make "transport_get(remote_get(url), 
NULL)" also mean the same thing as above, while "transport_get(NULL, 
NULL)" is obviously underspecified.)

>  - When helping to handle ls-remote request, there is no need for the
>    helper to know anything about the local state.  We probably shouldn't
>    even run setup_git_directory_gently() at all in this case.  But when
>    helping other kinds of request, the helper does need to know where our
>    repository is.
> 
>    In general, what should the initial environment for helpers be?  Should
>    they assume that they have to figure out where the git repository is
>    themselves (in other words, should they assume they cannot rely on
>    anything the caller does before they are called?  Would the caller
>    generally have done the usual repo discovery (including chdir() to the
>    toplevel), and there are some set of assumptions they can make?  If so
>    what are they?

Probably, the helper should be run with a predicable initial environment, 
simply because operations that use remote repositories are most often run 
from the toplevel of a repo, so people will fail to notice their bugs 
which trigger on running from subdirectories. If it's possible for the 
core git code to enforce regularity here, these oversights aren't bugs. 
That is, I think people working on helpers will assume that they always 
run from the environment that they run from the first time they try, 
whether or not they're supposed to assume this, and we can save a lot of 
trouble by making it okay.

Perhaps we should actively tell the helper if there is no git repository 
(or, if any git repository we happen to be in is merely coincidental and 
shouldn't affect the helper)? Helpers involving importing will probably 
want to know they don't have a private refs namespace, private state 
directory, etc. even for implementing "list" for ls-remote, and it would 
probably be best to require helper authors to report that they've 
considered this possibility before trying to use it.

>  builtin-ls-remote.c |    2 +-
>  remote-curl.c       |    3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin-ls-remote.c b/builtin-ls-remote.c
> index 78a88f7..a8d5613 100644
> --- a/builtin-ls-remote.c
> +++ b/builtin-ls-remote.c
> @@ -86,7 +86,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  			pattern[j - i] = p;
>  		}
>  	}
> -	remote = nongit ? NULL : remote_get(dest);
> +	remote = remote_get(dest);
>  	if (remote && !remote->url_nr)
>  		die("remote %s has no configured URL", dest);
>  	transport = transport_get(remote, remote ? remote->url[0] : dest);

You can also drop the two checks for remote being non-NULL here, since 
it's now always non-NULL...

> diff --git a/remote-curl.c b/remote-curl.c
> index ad6a163..7c83f77 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -81,8 +81,9 @@ int main(int argc, const char **argv)
>  	struct strbuf buf = STRBUF_INIT;
>  	const char *url;
>  	struct walker *walker = NULL;
> +	int nongit = 0;
>  
> -	setup_git_directory();
> +	setup_git_directory_gently(&nongit);
>  	if (argc < 2) {
>  		fprintf(stderr, "Remote needed\n");
>  		return 1;

Do things like git_path() fail cleanly if there was no git directory? If 
not, there should probably be tests of nongit on paths that actually need 
a git directory, rather than relying on the caller not to do anything that 
needs a git directory. Even if the core is wise enough not to use "fetch" 
if there's nowhere to put the result, this code is likely to be an example 
for helpers that won't be able to rely on the same analysis.

	-Daniel
*This .sig left intentionally blank*
