From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Junio C Hamano] Re: Consolidate SHA1 object file close
Date: Tue, 17 Jun 2008 09:30:54 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806170919370.25099@woody.linux-foundation.org>
References: <7viqwbfxk6.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0806151057100.2949@woody.linux-foundation.org> <7v4p7s8xjc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 18:33:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8e7K-00030T-DE
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 18:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbYFQQcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 12:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752846AbYFQQcO
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 12:32:14 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44184 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751843AbYFQQcN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jun 2008 12:32:13 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5HGUu3m001377
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 17 Jun 2008 09:30:57 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5HGUsZ2022873;
	Tue, 17 Jun 2008 09:30:55 -0700
In-Reply-To: <7v4p7s8xjc.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.857 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85310>



On Mon, 16 Jun 2008, Junio C Hamano wrote:
> 
> However, this may be more important fix.  We want to make sure that
> adjust_shared_perm() is called on the success codepath, especially not
> when mkdir() does _not_ fail.

Oops. Yes.

The old code this came from actually did it differently: it failed if 
mkdir _succeeded_ but then adjust_shared_perm() failed. If the mkdir 
failed, it would just try again. That was what confused me - it was a 
copy-and-paste thing, but with me misreading the source of it and being 
confused.

IOW, the old code looked like

	if (!mkdir(filename, 0777) && adjust_shared_perm(filename)) {
		.. failure path ..

which is just really odd. A failing mkdir would be a "success" from this 
standpoint, leading to another "link()" being attempted. I think it may 
have wanted to return the errno from the link() or something.

Your fix is obviously superior. And equally obviously we don't seem to 
have any tests for this case. Maybe because I have a umask of 0002, so the 
mkdir() would already make it group-writable?

		Linus
