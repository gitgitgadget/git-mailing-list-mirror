From: Lukas Fleischer <lfleischer@lfos.de>
Subject: Re: [PATCH/RFC] receive-pack: allow for hiding refs outside the namespace
Date: Wed, 28 Oct 2015 08:00:45 +0100
Message-ID: <20151028070045.5031.43810@s-8d3a2f8b.on.site.uni-stuttgart.de>
References: <1445846999-8627-1-git-send-email-lfleischer@lfos.de>
 <xmqqk2q9h05h.fsf@gitster.mtv.corp.google.com>
 <20151027053916.3030.8259@typhoon.lan>
 <20151027055911.4877.94179@typhoon.lan>
 <20151027143207.18755.82151@s-8d3a2f8b.on.site.uni-stuttgart.de>
 <xmqqfv0wcgzx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 08:00:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrKjC-00082Q-SQ
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 08:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512AbbJ1HAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 03:00:49 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:12941 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755122AbbJ1HAs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Oct 2015 03:00:48 -0400
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id 8a1780d2;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Wed, 28 Oct 2015 08:00:47 +0100 (CET)
In-Reply-To: <xmqqfv0wcgzx.fsf@gitster.mtv.corp.google.com>
User-Agent: alot/0.3.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280355>

On Tue, 27 Oct 2015 at 19:18:26, Junio C Hamano wrote:
> [...]
> When I asked 'Is transfer.hiderefs insufficient?', I wasn't
> expecting it to be usable out of box.  It was a suggestion to build
> on top of it, instead of adding a parallel support for something
> specific to namespaces.
> 

Agreed, and I do have a couple of patches to improve hideRefs. I still
have some questions before submitting them, though. See below.

> For example, if the problem is that you cannot tell ref_is_hidden()
> what namespace the ref is from because it is called after running
> strip_namespace(), perhaps you can find a way to have the original
> "namespaced ref" specified on transfer.hiderefs and match them?
> Then in repository for project A, namespaced refs for project B can
> be excluded by specifying refs/namespaces/B/* on transfer.hiderefs.
> 
> Perhaps along the lines of this?
> [...]

My original question remains: Do we want to continue supporting things
like transfer.hideRefs=.have (which currently magically hides all refs
outside the current namespace)? For 100% backwards compatibility, we
would have to. On the other hand, one could consider the current
behavior a bug and one could argue that it is weird enough that probably
nobody (apart from me) relies on it right now. If we decide to keep it
anyway, I think it should be documented.

Another patch I have in my patch queue adds support for a whitelist mode
to hideRefs. There are several ways to implement that:

1. Make transfer.hideRefs='' hide all refs (it currently does not). The
   user can then whitelist refs explicitly using negative patterns
   below that rule. This is how my current implementation works. Using
   the empty string seemed most natural since hideRefs matches prefixes
   and every string has the empty string as a prefix. If that seems too
   weird, we could probably special case something like
   transfer.hideRefs='*' instead.

2. Detect whether hideRefs only contains negative patterns. Switch to
   whitelist mode ("hide by default") in that case.

3. Add another option to switch between "hide by default" and "show by
   default".

I personally prefer the first option. Any other opinions?
