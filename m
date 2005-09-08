From: Jeff Carr <jcarr@linuxmachines.com>
Subject: Re: git-ls-new-files & make patch, pull, etc.
Date: Thu, 08 Sep 2005 15:19:03 -0700
Message-ID: <4320B8D7.7070004@linuxmachines.com>
References: <430A84D1.2050206@linuxmachines.com>	<7v1x4lz118.fsf@assigned-by-dhcp.cox.net>	<431DFF30.7010009@linuxmachines.com> <7virxdj45i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090802040204020007080706"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 00:17:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDUgu-0006xt-L0
	for gcvg-git@gmane.org; Fri, 09 Sep 2005 00:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbVIHWQS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 18:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbVIHWQS
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 18:16:18 -0400
Received: from [64.71.148.162] ([64.71.148.162]:8923 "EHLO
	mail.linuxmachines.com") by vger.kernel.org with ESMTP
	id S965033AbVIHWQS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2005 18:16:18 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.linuxmachines.com (Postfix) with ESMTP id C10426EFA4;
	Thu,  8 Sep 2005 15:19:00 -0700 (PDT)
Received: from mail.linuxmachines.com ([127.0.0.1])
	by localhost (giant [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 10758-07; Thu, 8 Sep 2005 15:19:00 -0700 (PDT)
Received: from [192.168.36.10] (x.packeteer.com [12.104.153.15])
	by mail.linuxmachines.com (Postfix) with ESMTP id 00F9E6EFA3;
	Thu,  8 Sep 2005 15:18:59 -0700 (PDT)
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virxdj45i.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.91.0.0
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at example.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8225>

This is a multi-part message in MIME format.
--------------090802040204020007080706
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 09/06/2005 02:08 PM, Junio C Hamano wrote:
> Jeff Carr <jcarr@linuxmachines.com> writes:
> 
> 
>>... If I remember
>>correctly, there was some threads at the beginning of git about how
>>datestamps were not accurate so there was no point in setting them(?) Or
>>maybe I mis-understood.
> 
> 
> The point of those thread was that clocks on machines tend to be
> not so accurate and we should not take the timestamps *too*
> seriously.  We do record the time as accurately as the clock is
> maintained on the machine the commit is made, provided if the
> user does not override it with the GIT_COMMIT_DATE environment
> variable with a bogus value.
> 
> The way you use it to show changes made in a certain timeperiod
> is a good example that the information is useful.  The argument
> against relying on timestamp too much in that thread you are
> remembering was that it should not be used to see which commit
> came before which other commit when there is no parent-child
> ancestry between them.  It is still a useful hint, and we do use
> it as such, but as the recent merge-base fixes show it is just a
> hint and relying on it too much tends to screw things up.


OK, I understand better now. I was just setting the mtime via the last
time the file showed up in the git-whatchanged output. When I check out
a repository I do:

git-read-tree -m HEAD && git-checkout-cache -q -f -u -a
git-restore-mtime

This is probably also a really bad reimplementation of something. :)

All and all, really enjoying using git. It's better.
Jeff

--------------090802040204020007080706
Content-Type: text/plain;
 name="git_restore_mtime"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git_restore_mtime"

#!/usr/bin/perl
# parses git-whatchanged output and then
# sets the mtime for all the files  # copyleft GPL

use strict;
use HTTP::Date;

# my $string = time2str($time);    # Format as GMT ASCII time
# my $now = str2time($string);    # convert ASCII date to machine time

my $oldest = localtime();
my %allfiles;
my $time;

# make a hash of all the files 
foreach my $file ( split "\n", `git-ls-files` ) {
	chomp $file;
	$allfiles{ $file } = 0;
}

# get the newest mtime for each one
foreach my $line ( `git-whatchanged` ) {
	chomp $line;
	my @parts = split " ", $line;
	if( $parts[0] eq "Date:" ) {
		shift @parts;
		pop @parts;
		$time = str2time( join " ", @parts );
		next;
	}
	if( $line =~ /^:/ ) {
		my $name = pop @parts;
		if( $allfiles{ $name } lt $time ) {
			# print "$name was $allfiles{ $name } now: $time\n";
			$allfiles{ $name } = $time;
		}
		if( $time lt $oldest ) {
			$oldest = $time;
		}
	}
}

# set the mtime for each one
foreach my $name ( sort keys %allfiles ) {
	if ( $allfiles{$name} eq 0 ) {
		# print "$name mtime $allfiles{$name}\n";
		utime $oldest, $oldest, $name;
	} else {
		# print "$name mtime $allfiles{$name}\n";
		utime $allfiles{$name}, $allfiles{$name}, $name;
	}
}


--------------090802040204020007080706--
