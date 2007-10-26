From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/6] copy vs rename detection: avoid unnecessary O(n*m)
 loops
Date: Fri, 26 Oct 2007 16:36:10 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710261633090.30120@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0710251112120.30120@woody.linux-foundation.or
 g> <alpine.LFD.0.999.0710251119120.30120@woody.linux-foundation.org>
 <7vabq5wkri.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999.0710261600510.30120@woody.linux-foundation.org>
 <7vy7dpv4ls.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 27 01:37:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlYjb-0002fk-0t
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 01:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbXJZXgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 19:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753035AbXJZXgq
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 19:36:46 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45708 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752357AbXJZXgq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Oct 2007 19:36:46 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9QNaAm0007979
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 26 Oct 2007 16:36:11 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9QNaAkL020193;
	Fri, 26 Oct 2007 16:36:10 -0700
In-Reply-To: <7vy7dpv4ls.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-3.235 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62455>



On Fri, 26 Oct 2007, Junio C Hamano wrote:
> 
> So for a broken pair, the actual value of rename_used does not really 
> matter.  We only care about it not going down to zero.

Correct. The rename_used count really is immaterial *except* for the magic 
distinction between zero ("it's a rename, no original source file left") 
and non-zero ("it's a copy, original source file remains").

Which is why the new counter is so fundamentally simple: by decrementing 
it for each rename we encounter, we automatically get that behaviour of 
"only the last user turns into a 'rename' if the source file really went 
away" that we want. 

The old code did it all with some really expensive loops over the 
remaining renames.

		Linus
