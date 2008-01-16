From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] close_lock_file(): new function in the lockfile
 API
Date: Wed, 16 Jan 2008 12:08:58 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801161207220.2806@woody.linux-foundation.org>
References: <7vmyr6bluy.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.44.0801152006260.944-100000@demand> <7vejchr3pf.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 21:11:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFEbK-0001Np-Nq
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 21:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809AbYAPUKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 15:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbYAPUKb
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 15:10:31 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51580 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753829AbYAPUKa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 15:10:30 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0GK90bb021114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Jan 2008 12:09:01 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0GK8wQl021815;
	Wed, 16 Jan 2008 12:08:59 -0800
In-Reply-To: <7vejchr3pf.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.217 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70736>



On Wed, 16 Jan 2008, Junio C Hamano wrote:
> +
> +void close_lock_file(struct lock_file *lk)
> +{
> +	close(lk->fd);
> +	lk->fd = -1;
> +}

Since one of the main purposes of closing would be the error testing of 
writes that haven't made it out yet on filesystems like NFS that do 
open-close cache serialization, I'd suggest doing this as

	int close_lock_file(struct lock_file *lk)
	{
		int fd = lk->fd;
		lk->df = -1;
		return close(fd);
	} 

to give the return code.

		Linus
