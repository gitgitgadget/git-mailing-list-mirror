Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 782BC1F461
	for <e@80x24.org>; Thu, 16 May 2019 01:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfEPBqX (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 21:46:23 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:35930 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbfEPAsS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 20:48:18 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1hR4Z0-0006sa-PY; Thu, 16 May 2019 09:48:02 +0900
Date:   Thu, 16 May 2019 09:48:02 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: Closing fds twice when using remote helpers
Message-ID: <20190516004802.fmtdz52xxcplkgcf@glandium.org>
References: <20190515105609.sucfjvuumeyyrmjb@glandium.org>
 <87bm04vt81.fsf@evledraar.gmail.com>
 <b6ff2486-a1c2-4e89-4338-9e4e56d528bc@kdbg.org>
 <20190515220834.svurujspjt3bmath@glandium.org>
 <20190515235339.GA3579@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515235339.GA3579@sigill.intra.peff.net>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 15, 2019 at 07:53:40PM -0400, Jeff King wrote:
> On Thu, May 16, 2019 at 07:08:34AM +0900, Mike Hommey wrote:
> 
> > > >> - Except, well, fds being what they are, we in fact just closed a fd
> > > >>   from a packed_git->pack_fd. So, when use_pack is later called, and
> > > >>   tries to mmap data from that pack, it fails because the file
> > > >>   descriptor was closed.
> > > 
> > > Either dup() the file descriptor, or mmap() before you call the
> > > consuming start_command().
> 
> If I understand your case correctly, the mmap() is not relevant.  The
> issue is that we close a random file descriptor accidentally, and it
> just happens to be a pack descriptor later on. Right?
> 
> > You seem to imply this is my code doing something. It's not. The process
> > that is doing all the things I noted above is an unmodified `git fetch`,
> > when using a remote-helper transport. The use_pack happens after the
> > transport is disposed because that's at the end of git fetch, when it
> > updates refs.
> 
> Yes, it's a bug in git.
> 
> > Anyway, it would seem the fix is to dup(out) when passing it as in to
> > start_command?
> 
> Generally, yes. It looks like maybe this spot?
> 
> diff --git a/transport-helper.c b/transport-helper.c
> index fcd2a58d0e..45cdf891ec 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -433,7 +433,7 @@ static int get_importer(struct transport *transport, struct child_process *fasti
>  	struct helper_data *data = transport->data;
>  	int cat_blob_fd, code;
>  	child_process_init(fastimport);
> -	fastimport->in = helper->out;
> +	fastimport->in = xdup(helper->out);
>  	argv_array_push(&fastimport->args, "fast-import");
>  	argv_array_push(&fastimport->args, debug ? "--stats" : "--quiet");
>  
> 
> One thing I'd wonder, though: what is the contract between the helper
> and fast-import here? In the current code, when the helper closes its
> stdout, fast-import will see EOF. But not if we are holding on to
> another copy of the descriptor.

The helper is supposed to finish the fast-import stream with "done".
The documentation doesn't say much, but it also seems like the helper
could theoretically continue to respond to commands it's sent after
having done so, but that currently never happens AFAICT.

Mike
