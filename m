From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Mon, 02 Mar 2009 11:30:01 +0100
Message-ID: <49ABB529.1080500@viscovery.net>
References: <alpine.DEB.2.00.0903020941120.17877@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Mar 02 11:31:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le5Qy-0002Ic-Vs
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 11:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756350AbZCBKaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 05:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754106AbZCBKaM
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 05:30:12 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:29453 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022AbZCBKaL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 05:30:11 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Le5PN-0003t3-W2; Mon, 02 Mar 2009 11:30:02 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 69E934E4; Mon,  2 Mar 2009 11:30:01 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <alpine.DEB.2.00.0903020941120.17877@perkele.intern.softwolves.pp.se>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111926>

Peter Krefting schrieb:
> When opening a file through open() or fopen(), the path passed is
> UTF-8 encoded.

I don't think that this assumption is valid. Whenever the Windows API has
to convert between Unicode strings and char* strings, it uses the current
"ANSI code page". As far as I know, the UTF-8 codepage (65001) cannot be
used as the "current ANSI code page". Users will always have some code
page set that is not UTF-8.

For example, if the user specifies a file name on the command line, than
it will not enter git in UTF-8, but in the current "ANSI" or "OEM code
page" encoding. If git prints a file name under the assumption that it is
UTF-8 encoded, then it will be displayed incorrectly because the system
uses a different encoding.

> Since there is no real file system abstraction beyond using stdio
> (AFAIK), I need to hack it by replacing fopen (and open). Probably
> opendir/readdir as well (might be trickier), and possibly even hack
> around main() to parse the wchar_t command-line instead of the char copy.

I think you are grossly underestimating the venture that you want to
undertake here.

Please come up with a plan how you are going to deal with the various
issues. File names enter and leave the system through different channels:

- the command line and terminal window
- object database (tree objects)
- opendir/readdir; opening files or directories for reading or writing

And there is probably some more... How do you treat encodings in these
channels? What if the file names are not valid UTF-8? Etc.

The biggest obstacle will be that git does not have a notion of "file name
encoding" - it simply treats a file name as a stream of bytes. There is no
place to write an encoding. If the byte streams are regarded as having an
encoding, then you can have ambiguities, mixed encodings, or invalid
characters. You would have to deal with this in some way.

> This will lose all chances of Windows 9x compatibility, but I don't know
> if there are any attempts of supporting it anyway?

Windows 9x is already out of the loop. We use GetFileInformationByHandle()
that is only available since Windows 2000.

-- Hannes
