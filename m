From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem using GIT CVS-server
Date: Wed, 03 May 2006 12:49:15 -0700
Message-ID: <7v1wvaevno.fsf@assigned-by-dhcp.cox.net>
References: <445865A5.5030700@lumumba.uhasselt.be>
	<46a038f90605030311s4e05de2dr90277f97a3a5c223@mail.gmail.com>
	<46a038f90605030411o29af1d1bra3276353347516f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"Panagiotis Issaris" <takis@lumumba.uhasselt.be>
X-From: git-owner@vger.kernel.org Wed May 03 21:49:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbNLd-0005Hv-Uq
	for gcvg-git@gmane.org; Wed, 03 May 2006 21:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWECTtR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 15:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWECTtR
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 15:49:17 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:49574 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750767AbWECTtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 May 2006 15:49:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060503194916.DOND9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 3 May 2006 15:49:16 -0400
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605030411o29af1d1bra3276353347516f6@mail.gmail.com>
	(Martin Langhoff's message of "Wed, 3 May 2006 23:11:17 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19516>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> On 5/3/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
>> Hmmm. 100% reproduceable -- looking at it now.
>
> Grumble. Some recent change has broken cvsserver -- if I rewind to the
> commit I made of cvsserver, the checkout works correctly. I suspect
> changes to git-diff-tree. However, I'll play dumb and try bisect to
> see where it leads...

Ah, the "master" git-log is C-rewrite version and does not show
the parents on the "commit (.*)" line itself with --parents.

Could you see if the attached patch helps?

When Linus and I did the rewrite, we tried to be somewhat
careful not to break people's expectations, but at the same
time, we considered that the log/show/whatchanged frontends to
rev-list are primarily for human consumption, so we "improved"
the details a bit [*1*], which obviously broke cvsserver's use
of git-log.

*1* Another difference I know about is that whatchanged used to
start an entry with "diff-tree" but now says "commit" like
others in "log" family of frontends.

-- >8 --
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 11d153c..71e384c 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2076,14 +2076,15 @@ sub update
     # TODO: log processing is memory bound
     # if we can parse into a 2nd file that is in reverse order
     # we can probably do something really efficient
-    my @git_log_params = ('--parents', '--topo-order');
+    my @git_rl_params = ('--parents', '--topo-order', '--pretty');
 
     if (defined $lastcommit) {
-        push @git_log_params, "$lastcommit..$self->{module}";
+        push @git_rl_params, "$lastcommit..$self->{module}";
     } else {
-        push @git_log_params, $self->{module};
+        push @git_rl_params, $self->{module};
     }
-    open(GITLOG, '-|', 'git-log', @git_log_params) or die "Cannot call git-log: $!";
+    open(GITLOG, '-|', 'git-rev-list',
+	 @git_rl_params) or die "Cannot call git-rev-list: $!";
 
     my @commits;
 
