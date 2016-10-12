Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45CEC207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 13:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933272AbcJLNBX (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 09:01:23 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.96]:34601 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933255AbcJLNBT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 09:01:19 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1buJ9E-0002rV-BO; Wed, 12 Oct 2016 15:00:40 +0200
Date:   Wed, 12 Oct 2016 15:00:34 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH v2 1/3] serialize collection of changed submodules
Message-ID: <20161012130034.GA84247@book.hvoigt.net>
References: <cover.1475851621.git.hvoigt@hvoigt.net>
 <10cd5be93601bc52388100e80b6c6735a7cacfb4.1475851621.git.hvoigt@hvoigt.net>
 <CAGZ79kZiY56-84aThH1F02E_HzCTAK3KSYLbyP1D5GUAt892cw@mail.gmail.com>
 <xmqqvawzbzb2.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqvawzbzb2.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2016 at 03:43:13PM -0700, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
> 
> >> +static struct sha1_array *get_sha1s_from_list(struct string_list *submodules,
> >> +               const char *path)
> >
> > So this will take the stringlist `submodules` and insert the path into it,
> > if it wasn't already in there. In case it is newly inserted, add a sha1_array
> > as util, so each inserted path has it's own empty array.
> >
> > So it is both init of the data structures as well as retrieving them. I was
> > initially confused by the name as I assumed it would give you sha1s out
> > of a string list (e.g. transform strings to internal sha1 things).
> > Maybe it's just
> > me having a hard time to understand that, but I feel like the name could be
> > improved.
> >
> >     lookup_sha1_list_by_path,
> >     insert_path_and_return_sha1_list ?
> 
> I do not think either the name or the "find if exists otherwise
> initialize one" behaviour is particularly confusing, but I do not
> think "maintain a set of sha1_arrays keyed with a string" is a so
> widely reusable general concept/construct.  As can be seen easily in
> the names of parameters, this function is about maintaining a set of
> sha1_arrays keyed by paths to submodules, and I also assume that the
> array indexed by path is not meant to be a general purpose "we can
> use it to store any 40-hex thing" but to store something specific.
> 
> What is that specific thing?  The names of commit objects in the
> submodule repository?
> 
> I'd prefer to see that exact thing used to construct the function
> name for a helper function with specific usage in mind, i.e.
> get_commit_object_names_for_submodule_path() or something along that
> line.

I did not name this function too precisely to keep it's name short since
everything specific was quite long, like the suggestion from Junio.

Since this is a static function local to the submodule file I was
assuming anyone interested would just look up the usage and immediately
see the purpose. If I look into submodule-cache.c where I have a similar
functionality we used 'lookup_or_create' for this create on demand
functionality. So a function name would be:

	lookup_or_create_commit_objects_for_submodule_path(...

Which seems quite extensively long for a static function so how about
we shorten it a bit and add a comment:

	/* lookup or create commit object list for submodule */
	get_commit_objects_for_submodule_path(...

?

Cheers Heiko
