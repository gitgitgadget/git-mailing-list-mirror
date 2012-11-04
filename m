From: Pete Wyckoff <pw@padd.com>
Subject: Re: checkout-index: unable to create file foo (File exists)
Date: Sun, 4 Nov 2012 17:10:18 -0500
Message-ID: <20121104221018.GB9160@padd.com>
References: <k6ulre$bko$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
X-From: git-owner@vger.kernel.org Sun Nov 04 23:10:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TV8Oo-0002iK-Uf
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 23:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164Ab2KDWKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 17:10:22 -0500
Received: from honk.padd.com ([74.3.171.149]:42156 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751879Ab2KDWKV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2012 17:10:21 -0500
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id 1FADAD27;
	Sun,  4 Nov 2012 14:10:21 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id CF1812559E; Sun,  4 Nov 2012 17:10:18 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <k6ulre$bko$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209043>

brian@interlinx.bc.ca wrote on Thu, 01 Nov 2012 16:25 -0400:
> When we use git on a network filesystem, occasionally and sporadically
> we will see the following from a git checkout command:
> 
> error: git checkout-index: unable to create file foo (File exists)
> 
> Through a very basic grepping and following of the source it seems that
> the core of the error message is coming from write_entry() in entry.c:
> 
> 		fd = open_output_fd(path, ce, to_tempfile);
> 		if (fd < 0) {
> 			free(new);
> 			return error("unable to create file %s (%s)",
> 				path, strerror(errno));
> 		}
> 
> So looking into open_output_fd() there is a call to create_file() which
> does:
> 
> 	return open(path, O_WRONLY | O_CREAT | O_EXCL, mode);
> 
> I am able to prevent the problem from happening with 100% success by
> simply giving the git checkout a "-q" argument to prevent it from
> emitting progress reports.  This would seem to indicate that the problem
> likely revolves around the fact that the progress reporting uses SIGALRM.
> 
> Given that O_CREAT | O_EXCL are used in the open() call and that SIGALRM
> (along with SA_RESTART) is being used frequently to do progress updates,
> it seems reasonable to suspect that the problem is that open() is being
> interrupted (but only after it creates the file and before completing)
> by the progress reporting mechanism's SIGALRM and when the progress
> reporting is done, open() is restarted automatically (due to the use of
> SA_RESTART) and fails because the file exists and O_CREAT | O_EXCL are
> used in the open() call.
> 
> Does this seem like a reasonable hypothesis?

Fascinating problem and observations.

We've been using NFS with git for quite a while and have never
seen such an error.

> If it does, where does the problem lie here?  Is it that SA_RESTART
> should not be used since it's not safe with open() and O_CREAT | O_EXCL
> (and every system call caller should be handling EINTR) or should the
> open() be idempotent so that it can be restarted automatically with
> SA_RESTART?  If open(2) is supposed to be idempotent, it would be most
> useful to have a citation to standard where that is specified.
> 
> If open() is not required to be idempotent, it's use with O_CREAT |
> O_EXCL and SA_RESTART seems fatally flawed.

man 7 signal (linux man-pages 3.42) describes open() as restartable.

Which network filesystem and OS are you using?  The third option is
that there is a bug in the filesystem client.

		-- Pete
