From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Wed, 21 Jun 2006 19:36:46 +0200
Organization: At home
Message-ID: <e7c034$1c1$1@sea.gmane.org>
References: <e79921$u0e$1@sea.gmane.org> <46a038f90606201233p6283febbn9a46e36c3a666903@mail.gmail.com> <20060621130535.G2b34d382@leonov.stosberg.net> <20060621164503.GA1285@h4x0r5.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Jun 21 19:38:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ft6ek-0006Ql-6a
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 19:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWFURiT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 13:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWFURiT
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 13:38:19 -0400
Received: from main.gmane.org ([80.91.229.2]:9680 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932288AbWFURiS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jun 2006 13:38:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ft6e2-0006E6-Ri
	for git@vger.kernel.org; Wed, 21 Jun 2006 19:37:38 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Jun 2006 19:37:38 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Jun 2006 19:37:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22282>

Ryan Anderson wrote:

> On Wed, Jun 21, 2006 at 03:05:35PM +0200, Dennis Stosberg wrote:
>> (2) Setting %ENV has no effect on spawned processes under mod_perl,
>>     so the git commands would never find the project directories.
>>     My first thought was to set $GIT_DIR on the commands' command
>>     lines like in open($fh, '$GIT_DIR=blah git-rev-list ...') but it
>>     would lead to an extra shell being spawned on every invocation
>>     of a git command.
> 
> I haven't looked at gitweb much, but why can't you solve this by doing
> manual pipe,fork,exec combinations?  That should give you complete
> control over the environment, right?

In gitweb.cgi we now use magic open "-|" invocation, e.g.:

        open my $fd, "-|", "$gitbin/git-cat-file -t $hash" or return;

in git-rerere we still fork magically, but exec explicitely

        my $pid = open($in, '-|');
        die "$!" unless defined $pid;
        if (!$pid) {
                exec(qw(git ls-files -z -u)) or die "$!: ls-files";
        }

The same is done in git-annotate (via open_pipe sub which takes care of
ActiveState Perl implementation); git-archimport, git-cvsexportcommit 
(via safe_pipe_capture); git-send-email (without encapsulating in 
a subroutine; it also uses backticks)  

git-svn uses fork + redirecting output + exec and waitpid for quiet_run
subroutine and system call.

git-cvsimport uses system call, backticks, straight pipe open, i.e. using
"git-command |", and magic open "-|" like gitweb.cgi. git-cvsserver has
safe_pipe_capture, but sometimes uses backticks. git-fmt-merge-message uses
backticks only. git-mv uses backticks and pipe. git-svnimport uses system
call and pipe.

What a mess. We really need Git.pm module...


And to answer your question, AFAICT exec cannot modify environment, not like
execve (or execle wrapper). POE (POE::Wheel::Run) or IPC::Run modules
perhaps...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
