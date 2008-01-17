From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 16 Jan 2008 21:11:20 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801162059460.2806@woody.linux-foundation.org>
References: <478E1FED.5010801@web.de> <76718490801162043w3884435ex435f38b9de837540@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian+git@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 06:12:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFN2o-0004HP-Pd
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 06:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbYAQFLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 00:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbYAQFLY
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 00:11:24 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58517 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750782AbYAQFLX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2008 00:11:23 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0H5BK2s012513
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Jan 2008 21:11:21 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0H5BK1b010354;
	Wed, 16 Jan 2008 21:11:20 -0800
In-Reply-To: <76718490801162043w3884435ex435f38b9de837540@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.415 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_48
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70827>



On Wed, 16 Jan 2008, Jay Soffian wrote:
>
> FWIW, here's Sun's take on the issue of filesystems and i18n:

Pretty sane, from a quick read-through, although most of it seems to not 
be about general issue, as about "let's emulate others correctly on their 
filesystems" (ie the rules are different for NTFS and HFS+, little enough 
discussion about "native" preferred logic).

However, while they don't consider normalization on file creates to be the 
"preferred solution", they *do* consider filename comparison with 
canonical equivalence to be that. Which means that you can get the same 
odd problems:

	fd = open(filename, O_CREAT);
	+
	readdir()

can actually return a *different* filename than the one we just created, 
if it already existed in the directory under the different normalization.

So it's basically "normalization-preserving, but normalization-ignoring" 
(the same way many filesystems are case-preserving, but case-ignoring). I 
don't much like it either, but as with case, the "preserving" behaviour is 
probably the nicer one.

I'd guess the problems are harder to trigger in practice, but you can 
still get some pretty hairy cases. It's just painful when readdir() and 
your own file creation doesn't have any obvious 1:1 relationship.

			Linus
