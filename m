From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2] Document pack v4 format
Date: Thu, 05 Sep 2013 17:04:03 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309051655310.14472@syhkavp.arg>
References: <1377602225-30439-1-git-send-email-pclouds@gmail.com>
 <1377917393-28460-1-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.03.1309030156410.14472@syhkavp.arg>
 <alpine.LFD.2.03.1309030231350.14472@syhkavp.arg>
 <CACsJy8CZP+55nhfEbgRGa9=y0PyExyHt_seiSc23kB31-_c1Hg@mail.gmail.com>
 <CACsJy8CzpW_xsoxU=+OE6ssbnPu9tyAqRten0=Q5cxPUZ4aeMw@mail.gmail.com>
 <alpine.LFD.2.03.1309042350560.14472@syhkavp.arg>
 <CACsJy8BeU_01c0f5RJExcYo7xGETnduKOw-_shszHd0ZFgZDXw@mail.gmail.com>
 <alpine.LFD.2.03.1309050024090.14472@syhkavp.arg>
 <CACsJy8CX=4Oz_h2NtS3FRdK6_zdFksa+JR5C6Z-z3Y70PLAsyQ@mail.gmail.com>
 <alpine.LFD.2.03.1309050131000.14472@syhkavp.arg>
 <CACsJy8DKL9KnPAXcf+NPU_Y5J1Dz_pYxSpONN4LxcQVi1JOBYw@mail.gmail.com>
 <alpine.LFD.2.03.1309051311070.14472@syhkavp.arg>
 <xmqq1u53hv6l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 05 23:04:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHgiq-0003z4-Di
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 23:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754519Ab3IEVEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 17:04:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30720 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124Ab3IEVEG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 17:04:06 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSO001AO7URLTC0@VL-VM-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 17:04:03 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 5DAC92DA0547; Thu, 05 Sep 2013 17:04:03 -0400 (EDT)
In-reply-to: <xmqq1u53hv6l.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233991>

On Thu, 5 Sep 2013, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > On Thu, 5 Sep 2013, Duy Nguyen wrote:
> >
> >> On Thu, Sep 5, 2013 at 12:39 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> >> > Now the pack index v3 probably needs to be improved a little, again to
> >> > accommodate completion of thin packs.  Given that the main SHA1 table is
> >> > now in the main pack file, it should be possible to still carry a small
> >> > SHA1 table in the index file that corresponds to the appended objects
> >> > only. This means that a SHA1 search will have to first use the main SHA1
> >> > table in the pack file as it is done now, and if not found then use the
> >> > SHA1 table in the index file if it exists.  And of course
> >> > nth_packed_object_sha1() will have to be adjusted accordingly.
> >> 
> >> What if the sender prepares the sha-1 table to contain missing objects
> >> in advance? The sender should know what base objects are missing. Then
> >> we only need to append objects at the receiving end and verify that
> >> all new objects are also present in the sha-1 table.
> >
> > I do like this idea very much.  And that doesn't increase the thin pack 
> > size as the larger SHA1 table will be compensated by a smaller sha1ref 
> > encoding in those objects referring to the missing ones.
> 
> Let me see if I understand the proposal correctly.  Compared to a
> normal pack-v4 stream, a thin pack-v4 stream:
> 
>  - has all the SHA-1 object names involved in the stream in its main
>    object name table---most importantly, names of objects that
>    "thin" optimization omits from the pack data body are included;
> 
>  - uses the SHA-1 object name table offset to refer to other
>    objects, even to ones that thin stream will not transfer in the
>    pack data body;
> 
>  - is completed at the receiving end by appending the data for the
>    objects that were not transferred due to the "thin" optimization.
> 
> So the invariant "all objects contained in the pack" in:
> 
>  - A table of sorted SHA-1 object names for all objects contained in
>    the pack.
> 
> that appears in Documentation/technical/pack-format.txt is still
> kept at the end, and more importantly, any object that is mentioned
> in this table can be reconstructed by using pack data in the same
> packfile without referencing anything else.  Most importantly, if we
> were to build a v2 .idx file for the resulting .pack, the list of
> object names in the .idx file would be identical to the object names
> in this table in the .pack file.

That is right.

> If that is the case, I too like this.
> 
> I briefly wondered if it makes sense to mention objects that are
> often referred to that do not exist in the pack in this table
> (e.g. new commits included in this pack refer to a tree object that
> has not changed for ages---their trees mention this subtree using a
> "SHA-1 reference encoding" and being able to name the old,
> unchanging tree with an index to the object table may save space),
> but that would break the above invariant in a big way---some objects
> mentioned in the table may not exist in the packfile itself---and it
> probably is not a good idea.

Yet, if an old tree that doesn't change is often referred to, it should 
be possible to have only one such reference in the whole pack and all 
the other trees can use a delta copy sequence to refer to it.  At this 
point whether or not the tree being referred to is listed inline or in 
the SHA1 table doesn't make a big difference.

> Unlike that broken idea, "include
> names of the objects that will be appended anyway" approach to help
> fattening a thin-pack makes very good sense to me.
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
