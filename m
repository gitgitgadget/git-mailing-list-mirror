From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH][v2] http authentication via prompts (with correct line
  lengths)
Date: Tue, 17 Mar 2009 12:24:01 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903171206490.19665@iabervon.org>
References: <d8c371a80903162215k4c27762cva650ea64d7850afa@mail.gmail.com> <7v8wn4u0ip.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Amos King <amos.l.king@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 17:26:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljc6q-0007gY-Gi
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 17:25:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757660AbZCQQYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 12:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757100AbZCQQYF
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 12:24:05 -0400
Received: from iabervon.org ([66.92.72.58]:54935 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756105AbZCQQYE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 12:24:04 -0400
Received: (qmail 20755 invoked by uid 1000); 17 Mar 2009 16:24:01 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Mar 2009 16:24:01 -0000
In-Reply-To: <7v8wn4u0ip.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113494>

On Mon, 16 Mar 2009, Junio C Hamano wrote:

> Amos King <amos.l.king@gmail.com> writes:
> 
> > Junio,
> >
> > I'm working with Mike on the http auth stuff, and I was testing out
> > your patch.  I can get it to work for fetch but push is giving me some
> > grief.  Looking through the code I noticed that online 219 of
> > http-push.c that http_init is being called with NULL instead of a
> > remote.  If I pass in the remote then there is no remotre-url.  I've
> > been digging around and can't find where or when that is being set.
> > It has been a while since I worked with C but I'd love to jump in and
> > help out here.  Can you point me in the right direction to get the
> > remote->url[0] set for the http_auth_init to use?
> 
> Daniel is the primary culprit who introduced the transport abstraction,
> and I think he muttered something about his work-in-progress that involves
> in some change in the API.  Perhaps he has some insights here?
> 
> Naah.  I forgot that the transport abstraction on the fetch side is much
> more integrated but curl_transport_push() simply launches http-push.c that
> has a world on its own.  Worse yet, "remote" in http-push.c is not even
> the "struct remote"; it is something private to http-push.c called "struct
> repo".
>
> I am not sure how much work would be involved in converting (or if it is
> even worth to convert) http-push.c to fit better into the transport API,
> but if that is feasible, it might be a better longer-term solution.

I think it would be a good thing to do. With the new transport push 
method, it could even get support for updating the tracking refs that 
track the refs you changed, since I broke that out of the git-native 
protocol code and into the transport code.

My guess is that converting http-push to be called in-process would 
actually be pretty easy, because the two sides don't look at the same data 
currently. (Some things were tricky with fetch, because the same process 
sometimes wants to do fetches multiple times, for getting tags; this isn't 
as big a deal.)

I think it should just be a matter of breaking http-push's main() into a 
function that deals with the http-push command line and a function that 
does the work, setting up a header file like send-pack.h, and changing 
transport.c to just call the function.

> Right now, builtin-push.c does all the remote inspection and when
> http-push is called, the latter gets the information at the lowest level
> only; the higher level information such as what nickname was used by the
> user to initiate the "git push" process and whether the refspecs came from
> the command line or from the config are all lost, which is quite sad.

What I did short-term for the send-pack version was introduce an optional 
command line argument, "--remote", that names the remote used, so the 
other program could get the configuration as well. It's a pretty easy 
step, but I don't think it's too worthwhile in this case.

> But as a much lower impact interim solution, I suspect that you can fake a
> minimally usable remote.  The http_push() codepath only cares about
> remote->http_proxy and remote->url settings as far as I can tell, so
> perhaps you can start (with a big warning that the remote you are creating
> is a fake one) by filling the absolute minimum?
> 
> That is, something along these lines (this comes on top of an obvious
> patch that renames existing "remote" variable in http-push. to "repo").
> 
> diff --git a/http-push.c b/http-push.c
> index dfbb247..f04ac74 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -2197,6 +2197,7 @@ int main(int argc, char **argv)
>  	int new_refs;
>  	struct ref *ref;
>  	char *rewritten_url = NULL;
> +	struct remote *remote;
>  
>  	git_extract_argv0_path(argv[0]);
>  
> @@ -2258,12 +2259,14 @@ int main(int argc, char **argv)
>  	if (!repo->url)
>  		usage(http_push_usage);
>  
> +	remote = remote_get(repo->url);
> +
>  	if (delete_branch && nr_refspec != 1)
>  		die("You must specify only one branch name when deleting a remote branch");
>  
>  	memset(remote_dir_exists, -1, 256);
>  
> -	http_init(NULL);
> +	http_init(remote);
>  
>  	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");

This should work, although it obviously won't figure out the proxy for the 
configuration for the remote that was actually used.

	-Daniel
*This .sig left intentionally blank*
