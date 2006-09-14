From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] gitweb: Use File::Find::find in git_get_projects_list
Date: 14 Sep 2006 10:12:29 -0700
Message-ID: <86mz921if6.fsf@blue.stonehenge.com>
References: <200609140839.56181.jnareb@gmail.com>
	<200609140959.04061.jnareb@gmail.com>
	<7vvenq4wgp.fsf@assigned-by-dhcp.cox.net>
	<200609141201.41711.jnareb@gmail.com>
	<7vmz924cxy.fsf@assigned-by-dhcp.cox.net> <eec1tp$9c9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 14 19:12:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNulP-00069R-9G
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 19:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWINRMb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 13:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWINRMb
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 13:12:31 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:28501 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1750778AbWINRMa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 13:12:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 29E0A8F5B9;
	Thu, 14 Sep 2006 10:12:30 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 17733-01-10; Thu, 14 Sep 2006 10:12:29 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id AAC198F5F3; Thu, 14 Sep 2006 10:12:29 -0700 (PDT)
To: Jakub Narebski <jnareb@gmail.com>
x-mayan-date: Long count = 12.19.13.11.10; tzolkin = 2 Oc; haab = 3 Chen
In-Reply-To: <eec1tp$9c9$1@sea.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27016>

>>>>> "Jakub" == Jakub Narebski <jnareb@gmail.com> writes:

Jakub> First benchmarks showed that no_chdir was some faster. I have rechecked, 
Jakub> and they are the same within the margin of error, perhaps without
Jakub> no_chdir is slightly faster. 447 +/- 11 ms vs. 450 +/- 10 ms according
Jakub> to ApacheBench (ab -n 10).

Any benchmarks will certainly depend on the O/S as well.  The advantage to
chdir is that the name-to-inode lookups don't need to keep retraversing the
upper directories.  And keep in mind that caching will affect the benchmarks
on that.

As for that whole -d thing...

If you use _, you have to keep in mind whether the previous call was a stat()
or an lstat().  Both lstat() (explictly) and -l use lstat().  Everything else
is a stat().  So, "-l and not -d" uses an lstat to determine that we're
looking at a symlink, but a stat to determine that the item pointed at is not
a directory.  NEVER use readlink(), as it very likely will require a lot of
flattening for you to simulate what the OS does.  (See my article on that at
<http://www.stonehenge.com/merlyn/UnixReview/col27.html>.)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
