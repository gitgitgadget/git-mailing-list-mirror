From: Justin Frankel <justin@cockos.com>
Subject: RFC: checkout/temporary branch switch restoring modification times
Date: Mon, 04 Oct 2010 00:42:00 -0400
Organization: Cockos Incorporated
Message-ID: <4CA95B18.5090008@cockos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 04 06:49:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2cyy-0002Hm-F3
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 06:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545Ab0JDEst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 00:48:49 -0400
Received: from mail.cockos.com ([204.11.104.234]:53674 "EHLO mail.cockos.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341Ab0JDEst (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 00:48:49 -0400
X-Greylist: delayed 406 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Oct 2010 00:48:49 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.cockos.com (Postfix) with ESMTP id 024E9EC491
	for <git@vger.kernel.org>; Sun,  3 Oct 2010 21:43:12 -0700 (PDT)
X-Virus-Scanned: amavisd-new at mail.cockos.com
Received: from mail.cockos.com ([127.0.0.1])
	by localhost (mail.cockos.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a+lcdoUSys7V for <git@vger.kernel.org>;
	Sun,  3 Oct 2010 21:43:11 -0700 (PDT)
Received: from [192.168.2.42] (cpe-74-66-229-188.nyc.res.rr.com [74.66.229.188])
	by mail.cockos.com (Postfix) with ESMTPSA id 2D28DEC490
	for <git@vger.kernel.org>; Sun,  3 Oct 2010 21:43:11 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157976>

Hello all,

I often find myself wanting to switch temporarily to another branch, and
then back to my original branch, but what I find is that my build tools
such as MSVC or Xcode) notice the file modification times changed on
the changed files, and then want to rebuild, even though the contents of
the files are the same.

I've implemented a perl script (tested on OSX and msysGit), which I've
named "git-cop" (so I can use via "git cop") to checkout,
preserving file modification times.

The use case is:

git cop master
; build
git cop some-branch-that-affects-lots-of-files
; edit some things, commit
git cop master
; build (fast, nothing changed)

If you use "checkout" instead of "cop", the final build command might
take longer, since the modification times on files may have changed.

To summarize the implementation of the script:

1) Get a list of what files will change
2) Read timestamps for changed files, updating .git/timestamp-list.txt
which is effectively an associative array of timestamps, indexed
by "blobhash:filename".
3) Call git checkout
4) Update file modification times with their new timestamps (read from
.git/timestamp-list.txt, using newblobhash:filename).

This will get slower as that text file grows, but you can periodically
remove .git/timestamp-list.txt (any time you're not in the middle of a
temporary branch switch), and it will be regenerated.

As this is a request for comments, I'd be curious if anybody has
thoughts on the best way to integrate this type of functionality into
git, or indeed if anybody else thinks it is worth including (I do find
it saves me a great deal of time, but it is easy enough to add to my git
installs, too).

Additionally, is there a better place to store repository-local
information, information which isn't terribly important and shouldn't be
copied in case of clones, etc? I figured .git/timestamp-list.txt isn't
the best place, but where would that be?

Cheers,

Justin



---------------- begin git-cop -----------------
#!/usr/bin/perl

my ($destbranch,$allargs) = ("", "");

foreach (@ARGV) {
	$allargs .= " $_";
	# last non-option parameter would be considered the new branch
	$destbranch = $_ if ($_ !~ /^-/);
}

$destbranch eq "" and die "Usage: git-cop [checkout options] <branch>\n";

my $modf = join('',`git diff --name-only HEAD..$destbranch`);
$modf =~ s/ /\\ /g;
$modf =~ s/\n/ /g;

length($modf)>0 or exit(system("git checkout$allargs"));

chomp(my $pwd = `git rev-parse --show-toplevel`);
my $idxfile = "${pwd}/.git/timestamp-list.txt";
chdir($pwd);

my %times;
if (open(my $F, "<", $idxfile)) {
	# read cached timestamps
	while (<$F>) {
		chomp;
		my ($val, $nm) = split(/\t/, $_,2);
		$nm eq "" or $val eq "" or $times{$nm} = $val;
	}
	close($F);
}

my $idxfile_updcnt = 0;
foreach (`git ls-tree HEAD $modf`) {
	chomp;
	my ($perm, $type, $hash, $fn) = split(" ",$_,4);
	if ($type eq "blob") {
		# add/update timestamp in cache if needed
		$hash .= ":$fn";
		my $mt = int ((stat("${pwd}/$fn"))[9]);
		if ($mt && $mt != (int $times{$hash})) {
			$times{$hash} = $mt;
			$idxfile_updcnt++;
		}
	}
}

if ($idxfile_updcnt != 0) {
	print "Saved/updated timestamps for $idxfile_updcnt files\n";
	if (open(my $F, ">", $idxfile)) {
		print $F "$ts\t$nm\n" while (($nm,$ts) = each(%times));
		close($F);
	}
}

my $rv = system("git checkout$allargs");

!$rv or exit($rv);

# restore timestamps from cache
my $update_cnt = 0;
foreach (`git ls-tree HEAD $modf`) {
	chomp;
	my ($perm, $type, $hash, $fn) = split(" ",$_,4);
	if ($type eq "blob") {
		$hash .= ":$fn";
		my $tsreq = int $times{$hash};
		if ($tsreq &&
  		    $tsreq != (int ((stat("${pwd}/$fn"))[9]))) {
			utime(undef,$tsreq,"${pwd}/$fn");
			$update_cnt++;
		}
	}
}
$update_cnt < 1 or
	print "Updated file timestamps for $update_cnt files\n";

exit (0);

---------------- end git-cop -----------------
