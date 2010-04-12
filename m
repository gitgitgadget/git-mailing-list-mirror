From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 2/2] index-pack: rationalize unpack_entry_data()
Date: Mon, 12 Apr 2010 11:47:25 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004121145290.7232@xanadu.home>
References: <1271041047-32563-1-git-send-email-nico@fluxnic.net>
 <1271041047-32563-2-git-send-email-nico@fluxnic.net>
 <4BC2BF69.8050100@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Apr 12 18:26:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1MTE-0007pl-2g
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 18:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698Ab0DLQ0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 12:26:35 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46109 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175Ab0DLQ0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 12:26:24 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L0R00J8BT715K90@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 12 Apr 2010 11:47:25 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4BC2BF69.8050100@viscovery.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144751>

On Mon, 12 Apr 2010, Johannes Sixt wrote:

> Am 4/12/2010 4:57, schrieb Nicolas Pitre:
> > -	for (;;) {
> > -		int ret = git_inflate(&stream, 0);
> > -		use(input_len - stream.avail_in);
> > -		if (stream.total_out == size && ret == Z_STREAM_END)
> > -			break;
> > -		if (ret != Z_OK)
> > -			bad_object(offset, "inflate returned %d", ret);
> > +	do {
> >  		stream.next_in = fill(1);
> >  		stream.avail_in = input_len;
> > -	}
> > +		status = git_inflate(&stream, 0);
> > +		use(input_len - stream.avail_in);
> > +	} while (status == Z_OK);
> >  	git_inflate_end(&stream);
> > +	if (stream.total_out != size || status != Z_STREAM_END)
> > +		bad_object(offset, "inflate returned %d", status);
> >  	return buf;
> 
> Is stream.total_out still valid after inflateEnd() (and I mean "valid by
> definition", not just "by accident")? 

I don't see any indication to the contrary.

> To stay on the safe side, you should call git_inflate_end only after 
> this last check.

Agreed.  Will do.


Nicolas
