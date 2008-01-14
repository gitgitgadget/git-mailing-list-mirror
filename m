From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] Don't display crlf warning twice
Date: Mon, 14 Jan 2008 07:17:26 +0100
Message-ID: <B4297A2E-9F8F-4167-AB48-10AC1FB4E1D5@zib.de>
References: <1200241847776-git-send-email-prohaska@zib.de> <1200267979-17683-1-git-send-email-dpotapov@gmail.com>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, torvalds@linux-foundation.org,
	git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 07:20:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEIgi-0007VI-4e
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 07:20:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbYANGUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 01:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbYANGUQ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 01:20:16 -0500
Received: from mailer.zib.de ([130.73.108.11]:64787 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432AbYANGUO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 01:20:14 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0E6GNb7001253;
	Mon, 14 Jan 2008 07:19:47 +0100 (CET)
Received: from [192.168.178.21] (brln-4db9373f.pool.einsundeins.de [77.185.55.63])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0E6GLuI000630
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 14 Jan 2008 07:16:22 +0100 (MET)
In-Reply-To: <1200267979-17683-1-git-send-email-dpotapov@gmail.com>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70440>

Dimitry,
Thanks for finding the code path that leads to double printing
the warning.

Your traces reveal that it is a racy condition that can trigger
the double warnings.  In my test cases this apparently does not
happen, at least not on my machine.

Do you have a test case that reliably triggers the second call to
convert_to_git()?



On Jan 14, 2008, at 12:46 AM, Dmitry Potapov wrote:

> 'git add' could call crlf_to_git() twice, and this caused that the  
> same
> crlf warning being display twice. The first time crlf_to_git() is  
> called
> when a file is added to index, and it could be called the second time
> during writing the index.
>
> This patches sets safe_crlf to false before the second call.

This would certainly work.

However I do not think it is the right place to fix ...


> Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
> ---
>
> On Sun, Jan 13, 2008 at 05:30:47PM +0100, Steffen Prohaska wrote:
>> _
>> I mentioned earlier that crlf_to_git() would be called twice.   
>> Unfortunately,
>> I can't reproduce this behaviour and are not even sure if it ever  
>> happend.
>
> I think I have found the cause. It can be seen from the following  
> trace:
>
> ==============
> #0  crlf_to_git (path=0x814b37e "a", src=0xb7fb4000 "Hello\r\nHello 
> \r\nHello\n", len=20, buf=0xbfad504c, action=-1) at convert.c:89
> #1  0x080e0454 in convert_to_git (path=0x814b37e "a",  
> src=0xb7fb4000 "Hello\r\nHello\r\nHello\n", len=20, dst=0xbfad504c)  
> at convert.c:578
> #2  0x080b7194 in index_fd (sha1=0xbfad508c "", fd=7,  
> st=0xbfad50d8, write_object=0, type=OBJ_BLOB, path=0x814b37e "a")  
> at sha1_file.c:2345

Here, index_fd() is called with write_object=0 ...


> #3  0x080a7dd4 in ce_compare_data (ce=0x814b340, st=0xbfad50d8) at  
> read-cache.c:56
> #4  0x080a8045 in ce_modified_check_fs (ce=0x814b340,  
> st=0xbfad50d8) at read-cache.c:111
> #5  0x080aa66d in ce_smudge_racily_clean_entry (ce=0x814b340) at  
> read-cache.c:1121
> #6  0x080aa79d in write_index (istate=0x814a3e0, newfd=6) at read- 
> cache.c:1177
> #7  0x0804c66a in cmd_add (argc=1, argv=0xbfad6408, prefix=0x0) at  
> builtin-add.c:261
> ==============
> #0  crlf_to_git (path=0x814b094 "a", src=0xb7fb4000 "Hello\r\nHello 
> \r\nHello\n", len=20, buf=0xbfad50ec, action=-1) at convert.c:89
> #1  0x080e0454 in convert_to_git (path=0x814b094 "a",  
> src=0xb7fb4000 "Hello\r\nHello\r\nHello\n", len=20, dst=0xbfad50ec)  
> at convert.c:578
> #2  0x080b7194 in index_fd (sha1=0x814b368 "", fd=7, st=0xbfad5174,  
> write_object=1, type=OBJ_BLOB, path=0x814b094 "a") at sha1_file.c:2345

while here index_fd() is called with write_object=1.


> #3  0x080b731f in index_path (sha1=0x814b368 "", path=0x814b094  
> "a", st=0xbfad5174, write_object=1) at sha1_file.c:2377
> #4  0x080a8c00 in add_file_to_index (istate=0x814a3e0,  
> path=0x814b094 "a", verbose=0) at read-cache.c:433
> #5  0x0804c640 in cmd_add (argc=1, argv=0xbfad6408, prefix=0x0) at  
> builtin-add.c:257
> ==============


Without digging deeply through the code, this looks to me as if
we could base our decision wether to print a warning or not on
this difference.

My first take is: we should print a warning if write_object=1
and should be quiet if write_object=0.  The flag can easily be
passed to convert_to_git().

My assumption is that users would only be interested in the
warning if data is really written to the repository (and that
this is the meaning of write_object=1).  But maybe there are
cases where a warning is also appropriate even if the data
is not written?  I don't now.

Another question is if we should die() even if write_object=0;
or only if write_object=1?

	Steffen
