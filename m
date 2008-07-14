From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 2/3] add new Git::Repo API
Date: Mon, 14 Jul 2008 03:40:52 +0200
Message-ID: <20080714014051.GK10151@machine.or.cz>
References: <4876B223.4070707@gmail.com> <1215738665-5153-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Hawley <warthog19@eaglescrag.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 03:48:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIDBL-0006kM-Sa
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 03:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754293AbYGNBk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 21:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754166AbYGNBk4
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 21:40:56 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55754 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753234AbYGNBkz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 21:40:55 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 0C712393B32A; Mon, 14 Jul 2008 03:40:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1215738665-5153-1-git-send-email-LeWiemann@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88365>


Thanks to Jakub for a nice writeup too. I will try to cover mainly
design issues and do not try to dive too much into technical arguments
about current Git.pm, since I agree with the general idea of designing
a new API; Jakub covered most of that pretty well, I think.

Maybe I sound too mentoring at places; I tried to tone that down as much
as possible, and of course what Lea should be working on is her and hers
official mentor call. On the other hand, if something general gets into
the Git tree, I'd like to make sure it's something we can live happily
with for long time, not just a hack tailored for gitweb caching.


On Fri, Jul 11, 2008 at 03:11:05AM +0200, Lea Wiemann wrote:
> This also adds the Git::Commit and Git::Tag classes, which are used by
> Git::Repo, the Git::Object base class, and the Git::RepoRoot helper
> factory class.

I really miss some more detailed writeup on the envisioned design here.
And if we are redoing the API in a better way, we better should have
some vision.

Most importantly, how is Git::Repo interacting with working copies, and
how is it going to interact with them as the new OO model shapes up?
You mention briefly Git::WC later, but it is not really clear how the
interaction should work.


First, I don't think it's good idea at all to put the pipe-related stuff
to Git::Repo - this is botched up API just like the current one. This
all is independent from any repository instances, in fact it's perfectly
valid to call standalone remote commands (like ls-remote or, actually,
clone).

Here is an idea: Introduce Git::Command object that will have very
general interface and look like

	my $c = Git::Command->new(['git', '--git-dir=.', 'cat-file', \
		'-p', 'bla'], {pipe_out=>1})
	...
	$c->close();

and a Git::CommandFactory with a nicer interface that would look like

	my $cf = Git::CommandFactory->new('git', '--git-dir=.');
	my $c = $cf->output_pipe('cat-file', '-p', 'bla');
	$c->close();

Then, Git::Repo would have a single Git::CommandFactory instance
pre-initialized with the required calling convention, and returned by
e.g. cmd() method. Then, from the user POV, you would just:

	my $repo = Git::Repo->new;
	$repo->cmd->output_pipe('cat-file', '-p', 'bla');

Or am I overdoing it?


Git::Repo considers only bare repositories. Now, since "working copy" by
itself has nothing to do with Git and is just an ordinary directory
tree, I think Git::WC does not make that much sense, but something like
Git::Repo::Nonbare certainly would. This would be a Git::Repo subclass
with:

	* Different constructor

	* Different Git::CommandFactory instance

	* Git::Index object aside the existing ones (like Git::Config,
	  Git::RefTree, ...)

	* Some kind of wc_root() method to help directory navigation

And that pretty much covers it?


Another thing is clearly describing how error handling is going to work.
I have not much against ditching Error.pm, but just saying "die + eval"
does not cut it - how about possible sideband data? E.g. the failure
mode of Git.pm's command() method includes passing the error'd command
output in the exception object. How are we going to handle it? Now, it
might be actually okay to say that we _aren't_ going to handle this if
it is deemed unuseful, but that needs to be determined too. I don't know
off the top of my head.


> ---
> Here's some elaboration on why I didn't use or extend Git.pm.
> 
> Please note before starting a reply to this: This is not an argument;
> I'm just explaining why I implemented it the way I did.  So please
> don't try to argue with me about what I should or should have done.
> I'm not going to refactor Git::Repo to use Git.pm or vice versa; it's
> really a much more non-trivial task than you might think at first
> glance.

Frankly, I'm not really happy about this attitude. "In my dark corner,
I have developed this. Now behold - take it or leave it be; I'm not
going to argue."

That said, I do agree that better-structured object API would be
beneficial, and I think what you posted here is a good starting point.
However, I'm not going to settle with seeing a completely parallel and
independent code pop up alongside the existing Git.pm.

Instead, I believe the best course is to gradually translate all the
Git.pm functionality to the new OO model, leaving Git.pm as a
compatibility wrapper. Now, if you believe this is a non-trivial task,
please tell us why.

It should be actually very easy to start with moving all the pipe
functionality to Git::Command. This should let us get rid of a lot of
technical code, which can be reused in the cleanly rebuilt API. Aside
of the object management + error handling, the rest of Git.pm is then
actually rather boring and unimportant, especially given Jakub's
hopefully upcoming Git::Config.

I will be happy to send in patches factoring out the pipe handling to
Git::Command as soon as we agree about the missing design details and
the way of error handling. Then, making use of that in Git::Repo should
get us a long way ahead.

>   Now I'm all in favor of re-using existing code, but refactoring
>   Git.pm would have taken *much* longer than simply writing a new
>   module.  I'm working on caching for gitweb, not on implementing the
>   next great Perl API for Git.  (And Git::Repo isn't great, FTR.)

Wait, I can't make sense out of this paragraph. If Git.pm sucks, we can
work on new API. But we better _make_ it great. Or someone else comes by
next year and says "oh, but it's buggy and needs refactoring, let's
throw it away and redesign it!"

I agree that your main objective is caching for gitweb, but that's not
what everything revolves around for the rest of us. If you chose the way
of caching within the Git API and introducing the API to gitweb, I think
you should spend the effort to deal with the API properly now.

> diff --git a/perl/Git/Commit.pm b/perl/Git/Commit.pm
> new file mode 100644
> index 0000000..a9bc304
> --- /dev/null
> +++ b/perl/Git/Commit.pm
> @@ -0,0 +1,163 @@
> +=head1 NAME
> +
> +Git::Commit - Object-oriented interface to Git commit objects.
> +
> +=cut
> +
> +use strict;
> +use warnings;
> +
> +
> +package Git::Commit;
> +
> +use base qw(Git::Object);
> +
> +use constant _MESSAGE => 'M';
> +use constant _ENCODING => 'E';
> +use constant _TREE => 'T';
> +use constant _PARENTS => 'P';
> +use constant _AUTHOR => 'A';
> +use constant _COMMITTER => 'C';

What is the idea behind this? It may make sense to create numerical
constants like this and use arrays instead of hashes for "structs" in
order to gain extra performance. But if you are going to use hashes
anyway, why not actually key by sensible name directly?

> +=head1 METHODS
> +
> +=over
> +
> +=item $commit = Git::Commit->new($repo, $sha1)

Are we sure we don't want hash-based arguments instead? This is badly
extensible and inconsistent with the rest of the API.

> +Return a new Git::Commit instance for a commit object with $sha1 in
> +repository $repo.
> +
> +Calls to this method are free, since it does not check whether $sha1
> +exists and has the right type.  However, accessing any of the commit
> +object's properties will fail if $sha1 is not a valid commit object.

This is nice idea, but I'd also provide a well-defined way for the user
to verify the object's validity at a good moment; basically, make load()
a public method. The user can deal with errors then and rely on
error-free behavior later.

> +Note that $sha1 must be the SHA1 of a commit object; tag objects are
> +not dereferenced.

Why not?

> +=item $obj->repo
> +
> +Return the Git::Repo instance this object was instantiated with.
> +
> +=item $obj->sha1
> +
> +Return the SHA1 of this commit object.
> +
> +=item $commit->tree
> +
> +Return the tree this commit object refers to.
> +
> +=item $commit->parents
> +
> +Return a list of zero or more parent commit objects.  Note that commit
> +objects stringify to their respective SHA1s, so you can alternatively
> +treat this as a list of SHA1 strings.
> +
> +=item $commit->authors

author

> diff --git a/perl/Git/Object.pm b/perl/Git/Object.pm
> new file mode 100644
> index 0000000..a5126f9
> --- /dev/null
> +++ b/perl/Git/Object.pm
> @@ -0,0 +1,81 @@
> +=head1 NAME
> +
> +Git::Object - Object-oriented interface to Git objects (base class).
> +
> +=head1 DESCRIPTION
> +
> +Git::Object is a base class that provides access to commit, tag and
> +(unimplemented) tree objects.  See L<Git::Commit> and L<Git::Tag>.
> +
> +Objects are loaded lazily, and hence instantiation is free.  Objects
> +stringify to their SHA1s.

Maybe use the term 'Git database objects'? This way, it seems as if we
are talking about all Git/*.pm objects.

> +=cut
> +
> +
> +use strict;
> +use warnings;
> +
> +
> +package Git::Object;
> +
> +use base qw(Exporter);
> +
> +our @EXPORT = qw();
> +our @EXPORT_OK = qw();
> +
> +use overload
> +    '""' => \&stringify;

(For the beholders: the overload pragma comes from 5.004.)

> +# Hash indices:
> +use constant _REPO => 'R';
> +use constant _SHA1 => 'H';
> +
> +=head1 METHODS
> +
> +=over
> +
> +=item Git::Object->new($repo, $sha1)
> +
> +Return a new Git::Object instance for the object with $sha1 in the
> +repository $repo (a Git::Repo instance).
> +
> +Note that this method does not check whether the object exists in the
> +repository.  Trying to accessing its properties through a subclass
> +will fail if the object doesn't exist, however.
> +
> +=cut
> +
> +sub new {
> +	my($class, $repo, $sha1) = @_;
> +	die "$repo is not a Git::Repo instance" unless $repo->isa('Git::Repo');
> +	my $self = {_REPO() => $repo, _SHA1() => $sha1};
> +	return bless $self, $class;
> +}
> +
> +=item $obj->repo
> +
> +Return the Git::Repo instance this object was instantiated with.
> +
> +=cut
> +
> +sub repo {
> +	shift->{_REPO()}
> +}
> +
> +=item $obj->sha1
> +
> +Return the SHA1 of this object.
> +
> +=cut
> +
> +sub sha1 {
> +	shift->{_SHA1()}
> +}
> +
> +sub stringify {
> +	shift->{_SHA1()}
> +}
> +
> +1;

Why not overload "" directly to sha1()?

> diff --git a/perl/Git/Repo.pm b/perl/Git/Repo.pm
> new file mode 100644
> index 0000000..5a4c7e0
> --- /dev/null
> +++ b/perl/Git/Repo.pm
> @@ -0,0 +1,397 @@
> +=head1 NAME
> +
> +Git::Repo - Read-only access to the Git repositories.
> +
> +WARNING: This module is in active development -- do not use it in any
> +production code as the API may change at any time.
> +
> +=head1 SYNOPSIS
> +
> +  use Git::Repo;
> +
> +  my $repo = Git::Repo->new(
> +      directory => '/path/to/repository.git',
> +      git_binary => '/usr/bin/git');
> +  my ($sha1, $type, $size) = $repo->get_sha1('HEAD');
> +  print "Last log message:\n\n" . $repo->get_commit($sha1)->message;
> +
> +=cut
> +
> +
> +use strict;
> +use warnings;
> +use 5.006002;
> +
> +
> +package Git::Repo;
> +
> +use Git::Tag;
> +use Git::Commit;
> +
> +use IPC::Open2 qw(open2);
> +use IO::Handle;
> +
> +use base qw(Exporter);
> +
> +our @EXPORT = qw();
> +our @EXPORT_OK = qw(assert_sha1 assert_opts);
> +
> +# Auxiliary subroutines
> +
> +sub assert_opts {
> +	die "must have an even number of arguments for named options"
> +	    unless $#_ % 2;
> +}
> +
> +sub assert_sha1 {
> +	my $sha1 = shift;
> +	die "'$sha1' is not a SHA1 (need to use get_sha1?)"
> +	    unless $sha1 && $sha1 =~ /^[a-f0-9]{40}$/;
> +}

Pretend names with underscores, since they are internal?

> +=head1 METHODS
> +
> +=head2 Instantiation and basic methods
> +
> +=over
> +
> +=item $repo = Git::Repo->new(%opts)
> +
> +Return a new Git::Repo object.  The following options are supported:
> +
> +=over
> +
> +=item 'directory'
> +
> +The directory of the repository (mandatory).
> +
> +Note that this option is working-copy agnostic; you need to
> +instantiate it with the working copy's .git directory as the
> +'directory' option.

I don't think making this mandatory is reasonable, since all the git
commands can automatically figure this out by themselves too; so can
Git::Repo easily by calling git rev-parse --git-dir.

> +=item 'git_binary'
> +
> +The name or full path of the git binary (default: 'git').
> +
> +=back
> +
> +Calling this method is free, since it does not check whether the
> +repository exists.  Trying to access the repository through one of the
> +instance methods will fail if it doesn't exist though.
> +
> +Examples:
> +
> +    $repo = Git::Repo->new(directory => '/path/to/repository.git');
> +    $repo = Git::Repo->new(directory => '/path/to/working_copy/.git');
> +
> +=cut
> +
> +sub new {
> +	my $class = shift;
> +	assert_opts(@_);
> +	my $self = {@_};
> +	bless $self, $class;
> +	die 'no directory given' unless $self->{directory};
> +	return $self;
> +}
> +
> +=item $repo->repo_dir
> +
> +Return the directory of the repository (.../.git in case of a working
> +copy).
> +
> +=cut
> +
> +sub repo_dir {
> +	shift->{directory}
> +}
> +
> +=item $repo->git_binary
> +
> +Return the name of or path to the git binary (used with exec).
> +
> +=cut
> +
> +sub git_binary {
> +	shift->{git_binary}
> +}

--- CUT ---

> +=item $repo->version
..snip..
> +# Return the first items of the git command line, for instance
> +# qw(/usr/bin/git --git-dir=/path/to/repo.git).
> +sub _get_git_cmd {
> +	my $self = shift;
> +	return ($self->git_binary || 'git', '--git-dir=' . $self->repo_dir);
> +}

--- CUT ---

This definitely does not belong to a Git::Repo object.

BTW, I like the idea of reuse => 1 very much.

> +=back
> +
> +=head2 Inspecting the Repository
> +
> +=over
> +
> +=item $repo->cat_file($sha1)
> +
> +Return the ($type, $content) of the object identified by $sha1, or die
> +if no such object exists in the repository.

I don't think this is good combination of semantic and name. Since we
don't do the same thing as plain git cat-file, we might as well call it
cat_object() or even better get_object().

> +Note that you may want to use the higher-level methods get_commit and
> +get_tag instead.
..snip..

> +=item $repo->get_path($tree_sha1, $file_sha1)

Now we are quickly getting messy again. This should definitely live in
Git::Tree.

> +=item $repo->get_refs

Again, the refs should be properly integrated into the object structure.

-- 
				Petr "Pasky" Baudis
GNU, n. An animal of South Africa, which in its domesticated state
resembles a horse, a buffalo and a stag. In its wild condition it is
something like a thunderbolt, an earthquake and a cyclone. -- A. Pierce
