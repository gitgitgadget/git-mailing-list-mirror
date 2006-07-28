From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Allow fetching from multiple repositories at once
Date: Fri, 28 Jul 2006 07:46:36 +0200
Message-ID: <20060728054636.GL13776@pasky.or.cz>
References: <20060728054341.15864.35862.stgit@machine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, alp@atoker.com
X-From: git-owner@vger.kernel.org Fri Jul 28 07:46:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6LBK-00083U-Os
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 07:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbWG1Fqk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 01:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751978AbWG1Fqk
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 01:46:40 -0400
Received: from w241.dkm.cz ([62.24.88.241]:6362 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751975AbWG1Fqj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jul 2006 01:46:39 -0400
Received: (qmail 16067 invoked by uid 2001); 28 Jul 2006 07:46:36 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060728054341.15864.35862.stgit@machine>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24367>

Dear diary, on Fri, Jul 28, 2006 at 07:44:21AM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
> So, you need some kind of porcelain for this. The idea is that instead of
> telling git-fetch-pack a single repository, you pass multiple --repo=
> parameters and refs always "belong" to the latest mentioned repository;
> when outputting the new ref values, the appropriate repo is mentioned near
> each ref. In order for this to be useful, on your local side you should
> share the objects database in some way - either using alternates (then
> you must fetch to an object database reachable from everywhere) or symlinked
> object databases.
> 
> You still need to pass git-fetch-pack some URL in addition to the
> repositories - it is used only for git_connect(), the purpose is that
> repositories must be local directories so if you want to talk remote, you
> need to do something like
> 
> 	git-fetch-pack git://kernel.org/pub/scm/git/git.git --repo=/pub/scm/git/git.git master next --repo=/pub/scm/cogito/cogito.git master

This is a simple "porcelain" for it:

-->8--

#!/usr/bin/perl
use warnings;
use strict;

# Remember that you must ensure the obj database is shared - either symlink it
# or setup alternates!
#my $remoteurl = 'git://git.kernel.org/pub/scm/git/git.git';
#my %config = (
#	'/pub/scm/git/git.git' => {
#		'next' => {
#			'/home/xpasky/q/gg' => 'origin'
#		},
#		'master' => {
#			'/home/xpasky/q/gg' => 'origin2',
#			'/home/xpasky/q/gg2' => 'origin'
#		}
#	},
#	'/pub/scm/cogito/cogito-doc.git' => {
#		master => {
#			'/home/xpasky/q/gg2' => 'origin2'
#		}
#	}
#);
my $remoteurl = 'puturlofremotehosthere';
my %config = (
	'remoterepo1' => {
		branch1 => {
			'localrepo1' => 'origin'
		},
		branch2 => {
			'localrepo1' => 'origin2',
			'localrepo2' => 'origin'
		}
	},
	'remoterepo2' => {
		master => {
			'localrepo2' => 'origin2'
		}
	}
);

my @args = ($remoteurl);
foreach my $repo (keys %config) {
	push (@args, '--repo='.$repo);
	foreach my $branch (keys %{$config{$repo}}) {
		push (@args, $branch);
	}
}

open (F, '-|', 'git-fetch-pack', @args) or die "$!";
while (<F>) {
	chomp;
	split / /, $_;
	my ($sha, $ref, $repo) = @_;
	$ref =~ s#^refs/heads/##;
	foreach my $lrepo (keys %{$config{$repo}->{$ref}}) {
		system("GIT_DIR=$lrepo git-update-ref $config{$repo}->{$ref}->{$lrepo} $sha");
	}
}
close (F);

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
