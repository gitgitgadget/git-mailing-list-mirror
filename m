From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Doubts about hot to properly write post-receive hook to send an email
 with a newly added patch
Date: Sat, 06 Mar 2010 12:55:35 -0300
Message-ID: <4B927AF7.2060708@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 06 22:28:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No15x-0004YU-AG
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 21:59:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096Ab0CFPzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 10:55:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:12000 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821Ab0CFPzj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 10:55:39 -0500
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o26Ftd6M031534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Sat, 6 Mar 2010 10:55:39 -0500
Received: from [10.11.9.128] (vpn-9-128.rdu.redhat.com [10.11.9.128])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o26FtaGV017946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sat, 6 Mar 2010 10:55:38 -0500
User-Agent: Thunderbird 2.0.0.22 (X11/20090609)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm needing a post-receive hook that would send a copy to the patch author,
to the C/C recipients and to the ones that signed/acked/tested a patch.

The idea is to announce to the patch author and to the relevant parts that
a new patch were accepted on my -git tree, showing the patch/comments
after its addition at the tree.

So, I wrote a perl script for this (see enclosed) for it.

Unfortunately, I just found a serious bug: when I merge back from upstream, 
it sends a message also for all patch authors from upstream!

What's the better way to identify what patches came from a merge tree,
in order to remove them from the mailbomb queue?

Cheers,
Mauro


---

#!/usr/bin/perl
#
# License: GPLv2
#
use warnings;
use strict;
use Sys::Hostname;

$ENV{PATH} = '/usr/local/bin:/usr/bin:/bin';

my $debug = 0;
my $mail_cmd = "/usr/sbin/sendmail";
#
# Retrieve all info from git config
#
my $project_name = qx(git config mailnotify.project) || "untitled";
my $smtp_server  = qx(git config mailnotify.smtpserver) || "localhost";
my $from         = qx(git config mailnotify.from) || sprintf('%s@%s', $project_name, hostname());
my $to           = qx(git config mailnotify.to) || die("No mail To:");
my $cfgcc        = qx(git config mailnotify.cc) || "";
my $replyto      = qx(git config mailnotify.replyto) || "";
my $maxsize      = qx(git config mailnotify.maxsize) || "";
my $url          = qx(git config mailnotify.url) || "";

$project_name =~ s/\s+$//;
$smtp_server =~ s/\s+$//;
$from =~ s/\s+$//;
$to =~ s/\s+$//;
$cfgcc =~ s/\s+$//;
$replyto =~ s/\s+$//;
$maxsize =~ s/\s+$//;
$url =~ s/\s+$//;

#
# Get old revision, new revision and branch/tag name
#
my ($oldrev, $newrev, $refname);
if (scalar(@ARGV)) {
	($oldrev, $newrev, $refname) = @ARGV[ 0 .. 2 ];
} else {
	my $args = <STDIN>;
	($oldrev, $newrev, $refname) = split(" ", $args);
}
printf(STDERR "args:%s %s %s\n", $oldrev, $newrev, $refname) if ($debug);

#
# Get the complete revision name
#
$oldrev = qx(git rev-parse $oldrev);
$newrev = qx(git rev-parse $newrev);

chomp($oldrev);
chomp($newrev);
chomp($refname);

if ($debug) {
    printf(STDERR "oldrev:%s\n", $oldrev);
    printf(STDERR "newrev:%s\n", $newrev);
    printf(STDERR "refname:%s\n", $refname);
}

#
# Get branch name
#
my $branch = (split("/", $refname))[-1];

#
# get revisions
#
open REF, "git rev-list $oldrev..$newrev|";
while (<REF>) {
	my $ref= $_;

	my $author = qx(git log -1 --pretty=format:"%aN" $ref);
	my $data = qx(git log -1 --pretty=format:"%aD" $ref);
	my $subject = qx(git log -1 --pretty=format:"%s" $ref);
	$subject = sprintf("[git:%s/%s] %s", $project_name, $branch, $subject);

	my %copy;
	my $log = "";
	open IN, "git log -1 --pretty=email --stat $ref|";

	# Discard initial From line
	my $dumb=<IN>;

	while (<IN>) {
		next if (m/^Subject: /);
		next if (m/^Date: /);
		$log .= $_;

		if (m/(signed-off-by|author|from|accepted-by|tested-by|thanks-to|reviewed-by|cc|acked-by):\s*(.*)\s*\n$/i) {
			my $sob=$2;
			if ($sob =~ m/\s*(.*)\s*<(.*)>/) {
				my $name = $1;
				my $email = $2;
				$name =~ s/^\s+//;
				$name =~ s/\s+$//;
				$name =~ s/^\"(.*)\"$/$1/;
				$name="" if ($name =~ m/\@/);
				$copy{"$email"} = $name;
			} elsif ($sob =~ m/([^\s]+\@[^\s+]+)/) {
				my $email = $1;
				$copy{"$email"} = "" if (!exists($copy{"$email"}));
			}
		}
	}
	close IN;

	my $cc = $cfgcc;
	while (my ($key,$value) = each(%copy) ) {
		next if ($key =~ m/stable\@kernel.org/);
		if ($value ne "") {
			$cc .= ", $value <$key>";
		} else {
			$cc .= ", $key";
		}
	}
	$cc =~ s/^, //;
	$cc =~ s/\s+/ /g;

	my $diff = qx(git show --pretty=format:"" $ref);

	my $header = "Subject: $subject\nFrom: Patch from $author <$from>\nTo: $to\nData: $data\n";
	$header .= "Cc: $cc\n" if ($cc);

	if ($replyto) {
		$header .= "Mail-followup-to: $replyto\n";
		$header .= "Forward-to: $replyto\n";
		$header .= "Reply-to: $replyto\n";
	}

	my $email = "$header\n$log\n---\n\n";
	$email   .= "$url?a=commitdiff;h=$ref" if ($url);
	if ($maxsize && length($diff) > $maxsize) {
		$diff = "<diff discarded since it is too big>\n"
	}
	$email .= $diff;

	if (!$debug) {
		open(MAIL, "| $mail_cmd -t");
		print MAIL $email;
		close MAIL;
	} else {
		print $email;
	}
}

close REF;
