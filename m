From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git performance after directory copy
Date: Mon, 20 Sep 2010 11:56:36 +0200
Message-ID: <vpq62y0hh63.fsf@bauges.imag.fr>
References: <C5A8FDEFF7647F4C9CB927D7DEB307730F33B7C9@ahr075s.basler.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Gaer\, A." <Andreas.Gaer@baslerweb.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 11:56:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxd7A-00084W-K1
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 11:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755817Ab0ITJ4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 05:56:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56776 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755792Ab0ITJ4m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 05:56:42 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o8K9q4VU015437
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 20 Sep 2010 11:52:04 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Oxd6y-0005yB-Au; Mon, 20 Sep 2010 11:56:36 +0200
In-Reply-To: <C5A8FDEFF7647F4C9CB927D7DEB307730F33B7C9@ahr075s.basler.corp> (A. Gaer's message of "Mon\, 20 Sep 2010 11\:20\:44 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 20 Sep 2010 11:52:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o8K9q4VU015437
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1285581127.283@vYA2NaLu74g6H1oI2H3liw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156609>

"Gaer, A." <Andreas.Gaer@baslerweb.com> writes:

> On a copied source directory "git status" seems to be about
> 3 times slower than on the original directory.

It is expected that the first "git status" be slower. It will most
likely have to actually re-diff the files and update the index
stat-cache.

But I'm surprised that the next "git status" are still slow. Other
people may get a better explanation, but this very much looks like a
bug.

Are you sure you don't have any permission problem, like a read-only
.git/index?

To investigate a bit, you can play with diff.autorefreshindex. When
set to false, "git diff" will tell you about the files which are
identical, but do not have the same stat information (and hence, that
Git has to re-diff). For example:

$ git config diff.autorefreshindex false
$ git diff

# no output: bar.txt exists, but is up to date.

$ touch bar.txt
$ git diff     
diff --git a/bar.txt b/bar.txt

# No actual diff, but the file appears since its stat information is
# different.

$ git diff
diff --git a/bar.txt b/bar.txt

# Further "git diff" behave the same.

$ git status
...
$ git diff  

# git status did update the stat-cache, hence, no output from git diff
# anymore.

Another diagnosis tool would be "strace -e open git status,lstat64".
For example:

$ touch bar.txt 
$ strace -e open,lstat64 git status |& grep bar.txt
lstat64("bar.txt", {st_mode=S_IFREG|0644, st_size=30, ...}) = 0
open("bar.txt", O_RDONLY|O_LARGEFILE)   = 3
$ strace -e open,lstat64 git status |& grep bar.txt
lstat64("bar.txt", {st_mode=S_IFREG|0644, st_size=30, ...}) = 0

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
