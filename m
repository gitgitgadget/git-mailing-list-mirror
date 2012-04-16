From: Kacper Kornet <draenog@pld-linux.org>
Subject: Re: [PATCH] gitweb: Option to omit column with time of the last
 change
Date: Mon, 16 Apr 2012 23:39:38 +0200
Message-ID: <20120416213938.GB22574@camk.edu.pl>
References: <20120403132735.GA12389@camk.edu.pl>
 <201204141516.02719.jnareb@gmail.com>
 <20120416101242.GK17753@camk.edu.pl>
 <201204162206.50631.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 23:39:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJteO-0003B3-SF
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 23:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920Ab2DPVjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 17:39:52 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:57622 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752757Ab2DPVjv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 17:39:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 7293C5F0047;
	Mon, 16 Apr 2012 23:40:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ZV6ibU7Ax7i2; Mon, 16 Apr 2012 23:40:33 +0200 (CEST)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 3C3EF5F0046;
	Mon, 16 Apr 2012 23:40:33 +0200 (CEST)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id 10E414669F; Mon, 16 Apr 2012 23:39:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201204162206.50631.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195700>

I'm sorry to Jakub for duplicate message, but I have forgotten CC: to
the group.

On Mon, Apr 16, 2012 at 10:06:49PM +0200, Jakub Narebski wrote:
> On Mon, 16 Apr 2012, Kacper Kornet wrote:
> > On Sat, Apr 14, 2012 at 03:16:01PM +0200, Jakub Narebski wrote:
> >> On Wed, 4 Apr 2012, Kacper Kornet wrote:
> >>> On Wed, Apr 04, 2012 at 04:31:42PM +0200, Jakub Narebski wrote:
> >>>> On Wed, 4 April 2012, Kacper Kornet wrote:
> >>>>> On Wed, Apr 04, 2012 at 01:12:01AM +0200, Jakub Narebski wrote:
> >> So we would probably want to have said variable or set of variables
> >> describe three states:

> >> * find date of last change in repository with git-for-each-ref called
> >>   by git_get_last_activity(), which as a side effect verifies that
> >>   repository actually exist.  

> >>   git_get_last_activity() returns empty list in list context if repo
> >>   does not exist, hence

> >>   	my (@activity) = git_get_last_activity($pr->{'path'});
> >>   	unless (@activity) {
> >>   		next PROJECT;
> >>   	}

> >> * verify that repository exists with "git rev-parse --git-dir" or
> >>   "git rev-parse --verify HEAD", or "git symbolic-ref HEAD", redirecting
> >>   stderr to /dev/null (we would probably want to save output of the
> >>   latter two somewhere to use it later).

> >>   That saves I/O, but not fork.

> Actually if you look at the footer of projects list page with 'timed'
> feature enable you see that for N projects on list, gitweb uses 2*N+1
> git commands.  The "+1" part is from "git version", the "2*N" are from
> git-for-each-ref to get last activity (and verify repository as a
> side-effect)...

It is how I started to think about the problem. With my additional patch
to remove the owner I am able to reduce the number of git invocations to
1.

> ...and from call to "git config" to get owner (unconditional check for
> `gitweb.owner` override), description (if '.git/description' file got
> deleted), if applicable category (file then config), if applicable ctags
> (file(s) then config).

> So we can rely on "git config" being called, no need for separate
> verification.  My mistake.  (Though it might be hard to use this fact.)


> Well, with proposed option to remove 'owner' field we would have sometimes
> to verify repository with an extra git command...

> >> * don't verify that repository exists.

> >> Though perhaps the last possibility isn't a good idea, so it would be
> >> left two-state, as in your patch. 

> > My tests show that forks are also a bottleneck in my setup.

> What do you mean by "my tests" here?  Is it benchmark (perhaps just using
> 'timed' feature) with and without custom change removing fork(s)?  Or did
> you used profiler (e.g. wondefull Devel::NYTProf) for that?

Nothing fancy. I look at the footnote produced by "timed" feature. And
I see a difference between version with the following patch:

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 18cdf96..4a13807 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3156,6 +3156,18 @@ sub git_get_project_owner {
 	return $owner;
 }
 
+sub git_repo_exist {
+	my ($path) = @_;
+       my $fd;
+
+       $git_dir = "$projectroot/$path";
+       open($fd, "<", "$git_dir/HEAD") or return;
+       my $line = <$fd>;
+       close $fd or return;
+       return 1 if (defined $fd && substr($line, 0, 10) eq 'ref:refs/' 
+           || $line=~m/^[0-9a-z]{40}$/);
+       return 0;
+}
+
 sub git_get_last_activity {
 	my ($path) = @_;
 	my $fd;
@@ -5330,6 +5342,7 @@ sub fill_project_list_info {
 	my $show_ctags = gitweb_check_feature('ctags');
  PROJECT:
 	foreach my $pr (@$projlist) {
+             next PROJECT unless git_repo_exist($pr->{'path'});
 		if (project_info_needs_filling($pr, $filter_set->('age', 'age_string'))) {
 			my (@activity) = git_get_last_activity($pr->{'path'});
 			unless (@activity) {


and the one in which  git_repo_exist() uses invocation to /bin/true:

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 18cdf96..4bcc66f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3156,6 +3156,13 @@ sub git_get_project_owner {
 	return $owner;
 }
 
+sub git_repo_exist {
+	my ($path) = @_;
+
+        $git_dir = "$projectroot/$path";
+        return not system('/bin/true');
+}
+
 sub git_get_last_activity {
 	my ($path) = @_;
 	my $fd;


> >                                                             On the other 
> > hand I think that I can trust that my projects.list contains only valid
> > repositories. So I would prefer to have a don't verify option. Or there
> > is a possibility to write perl function with the same functionality as
> > is_git_directory() from setup.c and use it to verify if the directory is a
> > valid git repo.

> Well, we can add those checks to check_export_ok()... well to function
> it would call.

> is_git_repository from setup.c checks that "/objects" and "/refs"
> have executable permissions, and that "/HEAD" is valid via validate_headref
> which does slightly more than (now slightly misnamed) check_head_link()
> from gitweb...

> ...or that DB_ENVIRONMENT i.e. GIT_OBJECT_DIRECTORY environment variable
> is set, and path that it points to has executable permissions.  I don't
> think we have to worry about this for gitweb.

> I'll try to come up with a patch to gitweb that improves repository
> verification, and perhaps a patch that uses the fact that "git config"
> succeeded to verify repository.

As you see it is more or less what I have already written for my tests.
I only don't check if /objects and /refs are directories. If you want I
can send proper patch submission for this function

-- 
  Kacper Kornet


-- 
  Kacper Kornet
