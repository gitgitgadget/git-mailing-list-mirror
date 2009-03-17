From: Jeff King <peff@peff.net>
Subject: Re: Transparently encrypt repository contents with GPG
Date: Tue, 17 Mar 2009 04:22:39 -0400
Message-ID: <20090317082239.GF18475@coredump.intra.peff.net>
References: <978bdee00903121419o61cd7a87rb55809796bd257d7@mail.gmail.com> <fabb9a1e0903121434u4a3d71bdi6277071f54557a7e@mail.gmail.com> <49BA39A1.9090203@drmicha.warpmail.net> <200903131215.49336.trast@student.ethz.ch> <fabb9a1e0903130417x36121bd5ya8b323e0a80bbd8f@mail.gmail.com> <49BA6606.1070403@fastmail.fm> <7vy6v9f9zn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthias Nothhaft <matthias.nothhaft@googlemail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 09:24:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjUaw-00062x-Vj
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 09:24:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873AbZCQIWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 04:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752723AbZCQIWu
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 04:22:50 -0400
Received: from peff.net ([208.65.91.99]:55822 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752700AbZCQIWs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 04:22:48 -0400
Received: (qmail 2854 invoked by uid 107); 17 Mar 2009 08:22:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 17 Mar 2009 04:22:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Mar 2009 04:22:39 -0400
Content-Disposition: inline
In-Reply-To: <7vy6v9f9zn.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113436>

On Fri, Mar 13, 2009 at 01:23:08PM -0700, Junio C Hamano wrote:

> As the sole raison d'etre of diff.textconv is to allow potentially lossy
> conversion (e.g. msword-to-text) applied to the preimage and postimage
> pair of contents (that are supposed to be "clean") before giving a textual
> diff to human consumption, the above config may appear to work, but if you
> really want an encrypted repository, you should be using an encrypting
> filesystem.  That would give an added benefit that the work tree
> associated with your repository would also be encrypted.

I can think of one reason that having git do the encryption might be
beneficial: pushing to an untrusted source.

If you encrypted all blobs but kept trees and commits in plaintext, you
could retain (some of) the benefits of git's incremental push. The
downsides, though, are:

  1. You are revealing the hashes of your blobs' plaintext. Which means
     I can try brute-forcing your blobs by checking against a hash
     function.

  2. The remote can't actually look at the blobs. The most obvious
     problem with this is that you can't send it thin packs, since it
     can't actually resolve deltas.

And given the ensuing mess that it would make of the code to
conditionally say "Oh, we have this object, but you're not allowed to
read it", it is almost certainly not worth it.

But maybe somebody can prove me wrong and design a system that allows
efficient encrypted pushing to a non-trusted remote and also doesn't
suck.

-Peff
