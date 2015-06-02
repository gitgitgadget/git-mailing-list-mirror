From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFCv2 12/16] transport: get_refs_via_connect exchanges capabilities before refs.
Date: Tue, 02 Jun 2015 14:55:28 -0700
Message-ID: <xmqqr3ptzsfj.fsf@gitster.dls.corp.google.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
	<1433203338-27493-13-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, peff@peff.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 23:55:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzu9o-0008G4-EI
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 23:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbbFBVzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 17:55:32 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35254 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbbFBVzb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 17:55:31 -0400
Received: by igbyr2 with SMTP id yr2so98169250igb.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 14:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=m/UDNn9GNeiUNvgTP0f+BXVSGeGwIApevRNeBkWXlV8=;
        b=Eu0Kq8Ae0Jfh7999blMtHo9afs0LCj2M6EdUwEiI/1D+4p8pq5uLEe/bZzxIfNhKaR
         jUjU/CF5USgnSUhgtwVXXSllxxCyu9MMv+yBjnorKCrJXxNDMK4eMYZy/vvGkJg4ngJM
         wyVYltWsP0GF0B0UOT9cV38BSxbM4V+1EfEtque5RZsxMzRprm8kdyDaL5kaTLaCXHS1
         UBc29ZgxiUfpdBRPdtoEeJIUI2DjUqZDTkm1Wd03TGfklwMuvORrmEKacVHE5Ofqra+k
         8uT49Oi5v/2Xh5r+w4BiGpspzFuoMMk7MdNdzImLxK5pfwTxe9VY5AyX0mp5cbwvXoXM
         8R7Q==
X-Received: by 10.42.213.136 with SMTP id gw8mr36858823icb.95.1433282130309;
        Tue, 02 Jun 2015 14:55:30 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3140:53f3:e8c0:89b0])
        by mx.google.com with ESMTPSA id m9sm10844168igv.4.2015.06.02.14.55.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jun 2015 14:55:29 -0700 (PDT)
In-Reply-To: <1433203338-27493-13-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 1 Jun 2015 17:02:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270611>

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Notes:
>     A minor issue I am unsure about here is the
>     line
>     	&& transport->smart_options->transport_version)
>     which could be prevented if we always set the transport_version
>     in make_remote to be the default remote version.
>     
>     The advantage of having it always set in make_remote would
>     be a cleaner mind model (the version set is always accurate)
>     as opposed to now (version may be 0, then the default
>     applies as we don't care enough to set a version)
>     
>     However I think the code may be more ugly if we were to
>     always set the version in make_remote as then we would need
>     to move the DEFAULT_TRANSPORT_VERSION define into remote.h
>     or somewhere else (transport.h is not included in remote.c,
>     I guess that's on purpose?)

Interesting.  After reading 9/16, I was somehow expecting to see
that a new method get_capability() would be added to the transport
layer, and a function get_capability_via_connect() that calls
get_remote_capabilities() would be its implementation for the
"connect" transport.

The capability thing however is limited to the Git-aware aka smart
transports and it is unlikely that other transports would benefit
from such an organization, so I think the way this step integrates
the new get_remote_capabilities() to the system would be not just
sufficient but is more appropriate.

If you do not like the switching based on version in this function,
however, it is probably an option to add the new method and define
connect_v1 and connect_v2 as two separate transports.  The latter
would have get_capability() method, while the former (and all the
other transports) does not define it.  And the overall transport
layer would call get_capability() method when defined, and then
get_refs() method next, or something like that.

>  transport.c | 28 ++++++++++++++++++++++++----
>  transport.h |  6 ++++++
>  2 files changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/transport.c b/transport.c
> index b49fc60..ba40677 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -523,14 +523,33 @@ static int connect_setup(struct transport *transport, int for_push, int verbose)
>  
>  static struct ref *get_refs_via_connect(struct transport *transport, int for_push)
>  {
> +	struct transport_options options;
>  	struct git_transport_data *data = transport->data;
>  	struct ref *refs;
> +	int version = DEFAULT_TRANSPORT_VERSION;
>  
> +	if (transport->smart_options
> +	    && transport->smart_options->transport_version)
> +		version = transport->smart_options->transport_version;
>  	connect_setup(transport, for_push, 0);
> -	get_remote_heads(data->fd[0], NULL, 0, &refs,
> -			 for_push ? REF_NORMAL : 0,
> -			 &data->extra_have,
> -			 &data->shallow);
> +	switch (version) {
> +	case 2: /* first talk about capabilities, then get the heads */
> +		get_remote_capabilities(data->fd[0], NULL, 0);
> +		preselect_capabilities(&options);
> +		if (transport->select_capabilities)
> +			transport->select_capabilities(&options);
> +		request_capabilities(data->fd[1], &options);
> +		/* fall through */
> +	case 1:
> +		get_remote_heads(data->fd[0], NULL, 0, &refs,
> +				 for_push ? REF_NORMAL : 0,
> +				 &data->extra_have,
> +				 &data->shallow);
> +		break;
> +	default:
> +		die("BUG: Transport version %d not supported", version);
> +		break;
> +	}
>  	data->got_remote_heads = 1;
>  
>  	return refs;
> @@ -987,6 +1006,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
>  		struct git_transport_data *data = xcalloc(1, sizeof(*data));
>  		ret->data = data;
>  		ret->set_option = NULL;
> +		ret->select_capabilities = NULL;
>  		ret->get_refs_list = get_refs_via_connect;
>  		ret->fetch = fetch_refs_via_pack;
>  		ret->push_refs = git_transport_push;
> diff --git a/transport.h b/transport.h
> index 6095d7a..3e63efc 100644
> --- a/transport.h
> +++ b/transport.h
> @@ -74,6 +74,12 @@ struct transport {
>  	int (*fetch)(struct transport *transport, int refs_nr, struct ref **refs);
>  
>  	/**
> +	 * A callback to select protocol options. Must be set if
> +	 * the caller wants to change transport options.
> +	 */
> +	void (*select_capabilities)(struct transport_options *);
> +
> +	/**
>  	 * Push the objects and refs. Send the necessary objects, and
>  	 * then, for any refs where peer_ref is set and
>  	 * peer_ref->new_sha1 is different from old_sha1, tell the
