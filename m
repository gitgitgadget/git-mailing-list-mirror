Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAB60208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 21:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758775AbdHYVsn (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 17:48:43 -0400
Received: from chiark.greenend.org.uk ([212.13.197.229]:37059 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756702AbdHYVsm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 17:48:42 -0400
X-Greylist: delayed 1448 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Aug 2017 17:48:41 EDT
Received: by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with local
        (return-path ijackson@chiark.greenend.org.uk)
        id 1dlM5g-0005zO-8Z
        for git@vger.kernel.org; Fri, 25 Aug 2017 22:24:32 +0100
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <22944.38288.91698.811743@chiark.greenend.org.uk>
Date:   Fri, 25 Aug 2017 22:24:32 +0100
To:     git@vger.kernel.org
Subject: git signed push server-side
X-Mailer: VM 8.2.0b under 24.4.1 (i586-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have been investigating git signed pushes.  I found a number of
infelicities in the server side implementation which make using this
in practice rather difficult.  I'm emailing here (before writing
patches) to see what people think of my proposed changes.


1. PUSH_CERT_KEY has truncated keyid (Debian #852647)

I see this:
  GIT_PUSH_CERT_KEY=A3DBCBC039B13D8A

There is almost no purpose for which this 64-bit keyid can be safely
used.  The full key fingerprint should be provided instead.

Proposed change: provide the full fingerprint instead.  Do this
for every caller of gpg-interface.c.


2. git-receive-pack calls gpg (Debian #852684)

It would be better if it called gpgv.  gpg does all sorts of
complicated things, including automatically starting or connecting to
a gpg-agent, which are not appropriate for use in a daemon on a
server.

Additionally, I find that passing -c gpg.program=/usr/bin/gpgv
to git receive-pack is not effective, and there seems to be no
sensible way to specify the keyrings to use (although that could be
done by setting GNUPGHOME perhaps).

Proposed change: call gpgv instead (and make any needed changes to
adapt to gpgv).  Do this only when we are in git-receive-pack; other
call sites of gpg-interface.c will continue to use gpg.


3. No way to specify keyring (Debian #852684, side note)

There should be a way to specify the keyring used by
git-receive-pack's gpgv invocation.  This should probably be done with
a config option, receive.certKeyring perhaps.


4. Trouble with the nonce (Debian #852688 part 2)

To use the signed push feature it is necessary to provide a nonce seed
to git-receive-pack.

The docs say the seed must be secret but there is no documented way to
pass this seed to git that does not either write it to a git
configuration file somewhere, or pass it on a command line.  The git
configuration system is unsuited to keeping secrets.  Command lines
can be seen in ps etc.

Additionally, the seed should be changed occasionally (since
unchangeable secrets are a bad idea).  Ideally this should be done
automatically.

Analysis: the seed is used to allow the server to mostly-statelessly
verify the freshness of a client's nonce.  (This is necessary only in
connectionless transport protocols, "stateless_rpc" as
builtin/receive-pack.c has it.)

Proposed fix (in two parts):

(i) Provide a new config option receive.certNonceSeedsFile.  It
contains seeds, one per line.  When stateless_rpc, we send a nonce
computed from the first seed.  We accept nonces computed from any of
the listed seeds.  The documentation will say that the file should
normally contain two seeds; rollover is achieved by mving into place a
new seed at the top, and dropping one from the bottom.  An example
script will be provided.

(ii) At some later point, the following enhancement: When
!stateless_rpc, certNonceSeedsFile is ignored except that if neither
it nor the old certNonceSeed is set, the signed push feature is
disabled.  In this state we always get a fresh nonce (from a suitable
system random source).  Nontrivial because current git doesn't seem to
have a "get suitable random number" function, and the mess that is the
semantics of /dev/*random* files means that providing one is going to
be controversial.


5. There are no docs on how to use this feature properly
   (Debian #852695, #852688 part 1)

Using the signed push feature requires careful programming on the
server side.  There should be a doc explaining how to do this.

Proposed fix: provide a .txt file containing much the same contents as
seen here:
  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=852695


If I send patches like the above, would they be welcomed (subject to
detailed review, of course) ?

Thanks,
Ian.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.

If I emailed you from an address @fyvzl.net or @evade.org.uk, that is
a private address which bypasses my fierce spamfilter.
