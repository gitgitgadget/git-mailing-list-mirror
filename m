From: Jeff King <peff@peff.net>
Subject: Re: [RFC] tag-ref and tag object binding
Date: Wed, 27 Jan 2016 15:21:11 -0500
Message-ID: <20160127202111.GA30212@sigill.intra.peff.net>
References: <56A73DE6.5050201@drmicha.warpmail.net>
 <20160126152941.GA31951@LykOS>
 <20160126202651.GA1090@sigill.intra.peff.net>
 <56A87056.2010309@drmicha.warpmail.net>
 <20160127073357.GA7066@sigill.intra.peff.net>
 <56A87764.9070101@drmicha.warpmail.net>
 <20160127080901.GA7651@sigill.intra.peff.net>
 <56A88A69.6030503@drmicha.warpmail.net>
 <xmqqmvrq99mt.fsf@gitster.mtv.corp.google.com>
 <56A923FB.4050308@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Santiago Torres <santiago@nyu.edu>, Git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jan 27 21:21:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOWaj-0002ZT-1B
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 21:21:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965562AbcA0UVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 15:21:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:33393 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965116AbcA0UVO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 15:21:14 -0500
Received: (qmail 13068 invoked by uid 102); 27 Jan 2016 20:21:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jan 2016 15:21:14 -0500
Received: (qmail 14419 invoked by uid 107); 27 Jan 2016 20:21:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jan 2016 15:21:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jan 2016 15:21:11 -0500
Content-Disposition: inline
In-Reply-To: <56A923FB.4050308@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 27, 2016 at 09:09:31PM +0100, Michael J Gruber wrote:

> "subkey" and "uid" are different things. You bind a subkey to your
> primary key with that self-signature. subkeys don't carry any other
> signatures.
> 
> A primary key "carries" the uids, and whenever someone "signs your key"
> they in fact sign a specific uid - usually all, resulting in multiple
> signatures, one for each uid of the (primary) key.
> 
> A key is usually considered trusted if it carries "a" signature from a
> trusted key.
> 
> So, assuming my key carries a signature from a trusted key to at least
> one uid, it would be trusted no matter what (fake) uids I add to it later.

Right. I think I didn't do a good job of explaining myself earlier, so
let me try to rephrase.

When we look at the v2.7 tag, GPG sees that we are signed by Junio's
subkey, 96AFE6CB. It then knows that belongs to the main public key
713660A7, because the main key signed the subkey. And then it sees that
there are several uids for that main key, each with their own signatures
by other people.

So of the three uids that I have for that key:

  pub   4096R/713660A7 2011-10-01
  uid                  Junio C Hamano <gitster@pobox.com>
  uid                  Junio C Hamano <jch@google.com>
  uid                  Junio C Hamano <junio@pobox.com>

it reports back to git only one (the pobox.com), which we relay to the
user via --raw. If we wanted to check that the key matches the "tagger"
header, that works. But why did gpg return that first uid, and not any
of the others? We would ideally see all of them, and consider it OK if
it matches any uid (assuming that uid is sufficiently signed for gpg to
consider it valid).

Weirder, if you _don't_ use "--raw", the human-readable output gives us
all of the uids as "aka" lines:

  $ git verify-tag v2.7.0
  $ git verify-tag v2.7.0
  gpg: Signature made Mon 04 Jan 2016 05:08:12 PM EST using RSA key ID 96AFE6CB
  gpg: Good signature from "Junio C Hamano <gitster@pobox.com>"
  gpg:                 aka "Junio C Hamano <jch@google.com>"
  gpg:                 aka "Junio C Hamano <junio@pobox.com>"

  $ git verify-tag --raw v2.7.0
  [GNUPG:] SIG_ID xFANmHj+QJ1gwIcoRuT5BF/y8H4 2016-01-04 1451945292
  [GNUPG:] GOODSIG B0B5E88696AFE6CB Junio C Hamano <gitster@pobox.com>
  [GNUPG:] VALIDSIG E1F036B1FEE7221FC778ECEFB0B5E88696AFE6CB 2016-01-04 1451945292 0 4 0 1 2 00 96E07AF25771955980DAD10020D04E5A713660A7
  [GNUPG:] TRUST_FULLY

It seems like we should be able to get the raw-output to tell us all of
those uids. I guess it is not the end of the world to go back to gpg and
say "give me all of the valid uids that match this signing key", but it
seems silly to have to do so.

-Peff
