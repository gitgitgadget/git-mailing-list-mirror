From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 7/7] Factor ref updating out of fetch_with_import
Date: Thu, 29 Oct 2009 13:22:30 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910291311570.14365@iabervon.org>
References: <1256798426-21816-1-git-send-email-srabbelier@gmail.com>  <1256798426-21816-8-git-send-email-srabbelier@gmail.com> <20091029142232.GS10505@spearce.org>  <fabb9a1e0910290853p49070443v6d6bf2bf75faf80@mail.gmail.com>  <20091029155607.GA10505@spearce.org>
 <fabb9a1e0910290932u45c9c416m4d0ba0a8b2f5b01d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-1513267739-1256836950=:14365"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 18:22:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Yhp-0002Db-V8
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 18:22:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756467AbZJ2RW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 13:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755796AbZJ2RW1
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 13:22:27 -0400
Received: from iabervon.org ([66.92.72.58]:46418 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755688AbZJ2RW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 13:22:26 -0400
Received: (qmail 13705 invoked by uid 1000); 29 Oct 2009 17:22:30 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Oct 2009 17:22:30 -0000
In-Reply-To: <fabb9a1e0910290932u45c9c416m4d0ba0a8b2f5b01d@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131616>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-1513267739-1256836950=:14365
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 29 Oct 2009, Sverre Rabbelier wrote:

> Heya,
> 
> On Thu, Oct 29, 2009 at 08:56, Shawn O. Pearce <spearce@spearce.org> wrote:
> >> > I certainly have to wonder... if this is done in both fetch and
> >> > clone, why isn't it just part of fetch_refs?
> >>
> >> Because clone does not use fetch_refs, or am I missing something?
> >
> > Hmmph.  Weird.  Its been a while since I last looked at this code,
> > maybe I misunderstood it.
> 
> Unless you mean transport_fetch_refs? It can't be done in
> transport_fetch_refs because the foreign helper transport needs to
> update all refs, including those that wanted_peer_refs decided not to
> fetch. Otherwise the 'HEAD' ref will not be updated, and it is left at
> all zeros. It is not as obvious that that is a problem in this patch,
> but when Junio merges with Nico's [5bdc32d3e "make 'git clone' ask the
> remote only for objects it cares about"] the code looks like this:
> 
> 		if (refs) {
> 			struct ref *ref_cpy;
> 			mapped_refs = wanted_peer_refs(refs, refspec);
> 			ref_cpy = copy_ref_list(mapped_refs);
> 			transport_fetch_refs(transport, ref_cpy);
> 			if (transport->update_refs)
> 			{
> 				ref_cpy = copy_ref_list(refs);
> 				transport->update_refs(transport, ref_cpy);
> 				refs = ref_cpy;
> 				mapped_refs = wanted_peer_refs(refs, refspec);
> 			}
> 		}
> 
> Does it make more sense now? transport_fetch_refs gets only a limited
> view of the refs, so it cannot pass all the refs to
> transport_update_refs as needed.

I think there are a bunch of bugs that you're working around:

(a) if HEAD is determined to be a symref, and we care about HEAD, we care 
about whatever HEAD is a symref to; wanted_peer_refs() shouldn't be 
filtering such things out.

(b) we don't want to make a whole bunch of copies of the ref list to avoid 
updating the mutable ref list that we will look for updated values in; the 
merge of my series with Nico's should replace my copy_ref_list with his 
wanted_peer_refs, not include the copy afterwards. Correcting this should 
lead to the value that matters in the list that will be used having been 
updated directly by transport_fetch_refs().

	-Daniel
*This .sig left intentionally blank*
--1547844168-1513267739-1256836950=:14365--
