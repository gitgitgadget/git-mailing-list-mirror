From: Mark Hills <mark@pogo.org.uk>
Subject: Re: [PATCH] Be more careful with objects directory permissions on 
  clone
Date: Mon, 5 May 2008 10:56:57 +0100 (BST)
Message-ID: <alpine.BSO.1.10.0805051047260.7723@zrgural.vwaro.pbz>
References: <alpine.BSO.1.10.0805041234570.5819@zrgural.vwaro.pbz> <481ECCF0.6080308@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon May 05 11:58:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsxSc-0002ce-8P
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 11:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758905AbYEEJ5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 05:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758329AbYEEJ47
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 05:56:59 -0400
Received: from mailout.ijneb.com ([212.13.201.26]:36699 "EHLO
	metheny.ijneb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758659AbYEEJ46 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 05:56:58 -0400
Received: from localhost ([127.0.0.1] ident=mark)
	by metheny.ijneb.com with esmtp (Exim 4.69)
	(envelope-from <mark@pogo.org.uk>)
	id 1JsxRJ-0000pU-5U; Mon, 05 May 2008 10:56:57 +0100
In-Reply-To: <481ECCF0.6080308@viscovery.net>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: mark@pogo.org.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81263>

On Mon, 5 May 2008, Johannes Sixt wrote:

> Mark Hills schrieb:
>> Honour the setgid and umask when re-creating the objects directory
>> at the destination.
>>
>> cpio in copy-pass mode aims to copy file permissions which causes this
>> problem and cannot be disabled. Be explicit by copying the directory
>> structure first, honouring the permissions at the destination, then copy
>> the files with their existing read-only permissions.
> ...
>>          cd "$repo" &&
>> -        find objects -depth -print | cpio $cpio_quiet_flag -pumd$l
>> "$GIT_DIR/" || \
>> +        # Create dirs using umask and permissions and destination
>> +        find objects -type d -print | (cd "$GIT_DIR" && xargs mkdir -p) &&
>> +        # Copy 0444 permissions on files
>> +        find objects -type f -print | cpio $cpio_quiet_flag -pumd$l
>> "$GIT_DIR/" || \
>
> Wouldn't that be better:
>
> 	find objects ! -type d -print | cpio ...
>
> ?

This was my first suggestion, unfortunately it shows up broken behaviour 
in all but the latest version of cpio. It creates 0700 directory 
permissions which is even worse.

I didn't find the later versions of cpio to be widespread, so I wrote the 
patch to work in all cases.

See the thread 'git-clone file permissions and cpio'.

Mark
