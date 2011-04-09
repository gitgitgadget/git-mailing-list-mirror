From: "Steven E. Harris" <seh@panix.com>
Subject: Re: Confused over packfile and index design
Date: Sat, 09 Apr 2011 10:30:26 -0400
Organization: SEH Labs
Message-ID: <m28vvj7b0d.fsf@Spindle.sehlabs.com>
References: <m2d3kw70su.fsf@Spindle.sehlabs.com>
	<BANLkTikXcvRf1bLJXFOHBcGcN-B0m_xSnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 16:30:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8ZBU-0003GP-Tx
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 16:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754339Ab1DIOaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 10:30:39 -0400
Received: from lo.gmane.org ([80.91.229.12]:38495 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754203Ab1DIOai (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 10:30:38 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Q8ZBN-0003AL-BV
	for git@vger.kernel.org; Sat, 09 Apr 2011 16:30:37 +0200
Received: from c-24-23-122-157.hsd1.pa.comcast.net ([24.23.122.157])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 16:30:37 +0200
Received: from seh by c-24-23-122-157.hsd1.pa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 16:30:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-23-122-157.hsd1.pa.comcast.net
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.50 (darwin)
Cancel-Lock: sha1:AoxyCVaFCksalBH9nhsxKwhgT8U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171193>

Shawn Pearce <spearce@spearce.org> writes:

> Then remaining bytes are shoved into a libz inflate() routine until
> libz says the stream is over. As Peff mentioned elsewhere in the
> thread, libz maintains its own markers and checksum to know when the
> object's stream is over.

Ah, so even though you as the caller don't know how much data to feed to
libz, so long as you continue feeding it until it signals completion, it
will figure it out and tell you how much data it needed after all.

> As a safety measure, the inflated length from the object header is
> checked against the number of bytes returned by libz.  Any remaining
> data that libz didn't consume is the next object's header and data.

I see. This means that it's the packed object's "job" -- or, rather, the
job of the parser for the packed object -- to determine the payload
length. If the data was not compressed, then perhaps the deflated size
indicated in the header could provide sufficient framing, but for now we
don't need to worry about such flexibility.

[...]

> Its meant to tell us how many bytes to malloc() in order to hold the
> result of the libz inflate() call when the object is being read from
> the packfile. That way we don't under or over allocate the result
> buffer.

Does Git always inflate the objects into an in-memory buffer? As the
size of these objects can be very large (given the variable-length size
encoding), is there any provision to inflate the object to a temporary
file?

-- 
Steven E. Harris
