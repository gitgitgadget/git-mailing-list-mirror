From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC][RESEND][PATCH] Allow fetching from multiple repositories at once
Date: Sat, 23 Sep 2006 19:06:21 +0200
Message-ID: <20060923170621.GR8259@pasky.or.cz>
References: <20060923164308.16334.49252.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="JgQwtEuHJzHdouWu"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 19:06:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRAxQ-0005by-Hl
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 19:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWIWRGZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 13:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWIWRGZ
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 13:06:25 -0400
Received: from w241.dkm.cz ([62.24.88.241]:16774 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751329AbWIWRGY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 13:06:24 -0400
Received: (qmail 18878 invoked by uid 2001); 23 Sep 2006 19:06:21 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060923164308.16334.49252.stgit@machine.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27602>


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear diary, on Sat, Sep 23, 2006 at 06:45:09PM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
> You still need to pass git-fetch-pack some URL in addition to the
> repositories - it is used only for git_connect(), the purpose is that
> repositories must be local directories so if you want to talk remote, you
> need to do something like
> 
> 	git-fetch-pack git://kernel.org/pub/scm/git/git.git --repo=/pub/scm/git/git.git master next --repo=/pub/scm/cogito/cogito.git master
..snip..
> The main target of this are the Xorg people who have plenty of small repos
> and frequently want to update many of them. It would be nice if someone
> from Xorg reading this and concerned with this could measure the
> difference.

Attached is a simple porcelain script for this.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)

--JgQwtEuHJzHdouWu
Content-Type: text/x-perl; charset=us-ascii
Content-Disposition: attachment; filename="multifetch.pl"

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

--JgQwtEuHJzHdouWu--
