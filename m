From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC PATCH 0/8] Git remote helpers to implement smart
 transports.
Date: Wed, 2 Dec 2009 21:25:08 +0200
Message-ID: <20091202192507.GB10228@Knoppix>
References: <20091201165245.GF21299@spearce.org>
 <20091201171908.GA15436@Knoppix>
 <20091201193009.GM21299@spearce.org>
 <7vskbuwhmy.fsf@alter.siamese.dyndns.org>
 <20091202055632.GD31244@Knoppix>
 <7vy6llnar5.fsf@alter.siamese.dyndns.org>
 <20091202160446.GA32667@Knoppix>
 <alpine.DEB.1.00.0912021832480.4985@pacific.mpi-cbg.de>
 <fabb9a1e0912021006x2905578bo16dbcaedc0d97bc6@mail.gmail.com>
 <7vk4x5fcbf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 20:25:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFupH-00021t-GY
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 20:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754833AbZLBTZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 14:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753618AbZLBTZJ
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 14:25:09 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:56816 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbZLBTZI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 14:25:08 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 26D42C7C9D;
	Wed,  2 Dec 2009 21:25:14 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A062B6D0356; Wed, 02 Dec 2009 21:25:13 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id CAD174045;
	Wed,  2 Dec 2009 21:25:08 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <7vk4x5fcbf.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134377>

On Wed, Dec 02, 2009 at 10:41:40AM -0800, Junio C Hamano wrote:
> Sverre Rabbelier <srabbelier@gmail.com> writes:
> 
> >> Of course, I never understood why the backend should know the
> >> implementation detail that it is based on cURL, so it would be even more
> >> modular (at least by my definition) if there was no hard-coded mapping.
> >
> > Agreed.
> 
> I don't get this point at all.
> 
> Backend is _very_ aware of how it is implemented itself.  Naming one
> implementation git-remote-http is to declare that "I am the one and only
> implementation of http handler" and forces another implementation of http
> handler, perhaps based on different toolkit than libcurl, to forever be a
> second class citizen that need to use name other than 'http'.

At least it can be called as 'foo::http://' (That may be tolerable for
alternate implementations but not for primary ones).

> The "mapping" you two are calling "hard-coded" may be "hard-coded" but is
> a better kind of hard-coding than hard-coding "http" to "this particular
> implementation" implicitly like you two seem to be advocating.  Think of
> it as having one extra layer of indirection.

Its already indirected: By filesystem.

> When the second implementation of http handler proves to be better than
> the current one, we can flip the mapping, and anybody who were using
> "http://" to access some repository will automatically updated to use the
> new backend instead of the old one.  With your scheme, you probably could
> change the name of the old "http" backend to "http-deprecated" and the new
> one from "second-class-citizen-http" to "http" to achieve a similar
> effect, but I do not think it is as nice as having one extra level of
> indirection.

The new HTTP support must either be internal or not. And:

- If it is internal, renaming can be done anyway.
- If it is not, change can not be made.

And at package manager level, this is what 'conflicts: ' is about (and
alternates of apt).

> > However, I am not convinced that we should do any magic to map
> > "foo://" to git-remote-foo. On the other hand, I do think it makes
> > sense to have something modular that allows "git-remote-http" to be
> > implemented as a separate package that can be installed.
> 
> As I said, I do think modular is good, but I think what Dscho is
> advocating does not have much to achieve that goal.

Why should adding new git native protocol (that doesn't have so special
capabilities new core support is fundamentially required) require recompiling
git core? Why it should require more than dropping executable handler to
suitable place?[*]

Why should such protocols need to be specified 'foo::foo://'?

Granted, even with current dispatch meachanisms, its possible to hack
together something that accepts 'foo:://', 'foo::/' or 'foo::' but that
breaks user expectations rather badly (the U in URL stands for 'uniform')... 

And currently the URL space to be reassigned just produces fatal error
messages anyway.

[*] Merge strategies have similar issues. IMO, on encountering unknown
merge strategy, git merging code should check if there's handler for it,
if yes, obtain flags from it and then use it.

-Ilari 
