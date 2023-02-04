Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AF3C61DA4
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 11:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjBDLJg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 06:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjBDLJf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 06:09:35 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7119A46705
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 03:09:33 -0800 (PST)
Received: (qmail 3426 invoked by uid 109); 4 Feb 2023 11:09:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Feb 2023 11:09:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18036 invoked by uid 111); 4 Feb 2023 11:09:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 04 Feb 2023 06:09:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 4 Feb 2023 06:09:31 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v2 6/6] imap-send: correctly report "host" when using
 "tunnel"
Message-ID: <Y94866yd3adoC1o9@coredump.intra.peff.net>
References: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
 <patch-v2-6.6-686febb8cdc-20230202T093706Z-avarab@gmail.com>
 <Y91J+P5P9gV1Dygm@coredump.intra.peff.net>
 <230203.86bkmabfjr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <230203.86bkmabfjr.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 03, 2023 at 10:12:27PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Except that mutt config is different than the imap-send case in that it
> would presumably break if you changed:
> 
> 	set folder = imap://example.com/
> 	set tunnel = "ssh example.com /etc/rimapd"
> 
> So that one of the two was example.org instead of example.com (or
> whatever).

No, it would be perfectly happy (and in fact they do not exactly match
in my config). When you have a tunnel, that is the authoritative way to
get to the host, and the hostname mostly becomes a label. But
importantly, it is still used for certain things like local cache keys,
which would be shared with a non-tunnel connection to the same name.
Recent versions of mutt do also use the hostname for TLS verification,
if your tunnel is not itself secure (though this is not the default; you
have to set special options to tell it so).

> I agree that "give this to the auth helper" might be useful in general,
> but our current documentation says:
> 
> 	To use the tool, `imap.folder` and either `imap.tunnel` or `imap.host` must be set
> 	to appropriate values.
> 
> And the docs for "imap.tunnel" say "Required when imap.host is not set",
> and "imap.host" says "Ignored when imap.tunnel is set, but required
> otherwise".
> 
> Perhaps we should bless this as an accidental feature instead of my
> proposed patch, but that's why I made this change. It seemed like an
> unintentional bug that nobody intended.

Yes, I agree that the scenario I'm giving is contrary to what the docs
say. But IMHO it is worth preferring what the code does now versus what
the docs say. The current behavior misbehaves if you configure things
badly (accidentally mix and match imap.host and imap.tunnel). Your new
behavior misbehaves if you have two correctly-configure imap stanzas
(both with a host/tunnel combo). Those are both fairly unlikely
scenarios, and the outcomes are similar (we mix up credentials), but:

  1. In general, all things being equal, I'd rather trust the code as
     the status quo. People will complain if you break their working
     setup. They won't if you fix the documentation.

  2. In the current behavior, if it's doing the wrong thing, your next
     step is to fix your configuration (don't mix and match imap.host
     and imap.tunnel). In your proposed behavior, there is no fix. You
     are simply not allowed to use two different imap tunnels with
     credential helpers, because the helpers don't receive enough
     context to distinguish them.

     And that is not even "two imap tunnels in the same config". It is
     really per user. If I have two repositories, each with
     "imap.tunnel" in their local config, they will still invoke the
     same credential helpers, and both will just see host=tunnel. The
     namespace for "host" really is global and should be unique (ideally
     across the Internet, but at the very least among the hosts that the
     user contacts).

One fix would be to pass the tunnel command as the hostname. But even
that has potential problems. Certainly you'd have to tweak it (it's a
shell command, and hostnames have syntactic restrictions, including
forbidding newlines). And you'd probably want to swap out protocol=imap
for something else. But I'm not sure if helpers may complain (e.g., I
seem to recall that the osxkeychain helper translates protocol strings
into integer constants that the keychain API understands).

> Especially as you're focusing on the case where it contrary to the docs
> would do what you mean, but consider (same as the doc examples, but the
> domains are changed):
> 
> 	[imap]
> 	    folder = "INBOX.Drafts"
> 	    host = imap://imap.bar.com
> 	    user = bob
> 	    pass = p4ssw0rd
> 
> 	[imap]
> 	    folder = "INBOX.Drafts"
> 	    tunnel = "ssh -q -C user@foo.com /usr/bin/imapd ./Maildir 2> /dev/null"
> 	
> I.e. I have a config for "bar.com" I tried earlier, but now I'm trying
> to connect to "foo.com", because I read the docs and notice it prefers
> "tunnel" to "host" I think it's going to ignore that "imap.host", but
> it's going to provide the password for bar.com to foo.com if challenged.

Yes, that's a rather unfortunate effect of the way we do config parsing
(it looks to the user like stanzas, but we don't parse it that way; the
second stanza could even be in a different file!).

Though as I said above, I still think this case does not justify making
the code change, I do think it's the most compelling argument, and would
make sense to include in the commit message if we did want to do this.

> So I think if we want to keep this it would be better to have a
> imap.tunnel.credentialHost or something, to avoid conflating the two.

Yes, there are many config schemes that would avoid this problem. If you
are going to tie the two together, I think it would make sense to use
real subsections based on the host-name, like:

  # hostname is the subsection key; it also becomes a label when
  # necessary
  [imap "example.com"]

  # does not even need to mention a hostname. We'll assume example.com
  # here.
  tunnel = "any-command"

  # assumes example.com as hostname; not needed if you are using a
  # tunnel, of course
  protocol = imaps

But I would not bother going to that work myself. IMHO imap-send is
somewhat of an abomination, and I'd actually be just as happy if it went
away. But what you are doing seems to go totally in the wrong direction
to me (keeping it, but breaking a rare but working use case to the
benefit of a rare but broken misconfiguration).

> > Of course if you don't set imap.host, then we don't have anything useful
> > to say. But as you saw, in that case imap-send will default the host
> > field to the word "tunnel".
> 
> Isn't that more of a suggestion that nobody cares about this? Presumably
> if we had users trying to get this to work someone would have complained
> that they wanted a custom string rather than "tunnel", as the auth
> helper isn't very helpful in that case...

Not if they did:

  [imap]
  host = example.com
  tunnel = some-command

-Peff
