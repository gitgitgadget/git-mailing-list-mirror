From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] add new Git::Repo API
Date: Sat, 19 Jul 2008 21:07:55 +0200
Message-ID: <200807192107.56333.jnareb@gmail.com>
References: <4876B223.4070707@gmail.com> <200807150141.39186.jnareb@gmail.com> <20080718165407.GU10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Jul 19 21:09:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKHnl-00086R-3L
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 21:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754307AbYGSTIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 15:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547AbYGSTIE
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 15:08:04 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:5456 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbYGSTIC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 15:08:02 -0400
Received: by mu-out-0910.google.com with SMTP id w8so526379mue.1
        for <git@vger.kernel.org>; Sat, 19 Jul 2008 12:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=fRK33mdL0H51FlqztTUWOeKo5B7+Prcp6pAyW/ItP+k=;
        b=aEdpiiBugpbb5Ls/m2cAI3MIMUBUG6tOiuV0ukV02KLankWWJYSgrZhaYeI/9Pwnum
         oqmQxLhqgoIlXDKln+p1NQUUqZ2HosytfxtWejCmmcL0B3PlHQ2Gfh+4liaG4gq2p45s
         jigodvrB+jKUigBIrhJzJ++scfAbbAKXtM6+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=AT2i1mpT2qxF1TuGeKHmO8C9C6eAYxSPlk8koW5Z2VjKUgIQfwde347l787IQT6c2p
         1xVdHIH4Pz5jCDFkkyggMgShvMw8AtPlOKdYC+i+s/xAuRAENPJMC70xpjOJSIkP9qmX
         kgUswXcqu/ZvBaSuzgBe2L75err0TSdbaX3Yc=
Received: by 10.103.175.9 with SMTP id c9mr1272642mup.15.1216494480250;
        Sat, 19 Jul 2008 12:08:00 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.237.89])
        by mx.google.com with ESMTPS id b9sm11994480mug.13.2008.07.19.12.07.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 19 Jul 2008 12:07:58 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080718165407.GU10151@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89127>

On Fri, 18 July 2008, Petr Baudis wrote:
> On Tue, Jul 15, 2008 at 01:41:38AM +0200, Jakub Narebski wrote:
> > On Mon, 14 July 2008, Petr Baudis wrote:
> > > Here is an idea: Introduce Git::Command object that will have very
> > > general interface and look like
> > > 
> > > 	my $c = Git::Command->new(['git', '--git-dir=.', 'cat-file', \
> > > 		'-p', 'bla'], {pipe_out=>1})
> > > 	...
> > > 	$c->close();
> > 
> > Errr... how do you read from such a pipe?  <$c> I think wouldn't work,
> > unless you would use some trickery...
> 
> That's good point; it might either be done using some trickery, or
> $c->pipe. The idea behind having a special object for it though is to
> have *unified* (no matter how simple) error handling. You might not
> detect the command erroring out at the open time.
> 
> Is there a better approach for solving this?

I don't know if it is _better_ approach, but the _alternate_ approach
would be to use:

 	my $c = Git::Command->new(['git', '--git-dir=.', 'cat-file', \
 		'-p', 'bla'], {out=>my $fh, err=>undef})
	... 	
	while (my $line = <$fh>) {
	...
 	$c->close();

And trickery would be to use blessed filehandle, or what?  Or perhaps
extending IO::Handle (but not all like using object methods for I/O
handles)?

> > > and a Git::CommandFactory with a nicer interface that would look like
> > > 
> > > 	my $cf = Git::CommandFactory->new('git', '--git-dir=.');
> > > 	my $c = $cf->output_pipe('cat-file', '-p', 'bla');
> > > 	$c->close();
> > > 
> > > Then, Git::Repo would have a single Git::CommandFactory instance
> > > pre-initialized with the required calling convention, and returned by
> > > e.g. cmd() method. Then, from the user POV, you would just:
> > > 
> > > 	my $repo = Git::Repo->new;
> > > 	$repo->cmd->output_pipe('cat-file', '-p', 'bla');
> > > 
> > > Or am I overdoing it?
> > 
> > You are probably overdoing it.
> > 
> > I think it would be good to have the following interface
> > 
> > Git->output_pipe('ls-remotes', $URL, '--heads');
> 
> This is problematic; I think mixing the new and old interface within a
> single class is very bad idea, we should have Git::Standalone or
> something for this. Or, just, default Git::CommandFactory. ;-)

I forgot that we cannot obsolete / replace old interface.  Nevertheless
it would be nice to be able to use for example

	Git::Cmd->output_pipe('ls-remotes', $URL, '--heads');

but also

	output_pipe('myscript.sh', <arg1>, <arg2>);

See also below for alternative interfaces to Git::Cmd->output_pipe();

> > [...]
> > $r = Git::Repo->new(<git_dir>);
> > $r->output_pipe('ls_tree', 'HEAD');
> > [...]
> > $nb = Git::Repo::NonBare->new(<git_dir>[, <working_area>]);
> > $nb->output_pipe('ls-files');
> > 
> > 
> > How can it be done with minimal effort, unfortunately I don't know...
> 
> Well, this interface is almost identical to what I delineated, except
> that I have the extra ->cmd-> step there. But maybe, we could go with
> your API and instead have Git::CommandFactory as a base of Git::Repo?
> The hierarchy would be
> 
> 	Git::CommandFactory - provides the cmd_pipe toolkit
> 		|
> 	    Git::Repo       - provides repository model
> 		|
> 	Git::Repo::NonBare  - additional working-copy-related methods
> 
> I think I will post a sample implementation sometime over the weekend.

Thanks.

I think this is a very good idea.  Although... you mix somewhat here
relationships.  Relationship between Git::CommandFactory (Git::Cmd?)
is a bit different than relationship between Git::Repo and
Git::Repo::NonBare.  Git::Repo::NonBare is a case of Git::Repo which
additionally knows where its working copy (Git::WC?) is, and where
inside working copy we are (if we are inside working copy).  Git::Repo
uses Git::CommandFactory to route calls to git commands, and to
provide default '--git-dir=<repo_path>' argument.


What I'd like to have is a way to easily set in _one_ place where git
binary can be found, even if we are using different repositories, call
git commands not related to git repository.

Should we use

	Git::Cmd->output_pipe('ls-remotes', $URL, '--heads');
or
	output_pipe(GIT, 'ls-remotes', $URL, '--heads');
or
	output_pipe($GIT, 'ls-remotes', $URL, '--heads');
or
	output_pipe($Git::GIT, 'ls-remotes', $URL, '--heads');

we would want to be able to set where git binary is once (and for all),
for example via

	Git::Cmd->set_git('/usr/local/bin/git');

or something like that.

-- 
Jakub Narebski
Poland
