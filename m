Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BDD81F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 23:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751056AbdAYXyQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 18:54:16 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:45320 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750998AbdAYXyP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 18:54:15 -0500
Received: from glandium by mitsuha.glandium.org with local (Exim 4.88)
        (envelope-from <mh@glandium.org>)
        id 1cWXOE-0002l4-JV; Thu, 26 Jan 2017 08:54:10 +0900
Date:   Thu, 26 Jan 2017 08:54:10 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] gpg-interface: Add some output from gpg when it errors
 out.
Message-ID: <20170125235410.byxwmo7o7zdszzot@glandium.org>
References: <20170125030434.26448-1-mh@glandium.org>
 <xmqqtw8m7ncp.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtw8m7ncp.fsf@gitster.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 03:04:38PM -0800, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > For instance, after changing my laptop for a new one, I copied my
> > configs, but had some environment differences that broke gpg.
> > With this change applied, the output becomes, on this new machine:
> >   gpg: keyblock resource '/usr/share/keyrings/debian-keyring.gpg': No
> > such file or directory
> >   error: gpg failed to sign the data
> >   error: unable to sign the tag
> >
> > which makes it clearer what's wrong.
> 
> Overall I think this is a good thing to do.  Instead of eating the
> status output, showing what we got, especially when we know the
> command failed, would make the bug-hunting of user's environment
> easier, like you showed above.
> 
> The only thing in the design that makes me wonder is the filtering
> out based on "[GNUPG:]" prefix.  Why do we need to filter them out?

The [GNUPG:] lines are part of the status-fd protocol. They show details
that don't really seem interesting to the user. In fact, they even
contain the signed message (yes, in my case, it turns out gpg was
actually still signing, but returned an error code...).

For instance, in that failed run above, the entire output looks like:

gpg: keyblock resource '/usr/share/keyrings/debian-keyring.gpg': No
such file or directory
[GNUPG:] ERROR add_keyblock_resource ...
[GNUPG:] KEY_CONSIDERED ...
[GNUPG:] BEGIN_SIGNING H2
[GNUPG:] SIG_CREATED ...

All the [GNUPG:] lines are implementation details that don't seem
particularly useful. A case could be made for the ERROR one, though,
although it's also implementation detail-y.

> Implementation-wise, I'd be happier if we do not add any new
> callsites of strbuf_split(), which is a horrible interface.  But
> that is a minor detail.

What would you suggest otherwise?

Mike
