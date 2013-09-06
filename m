From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v3] Document pack v4 format
Date: Fri, 06 Sep 2013 12:44:11 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309061224350.20709@syhkavp.arg>
References: <1377917393-28460-1-git-send-email-pclouds@gmail.com>
 <1378433643-15638-1-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.03.1309052319310.20709@syhkavp.arg>
 <CACsJy8AWa0NFViO+3Cnp_0Gqzqidcbx9vPd1wxCuY1jjWhyFaQ@mail.gmail.com>
 <alpine.LFD.2.03.1309060922020.20709@syhkavp.arg>
 <CACsJy8CVaFKZE2bM+1AZPTpq19BS8-=UrYCcvO004Aw_EX-vfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_qGdJ4kPvfqaDVwnMzTSfJQ)"
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 18:44:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHz9N-0006ge-Lc
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 18:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756957Ab3IFQop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 12:44:45 -0400
Received: from relais.videotron.ca ([24.201.245.36]:21081 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756646Ab3IFQoo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 12:44:44 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSP00A91QHT3KW0@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 06 Sep 2013 12:44:17 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 6D72C2DA0547; Fri, 06 Sep 2013 12:44:16 -0400 (EDT)
In-reply-to: <CACsJy8CVaFKZE2bM+1AZPTpq19BS8-=UrYCcvO004Aw_EX-vfg@mail.gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234061>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_qGdJ4kPvfqaDVwnMzTSfJQ)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Fri, 6 Sep 2013, Duy Nguyen wrote:

> On Fri, Sep 6, 2013 at 8:25 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Fri, 6 Sep 2013, Duy Nguyen wrote:
> >
> >> On Fri, Sep 6, 2013 at 10:23 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> >> > On Fri, 6 Sep 2013, Nguy­n Thái Ng÷c Duy wrote:
> >> >
> >> >>
> >> >> Signed-off-by: Nguy­n Thái Ng÷c Duy <pclouds@gmail.com>
> >> >> ---
> >> >>  Should be up to date with Nico's latest implementation and also cover
> >> >>  additions to the format that everybody seems to agree on:
> >> >>
> >> >>   - new types for canonical trees and commits
> >> >>   - sha-1 table covering missing objects in thin packs
> >> >
> >> > Great!  I've merged this into my branch with the following amendment:
> >>
> >> I'd like to propose another change in the format to basically limit
> >> the use of sha1ref format "\0<SHA-1>" to tree entries only. All forms
> >> of deltas must have non-zero sha1 index (i.e. reference to SHA-1
> >> table). It will simplify handling code, and I think it makes sense too
> >
> > Why?
> >
> > This is still some artificial limitation and I tend not to like them.
> >
> > "Simplifying handling code" is not a good enough reason on its own,
> > especially if it reduce flexibility for possible future layout
> > optimizations.
> >
> > In what way is the code more difficult?
> 
> That'll be two ways of linking to another in-pack object. The linked
> object must be in the pack anyway, its sha-1 should be present in the
> sha-1 table. "\0<sha1>" is a longer encoding for nothing. If the
> linked sha1 is not in the pack (similar to the old ref-delta), it
> makes the pack depend on another one, which is what we've been
> avoding.

OK.  Let's say that if the needed SHA1 exists in the table then the 
sha1ref should use an index into that table.  That's a recommendation we 
can make, just like we suggest to have the ident/path tables sorted by 
usage frequency.

But even if index 0 with a SHA1 is used inline for an object in the same 
pack, it is still theoretically a valid pack even if somewhat wasteful.  
Maybe some tools in the future will benefit from this flexibility to 
simplify their implementation.

You mention that only tree objects should use this encoding, but commits 
should be allowed to use it as well.  Suppose that a commit reverts some 
changes to a pre-existing tree state.  That tree might already be in 
another pack and we shouldn't have to copy it into the current pack.  
Same goes for commit parents.  Etc.

> In your code you reject sha1ref starting with zero too
> (sha1_file.c::get_base_delta and packv4-parse.c::decode_entries)

Yeah... because I wrote the minimum code to make it work with the 
current encoder.  But the decoder could be more lenient than that.  It's 
just a matter of adding a call to find_pack_entry_one() when the sha1ref 
index is 0.


Nicolas

--Boundary_(ID_qGdJ4kPvfqaDVwnMzTSfJQ)--
