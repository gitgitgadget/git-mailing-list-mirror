From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] receive-pack, fetch-pack: reject bogus pack that records
 objects twice
Date: Fri, 18 Nov 2011 15:50:51 -0800
Message-ID: <CAJo=hJukf1C56-rSurJm5voKw+8T9up=9_Umhn032n4rNnLviw@mail.gmail.com>
References: <7v7h2znv36.fsf@alter.siamese.dyndns.org> <20111118103355.GA4854@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 19 00:51:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRYDF-0000pF-Ar
	for gcvg-git-2@lo.gmane.org; Sat, 19 Nov 2011 00:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756593Ab1KRXvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 18:51:13 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63608 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753697Ab1KRXvM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 18:51:12 -0500
Received: by ggnr5 with SMTP id r5so680541ggn.19
        for <git@vger.kernel.org>; Fri, 18 Nov 2011 15:51:12 -0800 (PST)
Received: by 10.101.3.15 with SMTP id f15mr1331522ani.160.1321660272195; Fri,
 18 Nov 2011 15:51:12 -0800 (PST)
Received: by 10.147.167.10 with HTTP; Fri, 18 Nov 2011 15:50:51 -0800 (PST)
In-Reply-To: <20111118103355.GA4854@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185686>

On Fri, Nov 18, 2011 at 02:33, Jeff King <peff@peff.net> wrote:
> On Wed, Nov 16, 2011 at 10:04:13PM -0800, Junio C Hamano wrote:
>
>> When receive-pack & fetch-pack are run and store the pack obtained over
>> the wire to a local repository, they internally run the index-pack command
>> with the --strict option. Make sure that we reject incoming packfile that
>> records objects twice to avoid spreading such a damage.
>
> If we are fixing a thin pack (which should be the case most of the
> time), we are rewriting the packfile anyway. Shouldn't we just omit
> the duplicate?
>
> I guess I'm a little confused about what is generating these duplicates.
> A buggy git? A malicious server? Bad luck?

A buggy Git. We found a case where JGit could generate duplicate
objects in the pack stream during a clone. The resulting client
worked... until it tried to do `git gc` or really any sort of `git
pack-objects`.

In my opinion, a pack should never contain duplicate objects. Its a
buggy remote that sends them. What I like about this patch is it stops
and tells the user the remote is broken, which it is.
