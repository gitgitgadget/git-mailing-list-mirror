From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Benchmarks regarding git's gc
Date: Wed, 09 Nov 2011 06:12:55 +0100
Message-ID: <4EBA0BD7.3050301@alum.mit.edu>
References: <CAMP44s3E-YCMQQzJAU2wjjD-adpNy6bGb-=iUQ=p=bFTWxm+Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 09 06:13:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RO0T9-0007Uv-PC
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 06:13:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058Ab1KIFM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Nov 2011 00:12:59 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:46317 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965Ab1KIFM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 00:12:58 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEDD6A.dip.t-dialin.net [84.190.221.106])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pA95CtKa000913
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 9 Nov 2011 06:12:56 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <CAMP44s3E-YCMQQzJAU2wjjD-adpNy6bGb-=iUQ=p=bFTWxm+Ng@mail.gmail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185147>

On 11/08/2011 12:34 PM, Felipe Contreras wrote:
> Has anybody seen these?
> http://draketo.de/proj/hg-vs-git-server/test-results.html#results
> 
> Seems like a potential area of improvement.

The fact that git requires periodic garbage collection is indeed
annoying (even in interactive use) and even more annoying in the
scenario discussed by the author of this article.

With respect to the article's claims about the overall efficiency of
Mercurial vs. git, I would like to point out that the author's use of a
test repository with a linear history avoids one of Mercurial's big
design weaknesses.  If the repository had had a branching history,
Mercurial's numbers would probably be significantly less flattering.

Mercurial's revlog repository format [1] (at least the last time I
checked) uses a single data file to hold the contents of all versions of
a single file in the working copy.  It appends a delta to the end of the
revlog file for each revision, with periodic fulltexts.  It is designed
to make it possible to reconstruct any file revision via a single seek
and a single read of at most twice the length of the file's fulltext
(assuming that the index is already known).  The avoidance of disk seeks
goes a long way to explaining Mercurial's competitive performance
despite the fact that it is written in Python.

However, the deltas stored in revlog are not relative to a revision's
parent(s), but rather relative to the previous revision in the revlog
file, which is typically the most recent revision committed *to any
branch*.  Therefore, revlog is very good at storing a linear series of
commits, but is considerably less efficient at storing a history with
lots of branches that were under development concurrently.  The net
result is that the history of a branchy repository can take up much more
space than that of a linear repository.

There was a GSOC "parentdelta" project to allow deltas to be computed
against parents [2], later replaced by a second "generaldelta" scheme
[3], but AFAICT this is still experimental and they are struggling with
its performance.

There is also a script in contrib that reorders the revisions in a
revlog file to put topological neighbors closer together [4].  This can
shrink the size of the file dramatically.  But of course this script is
something like "git gc" in the sense that it would presumably need to be
run periodically, and each run would have to lock the repo for some time.

All this is not to detract from the fact that Mercurial, by not
requiring garbage collection, has a big advantage against git in certain
scenarios.

Michael

[1]
http://mercurial.selenic.com/wiki/FAQ#FAQ.2BAC8-TechnicalDetails.How_does_Mercurial_store_its_data.3F
[2] http://mercurial.selenic.com/wiki/ParentDeltaPlan
[3]
http://mercurial.selenic.com/wiki/WhatsNew#Mercurial_1.9_.282011-07-01.29
[4] http://selenic.com/hg/file/54c0517c0fe8/contrib/shrink-revlog.py

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
