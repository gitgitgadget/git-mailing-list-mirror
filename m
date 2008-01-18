From: Brian Dessent <brian@dessent.net>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 20:08:51 -0800
Organization: My own little world...
Message-ID: <47902653.31E38914@dessent.net>
References: <478E1FED.5010801@web.de> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <200801180205.28742.robin.rosenberg.lists@dewire.com> <alpine.LFD.1.00.0801171716310.2957@woody.linux-foundation.org>
Reply-To: "git@vger.kernel.org" <git@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Pedro Melo <melo@simplicidade.org>,
	Mark Junker <mjscod@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 05:52:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFjDY-0004UK-DZ
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 05:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbYAREv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 23:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753487AbYAREv4
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 23:51:56 -0500
Received: from dessent.net ([69.60.119.225]:43193 "EHLO dessent.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752604AbYAREvz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 23:51:55 -0500
X-Greylist: delayed 2443 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Jan 2008 23:51:55 EST
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.50)
	id 1JFiZ7-0003MZ-Uj; Fri, 18 Jan 2008 04:10:50 +0000
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70965>

Linus Torvalds wrote:

> But for a UNIX interface layer, the most logical thing would probably be
> to map "open()" and friends not to CreateFileA(), but to
> CreateFileW(utf8_to_utf16(filename)).
> 
> Once you do that, then it sounds like Windows would basically be Unicode,
> and hopefully without any crazy normalization (but presumably all the
> crazy case-insensitivity cannot be fixed ;^).
> 
> So it probably really only depends on whether you choose to use the insane
> 8-bit code page translation or whether you just use a sane and trivial
> UTF8<->UTF16 conversion.
> 
> Anybody know which one cygwin/mingw does?

Cygwin does not yet support doing the smart thing.  At the moment you
can only open() files in the current 8 bit codepage.  There is a patch
floating around to allow using UTF-8, but it was rejected for inclusion
because it was considered too hackish.  Instead work has been ongoing
for some time to replumb the internal representation of Windows
filenames to use UTF-16 instead of plain chars, so that conversion
overhead can be held at a minimum.  In conjuction with dropping Win9x/ME
support this also means the Native APIs like NtCreateFile() can be used
directly, as they are more low level than the Win32 -A and -W functions
and expose more flexibility, such as the ability to implement the
openat() family of functions natively (no pun intended) without
emulation.  These two items (unicode and dropping non-NT windows) are
the big features for 1.7.

Of course since a lot of what Cygwin does is translate paths in
sometimes unobvious and complicated ways, there's a lot of path handling
code to adapt, so it's taking a while.

Incidently, the ridiculously short MAX_PATH of 260 on Windows comes from
the Win32 -A version of the functions.  The -W API and the Native API
can cope with paths of up to 32k wide chars, so a side benefit of this
should be the ability to finally stop running into length limits.  Of
course there's always a catch: when using long filenames with the Win32
-W API or the Native API you can only use absolute paths, so either you
have to live with the 260 limitation for relative paths or you keep
track of the current directory and always do a rel->abs conversion.  Or
better, if you stick to the Native API you can do a directory handle
relative openat-type thing which I suppose starts to sound relatively
sane.  However, there's another catch here: For some time Cygwin has
maintained a separate and private value of CWD behind Windows' back, and
only synced the two when spawning a non-Cygwin binary.  This allows
Windows to happly think the process' CWD is always C:\ or whatever, and
not hold an open handle to the actual CWD.  In turn Cygwin uses this to
allow POSIX filesystem behavior of being able to unlink the current dir,
which some programs or build systems assume they can do but is not
possible in straight Win32.  This is a roundabout way of saying that
going back to actually having to keep a handle to CWD open again in
order to do relative paths might be complicated.

Brian
