From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 2/3] add new Git::Repo API
Date: Fri, 18 Jul 2008 18:54:07 +0200
Message-ID: <20080718165407.GU10151@machine.or.cz>
References: <4876B223.4070707@gmail.com> <1215738665-5153-1-git-send-email-LeWiemann@gmail.com> <20080714014051.GK10151@machine.or.cz> <200807150141.39186.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 18:55:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJtEh-0004xf-Oa
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 18:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755886AbYGRQyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 12:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760682AbYGRQyL
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 12:54:11 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51631 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760643AbYGRQyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 12:54:09 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 6B8F6393B320; Fri, 18 Jul 2008 18:54:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200807150141.39186.jnareb@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89053>

On Tue, Jul 15, 2008 at 01:41:38AM +0200, Jakub Narebski wrote:
> On Mon, 14 July 2008, Petr Baudis wrote:
> > Here is an idea: Introduce Git::Command object that will have very
> > general interface and look like
> > 
> > 	my $c = Git::Command->new(['git', '--git-dir=.', 'cat-file', \
> > 		'-p', 'bla'], {pipe_out=>1})
> > 	...
> > 	$c->close();
> 
> Errr... how do you read from such a pipe?  <$c> I think wouldn't work,
> unless you would use some trickery...

That's good point; it might either be done using some trickery, or
$c->pipe. The idea behind having a special object for it though is to
have *unified* (no matter how simple) error handling. You might not
detect the command erroring out at the open time.

Is there a better approach for solving this?

> > and a Git::CommandFactory with a nicer interface that would look like
> > 
> > 	my $cf = Git::CommandFactory->new('git', '--git-dir=.');
> > 	my $c = $cf->output_pipe('cat-file', '-p', 'bla');
> > 	$c->close();
> > 
> > Then, Git::Repo would have a single Git::CommandFactory instance
> > pre-initialized with the required calling convention, and returned by
> > e.g. cmd() method. Then, from the user POV, you would just:
> > 
> > 	my $repo = Git::Repo->new;
> > 	$repo->cmd->output_pipe('cat-file', '-p', 'bla');
> > 
> > Or am I overdoing it?
> 
> You are probably overdoing it.
> 
> 
> I think it would be good to have the following interface
> 
> Git->output_pipe('ls-remotes', $URL, '--heads');

This is problematic; I think mixing the new and old interface within a
single class is very bad idea, we should have Git::Standalone or
something for this. Or, just, default Git::CommandFactory. ;-)

> [...]
> $r = Git::Repo->new(<git_dir>);
> $r->output_pipe('ls_tree', 'HEAD');
> [...]
> $nb = Git::Repo::NonBare->new(<git_dir>[, <working_area>]);
> $nb->output_pipe('ls-files');
> 
> 
> How can it be done with minimal effort, unfortunately I don't know...

Well, this interface is almost identical to what I delineated, except
that I have the extra ->cmd-> step there. But maybe, we could go with
your API and instead have Git::CommandFactory as a base of Git::Repo?
The hierarchy would be

	Git::CommandFactory - provides the cmd_pipe toolkit
		|
	    Git::Repo       - provides repository model
		|
	Git::Repo::NonBare  - additional working-copy-related methods

I think I will post a sample implementation sometime over the weekend.

> > Another thing is clearly describing how error handling is going to work.
> > I have not much against ditching Error.pm, but just saying "die + eval"
> > does not cut it - how about possible sideband data? E.g. the failure
> > mode of Git.pm's command() method includes passing the error'd command
> > output in the exception object. How are we going to handle it? Now, it
> > might be actually okay to say that we _aren't_ going to handle this if
> > it is deemed unuseful, but that needs to be determined too. I don't know
> > off the top of my head.
> 
> I think that the solution might be some output_pipe option on how to
> treat command exit status, command STDERR, and errors when invoking
> command (for example command not found).
> 
> Mentioned http://http://www.perl.com/pub/a/2002/11/14/exception.html
> explains why one might want to use Error.pm.

The arguments against its usage that popped up over the year(s?):

	(i) It is not standard practice in the Perl world

	(ii) It is syntactically ambiguous, c.f. Lea's report about
	the missing semicolon

	(iii) The usage of closures in this way has inherent memory leak
	issues

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
