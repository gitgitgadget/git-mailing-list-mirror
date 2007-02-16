From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] Fix incorrect diff of a link -> file change if core.filemode = false.
Date: Sat, 17 Feb 2007 00:30:03 +0100
Message-ID: <200702170030.04014.johannes.sixt@telecom.at>
References: <200702170009.02500.johannes.sixt@telecom.at> <7vejop1ysu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 17 00:30:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HICX4-0002mD-S5
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 00:30:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946284AbXBPXaJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 18:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbXBPXaJ
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 18:30:09 -0500
Received: from smtp1.noc.eunet-ag.at ([193.154.160.117]:44188 "EHLO
	smtp1.noc.eunet-ag.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbXBPXaH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 18:30:07 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.noc.eunet-ag.at (Postfix) with ESMTP
	id A2ECE33C6B; Sat, 17 Feb 2007 00:30:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 3D9DB3B46C;
	Sat, 17 Feb 2007 00:30:04 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <7vejop1ysu.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39960>

On Saturday 17 February 2007 00:13, Junio C Hamano wrote:
> Johannes Sixt <johannes.sixt@telecom.at> writes:
> > After this sequence:
> >
> > $ ln -s foo A
> > $ git add A
> > $ git commit -m link
> > $ rm A && echo bar > A
> >
> > the working copy contains a regular file A but HEAD contains A as a link.
> >
> > Normally, at this point 'git diff HEAD' displays this change as a removal
> > of the link followed by an addition of a new file. But in a repository
> > where core.filemode is false this is displayed as a modification of the
> > link. The reason is that the check when the cached mode is allowed to
> > override the file's actual mode is not strict enough.
> >
> > Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
>
> I do not follow.  core.filemode aka trust_executable_bit is
> about executable bit and not symlink.

Correct. But the breakage is still there. As you recall, the properties 
S_IFREG and S_IFLNK are recorded in the st_mode, and the line of code that I 
fixed trusts the index in too many cases, and copies the index's S_IFLNK over 
the the stat() result, which said S_IFREG. So the diff engine loses the 
information that it is should diff against a regular file, and thinks that 
the working copy is a symlink.

Please change the last sentence of the commit message, which hopefully makes 
the issue a bit clearer:

The fix is that the cached mode must only be allowed to override the file's 
actual mode (which includes the type information) if _both_ the working tree 
entry and the cached entry are regular files.

-- Hannes
