From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git with custom diff for commits
Date: Tue, 18 Dec 2007 22:51:16 +0100
Message-ID: <vpqsl1zfz8r.fsf@bauges.imag.fr>
References: <60687a7d0712171456p14328817y5aa229f0df23c02f@mail.gmail.com>
	<Pine.LNX.4.64.0712172300510.9446@racer.site>
	<vpq1w9kaphg.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0712172310090.9446@racer.site>
	<7vbq8o6gxw.fsf@gitster.siamese.dyndns.org>
	<vpqk5ncz8fn.fsf@bauges.imag.fr>
	<7vodco1him.fsf@gitster.siamese.dyndns.org>
	<000001c841b5$89fcef00$762a14ac@na.acco.com>
	<7vzlw7ybx7.fsf@gitster.siamese.dyndns.org>
	<000101c841b7$5f1d1060$762a14ac@na.acco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "'Junio C Hamano'" <gitster@pobox.com>,
	"'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
	<git@vger.kernel.org>
To: "Gerald Gutierrez" <ggmlfs@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 22:57:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4kRh-0002IB-LK
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 22:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbXLRV53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 16:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbXLRV53
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 16:57:29 -0500
Received: from imag.imag.fr ([129.88.30.1]:40981 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751712AbXLRV51 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 16:57:27 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lBILpIgv020458
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Dec 2007 22:51:18 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1J4kLM-0006lY-4j; Tue, 18 Dec 2007 22:51:16 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1J4kLM-0008RY-2F; Tue, 18 Dec 2007 22:51:16 +0100
In-Reply-To: <000101c841b7$5f1d1060$762a14ac@na.acco.com> (Gerald Gutierrez's message of "Tue\, 18 Dec 2007 12\:48\:37 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 18 Dec 2007 22:51:18 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68825>

"Gerald Gutierrez" <ggmlfs@gmail.com> writes:

> Yes, but wouldn't it be slick to actually teach git's internal diff to do
> things like GNU diff can, like the ignore option -I, case insensitivity,
> etc. I thought that's what the external diff capability is for, but it is
> not so.

Don't confuse diff and commit.

Git is really snapshot oriented. When you commit, you don't say
"record the changes I made since HEAD", you say "record the current
state of the working tree, and also record the fact that this state is
based on HEAD".

See what a commit object looks like:

$ git cat-file -p 183f84365d 
tree 3f9d576b4adc78188a411104bc21159d459fa3f4
parent b9c506f7d9f05a630fa7e31b77a9cf5081d7dbba
author Shun Kei Leung <kevinlsk@gmail.com> 1195614079 +0800
committer Junio C Hamano <gitster@pobox.com> 1195630064 -0800

git-p4: Fix typo in --detect-labels

Signed-off-by: Kevin Leung <kevinlsk@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
$ _

The "tree" tells you the state of the project as recorded by commit,
and the "parent" tells you where the HEAD was pointing to at commit
time. That's really the raw information recorded by git.

Now, "diff" comes into the picture for two things: 1) storage
efficiency (you prefer a 1Mb pack file to a 1Gb uncompressed
repository), but that doesn't change the concept, and 2) user
interface.

When you say "git show HEAD", for example, git will recompute a diff,
and show it to you because this is what you expect. But this
information is computed at "git show" time, not at "git commit" time.


What you seem to expect is to tell git "commit the changes except this
portion", what you have to tell git is actually "commit the new state,
but not if this portion is the only change". That sounds identical,
but it's actually a bit different.

-- 
Matthieu
