From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] git-add: Don't exclude explicitly-specified tracked files
Date: Thu, 12 Aug 2010 10:30:00 +0200
Message-ID: <vpqsk2kjks7.fsf@bauges.imag.fr>
References: <1281510236-8103-1-git-send-email-gdb@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de
To: Greg Brockman <gdb@MIT.EDU>
X-From: git-owner@vger.kernel.org Thu Aug 12 10:30:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjTBG-0001Su-3y
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 10:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933130Ab0HLIa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 04:30:26 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38342 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933075Ab0HLIaX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 04:30:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o7C8J6TM020578
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 12 Aug 2010 10:19:06 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OjTAn-0005aT-3B; Thu, 12 Aug 2010 10:30:01 +0200
In-Reply-To: <1281510236-8103-1-git-send-email-gdb@mit.edu> (Greg Brockman's message of "Wed\, 11 Aug 2010 03\:03\:56 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 12 Aug 2010 10:19:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o7C8J6TM020578
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1282205951.13611@20XN97q5fJQcqy99vDdfxg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153353>

Greg Brockman <gdb@MIT.EDU> writes:

> Currently, 'git add' will complain about excluded files, even if they
> are already tracked:

This is not exactly true:

$ echo '*.pdf' > .gitignore; touch foo.pdf; git add -f foo.pdf
$ echo content >> foo.pdf; git add foo.pdf

Here, the second "git add" didn't need the -f flag.

So, your problem is not about already-tracked exclude files, but it is
about already-tracked files in an excluded directory.

> This commit changes 'git add' to disregard excludes for tracked files
> whose paths are explicitly specified on the command-line.

I don't think you need this to solve the problem, and as Junio said,
that would make "git add dir/*" add all the ignored files, which would
make -f essentially useless.

After a quick look at the code, the issue seems close to (dir.c):

struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *pathname, int len)
{
	if (!cache_name_is_other(pathname, len))
		return NULL;

	ALLOC_GROW(dir->ignored, dir->ignored_nr+1, dir->ignored_alloc);
	return dir->ignored[dir->ignored_nr++] = dir_entry_new(pathname, len);
}

I guess the "if (!cache_name_is_other(pathname, len))" test is the one
allowing the behavior I got above, but here, in the case of "git add
dir/file" with "dir" being ignored, "pathname" is just "dir", not
"dir/file", hence your problem.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
