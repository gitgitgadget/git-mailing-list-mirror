From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [Request] Git reset should be able to ignore file permissions
Date: Tue, 18 Jun 2013 16:06:28 +0200
Message-ID: <vpq7ghrqzrv.fsf@anie.imag.fr>
References: <CACuz9s31OUWNxTqCmj7ukAo7=TpXK7zBv5kTFZ5obpXKOju9ng@mail.gmail.com>
	<vpqsj0fr19j.fsf@anie.imag.fr>
	<CACuz9s1KGKsL-pGftAtAWyX5gUA5c-PYyJUSstf+xw151rZLtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Alexander Nestorov <alexandernst@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 16:06:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UowYQ-0001uL-GR
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 16:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932882Ab3FROGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 10:06:33 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36000 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932822Ab3FROGc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 10:06:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5IE6Qwn018774
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Jun 2013 16:06:28 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UowYG-0004lh-Dw; Tue, 18 Jun 2013 16:06:28 +0200
In-Reply-To: <CACuz9s1KGKsL-pGftAtAWyX5gUA5c-PYyJUSstf+xw151rZLtA@mail.gmail.com>
	(Alexander Nestorov's message of "Tue, 18 Jun 2013 15:48:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 18 Jun 2013 16:06:28 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228235>

Alexander Nestorov <alexandernst@gmail.com> writes:

> I'm not trying to ignore the x bit, what I'm trying to do is make
> "git reset" checkout only the files that actually changed instead
> of checking out all the files with different permissions than the
> ones git thinks they should have.

Ah, OK, you want "git reset --hard" to just do a chmod, which would not
touch the file's mtime (but only the ctime).

Then, it's even easier to demonstrate: just "touch" instead of chmod.
Indeed:

$ touch myfile; sleep 2                        
$ strace -f git reset --hard 2>&1 | grep myfile
lstat("myfile", {st_mode=S_IFREG|0755, st_size=5, ...}) = 0
lstat("myfile", {st_mode=S_IFREG|0755, st_size=5, ...}) = 0
unlink("myfile")                        = 0
open("myfile", O_WRONLY|O_CREAT|O_EXCL, 0777) = 4

(sleep 2 is needed in the demonstration to avoid the "racy git"
safeties, but it's not really important)

Git doesn't even try to read the file content: once it detected that the
stat information changed, it rewrite the file without looking at its
content. It's faster this way for files that actually changed.

> Said with other word: when you run "git reset", git does a "status"
> and checkouts all the files that showed up from the "status".

No, it's indeed the opposite: "status" re-checks the content of changed
files, and update the stat-cache in the index accordingly if the content
actually didn't change.

Runing "git status" before "git reset --hard" should solve your problem.
The part of "git status" of interest is "git update-index --refresh":

$ touch myfile; sleep 2                        
$ git update-index --refresh
$ strace -f git reset --hard 2>&1 | grep myfile
lstat("myfile", {st_mode=S_IFREG|0755, st_size=5, ...}) = 0
$

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
