From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: How to check repository/working tree status from a script
Date: Tue, 19 May 2009 09:29:08 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905190920051.3301@localhost.localdomain>
References: <20090519143537.GA23505@torres.zugschlus.de> <alpine.LSU.2.00.0905191630120.23478@hermes-2.csi.cam.ac.uk> <20090519160031.GB23505@torres.zugschlus.de> <alpine.LFD.2.01.0905190915050.3301@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Marc Haber <mh+git@zugschlus.de>
X-From: git-owner@vger.kernel.org Tue May 19 18:29:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6SCP-0005k9-Vw
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 18:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870AbZESQ3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 12:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753743AbZESQ3i
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 12:29:38 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57077 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753601AbZESQ3i (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2009 12:29:38 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4JGT9Vr018542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 19 May 2009 09:29:10 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4JGT8eb011473;
	Tue, 19 May 2009 09:29:09 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0905190915050.3301@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.466 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119546>



On Tue, 19 May 2009, Linus Torvalds wrote:
> 
> And if what you want to know about is whether there are _new_ files you 
> might want to check, then you need a third check: 'git ls-files'. You 
> won't see it in the error code, but you can do
> 
> 	others=$(git ls-files -o --exclude-standard)
> 
> and then check it 'others' is empty or not.

Actually, you can use 'git ls-files' to also list files that are changed 
wrt the index, so then you can drop the 'git diff' thing.

IOW, something like this:

	# any staged changes (ready to commit)
	git diff --quiet --staged || echo Staged changes

	# any changes wrt the index (not staged)
	others=$(git ls-files --exclude-standard -o -d -m -u)
	[ -z "$others" ] || echo "Other changes"

should do it.

If you want more specificity wrt the "Other changes", you can add the "-t" 
flag to git ls-files and parse the output to see whether the listed files 
were just unknown (ie new files): '?', changed: 'C', removed: 'R' or need 
to be merged: 'M'

Of course, 'git diff [--staged]' is needed if you actually want to know 
some "deeper" patterns about _how_ things were changed. IOW, if you want 
to know about renames/copies, you need to use 'git diff -M/C' to get that 
kind of information.

			Linus
