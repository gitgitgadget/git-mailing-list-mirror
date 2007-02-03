From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Use "-f" when adding files with odd names in t9200.
Date: Sat, 3 Feb 2007 15:12:09 -0500
Message-ID: <F16FE131-CF33-4DD0-9A06-4A24C59C7623@silverinsanity.com>
References: <1AAD2384-C52D-4D60-A948-4F14C9515B53@silverinsanity.com> <20070203181329.GA10192@179.242.249.10.in-addr.arpa> <7v4pq358q4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 03 21:12:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDRFC-0001Ds-W1
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 21:12:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbXBCUMM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 15:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbXBCUMM
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 15:12:12 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:48777 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbXBCUML (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 15:12:11 -0500
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 57D761FFC02B;
	Sat,  3 Feb 2007 20:12:10 +0000 (UTC)
In-Reply-To: <7v4pq358q4.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38594>


On Feb 3, 2007, at 2:42 PM, Junio C Hamano wrote:

> Can you describe why git-add finds the (presumably mangled by
> HFS) path in ".gitignore"?  If we had some default pattern in
> info/exclude that is installed in the trash test repository I
> would understand that a mangled path could happen to match it,
> but I do not think we do not have any exclude pattern by
> default.
>
> Unless/until you know why git-add thinks it is ignored,...

It occurs because of the normalization issue on HFS+.  git-add  
compares the pathspecs given on the command line to a directory tree  
read from disk.  The pathspec is in NFC, and the tree is in NFD.   
When it tries to find the pathspec in the tree, it fails because of  
that.  When it checks to see if the file exists, HFS+ converts the  
pathspec to NFD transparently.  And since the file exists, but wasn't  
read by read_directory, git thinks it was because of an ignore file.

> ... I think this change means you are installing something the
> existing test knows to be broken, which is not very pretty.

The test finds that the ignore code is slightly broken on HFS+, which  
is not what it thinks it's testing.  And since the ignore files are  
empty, it should not adversely affect any other platforms.

The only solution I can think of is to make dir.c:match_one() unicode- 
aware.  Which I'm working on to see if it will work, but don't know  
if you want to include that complication.

~~ Brian
