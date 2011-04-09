From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Confused over packfile and index design
Date: Fri, 8 Apr 2011 22:07:50 -0400
Message-ID: <BANLkTikXcvRf1bLJXFOHBcGcN-B0m_xSnw@mail.gmail.com>
References: <m2d3kw70su.fsf@Spindle.sehlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Steven E. Harris" <seh@panix.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 04:08:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8Naz-0000eZ-85
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 04:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628Ab1DICIL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Apr 2011 22:08:11 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:32988 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061Ab1DICIL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Apr 2011 22:08:11 -0400
Received: by vxi39 with SMTP id 39so3134079vxi.19
        for <git@vger.kernel.org>; Fri, 08 Apr 2011 19:08:10 -0700 (PDT)
Received: by 10.52.169.37 with SMTP id ab5mr4202403vdc.283.1302314890149; Fri,
 08 Apr 2011 19:08:10 -0700 (PDT)
Received: by 10.52.166.133 with HTTP; Fri, 8 Apr 2011 19:07:50 -0700 (PDT)
In-Reply-To: <m2d3kw70su.fsf@Spindle.sehlabs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171178>

On Fri, Apr 8, 2011 at 19:58, Steven E. Harris <seh@panix.com> wrote:
> I was reading the Git Book discussion=B9 on the packfile and index fo=
rmats,
> and there's a confusing set of assertions concerning the design choic=
es
> that sound contradictory.

Its not.

> First, near the end of the section about the index format, we find th=
e
> following paragraph:
>
> ,----
> | Importantly, packfile indexes are /not/ neccesary to extract object=
s
> | from a packfile, they are simply used to quickly retrieve individua=
l
> | objects from a pack. The packfile format is used in upload-pack and
> | receieve-pack programs (push and fetch protocols) to transfer objec=
ts
> | and there is no index used then - it can be built after the fact by
> | scanning the packfile.
> `----
>
> That suggests that it's possible to read the packfile linearly and
> deduce where the various objects start and end, without the index
> available.

It is possible to do this.

Applications can scan the pack file by reading the 12 byte fixed
header and getting the object count from the 2nd word. Then enter a
loop that reads that many objects from the stream, before reading the
trailer SHA-1 checksum.

To read an object, the object header is consumed, reading the inflated
length from the variable length field. If the type code indicates the
object is a delta, the delta base reference is also read. Then
remaining bytes are shoved into a libz inflate() routine until libz
says the stream is over. As Peff mentioned elsewhere in the thread,
libz maintains its own markers and checksum to know when the object's
stream is over. As a safety measure, the inflated length from the
object header is checked against the number of bytes returned by libz.
Any remaining data that libz didn't consume is the next object's
header and data.

> Later, in the section on the packfile format, we find this:
>
> ,----
> | It is important to note that the size specified in the header data =
is
> | not the size of the data that actually follows, but the size of tha=
t
> | data /when expanded/. This is why the offsets in the packfile index=
 are
> | so useful, otherwise you have to expand every object just to tell w=
hen
> | the next header starts.
> `----
>
> Now that makes it sound like without the index, even if one knows whe=
re
> a packed object starts, reading its header tells its /inflated/ size,
> /not/ the number of remaining payload bytes representing the object.

Yes.

> I imagine that if the format is meant to record the size of the defla=
ted
> payload,

Its not. Its meant to tell us how many bytes to malloc() in order to
hold the result of the libz inflate() call when the object is being
read from the packfile. That way we don't under or over allocate the
result buffer.

--=20
Shawn.
