Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B7BC433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 05:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B866761350
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 05:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhJEFRX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 01:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhJEFRW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 01:17:22 -0400
X-Greylist: delayed 1266 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Oct 2021 22:15:32 PDT
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F33C061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 22:15:32 -0700 (PDT)
Received: from [2400:4160:1877:2b00:410a:fd15:2718:8b5d] (helo=glandium.org)
        by vuizook.err.no with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1mXcT3-0002iW-OO; Tue, 05 Oct 2021 04:54:21 +0000
Received: from glandium by goemon.lan with local (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1mXcSy-002Rgh-OA; Tue, 05 Oct 2021 13:54:12 +0900
Date:   Tue, 5 Oct 2021 13:54:12 +0900
From:   Mike Hommey <mh@glandium.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] Don't ignore transport_disconnect error codes in fetch
 and clone
Message-ID: <20211005045412.pqwsid6gpprxajbw@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <20210928001726.2592734-1-mh@glandium.org>
 <874ka5z9pz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874ka5z9pz.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Sorry for the delay, I managed to miss this reply.

On Tue, Sep 28, 2021 at 04:56:37AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Sep 28 2021, Mike Hommey wrote:
> 
> > When a remote-helper fails in a way that is not directly visible in the
> > remote-helper protocol, the helper failure is ignored by git during
> > fetch or clone.
> >
> > For example, a helper cannot directly report an error during an `import`
> > command (short of sending `feature done` to the fast-import file
> > descriptor and not sending a `done` later on).
> >
> > Or if the helper crashes at the wrong moment, git doesn't notice and
> > thinks everything went well.
> >
> > Signed-off-by: Mike Hommey <mh@glandium.org>
> > ---
> >  builtin/clone.c | 5 +++--
> >  builtin/fetch.c | 6 +++---
> >  2 files changed, 6 insertions(+), 5 deletions(-)
> >
> > What I'm not sure about is whether a message should be explicitly
> > printed by git itself in those cases.
> >
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index 66fe66679c..f26fa027c5 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -1398,7 +1398,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
> >  	submodule_progress = transport->progress;
> >  
> >  	transport_unlock_pack(transport);
> > -	transport_disconnect(transport);
> > +	err = transport_disconnect(transport);
> >  
> >  	if (option_dissociate) {
> >  		close_object_store(the_repository->objects);
> > @@ -1406,7 +1406,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
> >  	}
> >  
> >  	junk_mode = JUNK_LEAVE_REPO;
> > -	err = checkout(submodule_progress);
> > +	if (!err)
> > +		err = checkout(submodule_progress);
> >  
> >  	free(remote_name);
> >  	strbuf_release(&reflog_msg);
> 
> This seems buggy in some cases, e.g. just because we couldn't close()
> some final socket we should just not run the checkout at all? Shouldn't
> we note the disconnect status, but still see if we can do the checkout
> etc?

I guess it could be seen both ways. In my particular use case, I do want
automated testing to be able to catch Leak Sanitizer failures from a
remote-helper.

> > diff --git a/builtin/fetch.c b/builtin/fetch.c
> > index 25740c13df..66bccf6f50 100644
> > --- a/builtin/fetch.c
> > +++ b/builtin/fetch.c
> > @@ -1886,7 +1886,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
> >  {
> >  	struct refspec rs = REFSPEC_INIT_FETCH;
> >  	int i;
> > -	int exit_code;
> > +	int exit_code, disconnect_code;
> >  	int maybe_prune_tags;
> >  	int remote_via_config = remote_is_configured(remote, 0);
> >  
> 
> 
> > @@ -1952,9 +1952,9 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
> >  	exit_code = do_fetch(gtransport, &rs);
> >  	sigchain_pop(SIGPIPE);
> >  	refspec_clear(&rs);
> > -	transport_disconnect(gtransport);
> > +	disconnect_code = transport_disconnect(gtransport);
> >  	gtransport = NULL;
> > -	return exit_code;
> > +	return exit_code || disconnect_code;
> >  }
> >  
> >  int cmd_fetch(int argc, const char **argv, const char *prefix)
> 
> This seems like it really needs fixes in other areas,
> i.e. disconnect_git() returns 0 unconditionally, but should check at
> least finish_connect(), no?
> 
> Also once that's done you'll have a logic error here where you're
> conflating exit and error codes, we should not return -1 from main() (we
> do in a few cases, but it's nasty)>

transport_disconnect returns the remote-helper exit code for external
helpers, though, but I guess we don't necessarily need to return that
particular exit code.

Mike
