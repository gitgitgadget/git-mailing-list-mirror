From: Robert Wruck <wruck@tweerlei.de>
Subject: [BUG] git cat-file does not terminate
Date: Fri, 04 Mar 2011 14:04:00 +0100
Message-ID: <4D70E340.3050309@tweerlei.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 04 14:04:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvUg0-0004tz-Nu
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 14:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759551Ab1CDNEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 08:04:06 -0500
Received: from mail.tweerlei.de ([88.198.48.46]:40810 "EHLO mail.tweerlei.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759502Ab1CDNEF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 08:04:05 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.tweerlei.de (Postfix) with ESMTPSA id 459C4277B5
	for <git@vger.kernel.org>; Fri,  4 Mar 2011 14:04:03 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168438>

Hi,

this is some strange behaviour of cat-file:
On a certain file, `git cat-file blob <objectname>` writes an endless 
stream repeating the first 4096 byte of the original file.
cat-file -s and cat-file -t produce correct results.

Even stranger: This only happens with cygwin-git (1.7.4.1).
msysgit (same machine, same repository): works
linux-git (same machine, same repository): works

Even more strange: This only happens with cygwin on a particular machine 
(recent cygwin1.dll 1.7.8) under WinXP/32bit. On another machine, recent 
cygwin, Windows7/64bit it works...

Debugging a bit, I found that the following happens:
In xwrite (wrapper.c), write() is called with the total file size - in 
my case about 87 MB. This call returns -1 and EAGAIN but nevertheless 
writes 4096 byte to the output fd. I don't think that's expected 
behaviour...

I "fixed" it by limiting each write to 64k (thus looping in 
write_in_full) but maybe somebody knows about that cygwin behaviour?

This seems to be the cause of the dreaded "No newline found after blob" 
when running `git svn clone` under cygwin on a repository with large files.

You could argue that this is a cygwin bug but maybe limiting each write 
to a maximum size is a simple workaround.


-Robert
