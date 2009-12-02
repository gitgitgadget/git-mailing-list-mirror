From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC PATCH 0/8] Git remote helpers to implement smart
 transports.
Date: Wed, 2 Dec 2009 07:50:48 +0200
Message-ID: <20091202055048.GA31244@Knoppix>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <fabb9a1e0912010812t4de8027dj1faf828051d1adc2@mail.gmail.com>
 <20091201165245.GF21299@spearce.org>
 <20091201171908.GA15436@Knoppix>
 <20091201193009.GM21299@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 02 06:50:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFi78-00059B-9H
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 06:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbZLBFur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 00:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbZLBFuq
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 00:50:46 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:41581 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbZLBFuq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 00:50:46 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 9CD1618D1DB;
	Wed,  2 Dec 2009 07:50:51 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A05A9761331; Wed, 02 Dec 2009 07:50:51 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 4D5834033;
	Wed,  2 Dec 2009 07:50:49 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20091201193009.GM21299@spearce.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134299>

On Tue, Dec 01, 2009 at 11:30:09AM -0800, Shawn O. Pearce wrote:
> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
> > 
> > For instance, to support new types of authentication for smart transports
> > without patching client git binaries (SSH has lots of failure modes that
> > are quite nasty to debug) or abusing GIT_PROXY (yuck). 
> 
> So the bulk of this series is about making a proxy for git://
> easier to tie into git?

This is making the "layer 5/6" parts of git:// easier to replace, for whatever
reason that replacement may be desired (and the lower layer is just assumed to
be some kind of full-duplex link).

The part about abusing GIT_PROXY is _very_ nasty hack to be able to layer 6
gateway git smart transports.

The git:// protocol stack is: 
- Git smart transport subprotocols (upload-pack, upload-archive and receive-pack)
- git:// (request signaling and data passing)
- TCP/IP (or comparable)

And ssh://:

- Git smart transport subprotocols (upload-pack, upload-archive and receive-pack)
- SSH (request signaling, data passing, encrypt & auth).
- TCP/IP (or comparable)

Smart-HTTP:

- RPC versions of git smart transport subprotocols
- HTTP
- TLS (optional)
- TCP/IP (or comparable)

This is about:

- Git smart transport subprotocols (upload-pack, upload-archive and receive-pack)
- Some prtocol layer(s) (request signaling, data passing, maybe encrypt & auth, etc...)
- TCP/IP (or comparable)

> Forgive me if I sound stupid, but for gits:// shouldn't that just
> be a matter of git_connect() forking a git-remote-gits process
> linked against openssl?  Or, maybe it just runs `openssl s_client`?

gits:// was just an example. There can be other interesting stuff (I don't
even pretend my imagination is the limit). And I would rather link the gits://
handler to GnuTLS than OpenSSL, but that's seperate matter...

As for "other interesting stuff": Smart transport using Kerberos auth (just
throwing ideas, probably not going to implement that)?

> Why go through all of this effort of making a really generic proxy
> protocol system when the long-term plan is to just ship native
> gits:// support as part of git-core?

gits:// is not actual goal of this series. Its just something to build on
top of it.

-Ilari
