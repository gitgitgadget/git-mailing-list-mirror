From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [question] how can i verify whether a local branch is tracking
   a remote branch?
Date: Mon, 06 Apr 2009 14:00:34 +0200
Message-ID: <49D9EEE2.3000607@drmicha.warpmail.net>
References: <4d8e3fd30904050332w394cccbaq5b82d2a53ed357a3@mail.gmail.com> <20090405144413.GC2076@sigill.intra.peff.net> <4d8e3fd30904051425w6739a12fp5666e71e8b2d7958@mail.gmail.com> <20090406043426.GC12341@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 06 14:02:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqnWp-00022x-3x
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 14:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755465AbZDFMAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 08:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755329AbZDFMAm
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 08:00:42 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:60689 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755203AbZDFMAm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2009 08:00:42 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id D2ECE311CA5;
	Mon,  6 Apr 2009 08:00:39 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 06 Apr 2009 08:00:39 -0400
X-Sasl-enc: 7ynND2ldtbOHYNb0eRyfd+63/gyVTCmtY6fHHFUUdhYY 1239019239
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BCBF849FE;
	Mon,  6 Apr 2009 08:00:38 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090406 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090406043426.GC12341@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115809>

Jeff King venit, vidit, dixit 06.04.2009 06:34:
> On Sun, Apr 05, 2009 at 11:25:29PM +0200, Paolo Ciarrocchi wrote:
> 
>> An example:
>> $ git clone -n URL temp
>> $ cd temp
>> $ git branch -r
>>   origin/master
>>   origin/foo
>>   Origin/bar
>> $ git checkout --track -b foo origin/foo
>>
>> Now, how can I know that foo is tracking origin/foo ?
> 
> Doing it right is hard. You have to:
> 
>   1. check branch.foo.merge and branch.foo.rebase; if no value, it is not
>      tracking anything; if it is, remember that value as $m
> 
>   2. check branch.foo.remote for the remote name, $r
> 
>   3. check the fetch refspecs for remote $r; these can come from
>      the config, or from .git/remotes/* files. Maybe even .git/branches
>      files; I don't even remember how those work.
> 
>   4. find the refspec that fetches from $m; then find the matching
>      destination for that refspec. That is the tracking branch.
> 
> E.g., in your example (and using a modern git):
> 
>   1. $m is refs/heads/foo
>   2. $r is origin
>   3. The fetch refspec is in remote.origin.fetch, and is generally
>      "refs/heads/*:refs/remotes/origin/*"
>   4. So refs/heads/foo becomes refs/remotes/origin/foo.
>      refs/remotes/origin/foo is your tracking branch.
> 
> Steps 1 and 2 are easy, but 3 and 4 are a bit nasty. You can fake it by
> assuming that "refs/heads/$m" on "$r" is always "refs/remotes/$r/$m",
> which is true for very vanilla setups.
> 
> There is C code that does this, but there is not a good way of accessing
> it from the command-line. The best you can do is "git remote show
> origin", which on recent git versions should show something like:
> 
>   ...
>   Local branches configured for 'git pull':
>     foo    merges with remote foo
>   ...
> 
> But of course that implies that you already guessed the remote "origin".
> And it's not using plumbing, so it's not very suitable for scripts.
> 
> I don't think it would be unreasonable to expose this functionality via
> "for-each-ref". Something like this (which would need cleanup,
> documentation, and perhaps a :short variant):
> 
> ---
> diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
> index 5cbb4b0..3f418e4 100644
> --- a/builtin-for-each-ref.c
> +++ b/builtin-for-each-ref.c
> @@ -8,6 +8,7 @@
>  #include "blob.h"
>  #include "quote.h"
>  #include "parse-options.h"
> +#include "remote.h"
>  
>  /* Quoting styles */
>  #define QUOTE_NONE 0
> @@ -66,6 +67,7 @@ static struct {
>  	{ "subject" },
>  	{ "body" },
>  	{ "contents" },
> +	{ "tracking" },
>  };
>  
>  /*
> @@ -699,6 +701,18 @@ static void populate_value(struct refinfo *ref)
>  				v->s = s;
>  			}
>  		}
> +		if (!strcmp(name, "tracking")) {
> +			struct branch *branch;
> +			if (prefixcmp(ref->refname, "refs/heads/"))
> +				continue;
> +			branch = branch_get(ref->refname + 11);
> +			if (branch && branch->merge && branch->merge[0] &&
> +			    branch->merge[0]->dst)
> +				v->s = branch->merge[0]->dst;

Isn't that missing out on those cases where you --track (i.e. follow) a
local (upstream) branch? See
5e6e2b4 (Make local branches behave like remote branches when --tracked,
2009-04-01)

> +			else
> +				v->s = NULL;
> +			free(branch); /* XXX should also free other parts? */
> +		}
>  	}
>  
>  	grab_values(ref->value, 0, obj, buf, size);
> 
> 
> 
> 
> 

If we hook it up into git-branch there would be to useful directions:

- "git branch --follows foo" could list all branches which follow foo,
analogous to --contains. It gives you all your feature work on top of
foo, all branches affected by rebasing foo etc.

- "git branch --whatever foo" could list the branch whoch foo follows.

I just notices that "git branch -v foo" does not give me the "-v" output
for foo... Improving that would open up the possibility to go for -vv foo.

Michael
