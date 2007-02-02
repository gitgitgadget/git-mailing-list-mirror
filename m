From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: MinGW port usable
Date: Fri, 02 Feb 2007 00:55:38 -0800
Message-ID: <45C2FC8A.4060206@zytor.com>
References: <200701292320.43888.johannes.sixt@telecom.at> <45C18A3B.2070004@zytor.com> <45C1C24A.471F40AD@eudaptics.com> <45C2560E.6090504@zytor.com> <45C2F648.9030105@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 09:56:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCuD4-0003O8-AG
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 09:55:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbXBBIzv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 03:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbXBBIzv
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 03:55:51 -0500
Received: from terminus.zytor.com ([192.83.249.54]:51892 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbXBBIzv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 03:55:51 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l128tcBn017375
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Feb 2007 00:55:39 -0800
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
In-Reply-To: <45C2F648.9030105@zytor.com>
X-Virus-Scanned: ClamAV 0.88.7/2514/Thu Feb  1 13:50:10 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=0.6 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_96_XX,RCVD_IN_SORBS_DUL autolearn=no version=3.1.7
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38480>

H. Peter Anvin wrote:
> H. Peter Anvin wrote:
>>
>> Except they are (for NT-based Windows), so you're doing something 
>> goofy.  This is a widely used construct, so it can't be that broken.
>>
> 
> Erf... I dug through this, and it seems that WriteFile only works on a 
> socket if it has an OVERLAPPED argument now, because the socket is 
> opened for overlapping I/O.  This must be new behaviour in XP-SP2, 
> because this definitely wasn't the case when I last played with this 
> stuff back in 2003.  The Internet is full of people using this 
> technique, but I haven't found a way to get a socket which is *not* 
> opened for overlapping I/O.
> 
> How typical of Microsoft to break an incredibly powerful unified 
> paradigm, sort-of repair it, and then break it again.  There doesn't 
> seem to be an obvious way to repair this, either, since MS DLLs won't 
> let you override for example the write() function as called from inside 
> the C runtime DLL.
> 
> "Some people are just a total waste of carbon..."
> 

**HAH***

I found a workaround after all.  The trick is to use WSASocket() with a 
last argument 0 instead of socket().

I feel dirty now...


#include <winsock2.h>
#include <fcntl.h>
#include <io.h>

#define socket(a,b,c) sane_socket(a,b,c)

int sane_socket(int domain, int type, int protocol)
{
	SOCKET s;
	int fd;

	s = WSASocket(domain, type, protocol, NULL, 0, 0);
	if (s == INVALID_SOCKET) {
		/*
		 * WSAGetLastError() values seem to be mostly
		 * errno+10000; verify this or replace this with
		 * a switch statement...
		 */
		errno = WSAGetLastError() - 10000;
		return -1;
	}
	
	fd = _open_osfhandle(s, 0);
	if (fd < 0)
		closesocket(s);

	return fd;
}
