From: Toby Allsopp <Toby.Allsopp@navman.co.nz>
Subject: Re: Rebasing Multiple branches at once...
Date: Fri, 17 Oct 2008 09:27:48 +1300
Message-ID: <87vdvscmkb.fsf@nav-akl-pcn-343.mitacad.com>
References: <48F730D0.9040008@calicojack.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: Rick Moynihan <rick@calicojack.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 22:44:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqZhr-0006XX-Kv
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 22:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142AbYJPUnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 16:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754266AbYJPUnL
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 16:43:11 -0400
Received: from ip-58-28-171-25.wxnz.net ([58.28.171.25]:27825 "EHLO
	AKLEXFE01.mitacad.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752385AbYJPUnK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 16:43:10 -0400
X-Greylist: delayed 915 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Oct 2008 16:43:10 EDT
Received: from AKLEXVS01.mitacad.com ([10.112.5.35]) by AKLEXFE01.mitacad.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 17 Oct 2008 09:27:56 +1300
Received: from nav-akl-pcn-343.mitacad.com.navman.co.nz ([10.112.8.44]) by AKLEXVS01.mitacad.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 17 Oct 2008 09:27:56 +1300
In-Reply-To: <48F730D0.9040008@calicojack.co.uk> (Rick Moynihan's message of
	"Thu, 16 Oct 2008 13:17:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
X-OriginalArrivalTime: 16 Oct 2008 20:27:56.0787 (UTC) FILETIME=[ACA20430:01C92FCD]
X-TM-AS-Product-Ver: SMEX-8.0.0.1181-5.500.1027-16222.001
X-TM-AS-Result: No--21.895500-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98423>


--=-=-=

On Fri, Oct 17 2008, Rick Moynihan wrote:

> Hi,
>
> I have a master branch, a dev branch and a number of feature branches
> from dev.  And I was wondering if there was an easy way to rebase dev
> and all of it's sub-branches onto master.
>
> I know I can run this as a series of commands, and use --onto to do
> this, but was wondering if there was an easier way.  As running:
>
> git rebase master
>
> when on the dev branch only rebases dev and not it's dependent
> branches.

I have a Perl script I use to rebase a number of topic branches as the
remote tracking branches they're based on move.  It handles the case of
topic based on other topics.  It is designed specifically for my
workflow, which is tracking a central Subversion repository using
git-svn, but I don't think it relies on using git-svn.  Anyway, you
might find it useful for inspiration.

The script outputs a sequence of commands and leaves the running of them
up to you because you may need to resolve conflicts at any point.

Regards,
Toby.


--=-=-=
Content-Type: text/x-perl
Content-Disposition: inline; filename=git-rebase-branches

#!/usr/bin/perl

# Rebases master and everything based on master to the new trunk.  Use
# after a git-svn-fetch.

use strict;
use warnings;

use Getopt::Long;
use List::Util qw(first);

use Git;

my $dry_run;

GetOptions("dry-run|n" => \$dry_run)
  or die "usage error";

sub ref2branch {
    my $ref = shift;
    $ref =~ s,^refs/heads/,,
      or die "Not a branch: '$ref'";
    return $ref;
}

my $repo = Git->repository();

my %remotes_by_name;
my %remotes_by_hash;
my %remote_revs;

for ($repo->command('for-each-ref', 'refs/remotes')) {
    my ($hash, undef, $ref) = split;
    $remotes_by_name{$ref} = $hash;
    $remotes_by_hash{$hash} = $ref;
    $remote_revs{$ref} = [$repo->command('rev-list', $ref)];
}

my %heads_by_name;
my %heads_by_hash;

for ($repo->command('for-each-ref', 'refs/heads')) {
    my ($hash, undef, $ref) = split;
    $heads_by_name{$ref} = $hash;
    $heads_by_hash{$hash} = $ref;
}

my %roots;
my %heads_by_parent;

for my $head (sort keys %heads_by_name) {
    #print STDERR "Considering $head\n";
    my $parent;
    my $last_rev;
    for my $rev ($repo->command('rev-list', $head, '--not', keys %remotes_by_name)) {
        my $maybe_parent = $heads_by_hash{$rev};
        if ($maybe_parent && $maybe_parent ne $head) {
            #print STDERR "  found parent $maybe_parent\n";
            $parent = $maybe_parent;
            last;
        }
        $last_rev = $rev;
    }
    if ($parent) {
        push @{$heads_by_parent{$parent}}, $head;
    } elsif ($last_rev) {
        my $remote_base = $repo->command_oneline('rev-parse', "$last_rev^");
        my @remotes;
        #print STDERR "  last rev $last_rev $remote_base\n";
        for my $remote_name (sort keys %remotes_by_name) {
            my $remote = first { $_ eq $remote_base } @{$remote_revs{$remote_name}};
            if (defined($remote) && $remote eq $remote_base) {
                #print STDERR "  found remote $remote_name\n";
                push @remotes, $remote_name;
            }
        }
        if (@remotes == 1) {
            $roots{$head} = $remotes[0];
        } else {
            print STDERR "WARNING: Not exactly one candidate remote for $head: ",
                join(' ', @remotes), "\n";
        }
    }
}

for my $root (sort keys %roots) {
    my $remote = $roots{$root};
    my $short_root = ref2branch($root);
    $remote =~ s,^refs/,,;
    print "git rebase $remote $short_root\n";
    rebase_tree($root);
}

sub rebase_tree {
    my ($parent) = @_;
    for my $head (@{$heads_by_parent{$parent}}) {
        my $short_parent = ref2branch($parent);
        my $short_head = ref2branch($head);
        print "git rebase --onto $short_parent $heads_by_name{$parent} $short_head\n";
        rebase_tree($head);
    }
}

--=-=-=--
