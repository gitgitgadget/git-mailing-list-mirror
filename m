From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] push: point to 'git pull' and 'git push --force' in case
 of non-fast forward
Date: Thu, 06 Aug 2009 22:04:48 +0200
Message-ID: <4A7B3760.2000303@drmicha.warpmail.net>
References: <1249579933-1782-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Aug 06 22:05:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ9DM-0007du-3d
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 22:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756667AbZHFUFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 16:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756661AbZHFUFG
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 16:05:06 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:53197 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756659AbZHFUFF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 16:05:05 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 809BDB080;
	Thu,  6 Aug 2009 16:05:04 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 06 Aug 2009 16:05:04 -0400
X-Sasl-enc: Rt/DcgkhxnbXW9UFkdhkusNr4Lhx5LqMKxeNzfp77tfB 1249589103
Received: from localhost.localdomain (vpn-136-007.rz.uni-augsburg.de [137.250.136.7])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2F5C138B2;
	Thu,  6 Aug 2009 16:05:03 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.2pre) Gecko/20090728 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <1249579933-1782-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125119>

Matthieu Moy venit, vidit, dixit 06.08.2009 19:32:
> 'git push' failing because of non-fast forward is a very common situation,
> and a beginner does not necessarily understand "fast forward" immediately.
> 
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> That may be a bit verbose, but I think it's worth it.
> 
> Ideally, there should be a core.expertUser config variable to disable
> these kind of messages, but that's another story.
> 
>  builtin-push.c |    9 ++++++++-
>  transport.c    |   10 +++++++---
>  transport.h    |    3 ++-
>  3 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin-push.c b/builtin-push.c
> index 1d92e22..214ca77 100644
> --- a/builtin-push.c
> +++ b/builtin-push.c
> @@ -140,6 +140,7 @@ static int do_push(const char *repo, int flags)
>  		struct transport *transport =
>  			transport_get(remote, url[i]);
>  		int err;
> +		int nonfastforward;
>  		if (receivepack)
>  			transport_set_option(transport,
>  					     TRANS_OPT_RECEIVEPACK, receivepack);
> @@ -148,13 +149,19 @@ static int do_push(const char *repo, int flags)
>  
>  		if (flags & TRANSPORT_PUSH_VERBOSE)
>  			fprintf(stderr, "Pushing to %s\n", url[i]);
> -		err = transport_push(transport, refspec_nr, refspec, flags);
> +		err = transport_push(transport, refspec_nr, refspec, flags,
> +				     &nonfastforward);
>  		err |= transport_disconnect(transport);
>  
>  		if (!err)
>  			continue;
>  
>  		error("failed to push some refs to '%s'", url[i]);
> +		if (nonfastforward) {
> +			printf("Some branch push were rejected due to non-fast forward:\n");
> +			printf("Merge the remote changes (git pull) before pushing your's\n");
> +			printf("or use git push --force to discard the remote changes.\n");
> +		}
>  		errs++;
>  	}
>  	return !!errs;

May I suggest "Some push was rejected because it would not result in a
fast forward:\n Merge in the remote changes (using git pull) before
pushing yours\n or use..."?

Cheers,
Michael

> diff --git a/transport.c b/transport.c
> index de0d587..f231b35 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -820,7 +820,7 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count, i
>  }
>  
>  static void print_push_status(const char *dest, struct ref *refs,
> -							  int verbose, int porcelain)
> +			      int verbose, int porcelain, int * nonfastforward)
>  {
>  	struct ref *ref;
>  	int n = 0;
> @@ -835,11 +835,14 @@ static void print_push_status(const char *dest, struct ref *refs,
>  		if (ref->status == REF_STATUS_OK)
>  			n += print_one_push_status(ref, dest, n, porcelain);
>  
> +	*nonfastforward = 0;
>  	for (ref = refs; ref; ref = ref->next) {
>  		if (ref->status != REF_STATUS_NONE &&
>  		    ref->status != REF_STATUS_UPTODATE &&
>  		    ref->status != REF_STATUS_OK)
>  			n += print_one_push_status(ref, dest, n, porcelain);
> +		if (ref->status == REF_STATUS_REJECT_NONFASTFORWARD)
> +			*nonfastforward = 1;
>  	}
>  }
>  
> @@ -997,7 +1000,8 @@ int transport_set_option(struct transport *transport,
>  }
>  
>  int transport_push(struct transport *transport,
> -		   int refspec_nr, const char **refspec, int flags)
> +		   int refspec_nr, const char **refspec, int flags,
> +		   int * nonfastforward)
>  {
>  	verify_remote_names(refspec_nr, refspec);
>  
> @@ -1024,7 +1028,7 @@ int transport_push(struct transport *transport,
>  
>  		ret = transport->push_refs(transport, remote_refs, flags);
>  
> -		print_push_status(transport->url, remote_refs, verbose | porcelain, porcelain);
> +		print_push_status(transport->url, remote_refs, verbose | porcelain, porcelain, nonfastforward);
>  
>  		if (!(flags & TRANSPORT_PUSH_DRY_RUN)) {
>  			struct ref *ref;
> diff --git a/transport.h b/transport.h
> index 51b5397..639f13d 100644
> --- a/transport.h
> +++ b/transport.h
> @@ -68,7 +68,8 @@ int transport_set_option(struct transport *transport, const char *name,
>  			 const char *value);
>  
>  int transport_push(struct transport *connection,
> -		   int refspec_nr, const char **refspec, int flags);
> +		   int refspec_nr, const char **refspec, int flags,
> +		   int * nonfastforward);
>  
>  const struct ref *transport_get_remote_refs(struct transport *transport);
>  
