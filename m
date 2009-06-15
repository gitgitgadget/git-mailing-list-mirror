From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 0/7] Foreign VCS support
Date: Mon, 15 Jun 2009 09:26:41 -0700
Message-ID: <20090615162641.GA14735@padd.com>
References: <alpine.LNX.2.00.0905271328160.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jun 15 18:33:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGF7t-0007Vw-OP
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 18:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756788AbZFOQdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 12:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753553AbZFOQdb
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 12:33:31 -0400
Received: from marge.padd.com ([99.188.165.110]:47308 "EHLO marge.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528AbZFOQda (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 12:33:30 -0400
X-Greylist: delayed 410 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jun 2009 12:33:30 EDT
Received: from honk.padd.com (honk.padd.com [209.17.171.228])
	by marge.padd.com (Postfix) with ESMTPSA id 52D9F121A2A9;
	Mon, 15 Jun 2009 09:26:42 -0700 (PDT)
Received: by honk.padd.com (Postfix, from userid 7770)
	id D840C78C253; Mon, 15 Jun 2009 12:26:41 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0905271328160.2147@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121616>

barkalow@iabervon.org wrote on Wed, 27 May 2009 14:15 -0400:
> This is a newly-generated and reorganized replacement for db/foreign-scm. 
> It applies to recent next.

I finally got a chance to look at this new version.  If you have
updates somewhere, let me know.  I had to fix up some merge issues
to put it on top of 1.6.3.2.

First, I'd prefer to use the non-P4-API version, but it doesn't
link:

vcs-p4/vcs-p4.o: In function `p4_integrate':
/u/petew/src/git/vcs-p4/vcs-p4.c:405: undefined reference to `_p4_call_unknown'
vcs-p4/vcs-p4.o: In function `p4_resolve':
/u/petew/src/git/vcs-p4/vcs-p4.c:412: undefined reference to `_p4_call_unknown'
vcs-p4/vcs-p4.o: In function `p4_edit':
/u/petew/src/git/vcs-p4/vcs-p4.c:423: undefined reference to `_p4_call_unknown'
vcs-p4/vcs-p4.o: In function `p4_submit':
/u/petew/src/git/vcs-p4/vcs-p4.c:479: undefined reference to `_p4_call_form_io'
vcs-p4/vcs-p4.o: In function `export_p4':
/u/petew/src/git/vcs-p4/vcs-p4.c:1008: undefined reference to `p4_write_tree'
/u/petew/src/git/vcs-p4/vcs-p4.c:1031: undefined reference to `p4_release_tree'

Next, it took me a while to discover the format of the remote entry.
Can you think of a way that "git remote add ..." could just work?
How to tell it the "vcs = p4" setting at add time, for instance?

[remote "upstream"]
        url = foo
        codeline = //depot/path/to/project
        fetch = +refs/p4/*:refs/remotes/upstream/*
        port = my-p4-server:1666
        vcs = p4

The command "git remote show upstream" complains about "foo" in the url.
Looking at your patches, the only place that sets remote->foreign_vcs is
remote's handle_config().  This isn't going to work for "git remote show
upstream" which calls transport_get() with a NULL remote.

Maybe use urls of the form "vcs-p4://depot/path/to/project".  Might
solve both issues.

It does work, and I have added two unrelated parts of the p4 repo in
the same git.  I'm going to try some much larger scale tests soon.

		-- Pete
