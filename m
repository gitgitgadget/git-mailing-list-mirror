From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Make "git am" properly unescape lines matching ">>*From "
Date: Tue, 08 Jun 2010 13:50:08 -0700
Message-ID: <4C0EAD00.8000706@zytor.com>
References: <87hbldjo0s.fsf@yoom.home.cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Junio C Hamano <junkio@cox.net>
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Tue Jun 08 22:50:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM5kZ-0001AX-Md
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 22:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755609Ab0FHUuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 16:50:12 -0400
Received: from terminus.zytor.com ([198.137.202.10]:57987 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753848Ab0FHUuL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 16:50:11 -0400
Received: from anacreon.sc.intel.com (hpa@localhost [127.0.0.1])
	(authenticated bits=0)
	by mail.zytor.com (8.14.3/8.14.3) with ESMTP id o58Ko8oq031374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Tue, 8 Jun 2010 13:50:08 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-3.fc13 Thunderbird/3.0.4
In-Reply-To: <87hbldjo0s.fsf@yoom.home.cworth.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148714>

On 06/08/2010 12:57 PM, Carl Worth wrote:
> I'm adding support to notmuch[1] to more easily pipe a thread full of
> patches to "git am". So I added support for notmuch to format a thread
> (or any search) as an mbox.
> 
> When I did that, I was careful to escape lines from the bodies of email
> messages that begin with zero or more '>' characters followed
> immediately by "From " (From_ lines) by adding an initial '>'. [2]
> 
> But I noticed that "git am" wasn't removing any of these added '>'
> characters, so I was getting corrupted commit messages.
> 
> I'll follow up this message with a patch that fixes that by making
> git-mailsplit un-escape these lines. It's careful to do this only when
> processing an actual mbox, using the existing detection of a bare email
> message and not doing any un-escaping in that case.
> 
> I'll also follow up with a new test for both cases, (using "git am" with
> both an mbox with escaped From_ lines and an email message without
> escaped From_ lines).
> 

The problem with that is that it is not universally applied.  For what
I've seen, some mbox-based programs simply rely on there being a
Content-Length: header and don't need From lines to be escaped at all
(and don't do anything useful if they are), some do the leading > trick
(usually not reversably at all).

As far as I can tell, the Content-Length: is the most reliably handled
format and probably is what we should use.  This is the "mboxcl2" format
in your list.[*]  Unfortunately "mboxcl2" and "mboxrd" cannot be
distinguished from each other by inspection, which is a major defect of
both formats.

The statement that "the entire "mbox" family of mailbox formats is
gradually becoming irrelevant, and of only historical interest" is also
pretty silly -- mbox is still the preferred format for moving groups of
email from MUA to MUA, even if it is no longer used for active live
spool storage.  But, of course, you knew that already.

	-hpa

[*] There are apparently some MTA/MUAs which simply bypass the entire
problem by base64-encoding any email that contains /^From /, just as if
it contained NUL bytes.  It's a heavyweight, but thoroughly unambiguous
way of dealing with the problem.
