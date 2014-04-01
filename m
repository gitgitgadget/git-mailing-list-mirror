From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fast-import deltas
Date: Tue, 01 Apr 2014 10:14:02 -0700
Message-ID: <xmqqk3b90y79.fsf@gitster.dls.corp.google.com>
References: <20140401102554.GA32231@glandium.org>
	<20140401114502.GA15549@sigill.intra.peff.net>
	<20140401130703.GA1479@glandium.org>
	<20140401131512.GA19321@sigill.intra.peff.net>
	<20140401141856.GA2497@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Apr 01 19:14:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV2GP-0005E6-9V
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 19:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbaDAROM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 13:14:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63630 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322AbaDAROL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 13:14:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B58E777A1;
	Tue,  1 Apr 2014 13:14:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mItd35kpXLNNPV1l0UYNp+qrYgs=; b=oQSW4J
	OZxs3+9C6vip3JkC4HUS9aiCemIgv9dTlz0cIRdKSh2umFXbpUk/Lpyo/IXx+usq
	wnYGLZ7TsNsqKkp1ijmyrwTlXQOUfQ9OYSUkYG5JxT8ZKklIjLzlRQ+A+lL8B1LW
	IaEmiv0k04j6gJsXqvcw6PFGUIb6XxqGbWqok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xSrEKYHWua2cA4UzPTdSlmVYBJ8freAY
	WkAAJ6hzMpwS7eosGlEzNUmFAJ/vjDCUnCvKOLwIWxMOp6WNlTAb3f4wcIdjHqKE
	3JNEgvy5YYzPfA5RB2BPeI0ciJ0LG0WxlpZXqjb9AwgOyZGYzPEcZTFz0QfKfHoG
	0g55DSFInt4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25236777A0;
	Tue,  1 Apr 2014 13:14:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 75DE87779C;
	Tue,  1 Apr 2014 13:14:09 -0400 (EDT)
In-Reply-To: <20140401141856.GA2497@glandium.org> (Mike Hommey's message of
	"Tue, 1 Apr 2014 23:18:56 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 09C43E7A-B9C1-11E3-B026-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245616>

Mike Hommey <mh@glandium.org> writes:

> On Tue, Apr 01, 2014 at 09:15:12AM -0400, Jeff King wrote:
>> > It seems to me fast-import keeps a kind of human readable format for its
>> > protocol, i wonder if xdelta format would fit the bill. That being said,
>> > I also wonder if i shouldn't just try to write a pack on my own...
>> 
>> The fast-import commands are human readable, but the blob contents are
>> included inline. I don't see how sending a binary delta is any worse
>> than sending a literal binary blob over the stream.
>
> OTOH, the xdelta format is not exactly straightforward to produce, with
> the variable length encoding of integers. Not exactly hard, but when
> everything else in fast-import is straightforward, one has to wonder.

Unless you already have your change in the xdelta on hand, or the
format your foreign change is in gives sufficient information to
produce a corresponding xdelta without looking at the content that
your foreign change applies to, it is silly to try to convert your
foreign change into xdelta and feed it to fast-import.

What constitutes "sufficient" information?  The xdelta format is a
series of instructions that lets you:

 - copy N bytes from offset in the source material to the
   destination; or
 - copy these N literal bytes to the destination.

to an existing piece of content, identified by the object name of
the "source material", to produce a result of "applying delta".

As an example, think about the case where you have *,v files used by
RCS (and CVS).  The "foreign changes" given to you by that format is
a series of instructions that roughly corresponds to an "ed" script.
Insert these lines at the line number L, delete N lines from line
number K, etc.  In order to convert such a change into xdelta, you
would need to know what these line numbers correspond to byte offset
in the original file.  You also may want to know what the Git object
name for the original is, although in the fast-import stream you
might be able to get away by using the object mark facility.

Assuming that you do have and are willing to read the original file,
you have three possible (and one impractical) approaches:

 - Apply the foreign changes to the original file yourself (as that
   is the foreign system you are interested in, you know how to do
   that much better than Git does), and produce xdelta between the
   original and the result using only the original and the result.

 - Apply the foreign changes to the original file yourself, and feed
   the resulting content to fast-import in full, letting fast-import
   convert into the format Git understands.

 - Interpret the foreign changes, using the original file as a
   reference, to convert it into xdelta.

 - Teach fast-import how to interpret various formats that are used
   to express foreign changes, and feed that.

In the first approach, this "given the original and the result,
produce xdelta between them" can be reused by other people's
system.  You may be able to borrow diff-delta.c from us under our
licensing terms.

The second is the most straightforward; eventual deltification will
happen when the resulting repository is repacked and uses the same
code from diff-delta.c.

The third would be "*,v expresses the source location and length in
terms of lines, so look at the original to convert these into byte
offset and byte length xdelta wants", which I would think is silly.

And the last one is a maintenance nightmare I do not think we would
want to touch with a ten-foot pole.

In short, the most practical solution would be to reconstitute a
full object and feed that to fast-import, unless you already have
xdelta or you can turn your foreign change into xdelta without ever
looking at the original.
