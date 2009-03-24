From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: fatal: unable to write sha1 file git 1.6.2.1
Date: Tue, 24 Mar 2009 12:31:36 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0903241226570.3032@localhost.localdomain>
References: <49C9246E.3030508@mycircuit.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter <vmail@mycircuit.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 20:35:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmCPJ-0006qX-Hl
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 20:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756872AbZCXTd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 15:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756501AbZCXTd7
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 15:33:59 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52633 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753774AbZCXTd6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2009 15:33:58 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2OJVb0v006429
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 Mar 2009 12:32:13 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2OJVaIj031510;
	Tue, 24 Mar 2009 12:31:36 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <49C9246E.3030508@mycircuit.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.45 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114480>



On Tue, 24 Mar 2009, Peter wrote:
>
> I try to add a directory with lots of binary files to a git repository.
> I receive the error message:
> *
> fatal: unable to write sha1 file
> 
> *This is  git 1.6.2.1.
> 
> Are there limits concerning binary files ( like executables , images ) for the
> inclusion in a git repo ?

If that is the only error message you got, then afaik the only way that 
can happen is if "close(fd)" returns an error.

The only other "unable to write sha1 file" message happens if 
write_buffer() fails, but if that happens then you should also have gotten 
a

	file write error (<error message goes here>)

message in addition to the "unable to write sha1 file".

What OS? What filesystem? Are you perhaps running out of space?

You could also try to apply this patch to get more information (Junio, 
maybe worth doing regardless? We should try to avoid ambiguous error 
messages that don't give full error information)

		Linus
---
 sha1_file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 4563173..54972f9 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2287,7 +2287,7 @@ static void close_sha1_file(int fd)
 		fsync_or_die(fd, "sha1 file");
 	fchmod(fd, 0444);
 	if (close(fd) != 0)
-		die("unable to write sha1 file");
+		die("error when closing sha1 file (%s)", strerror(errno));
 }
 
 /* Size of directory component, including the ending '/' */
