From: Petr Vandrovec <petr@vmware.com>
Subject: Re: Fwd: [OT] Re: Git via a proxy server?
Date: Tue, 16 May 2006 15:11:46 +0200
Message-ID: <4469CF92.2010002@vmware.com>
References: <20060516121356.11646.qmail@web32002.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 16 15:14:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfzL9-0001PN-52
	for gcvg-git@gmane.org; Tue, 16 May 2006 15:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbWEPNLv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 09:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbWEPNLv
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 09:11:51 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:25613 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751820AbWEPNLt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 May 2006 09:11:49 -0400
Received: from mailhost1.vmware.com (mailhost1.vmware.com [10.16.12.135])
	by mailout1.vmware.com (Postfix) with ESMTP
	id ED67646AE; Tue, 16 May 2006 06:09:40 -0700 (PDT)
Received: from pa-exch3.vmware.com (pa-exch3.vmware.com [10.16.15.61])
	by mailhost1.vmware.com (Postfix) with ESMTP id 0A98B6FC329;
	Tue, 16 May 2006 06:11:49 -0700 (PDT)
Received: from [127.0.0.1] ([10.17.163.5]) by pa-exch3.vmware.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 16 May 2006 06:11:49 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.12) Gecko/20060205 Debian/1.7.12-1.1
X-Accept-Language: cs, en
To: Sam Song <samlinuxkernel@yahoo.com>
In-Reply-To: <20060516121356.11646.qmail@web32002.mail.mud.yahoo.com>
X-OriginalArrivalTime: 16 May 2006 13:11:49.0385 (UTC) FILETIME=[4A7A5790:01C678EA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20120>

Sam Song wrote:
> Hello,
> 
> Petr Vandrovec <petr@vmware.com> wrote:
> 
>>Date:	Mon, 27 Feb 2006 00:35:00 +0100
>>From:	Petr Vandrovec <petr@vmware.com>
>>To:	Sergey Vlasov <vsu@altlinux.ru>
>>CC:	"Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
>>	Kernel Mailing List 
>><linux-kernel@vger.kernel.org>
>>
>>>[snip]
>>>I have successfully used transconnect
>>>(http://sourceforge.net/projects/transconnect) for
>>>tunnelling git
>>>protocol through a HTTP proxy (squid in my case)
>>>supporting the CONNECT method.
>>>
>>>[snip] 
>>>Note: most HTTP proxy servers allow CONNECT method
>>>to a very limited range of ports, and 
>>>administrators will need to enable the git port
>>>(9418) explicitly.
>>>
>>
>>I know I'm coming kinda late, but I'm using:
>>
>>export GIT_PROXY_COMMAND=/usr/local/bin/proxy-cmd.sh
>>
>>and proxy-cmd.sh is just single-line command glued
>>from what I found available in /bin:
>>
>>#! /bin/bash
>>
>>(echo "CONNECT $1:$2 HTTP/1.0"; echo; cat ) | socket
>>
>>proxy.ourcompany.com 3128 | (read a; read a; cat )
>>
>>Replace socket's arguments 'proxy.ourcompany.com
>>3128' with your http proxy.  Fortunately our proxy
>>does not see anything wrong with git's port.
>>		Best regards,
>>			Petr Vandrovec
> 
> 
> With above usage on GIT_PROXY_COMMAND, I still have
> problem on connection with remote git repository.
> 
> I also tried setting http_proxy directly but the same
> result. It's first usage of git in our network. Well, 
> need I enable the git port 9418 at proxy server? Or 
> did I miss sth or what?

Yes.  Try running 'socket 192.168.40.99 80', and type
CONNECT 204.152.191.37:9418 HTTP/1.0
Proxy-Authorization: Basic <yoursecret,f.e.wget -d should reveal this to you>
<empty line>

You should get back user readable diagnostics what went wrong.  Yes, your admin 
must allow CONNECT method for target port 9418.

> I use git-2006-05-14.tar.gz package on FC3. 
> 
> Method I : Use GIT_PROXY_COMMAND
> 
> [root@sam u-boot]# git clone \
> git://www.denx.de/git/u-boot.git u-boot-denx.git
> 
> fatal: exec failed
> fetch-pack from 'git://www.denx.de/git/u-boot.git' 
> failed.

Is $GIT_PROXY_COMMAND executable? (just in case...)  Try 'strace -f git clone 
...', it should tell you what's going on.

> #! /bin/bash
> 
> (echo "CONNECT $1:$2 HTTP/1.0";echo;cat) | socket
> <um> <pwd> 192.168.40.99 80 | (read a;read a;cat)

What is '<um>' and '<pwd>' ?  socket just connects somewhere, so if you are 
supposed to use <username>:<pwd> to connect to your proxy, you must add 
Proxy-Authorization header yourself:

(echo "CONNECT $1:$2 HTTP/1.0";
  echo "Proxy-Authorization: Basic <base64encoded um:pwd>";
  echo;
  cat ) | socket 192.168.40.99 80 | (read a; read a; cat)

Best to test this is to start 'socket 192.168.40.99 80' from command line and 
then type these two lines above, plus one empty line.  You should get back '200 
OK', empty line, and then you can start communicating using git protocol - if 
you can do that...

> Method II : Use http_proxy directly
> 
> [root@sam u-boot]# export \
> http_proxy="http://<username>:<pwd>@192.168.40.99:80"
> [root@sam u-boot]# git clone \ 
> http://parisc-linux.org/git/linux-2.6.git/ parisc-2.6

As far as I can tell, http_proxy is ignored (Debian's git 1.3.2-1/cogito 0.17.2-1).
								Petr
