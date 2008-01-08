From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 8 Jan 2008 23:50:54 +0300
Message-ID: <20080108205054.GN6951@dpotapov.dyndns.org>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de> <20080108172957.GG22155@fieldses.org> <CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de> <7vmyrgry20.fsf@gitster.siamese.dyndns.org> <02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Jeff King <peff@peff.net>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Jan 08 21:55:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCLU3-0000aa-MF
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 21:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbYAHUzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 15:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752209AbYAHUzM
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 15:55:12 -0500
Received: from smtp01.mtu.ru ([62.5.255.48]:58071 "EHLO smtp01.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601AbYAHUzK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 15:55:10 -0500
Received: from smtp01.mtu.ru (localhost [127.0.0.1])
	by smtp01.mtu.ru (Postfix) with ESMTP id D4B9CAEB89C;
	Tue,  8 Jan 2008 23:54:39 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-189-183.pppoe.mtu-net.ru [85.141.189.183])
	by smtp01.mtu.ru (Postfix) with ESMTP id 3CB73ADD4CB;
	Tue,  8 Jan 2008 23:50:47 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JCLPS-0005uN-A7; Tue, 08 Jan 2008 23:50:54 +0300
Content-Disposition: inline
In-Reply-To: <02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp01.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69920>

On Tue, Jan 08, 2008 at 07:58:57PM +0100, Steffen Prohaska wrote:
> 
> I don't think a solution will be found by declaring one platform
> native (UNIX) and all other platform non-native.  The question to
> answer is how to support cross-platform projects.  A valid
> solution should never corrupt data unless the user explicitly
> told git to do so.  I don't believe it is a valid solution to set
> core.autocrlf=true on Windows and tell the users: "Well, in its
> default settings, git sometimes corrupts your data on Windows.
> Maybe you want to switch to Linux because this is the native
> platform where data corruption will never happen."

Maybe I am wrong but it seems to me that to guarantee that
CRLF conversion is reversible (which means that you can
always get exactly what you put into the repository), it is
enough to check that the conversation is performed only if
every LF is preceded by CR. If it is not so, error out and
tell the user that the file should be either marked as binary
or EOL in the text must be corrected.

So, even in those rare cases where the heuristic went wrong,
you will not lose your data. Most likely you will get the
above error, but even if a binary file is checked in as text,
it will affect only cross-platform projects, and it will be
easily to correct the situation later by marking this file
as binary and checking in again. So, it is a extermely rare
event, and no data is lost.

Perhaps, this option can be called core.autocrlf=safe

IMHO, a _text_ file is not just some octets, it consists of
lines. Even without CRLF conversation, Git is aware about
to do some basic operations like diff and merge. So, it is
natural to store lines in the repository in the same EOL
marker regardless on what platform the file is created. So,
having core.autocrlf=false on Windows is wrong. You may not
notice it until you do not move to another platform, but the
whole thing is already broken. It is not about one platform
being more native than other. It is like in the C standard,
LF is used to denote the end of line, because it is the only
sane choice to mark it.

Dmitry
