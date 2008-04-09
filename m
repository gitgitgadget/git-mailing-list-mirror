From: Adam Simpkins <adam@adamsimpkins.net>
Subject: Re: "gitk" and "git log --graph": Strange behaviour with --follow
Date: Wed, 9 Apr 2008 02:40:45 -0700
Message-ID: <20080409094044.GA20235@adamsimpkins.net>
References: <20080408164208.GA13871@mithlond>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 11:41:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjWoC-00020q-RP
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 11:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494AbYDIJkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 05:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752553AbYDIJks
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 05:40:48 -0400
Received: from smtp172.iad.emailsrvr.com ([207.97.245.172]:56991 "EHLO
	smtp172.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbYDIJks (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 05:40:48 -0400
Received: from relay7.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay7.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id F084C1B4146
	for <git@vger.kernel.org>; Wed,  9 Apr 2008 05:40:46 -0400 (EDT)
Received: by relay7.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id CBDFE1B413D
	for <git@vger.kernel.org>; Wed,  9 Apr 2008 05:40:46 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 5007B14100BC; Wed,  9 Apr 2008 02:40:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080408164208.GA13871@mithlond>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79089>

On Tue, Apr 08, 2008 at 07:42:08PM +0300, Teemu Likonen wrote:
> I found something very strange in graphical history tools "gitk" and
> "git log --graph" when used with --follow. In Git repository compare the
> following:
> 
>   $ gitk -- utf8.c
>   $ gitk --follow -- utf8.c
> 
> The output of "git log --graph" is somewhat similar:
> 
>   $ git log --graph --pretty=oneline -- utf8.c
>   $ git log --graph --pretty=oneline --follow -- utf8.c
> 
> All I can say is that the output is not intuitive at _all_. Almost all
> the commits are in separate history lines.

Yes, I see this behavior too.  The --follow option disables parent
rewriting, which gitk and "git log --graph" both rely on in this
instance.

Without --follow, the revision list is first pruned, and then the
parents are rewritten to include only those in the pruned list.  The
revision walk then occurs only over the pruned list.

With --follow, the revision list is not pruned, so parent rewriting
doesn't happen (and even if it did, I don't think it would have any
effect, since all commits are still in the list).  Instead, the
revision walk traverses all commits, but the log-tree/diff code simply
doesn't print any output for commits that aren't relevant.


I'm not familiar enough with the diff code to know the best way to fix
this.  One possible way might be to perform an extra revision walk in
revision.c before the "real" walk occurs.  This initial walk would
perform all of the diff calculations performed by the real walk, but
only for the purpose of pruning the list.  Then parent rewriting could
be done, and the "real" revision walk would only walk over the pruned
list.

-- 
Adam Simpkins
adam@adamsimpkins.net
