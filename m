From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2 15/16] index-pack: use nr_objects_final as sha1_table
 size
Date: Mon, 09 Sep 2013 14:46:54 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309091441540.20709@syhkavp.arg>
References: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
 <1378735087-4813-1-git-send-email-pclouds@gmail.com>
 <1378735087-4813-16-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.03.1309091047510.20709@syhkavp.arg>
 <xmqq61u94zew.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_Q2yuLmnpRpyE7je0dSqzXg)"
Cc: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 20:47:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ6Uk-0003nz-9G
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 20:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888Ab3IISrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 14:47:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:58782 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970Ab3IISrV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 14:47:21 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSV00LHHG6GCT10@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Sep 2013 14:47:04 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 665D82DA0625; Mon, 09 Sep 2013 14:47:04 -0400 (EDT)
In-reply-to: <xmqq61u94zew.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234356>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_Q2yuLmnpRpyE7je0dSqzXg)
Content-type: TEXT/PLAIN; charset=utf-8
Content-transfer-encoding: 8BIT

On Mon, 9 Sep 2013, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > On Mon, 9 Sep 2013, Nguyễn Thái Ngọc Duy wrote:
> >
> >> nr_objects in the next patch is used to reflect the number of actual
> >> objects in the stream, which may be smaller than the number recorded
> >> in pack header.
> >
> > This highlights an issue that has been nagging me for a while.
> >
> > We decided to send the final number of objects in the thin pack header 
> > for two reasons:
> >
> > 1) it allows to properly size the SHA1 table upfront which already 
> >    contains entries for the omitted objects;
> >
> > 2) the whole pack doesn't have to be re-summed again after being 
> >    completed on the receiving end since we don't alter the header.
> >
> > However this means that the progress meter will now be wrong and that's 
> > terrible !  Users *will* complain that the meter doesn't reach 100% and 
> > they'll protest for being denied the remaining objects during the 
> > transfer !
> >
> > Joking aside, we should think about doing something about it.  I was 
> > wondering if some kind of prefix to the pack stream could be inserted 
> > onto the wire when sending a pack v4.  Something like:
> >
> > 'T', 'H', 'I', 'N', <actual_number_of_sent_objects_in_network_order>
> >
> > This 8-byte prefix would simply be discarded by index-pack after being 
> > parsed.
> >
> > What do you think?
> 
> I do not think it is _too_ bad if the meter jumped from 92% to 100%
> when we finish reading from the other end ;-), as long as we can
> reliably tell that we read the right thing.

Sure.  but eventually people will complain about this.  So while we're 
about to introduce a new pack format anyway, better think of this little 
cosmetic detail now when it can be included in the pack v4 capability 
negociation.

> Which brings me to a tangent.  Do we have a means to make sure that
> the data received over the wire is bit-for-bit correct as a whole
> when it is a thin pack stream?  When it is a non-thin pack stream,
> we have the checksum at the end added by sha1close() which
> index-pack.c::parse_pack_objects() can (and does) verify.

The trailing checksum is still there.  Nothing has changed in that 
regard.


Nicolas

--Boundary_(ID_Q2yuLmnpRpyE7je0dSqzXg)--
