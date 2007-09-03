From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Stats in Git
Date: Mon, 03 Sep 2007 10:19:22 +0200
Message-ID: <vpqodgkma9h.fsf@bauges.imag.fr>
References: <46DACD93.9000509@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 10:20:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS7A3-0000dR-Sz
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 10:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769AbXICITu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 04:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753189AbXICITt
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 04:19:49 -0400
Received: from imag.imag.fr ([129.88.30.1]:60232 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752800AbXICITs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 04:19:48 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l838JMJE023056
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 3 Sep 2007 10:19:22 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IS79W-0000vK-Ar; Mon, 03 Sep 2007 10:19:22 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IS79W-0005rH-8a; Mon, 03 Sep 2007 10:19:22 +0200
In-Reply-To: <46DACD93.9000509@trolltech.com> (Marius Storm-Olsen's message of "Sun\, 02 Sep 2007 16\:49\:55 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 03 Sep 2007 10:19:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57443>

Marius Storm-Olsen <marius@trolltech.com> writes:

> However, while look at that whole stat'ing situation in git, I saw
> that doing 'git status' actually stats all the files _thrice_!
> Yup, that's not 1 time, or 2 times, but actually 3(!) times before
> 'git status' is content!

My experiments show 2 stats only:

$ strace -f git status |& grep -e execve -e  foo                  
[...]
[pid 22492] execve("/home/moy/local/usr//bin/git", ["git", "update-index", "-q", "--unmerged", "--refresh"], [/* 50 vars */]) = 0
[pid 22492] lstat64("foo", {st_mode=S_IFREG|0755, st_size=0, ...}) = 0
[pid 22493] execve("/home/moy/local/usr//bin/git", ["git", "runstatus"], [/* 49 vars */]) = 0
[pid 22493] lstat64("foo", {st_mode=S_IFREG|0755, st_size=0, ...}) = 0
[...]

Once for "git update-index --refresh" and once more for "git
runstatus". Obviously, a builtin with one tree traversal only would
provide a good speedup.

-- 
Matthieu
