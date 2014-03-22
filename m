From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: File extension conflict when working with git and latex
Date: Sat, 22 Mar 2014 08:11:50 +0100
Message-ID: <532D37B6.1000306@web.de>
References: <20140321161324.GC2965@fu.192.168.200.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Matthias Beyer <mail@beyermatthias.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 08:12:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRG6b-0008KW-VT
	for gcvg-git-2@plane.gmane.org; Sat, 22 Mar 2014 08:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbaCVHL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2014 03:11:57 -0400
Received: from mout.web.de ([212.227.15.3]:60631 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbaCVHL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2014 03:11:56 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LcPWs-1WrCdt2mKU-00jotf; Sat, 22 Mar 2014 08:11:51
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <20140321161324.GC2965@fu.192.168.200.1>
X-Provags-ID: V03:K0:tostsxqX4ojP5XV4OvWk/Kdn6+htFJbokq2XSC1MvQ4+xVYyFWS
 zljOm6ZmJ9HjFCTRyn89QNut/0ejEFZXX8do+TaCZLGzg/C3YODA5AbZHTVMNW4jjYr8lfO
 yf2CAlKskRpodhIzE6bPRt2+RgLFFBAz2IdD+0gmwIwDhHs+4zx+G+eXV8nWfY60VH8jL/K
 oTCJCBl5YiaIn+/ncAn9w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244763>

On 2014-03-21 17.13, Matthias Beyer wrote:
> Hi,
> 
> I struggled with a really nasty issue today (and yesterday):
> 
> I work on a semester project paper which is written in latex and
> therefor version-controlled with git. We compile the document using
> pdflatex, we automate the compiling with make.
> 
> pdflatex generates some temporary files, which are required if you
> call it the second and third time (it is a top-down compiler, which
> needs to be called several times). One of the file extensions is
> ".idx", which (kind of) conflicts with file extensions in .git/.
> 
> Unfortunetely, we wrote our `make clean` task recursively. I think you
> can imagine what went wrong: The clean-task corrupted the repository,
> as it removed .idx files from within .git/.
> 
> I lost work because of this ugly name collision.
> 
> My question now:
> 
> I know, I can fix this by fixing the clean task in my Makefile. But
> maybe someone somewhere on this world doesn't know the git internals
> as good as me (and, of course, my coworker). Is there _any chance
> at all_ that this gets mentioned somewhere, so others don't fall into
> this pit?
> 
The idx files are mentioned here:
http://www.git-scm.com/book/en/Git-Internals-Packfiles

(Otherwise, some random thoughts:)
- stay out of the .git directory, whatever you do
   (I lost some data because my faulty scripts using sed to replace
   "s/this/that/" and went into the .git directory) 
- Don't delete "read-only" files
   (The .idx files are all  "r--r--r--")
  Or in other words, do not use "rf -f" in a script, unless you know exactly
  what you and the script are doing.
- Replace "rm -f" whith "mv /tmp" could be an option
- As mentioned before, "git clean" can be an option,
  I used it once when the "make clean", "make distclean", "make reallydistclean"
  did not work as expected by me,
  some auto-generated config files where still not deleted. 
- Make backups of your repo (frequently)
- push the repo to a backup repo (frequently)
- Use $GIT_DIR to move the repo out of your work tree:
  https://www.kernel.org/pub/software/scm/git/docs/git.html

- Prepare a patch that renames the *.idx files used by Git into
  *.gitidx, *.gidx, *.packidx, (and the *.pack into *.packdata ??) 

Hopefully you did not loose too much data, and if you have an idea how to improve
things, you may consider sending a patch, improvements are possible and welcome.
