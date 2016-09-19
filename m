Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B4F92070F
	for <e@80x24.org>; Mon, 19 Sep 2016 19:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932132AbcISTvZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 15:51:25 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.29]:50780 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932109AbcISTvY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 15:51:24 -0400
Received: from [84.168.70.3] (helo=book.hvoigt.net)
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1bm4b1-0007H0-FL; Mon, 19 Sep 2016 21:51:19 +0200
Date:   Mon, 19 Sep 2016 21:51:18 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH 2/2] serialize collection of refs that contain submodule
 changes
Message-ID: <20160919195118.GB62429@book.hvoigt.net>
References: <20160824173017.24782-1-sbeller@google.com>
 <20160824183112.ceekegpzavnbybxp@sigill.intra.peff.net>
 <xmqqh9aaot49.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYOBqQ0FF4J-+KbefSD8HRrUeMqpO27m_jprhm93aB+LA@mail.gmail.com>
 <20160824230115.jhmcr4r7wobj5ejb@sigill.intra.peff.net>
 <20160914175130.GB7613@sandbox>
 <xmqqd1k3losd.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd1k3losd.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Sep 16, 2016 at 10:47:46AM -0700, Junio C Hamano wrote:
> One thing that makes me worried is how the ref cache layer interacts
> with this.  I see you first call push_unpushed_submodules() when
> ON_DEMAND is set, which would result in pushes in submodule
> repositories, updating their remote tracking branches.  At that
> point, before you make another call to find_unpushed_submodules(),
> is our cached ref layer knows that the remote tracking branches
> are now up to date (otherwise, we would incorrectly judge that these
> submodules need pushing based on stale information)?

I am not sure if I understand you correctly here. With the "ref cache layer"
you are referring to add_submodule_odb() which is called indirectly from
submodule_needs_pushing()? Those revs are only used to check whether the hash
we need on the remote side exists in the local submodule. That should not
change due to a push. The actual check whether the commit(s) exist on the
remote side is done using a 'rev-list' in a subprocess later.


> > diff --git a/transport.c b/transport.c
> > index 94d6dc3..76e1daf 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -903,23 +903,29 @@ int transport_push(struct transport *transport,
> >  
> >  		if ((flags & TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND) && !is_bare_repository()) {
> >  			struct ref *ref = remote_refs;
> > +			struct sha1_array hashes = SHA1_ARRAY_INIT;
> > +
> >  			for (; ref; ref = ref->next)
> > -				if (!is_null_oid(&ref->new_oid) &&
> > -				    !push_unpushed_submodules(ref->new_oid.hash,
> > -					    transport->remote->name))
> > -				    die ("Failed to push all needed submodules!");
> > +				if (!is_null_oid(&ref->new_oid))
> > +					sha1_array_append(&hashes, ref->new_oid.hash);
> > +
> > +			if (!push_unpushed_submodules(&hashes, transport->remote->name))
> > +				die ("Failed to push all needed submodules!");
> 
> Do we leak the contents of hashes here?

Good catch, sorry about that. Will clear the hashes array.


> >  		}
> >  
> >  		if ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
> >  			      TRANSPORT_RECURSE_SUBMODULES_CHECK)) && !is_bare_repository()) {
> >  			struct ref *ref = remote_refs;
> >  			struct string_list needs_pushing = STRING_LIST_INIT_DUP;
> > +			struct sha1_array hashes = SHA1_ARRAY_INIT;
> >  
> >  			for (; ref; ref = ref->next)
> > -				if (!is_null_oid(&ref->new_oid) &&
> > -				    find_unpushed_submodules(ref->new_oid.hash,
> > -					    transport->remote->name, &needs_pushing))
> > -					die_with_unpushed_submodules(&needs_pushing);
> > +				if (!is_null_oid(&ref->new_oid))
> > +					sha1_array_append(&hashes, ref->new_oid.hash);
> > +
> > +			if (find_unpushed_submodules(&hashes, transport->remote->name,
> > +						&needs_pushing))
> > +				die_with_unpushed_submodules(&needs_pushing);
> 
> Do we leak the contents of hashes here?  I do not think we need to
> worry about needs_pushing leaking, as we will always die if it is
> not empty, but it might be a better code hygiene to clear it as
> well.

As above, will fix.

Cheers Heiko
