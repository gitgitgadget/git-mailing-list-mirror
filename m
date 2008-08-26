From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: "failed to read delta base object at..."
Date: Tue, 26 Aug 2008 16:55:52 -0400
Message-ID: <20080826205552.GR4380@fieldses.org>
References: <20080825164602.GA2213@fieldses.org> <alpine.LFD.1.10.0808251153210.3363@nehalem.linux-foundation.org> <20080825213104.GI2213@fieldses.org> <alpine.LFD.1.10.0808251435540.3363@nehalem.linux-foundation.org> <20080825221321.GL2213@fieldses.org> <alpine.LFD.1.10.0808251616240.3363@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 22:57:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY5b2-0006iH-09
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 22:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbYHZUzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 16:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbYHZUzy
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 16:55:54 -0400
Received: from mail.fieldses.org ([66.93.2.214]:52194 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751003AbYHZUzy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 16:55:54 -0400
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1KY5Zw-0002dD-JO; Tue, 26 Aug 2008 16:55:52 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808251616240.3363@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93817>

On Mon, Aug 25, 2008 at 04:59:26PM -0700, Linus Torvalds wrote:
> and the difference literally seems to be just a block of less than 160 
> bytes. But it's certainly not a single-bit error, and it's also not a disk 
> block or anything like that.
> 
> Looking at the first line that differs, they are:
> 
> 	-0003460 a0 14 8d 7d cd 12 75 81 2b c4 d9 71 27 62 ae b5
> 	+0003460 a0 14 8d 7d 22 00 00 00 6b 57 fe ff 55 57 fe ff
> 
> so the differences start at offset 03464. The last line is:
> 
> 	-0003700 47 f7 9b 3d b6 a5 99 5a cf 49 ef e0 3f 54 08 f4
> 	+0003700 ae 41 49 50 aa 40 fe ff cf 49 ef e0 3f 54 08 f4
> 
> so they re-join at 03708 (octal offsets because of 'od' behavior).  But in 
> between there seems to be nothing in common.
> 
> So the corrupt data looks like
> 
>                             22 00 00 00 6b 57 fe ff 55 57 fe ff
>         0003500 aa 57 fe ff b0 00 0e 00 d9 66 22 00 00 00 00 e0
>         0003520 19 9f fe ff ff ff d1 43 fe ff d1 43 fe ff 00 c0
>         0003540 bf fe f0 33 69 bf b2 33 69 bf 00 00 00 10 01 fe
>         0003560 bf fe 66 01 00 00 01 1f 37 17 2e 59 fe ff 00 00
>         0003600 00 00 c2 41 fe ff 00 00 01 1f 37 17 44 42 fe ff
>         0003620 00 01 fe ff 01 1f 37 07 d4 42 fe ff 02 01 a8 44
>         0003640 00 f8 bf fe 6b 57 fe ff 55 57 fe ff 97 57 fe ff
>         0003660 00 f8 bf fe 04 00 fe ff ab 45 fe ff 02 00 fe ff
>         0003700 ae 41 49 50 aa 40 fe ff 
> 
> and I don't see what the patern is, except that there's a lot of "fe ff" 
> in there.

and all aligned on 2-byte boundaries?  I don't see anything suggestive
there either.

> 148 bytes, no obvious source. It definitely does _not_ look like 
> compressed input (it's too regular to be something zlib spits out), nor is 
> it text. Nor is it valid x86 assembly, so it's not some code-segment data 
> either.
> 
> And as far as I can tell, that's the _only_ corruption in the whole file, 
> but I didn't really double-check.
> 
> Does anybody see a pattern?

Got me.  Thanks for taking a look at it.

--b.
