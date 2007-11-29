From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Make Git accept absolute path names for files within the work tree
Date: Thu, 29 Nov 2007 02:15:33 +0100
Message-ID: <200711290215.34237.robin.rosenberg@dewire.com>
References: <7vmyt0edso.fsf@gitster.siamese.dyndns.org> <1196205847-22968-1-git-send-email-robin.rosenberg@dewire.com> <7vmysy7oav.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 02:14:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxXye-0003UB-1l
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 02:14:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761544AbXK2BN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 20:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761586AbXK2BNZ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 20:13:25 -0500
Received: from [83.140.172.130] ([83.140.172.130]:2309 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1761061AbXK2BNY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 20:13:24 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 8718314744E0;
	Thu, 29 Nov 2007 02:04:05 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 20248-10; Thu, 29 Nov 2007 02:04:05 +0100 (CET)
Received: from [10.9.0.5] (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 1BEC6A149A4;
	Thu, 29 Nov 2007 02:04:05 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <7vmysy7oav.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66488>

onsdag 28 november 2007 skrev Junio C Hamano:
> This looks somewhat tighter than the previous one, but still made me
> worried if the caller of prefix_path() has run the setup sequence enough
> so that calling get_git_work_tree() is safe, so I ended up auditing the
> callpath.  At least, I do not want to see that unconditional call to
> get_git_work_tree() when we do not need to do this "ah prefix got an
> unusual absolute path" stuff.
> 
>  * builtin-init-db.c uses prefix_path() to find where the template is
>    (this is mingw fallout change); in general, I do not think we would
>    want to trigger repository nor worktree discovery inside init-db,
>    although I suspect this particular callpath could be made Ok (because
>    it is taken only when template_dir is not absolute) if you do not
>    unconditionally call get_git_work_tree() in prefix_path().
> 
>  * config.c uses prefix_path() to find the ETC_GITCONFIG that is not
>    absolute (again, mingw fallout).  When git_config() is called, we
>    already should have discovered repository but worktree may not have
>    been found yet (config.worktree can be used to specify where it is,
>    so you have a chicken and egg problem).  Again, this particular
>    callpath happens to be Ok because this is used only for non-absolute
>    path, but that is a bit subtle.

I wonder if this usage in config and initdb is what prefix_path() was intended for.  The
interface is declared in cache.h and there are error conditions like '%s is outside repository'.

Maybe we should have a boolean indicating whether the arguments refer to filespecs
or not to make this clear or rewite the mingw fallouts in some other way.

>  * get_pathspec() uses prefix_path() for obvious reasons, and the prefix
>    it gets must have been discovered by finding out where the worktree
>    is, so by definition that one is safe.
> 
> Everybody else you would get from "git grep prefix_path" are after the
> proper setup, so they should all be safe. 

Thanks for looking at the usages. I'll come up with some more tests too, though writing
negative tests sometimes is a challenge. Tests all to easily fail for the wrong reason which
is bad when we expect them to fail for the right reason.

-- robin
