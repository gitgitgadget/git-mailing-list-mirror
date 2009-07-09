From: Eric Blake <ebb9@byu.net>
Subject: Re: [PATCH 3/3] Avoid doing extra 'lstat()'s for =?utf-8?b?ZF90eXBl?= if we =?utf-8?b?aGF2ZQlhbg==?= up-to-date cache entry
Date: Thu, 9 Jul 2009 21:52:24 +0000 (UTC)
Message-ID: <loom.20090709T214734-78@post.gmane.org>
References: <20090707000500.GA5594@dpotapov.dyndns.org> <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain> <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain> <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain> <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain> <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain> <7vskh646bw.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907090832200.3352@localhost.localdomain> <7vws6h3ji4.fsf@alter.siamese.dyndns.org> <20090709210513.GB19425@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 09 23:52:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MP1Xt-0007qd-RK
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 23:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755621AbZGIVwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 17:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755346AbZGIVwm
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 17:52:42 -0400
Received: from main.gmane.org ([80.91.229.2]:44146 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754696AbZGIVwl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 17:52:41 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MP1Xi-0005Ec-8w
	for git@vger.kernel.org; Thu, 09 Jul 2009 21:52:38 +0000
Received: from l3-128-170-36-102.l-3com.com ([128.170.36.102])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 21:52:38 +0000
Received: from ebb9 by l3-128-170-36-102.l-3com.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 21:52:38 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 128.170.36.102 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.11) Gecko/2009060215 Firefox/3.0.11 (.NET CLR 3.5.30729))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123015>

Dmitry Potapov <dpotapov <at> gmail.com> writes:

> With this patch, I see one 'stat' less for each directory, which on my
> repo resulted in about 10.7% less 'stat' or 4.8% less of the total
> number of syscalls. The total run time decreased by 4.6%.
> 
> Still, there are many stats for directories -- for each directory I see
> 2 + number of subdirectories it has, but I am not sure about its cause.

That would probably be the fact that in cygwin 1.5, a stat() of a directory
results in querying all the contents of the directory so as to correctly
populate the st_link member based on the number of subdirectories.  In cygwin
1.7, in addition to adding the d_type member to readdir, stat was also changed
to blindly return st_link of 1 for all directories rather than wasting time
populating the st_link member (since Windows provides no efficient way of
accessing that number).

-- 
Eric Blake
