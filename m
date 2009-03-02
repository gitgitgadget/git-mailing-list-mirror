From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Mon, 02 Mar 2009 11:46:47 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0903021137110.17877@perkele.intern.softwolves.pp.se>
References: <alpine.DEB.2.00.0903020941120.17877@perkele.intern.softwolves.pp.se>
 <49ABB529.1080500@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Mar 02 11:49:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le5hy-0007AO-4R
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 11:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754761AbZCBKrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 05:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754106AbZCBKrp
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 05:47:45 -0500
Received: from smtp.getmail.no ([84.208.20.33]:45353 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753343AbZCBKro (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 05:47:44 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0KFV0041LKNHUD00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 02 Mar 2009 11:47:42 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KFV00MKXKLZIV00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 02 Mar 2009 11:46:47 +0100 (CET)
Received: from perkele ([84.215.142.63]) by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KFV00IXHKLZT740@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 02 Mar 2009 11:46:47 +0100 (CET)
Received: by perkele (Postfix, from userid 501)	id 8E7422FC03; Mon,
 02 Mar 2009 11:46:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id 8BB8C2FC02; Mon, 02 Mar 2009 11:46:47 +0100 (CET)
In-reply-to: <49ABB529.1080500@viscovery.net>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111928>

Johannes Sixt:

> I don't think that this assumption is valid.

Depends on where you are coming from. For the files stored in the Git 
repositories, I believe all file names are supposed to be UTF-8 encoded 
(just like commit messages and user names are). That's the assumption I 
started working from.

> Users will always have some code page set that is not UTF-8.

Indeed. And as long as the char-pointer interfaces in stdio and elsewhere 
work on that assumption, we have a problem.

> For example, if the user specifies a file name on the command line, than
> it will not enter git in UTF-8, but in the current "ANSI" or "OEM code
> page" encoding.

That problem is already solved as we do have a wchar_t command line 
available. If you pass a file name that is not representable in the current 
"ANSI" codepage on the command line, it will come out as garbage in the 
char* version, but will be correct in the wchar_t* version. Thus we need to 
convert that to utf-8 and use that instead.

> If git prints a file name under the assumption that it is UTF-8 encoded, 
> then it will be displayed incorrectly because the system uses a different 
> encoding.

Here setting the local codepage to UTF-8 *might* work, although I haven't 
tested that. Or always use the wchar_t versions of printf and friends.

> I think you are grossly underestimating the venture that you want to 
> undertake here.

I've done this before with other software, so, yes, I know it is quite a big 
undertaking. That is also why I started out with a minimal RFC patch to see 
if there was any interest in working with this.

> Please come up with a plan how you are going to deal with the various
> issues. File names enter and leave the system through different channels:
>
> - the command line and terminal window

GetCommandLineW() as decribed above.

> - object database (tree objects)

Those file names are supposedly always UTF-8.

> - opendir/readdir; opening files or directories for reading or writing

Wrap file open and directory read to use the wchar_t versions, converting 
that to UTF-8 strings at the API level.

> And there is probably some more... How do you treat encodings in these 
> channels? What if the file names are not valid UTF-8? Etc.

Ill-formed UTF-8 should just be rejected. Invalid UTF-8 is worse. I'm not 
sure what the Linux version does, when running in a UTF-8 locale. Does it 
allow ill-formed or illegal UTF-8 sequences?

NTFS allows almost any sequence of wchar_t's, it doesn't even have to be 
valid UTF-16.

> The biggest obstacle will be that git does not have a notion of "file name 
> encoding" - it simply treats a file name as a stream of bytes.

Yeah, that is one of the major bugs in its design, IMHO. But almost everyone 
seems to assume that file names are UTF-8 strings anyway, so in the absence 
of any other information, it's a good assumption as any to make.

> If the byte streams are regarded as having an encoding, then you can have 
> ambiguities, mixed encodings, or invalid characters. You would have to 
> deal with this in some way.

Considering we already see problems with file names that cannot properly be 
represented on some file systems (case-only differences in the Linux kernel 
when checked out on Windows; Mac OS' built-in Unicode normalization of file 
names, etc.)

> Windows 9x is already out of the loop.

Good.

-- 
\\// Peter - http://www.softwolves.pp.se/
