From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 17:24:01 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801171716310.2957@woody.linux-foundation.org>
References: <478E1FED.5010801@web.de> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <200801180205.28742.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pedro Melo <melo@simplicidade.org>, Mark Junker <mjscod@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 02:24:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFfyS-0008ON-Op
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 02:24:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758186AbYARBYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 20:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757181AbYARBYR
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 20:24:17 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34385 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757459AbYARBYR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2008 20:24:17 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0I1O2gE009684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Jan 2008 17:24:03 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0I1O1sr024480;
	Thu, 17 Jan 2008 17:24:02 -0800
In-Reply-To: <200801180205.28742.robin.rosenberg.lists@dewire.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.716 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70945>



On Fri, 18 Jan 2008, Robin Rosenberg wrote:

> torsdagen den 17 januari 2008 skrev Linus Torvalds:
> > And yes, I also realize that it's not going to be realistic. We're 
> > probably *closer* to that than we used to be, but I don't think you can 
> > even make Windows think FAT is UTF-8.
>
> It's UTF-16 (when needed). I think it's all in the Linux kernel for you
> to see.

.. well, FAT certainly wasn't. But yes, VFAT probably is.  Not that I want 
to look at it ;)

> > translation to UTF-8, and since we use C strings, I'd assume/hope Windows 
> > actually uses that unambiguous translation for any filenames).
> 
> It uses the local 8-bit codepage, which is not UTF-8, often some latin-inspired
> thingy, but in Asia multi-byte encodings are used. In western Europe it is
> Windows-1252, which is almost, but not exactly iso-8859-1. Oh, and then we
> have the cmd prompt which has another encoding in 8-bit mode.

Well, if it uses a 8-bit codepage, then that means that as far as the 
POSIX filename interface is concerned, it has nothing what-so-ever to do 
with Unicode (ie unicode is just a totally invisible internal encoding 
issue, not externally visible).

I assume you have to use some insane Windows-only UCS-2 filename function 
to actually see any Unicode behaviour.

Sad. Because there really is no reason to use a local 8-bit codepage when 
you could just use UTF-8.

> I think there is a cygwin patch that converts to and from UTF-8. An application
> can choose to use the "A" or "W" interfaces. The W-API's are the real ones and 
> the others' are just wrappers that convert to and from UTF-16 before anything
> happens (i.e. CreateFileA is slower than CreateFileW and so on). 

So the CreateFileW() is the "native UTF-16 interface", and CreateFileA() 
is the 8-bit codepage one that has nothing to do with Unicode and is 
purely some local thing.

But for a UNIX interface layer, the most logical thing would probably be 
to map "open()" and friends not to CreateFileA(), but to 
CreateFileW(utf8_to_utf16(filename)). 

Once you do that, then it sounds like Windows would basically be Unicode, 
and hopefully without any crazy normalization (but presumably all the 
crazy case-insensitivity cannot be fixed ;^).

So it probably really only depends on whether you choose to use the insane 
8-bit code page translation or whether you just use a sane and trivial 
UTF8<->UTF16 conversion.

Anybody know which one cygwin/mingw does?

			Linus
