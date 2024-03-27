Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926253BBD3
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711532924; cv=none; b=gsjtaCCpAlo6/aZmdOJfCu6WydDv9IluEr/PjYE4geDDRwEGiPj/cxUKUZe3TZVeuA/U1zDQfVt/YdwkQvy2SzRg9QhcdYkj6IiA11gfsvgy4s375t+NdRB2gOPLoODQFTlyVgT5bWxV3UKEzIGUGPaG78/XpIDqoBGCWUywANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711532924; c=relaxed/simple;
	bh=XdUIRSZLKTDalH7eXx2JM1wYqhKls8naJBkCuguh4Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kp6MfhOXsPKxi5p22G0hff4NAzeagc7H+eGvZFSZ/tlUcUqla6Y9eHGNYqXXd3qJv+x10NWkPGDstwttbLrMuGNLQbhmgd5LRVg1xVH/ykPjG7W/vK5unvmp0LyOc5sJg0A6F54KrAzfDk3i14xTBHae3nCrJYh255lsm0VtgqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23365 invoked by uid 109); 27 Mar 2024 09:48:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Mar 2024 09:48:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25273 invoked by uid 111); 27 Mar 2024 09:48:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Mar 2024 05:48:46 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 27 Mar 2024 05:48:40 -0400
From: Jeff King <peff@peff.net>
To: "Eric W. Biederman" <ebiederm@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/3] some transport-helper "option object-format"
 confusion
Message-ID: <20240327094840.GA857435@coredump.intra.peff.net>
References: <20240307084735.GA2072130@coredump.intra.peff.net>
 <20240320093226.GA2445531@coredump.intra.peff.net>
 <87y1ac3kb6.fsf@gmail.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y1ac3kb6.fsf@gmail.froward.int.ebiederm.org>

On Wed, Mar 20, 2024 at 12:05:49PM -0500, Eric W. Biederman wrote:

> Your sentence has what I was asking for backwards.  It would be healthy
> if the code fails when "object-format" has been advertised by the
> remote, requested by the transport-helper, and the remote does not send
> ":object-format".

Ah, I see. That is probably reasonable, under the assumption that nobody
would have implemented "object-format" so far and _not_ sent it. It
might be worth clarifying the documentation at the same time.

> The implementation should just be:
> 
> diff --git a/transport-helper.c b/transport-helper.c
> index b660b7942f9f..e648f136287d 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -1206,6 +1206,7 @@ static struct ref *get_refs_list_using_list(struct transport *transport,
>  	struct ref **tail = &ret;
>  	struct ref *posn;
>  	struct strbuf buf = STRBUF_INIT;
> +	bool received_object_format = false;
>  
>  	data->get_refs_list_called = 1;
>  	helper = get_helper(transport);
> @@ -1236,9 +1236,13 @@ static struct ref *get_refs_list_using_list(struct transport *transport,
>  					die(_("unsupported object format '%s'"),
>  					    value);
>  				transport->hash_algo = &hash_algos[algo];
> +				received_object_format = true;
>  			}
>  			continue;
>  		}
> +		else if (data->object_format && !received_object_format) {
> +			die(_("missing :object-format"));
> +		}
>  
>  		eov = strchr(buf.buf, ' ');
>  		if (!eov)
> 
> Am I missing something that makes a bad implementation?

No, that seems right to me (modulo that we do not use C99 "bool" in our
code base).

> Hmm.  I thought gitremote-helpers.txt said the key value pairs
> would precede everything else from a list command.
> gitremote-helpers.txt does not mention that.  That looks like
> a Documentation oversight.
> 
> However remote-curl.c in output_refs prints :object-format before
> anything else, and transport-helper.c will malfunction if :object-format
> is sent after any of the refs.  As transport->hash_algop is used by
> get_oid_hex_algop is used to parse the oids of the refs.

Yeah, I think it is a natural consequence of "object-format", since it
is necessary for parsing the result. And since there aren't any other
keywords yet, we can surmise that nobody is doing the wrong thing yet.
So now is a good time to clarify the documentation.

I'm also not sure if we ever say explicitly in the documentation that
the keywords start with a colon. But maybe I am just missing it.

> diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
> index ed8da428c98b..b6ca29a245f3 100644
> --- a/Documentation/gitremote-helpers.txt
> +++ b/Documentation/gitremote-helpers.txt
> @@ -268,6 +268,8 @@ Support for this command is mandatory.
>  	ref. A space-separated list of attributes follows the name;
>  	unrecognized attributes are ignored. The list ends with a
>  	blank line.
> +
> +	Keywords should precede everything else in the list.
>  +
>  See REF LIST ATTRIBUTES for a list of currently defined attributes.
>  See REF LIST KEYWORDS for a list of currently defined keywords.
> 
> I do agree that the sanity check can be added to your series, so if you
> would prefer I can do that.

Yeah, do you want to send some patches that can go on top of mine?

-Peff
