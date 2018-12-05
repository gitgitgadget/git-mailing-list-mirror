Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B842F211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 05:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbeLEFCK (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 00:02:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59107 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeLEFCK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 00:02:10 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B28BE118B88;
        Wed,  5 Dec 2018 00:02:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HBdGRou9JR5xLNOQOZ0WH0mpRVk=; b=u9Mv6l
        o+s67sq4LZIELNo/zKc+gfxVL65xu7szzxY9PWMymKNBkO8kiQfCZunVWYd9Gk8c
        o4JhndcvduAEMgC21pfKCA6t1czDrN0oJD/zWkM0597s3ACUTthdEVKHoFKDXWuO
        oH3S/SBknM6Lrcv5EnoemITAUtujk3B9Xrhvs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nD6Tm1AmFJ+m1shxOhqFka4x3xA6qWEa
        r6Zs9A9PTuH+xSZna3iVuvRzhm3BtzCbq/VgGlA0JmYALS9gW4+Qn2MwinBBPE6c
        G6hi6HbbhaFv7uG8WGPjAEnpqaV0s+LdX1pcRcTYB1e3WkLGfUaxEBgdH1O3uc8Y
        FW21MEW2Id8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AAD98118B85;
        Wed,  5 Dec 2018 00:02:07 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 20A2C118B83;
        Wed,  5 Dec 2018 00:02:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [WIP RFC 2/5] Documentation: add Packfile URIs design doc
References: <cover.1543879256.git.jonathantanmy@google.com>
        <0461b362569362c6d0e73951469c547a03a1b59d.1543879256.git.jonathantanmy@google.com>
Date:   Wed, 05 Dec 2018 14:02:06 +0900
In-Reply-To: <0461b362569362c6d0e73951469c547a03a1b59d.1543879256.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Mon, 3 Dec 2018 15:37:35 -0800")
Message-ID: <xmqqbm60d0s1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9F8B602-F84A-11E8-A023-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> +This feature allows servers to serve part of their packfile response as URIs.
> +This allows server designs that improve scalability in bandwidth and CPU usage
> +(for example, by serving some data through a CDN), and (in the future) provides
> +some measure of resumability to clients.

Without reading the remainder, this makes readers anticipate a few
good things ;-)

 - "part of", so pre-generated constant material can be given from
   CDN and then followed-up by "filling the gaps" small packfile,
   perhaps?

 - The "part of" transmission may not bring the repository up to
   date wrt to the "want" objects; would this feature involve "you
   asked history up to these commits, but with this pack-uri, you'll
   be getting history up to these (somewhat stale) commits"?

Anyway, let's read on.

> +This feature is available only in protocol version 2.
> +
> +Protocol
> +--------
> +
> +The server advertises `packfile-uris`.
> +
> +If the client replies with the following arguments:
> +
> + * packfile-uris
> + * thin-pack
> + * ofs-delta

"with the following" meaning "with all of the following", or "with
any of the following"?  Is there a reason why the server side must
require that the client understands and is willing to accept a
thin-pack when wanting to use packfile-uris?  The same question for
the ofs-delta.

When the pregenerated constant material the server plans to hand out
the uris for was prepared by using ofs-delta encoding, the server
cannot give the uri to it when the client does not want ofs-delta
encoded packfile, but it feels somewhat strange that we require the
most capable client at the protocol level.  After all, the server
side could prepare one with ofs-delta and another without ofs-delta
and depending on what the client is capable of, hand out different
URIs, if it wanted to.

The reason why I care is because thin and ofs will *NOT* stay
forever be the only optional features of the pack format.  We may
invent yet another such optional 'frotz' feature, which may greatly
help the efficiency of the packfile encoding, hence it may be
preferrable to always generate a CDN packfile with that feature, in
addition to thin and ofs.  Would we add 'frotz' to the above list in
the documentation, then?  What would happen to existing servers and
clients written before that time then?

My recommendation is to drop the mention of "thin" and "ofs" from
the above list, and also from the following paragraph.  The "it MAY
send" will serve as a practical escape clause to allow a server/CDN
implementation that *ALWAYS* prepares pregenerated material that can
only be digested by clients that supports thin and ofs.  Such a server
can send packfile-URIs only when all of the three are given by the
client and be compliant.  And such an update to the proposed document
would allow a more diskful server to prepare both thin and non-thin
pregenerated packs and choose which one to give to the client depending
on the capability.

> +when the server sends the packfile, it MAY send a `packfile-uris` section
> +directly before the `packfile` section (right after `wanted-refs` if it is
> +sent) containing HTTP(S) URIs. See protocol-v2.txt for the documentation of
> +this section.

So, this is OK, but

> +Clients then should understand that the returned packfile could be incomplete,
> +and that it needs to download all the given URIs before the fetch or clone is
> +complete. Each URI should point to a Git packfile (which may be a thin pack and
> +which may contain offset deltas).

weaken or remove the (parenthetical comment) in the last sentence,
and replace the beginning of the section with something like

	If the client replies with 'packfile-uris', when the server
	sends the packfile, it MAY send a `packfile-uris` section...

You may steal what I wrote in the above response to help the
server-side folks to decide how to actually implement the "it MAY
send a packfile-uris" part in the document.

> +Server design
> +-------------
> +
> +The server can be trivially made compatible with the proposed protocol by
> +having it advertise `packfile-uris`, tolerating the client sending
> +`packfile-uris`, and never sending any `packfile-uris` section. But we should
> +include some sort of non-trivial implementation in the Minimum Viable Product,
> +at least so that we can test the client.
> +
> +This is the implementation: a feature, marked experimental, that allows the
> +server to be configured by one or more `uploadpack.blobPackfileUri=<sha1>
> +<uri>` entries. Whenever the list of objects to be sent is assembled, a blob
> +with the given sha1 can be replaced by the given URI. This allows, for example,
> +servers to delegate serving of large blobs to CDNs.

;-)

> +Client design
> +-------------
> +
> +While fetching, the client needs to remember the list of URIs and cannot
> +declare that the fetch is complete until all URIs have been downloaded as
> +packfiles.
> +
> +The division of work (initial fetch + additional URIs) introduces convenient
> +points for resumption of an interrupted clone - such resumption can be done
> +after the Minimum Viable Product (see "Future work").
> +
> +The client can inhibit this feature (i.e. refrain from sending the
> +`packfile-urls` parameter) by passing --no-packfile-urls to `git fetch`.

OK, this comes back to what I alluded to at the beginning.  We could
respond to a full-clone request by feeding a series of packfile-uris
and some ref information, perhaps like this:

	* Grab this packfile and update your remote-tracking refs
          and tags to these values; you'd be as if you cloned the
          project when it was at v1.0.

	* When you are done with the above, grab this packfile and
          update your remote-tracking refs and tags to these values;
          you'd be as if you cloned the project when it was at v2.0.

	* When you are done with the above, grab this packfile and
          update your remote-tracking refs and tags to these values;
          you'd be as if you cloned the project when it was at v3.0.

	...

	* When you are done with the above, here is the remaining
          packdata to bring you fully up to date with your original
          "want"s.

and before fully reading the proposal, I anticipated that it was
what you were going to describe.  The major difference is "up to the
packdata given to you so far, you'd be as if you fetched these" ref
information, which would allow you to be interrupted and then simply
resume, without having to remember the set of packfile-uris yet to
be processed across a fetch/clone failure.  If you sucessfully fetch
packfile for ..v1.0, you can update the remote-tracking refs to
match as if you fetched back when that was the most recent state of
the project, and then if you failed while transferring packfile for
v1.0..v2.0, the resuming would just reissue "git fetch" internally.

I think what you proposed, i.e. without the "with the data up to
this packfile, you have history to these objects", would also work,
even though it requires us to remember more of what we learned
during the initial attempt throughout retrying failed transfers.

> +Future work
> +-----------
> +
> +The protocol design allows some evolution of the server and client without any
> +need for protocol changes, so only a small-scoped design is included here to
> +form the MVP. For example, the following can be done:
> +
> + * On the server, a long-running process that takes in entire requests and
> +   outputs a list of URIs and the corresponding inclusion and exclusion sets of
> +   objects. This allows, e.g., signed URIs to be used and packfiles for common
> +   requests to be cached.
> + * On the client, resumption of clone. If a clone is interrupted, information
> +   could be recorded in the repository's config and a "clone-resume" command
> +   can resume the clone in progress. (Resumption of subsequent fetches is more
> +   difficult because that must deal with the user wanting to use the repository
> +   even after the fetch was interrupted.)
> +
> +There are some possible features that will require a change in protocol:
> +
> + * Additional HTTP headers (e.g. authentication)
> + * Byte range support
> + * Different file formats referenced by URIs (e.g. raw object)
> +
> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> index 345c00e08c..2cb1c41742 100644
> --- a/Documentation/technical/protocol-v2.txt
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -313,7 +313,8 @@ header. Most sections are sent only when the packfile is sent.
>  
>      output = acknowledgements flush-pkt |
>  	     [acknowledgments delim-pkt] [shallow-info delim-pkt]
> -	     [wanted-refs delim-pkt] packfile flush-pkt
> +	     [wanted-refs delim-pkt] [packfile-uris delim-pkt]
> +	     packfile flush-pkt
>  
>      acknowledgments = PKT-LINE("acknowledgments" LF)
>  		      (nak | *ack)
> @@ -331,6 +332,9 @@ header. Most sections are sent only when the packfile is sent.
>  		  *PKT-LINE(wanted-ref LF)
>      wanted-ref = obj-id SP refname
>  
> +    packfile-uris = PKT-LINE("packfile-uris" LF) *packfile-uri
> +    packfile-uri = PKT-LINE("uri" SP *%x20-ff LF)
> +
>      packfile = PKT-LINE("packfile" LF)
>  	       *PKT-LINE(%x01-03 *%x00-ff)
