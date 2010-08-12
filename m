From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] git-add: Don't exclude explicitly-specified tracked files
Date: Thu, 12 Aug 2010 18:31:13 +0200
Message-ID: <vpq39ujg5da.fsf@bauges.imag.fr>
References: <1281510236-8103-1-git-send-email-gdb@mit.edu>
	<vpqsk2kjks7.fsf@bauges.imag.fr>
	<AANLkTimODL6j11D6QuUX4b47GwFOVOXdqkhqrRfRaxmq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de
To: Greg Brockman <gdb@MIT.EDU>
X-From: git-owner@vger.kernel.org Thu Aug 12 18:35:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojakl-0005Et-PR
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 18:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570Ab0HLQfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 12:35:34 -0400
Received: from imag.imag.fr ([129.88.30.1]:60088 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752224Ab0HLQfd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 12:35:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o7CGVE65001995
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 12 Aug 2010 18:31:14 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OjagT-0003Cu-Vo; Thu, 12 Aug 2010 18:31:14 +0200
In-Reply-To: <AANLkTimODL6j11D6QuUX4b47GwFOVOXdqkhqrRfRaxmq@mail.gmail.com> (Greg Brockman's message of "Thu\, 12 Aug 2010 11\:54\:01 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 12 Aug 2010 18:31:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153386>

Greg Brockman <gdb@MIT.EDU> writes:

>>> This commit changes 'git add' to disregard excludes for tracked files
>>> whose paths are explicitly specified on the command-line.
>>
>> I don't think you need this to solve the problem,

This remains (see below) ...

>> and as Junio said, that would make "git add dir/*" add all the
>> ignored files, which would make -f essentially useless.

... but this is actually wrong, yes. Your commit message states

| This commit changes 'git add' to disregard excludes for tracked
| files whose paths are explicitly specified on the command-line.

I had missed the "tracked files whose ..." part, and focused on the
"path is explicitely specified on the command-line".

And actually, all you need is to see whether the file is tracked or
not, and not whether it's been given from the command-line. With your
patch, I get:

$ git init git
Initialized empty Git repository in /tmp/git/.git/
$ cd git
$ mkdir dir
$ touch dir/file
$ echo dir > .gitignore
$ git add -f dir/file
$ echo content >> dir/file
$ git add dir/file
$ git add dir/f*    # <--- shell globing

Up to now, everything OK. But:

$ git add dir/f\*   # <--- Git globing.
The following paths are ignored by one of your .gitignore files:
dir
Use -f if you really want to add them.
fatal: no files added

I think Git should not apply any .gitignore rule to already-tracked
files, whether they are given from the command-line explicitely or
through globbing.

One case which can be discussed:

$ git add dir
The following paths are ignored by one of your .gitignore files:
dir
Use -f if you really want to add them.
fatal: no files added

I don't think I should need a -f flag here either, since dir/ contains
only tracked files. But I don't care much here.

> Incidentally, I noticed that 'git add dir/file' for ignored dir worked
> fine in an older version of git.  'git bisect' reveals that the
> behavior I would like to change was introduced in 29209cb.  From the
> commit message, I get the sense that this particular behavior was not
> actually intentional (someone please correct me if I'm missing
> something).

My understanding is that the goal was to reject the first "git add
subdir/file", but not subsequent ones.

I'd suggest that you write a first patch introducing new tests,
possibly marked as test_expect_failure, so that people can at least
agree on the desired behavior, and then an implementation could
follow.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
