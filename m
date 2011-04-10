From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Confused over packfile and index design
Date: Sat, 09 Apr 2011 22:08:53 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1104092147520.28032@xanadu.home>
References: <m2d3kw70su.fsf@Spindle.sehlabs.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_99+qREuHuNEI8+4ka6vo2g)"
Cc: git@vger.kernel.org
To: "Steven E. Harris" <seh@panix.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 04:09:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8k5R-0002F1-Nd
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 04:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788Ab1DJCIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 22:08:55 -0400
Received: from relais.videotron.ca ([24.201.245.36]:54191 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271Ab1DJCIy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 22:08:54 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz24.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LJE00BY8Z9SX380@vl-mo-mrz24.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 09 Apr 2011 22:08:16 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <m2d3kw70su.fsf@Spindle.sehlabs.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171234>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_99+qREuHuNEI8+4ka6vo2g)
Content-type: TEXT/PLAIN; charset=utf-8
Content-transfer-encoding: 8BIT

On Fri, 8 Apr 2011, Steven E. Harris wrote:

> I was reading the Git Book discussion¹ on the packfile and index formats,
> and there's a confusing set of assertions concerning the design choices
> that sound contradictory.
> 
> First, near the end of the section about the index format, we find the
> following paragraph:
> 
> ,----
> | Importantly, packfile indexes are /not/ neccesary to extract objects
> | from a packfile, they are simply used to quickly retrieve individual
> | objects from a pack. The packfile format is used in upload-pack and
> | receieve-pack programs (push and fetch protocols) to transfer objects
> | and there is no index used then - it can be built after the fact by
> | scanning the packfile.
> `----
> 
> That suggests that it's possible to read the packfile linearly and
> deduce where the various objects start and end, without the index
> available.

Exact.

> Later, in the section on the packfile format, we find this:
> 
> ,----
> | It is important to note that the size specified in the header data is
> | not the size of the data that actually follows, but the size of that
> | data /when expanded/. This is why the offsets in the packfile index are
> | so useful, otherwise you have to expand every object just to tell when
> | the next header starts.
> `----
> 
> Now that makes it sound like without the index, even if one knows where
> a packed object starts, reading its header tells its /inflated/ size,
> /not/ the number of remaining payload bytes representing the object. If
> that's true, then how does one figure out where one object ends and the
> next one begins /without the index/?

There is a reason why we use a pack index.  It is not essential to have 
it but it is extremely convenient.  Because to know exactly where one 
object ends and therefore where the next one starts, we do have to 
inflate every object.  So the idea is to do that once to construct the 
pack index and allow for random access once the index is available.  
Accessing a particular object without the pack index would be extremely 
costly otherwise, especially if it is towards the end of the pack.

The reason for storing only the expanded data size is to have the exact 
buffer size allocated for the inflated data.  The zlib stream that 
follows is encoded to consume only the needed data to produce the 
inflated object.  When the output buffer is all used, the zlib library 
should flag the end of the deflated stream.  If not then there is an 
error in the pack data.

> Recall that the first paragraph quoted above says that the index can be
> built from the packfile, as opposed to it being essential to reading the
> packfile. Is one of these paragraphs incorrect?

Well... in practice the index is pretty much essential if you want to 
read any random object from the pack.  But the index can be recreated 
at anytime simply by reading all objects sequentially from the pack.

> The Git documentation on the pack format² mentions that the packed
> object headers represent the lengths as variable-sized integers
> 
> ,----
> | n-byte type and length (3-bit type, (n-1)*7+4-bit length)
> `----
> 
> but it doesn't say whether that's the number of (deflated) payload bytes
> or the inflated object size, as the Git Book asserts.

It is the inflated object size.

> I imagine that if the format is meant to record the size of the deflated
> payload, then it would be challenging to compress the data straight into
> the packfile, because one wouldn't know the final size until it was
> written, which means that one wouldn't know how many bytes will be
> necessary to write its length in the header, which means one wouldn't
> know where to start writing the deflated payload.

Exact.  And we also want to be able to construct a pack on the fly and 
stream it over a network connection without having to seek back.

> Are there any other clarifying documents you can recommend to understand
> the design?

When in doubt, the code is always the ultimate source of information.


Nicolas

--Boundary_(ID_99+qREuHuNEI8+4ka6vo2g)--
