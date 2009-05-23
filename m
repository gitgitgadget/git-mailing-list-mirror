From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Funny error with git gc...
Date: Sat, 23 May 2009 09:02:55 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905230859290.3555@localhost.localdomain>
References: <alpine.DEB.1.00.0905152000520.4449@intel-tinevez-2-302> <7vmy9etey8.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0905151128230.3343@localhost.localdomain> <alpine.DEB.1.00.0905152105340.26154@pacific.mpi-cbg.de> <alpine.DEB.1.00.0905152111140.26154@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0905152115220.26154@pacific.mpi-cbg.de> <alpine.LFD.2.01.0905151307390.3343@localhost.localdomain> <alpine.DEB.1.00.0905231050480.9099@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 23 18:03:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7tgk-0000LC-VE
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 18:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769AbZEWQDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 12:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752656AbZEWQDA
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 12:03:00 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51129 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752209AbZEWQC7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 May 2009 12:02:59 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4NG2tLN023200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 23 May 2009 09:02:56 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4NG2tMI006534;
	Sat, 23 May 2009 09:02:55 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.DEB.1.00.0905231050480.9099@intel-tinevez-2-302>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.463 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119779>



On Sat, 23 May 2009, Johannes Schindelin wrote:
> On Fri, 15 May 2009, Linus Torvalds wrote:
> 
> > On Fri, 15 May 2009, Johannes Schindelin wrote:
> > >  
> > >  	fd = mkstemp(template);
> > > +	if (fd < 0) {
> > > +		release_pack_memory((size_t)-1ll, -1);
> > > +		fd = mkstemp(template);
> > 
> > This is wrong. You can't use "template" twice. You need to re-initialize 
> > it. The first one will blow away the XXXX pattern.
> 
> Turns out that would be awkward, as the xmkstemp() function would have to 
> copy the template just in case mkstemp() fails due to too many open files, 
> and of course it would need to release the copy afterwards.
> 
> OTOH we cannot just use the initialized filename, because there 
> might be a race condition with another process, right?

Correct. You basically need to have the caller re-create the template. We 
already do that in some other cases: see odb_mkstemp(), or 
create_tempfile(). Both of them do that template re-creation on failure, 
and try again.

You could save off the template into a local temporary array, of course.

		Linus
