From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 2/3] add new Git::Repo API
Date: Sun, 20 Jul 2008 23:36:42 +0200
Message-ID: <20080720213642.GE10151@machine.or.cz>
References: <4876B223.4070707@gmail.com> <200807150141.39186.jnareb@gmail.com> <20080718165407.GU10151@machine.or.cz> <200807192107.56333.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 23:37:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKgbH-0001Qf-BY
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 23:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbYGTVgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 17:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbYGTVgt
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 17:36:49 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60296 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994AbYGTVgq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 17:36:46 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id F3F75393B32A; Sun, 20 Jul 2008 23:36:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200807192107.56333.jnareb@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89237>

On Sat, Jul 19, 2008 at 09:07:55PM +0200, Jakub Narebski wrote:
> On Fri, 18 July 2008, Petr Baudis wrote:
> > On Tue, Jul 15, 2008 at 01:41:38AM +0200, Jakub Narebski wrote:
> > > On Mon, 14 July 2008, Petr Baudis wrote:
> > > > Here is an idea: Introduce Git::Command object that will have very
> > > > general interface and look like
> > > > 
> > > > 	my $c = Git::Command->new(['git', '--git-dir=.', 'cat-file', \
> > > > 		'-p', 'bla'], {pipe_out=>1})
> > > > 	...
> > > > 	$c->close();
> > > 
> > > Errr... how do you read from such a pipe?  <$c> I think wouldn't work,
> > > unless you would use some trickery...
> > 
> > That's good point; it might either be done using some trickery, or
> > $c->pipe. The idea behind having a special object for it though is to
> > have *unified* (no matter how simple) error handling. You might not
> > detect the command erroring out at the open time.
> > 
> > Is there a better approach for solving this?
> 
> I don't know if it is _better_ approach, but the _alternate_ approach
> would be to use:
> 
>  	my $c = Git::Command->new(['git', '--git-dir=.', 'cat-file', \
>  		'-p', 'bla'], {out=>my $fh, err=>undef})
> 	... 	
> 	while (my $line = <$fh>) {
> 	...
>  	$c->close();

I think this is horribly ugly, you would be *much* better keeping the
filehandle within $c if going this way.

> And trickery would be to use blessed filehandle, or what?  Or perhaps
> extending IO::Handle (but not all like using object methods for I/O
> handles)?

Maybe blessed filehandle is the simplest way; it seems that in case we
need anything more complex later, it should be possible to replace it
with an IO::Handle subclass, but that feels like overengineering now.

> I forgot that we cannot obsolete / replace old interface.  Nevertheless
> it would be nice to be able to use for example
> 
> 	Git::Cmd->output_pipe('ls-remotes', $URL, '--heads');
> 
> but also
> 
> 	output_pipe('myscript.sh', <arg1>, <arg2>);

I think exported functions should have all a git_ prefix.

> > Well, this interface is almost identical to what I delineated, except
> > that I have the extra ->cmd-> step there. But maybe, we could go with
> > your API and instead have Git::CommandFactory as a base of Git::Repo?
> > The hierarchy would be
> > 
> > 	Git::CommandFactory - provides the cmd_pipe toolkit
> > 		|
> > 	    Git::Repo       - provides repository model
> > 		|
> > 	Git::Repo::NonBare  - additional working-copy-related methods
> > 
> > I think I will post a sample implementation sometime over the weekend.
> 
> Thanks.
> 
> I think this is a very good idea.  Although... you mix somewhat here
> relationships.  Relationship between Git::CommandFactory (Git::Cmd?)
> is a bit different than relationship between Git::Repo and
> Git::Repo::NonBare.  Git::Repo::NonBare is a case of Git::Repo which
> additionally knows where its working copy (Git::WC?) is, and where
> inside working copy we are (if we are inside working copy).  Git::Repo
> uses Git::CommandFactory to route calls to git commands, and to
> provide default '--git-dir=<repo_path>' argument.

Yes, but that does not mean Git::Repo must not inherit from
Git::CmdFactory. Think of Git::CmdFactory as maybe a kind of Java-sense
interface to a degree.

> What I'd like to have is a way to easily set in _one_ place where git
> binary can be found, even if we are using different repositories, call
> git commands not related to git repository.
> 
> Should we use
> 
> 	Git::Cmd->output_pipe('ls-remotes', $URL, '--heads');
> or
> 	output_pipe(GIT, 'ls-remotes', $URL, '--heads');
> or
> 	output_pipe($GIT, 'ls-remotes', $URL, '--heads');
> or
> 	output_pipe($Git::GIT, 'ls-remotes', $URL, '--heads');
> 
> we would want to be able to set where git binary is once (and for all),
> for example via
> 
> 	Git::Cmd->set_git('/usr/local/bin/git');
> 
> or something like that.

Yes, that should work fine, with the Git::Cmd subclasses looking into
the singleton.

BTW, I don't like Git::Cmd for the factory interface, since the methods
create Git::Command objects and then the naming does not make any sense.
So I'm going to use class names Git::CmdFactory and Git::Cmd for the
first prototype (since "Command" _is_ too long), unless you have better
but still clear names.

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
