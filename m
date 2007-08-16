From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Storing Maintainers info around the kernel tree
Date: Thu, 16 Aug 2007 09:04:50 -0400
Message-ID: <D31EF534-ACD1-426D-AF88-F152C23CB542@mac.com>
References: <46bffbd3.IqsNHrHU1Y9BF7Dd%joe@perches.com> <20070814232430.GA9325@redhat.com> <2ABEF126-D860-46D2-8E15-673C3ADB51A0@mac.com> <200708151321.05959.rjw@sisk.pl>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: multipart/mixed; boundary=Apple-Mail-11-656376432
Cc: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Joe Perches <joe@perches.com>, Pavel Machek <pavel@ucw.cz>,
	linux-pm@lists.linux-foundation.org,
	LKML Kernel <linux-kernel@vger.kernel.org>,
	Salikh Zakirov <salikh@gmail.com>, git@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Rene Herman <rene.herman@gmail.com>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760469AbXHPNFj@vger.kernel.org Thu Aug 16 15:05:58 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760469AbXHPNFj@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILf2t-0002pW-WA
	for glk-linux-kernel-3@gmane.org; Thu, 16 Aug 2007 15:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760469AbXHPNFj (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 16 Aug 2007 09:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754504AbXHPNFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Aug 2007 09:05:00 -0400
Received: from smtpout.mac.com ([17.250.248.178]:49953 "EHLO smtpout.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753692AbXHPNE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Aug 2007 09:04:58 -0400
Received: from mac.com (smtpin02-en2 [10.13.10.147])
	by smtpout.mac.com (Xserve/smtpout08/MantshX 4.0) with ESMTP id l7GD4vOF006914;
	Thu, 16 Aug 2007 06:04:57 -0700 (PDT)
Received: from [10.0.2.1] (ip70-187-212-71.dc.dc.cox.net [70.187.212.71])
	(authenticated bits=0)
	by mac.com (Xserve/smtpin02/MantshX 4.0) with ESMTP id l7GD4pQV026607
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 16 Aug 2007 06:04:56 -0700 (PDT)
In-Reply-To: <200708151321.05959.rjw@sisk.pl>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56013>


--Apple-Mail-11-656376432
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

Merging a couple related threads here:

On Aug 16, 2007, at 07:57:23, Rene Herman wrote:
> On 08/16/2007 01:26 PM, Salikh Zakirov wrote:
>> Rene Herman wrote:
>>> Perhaps that immediately suggests an implementation to someone  
>>> already familiar with git internals?
>> perhaps http://www.kernel.org/pub/software/scm/git/docs/ 
>> gitattributes.html and http://www.kernel.org/pub/software/scm/git/ 
>> docs/git-check-attr.html can help you?
>
> No, thanks, saw them, but .gitattributes is in fact in the same  
> category as .gitignore, which would _be_ a property.
>
> If you do this stuff in files scattered around the tree, updating  
> and moving stuff becomes a pain -- the tool would need to go edit  
> files.

 From a practical standpoint we don't want to duplicate someone's  
maintainer information in the attributes of every file they  
maintain.  It would be much easier to put in the "kernel/somesubsys"  
directory a Maintainers file which has:

[SOME RANDOM SUBSYSTEM]
P: J. Random Hacker
M: j.random.hacker@localhost
L: random-subsys-devel@vger.kernel.org
F: *

Anywhere else you had files that you wanted to associate with J.  
Random Hacker's maintainership, you would just use:

[SOME RANDOM SUBSYSTEM]
F: somesubsys.h


I posted a comment describing a mechanism like this a couple days ago:
   http://lkml.org/lkml/2007/8/14/488

Executive overview:
On Aug 15, 2007, at 07:21:04, Rafael J. Wysocki wrote:
> On Wednesday, 15 August 2007 04:51, Kyle Moffett wrote:
>> (a) "Maintainers" files sprinkled around the source tree with  
>> relative pathnames and other data
>>
>> (b) Tool to generate a combined "MAINTAINERS" file from the ones  
>> sprinkled around the source tree
>>
>> (c) Tool to search through the generated "MAINTAINERS" file with  
>> all sorts of useful command-line options
>>
>> (d) Tool to check the generated "MAINTAINERS" file against recent  
>> git history and make suggestions
>
> I like this idea. :-)

Well, to back up this idea with some code, I'm attaching a little  
perl script which does part (b).  Basically you call it as:
   ./maint-combine $(find . -name Maintainers)

It will print any syntax errors on stderr during parsing.  Once it's  
done it will dump to stdout its combined "MAINTAINERS" text.  A  
couple notes:

*  It uses a little "priority" system to figure out what order to  
print the data from each origin in.  For example, the "F:" tag is  
given a score of 0, to force data consisting of just files towards  
the end.  The "P:", "M:", and "L:" tags are given scores of 5, since  
people are generally interesting to know about.  Everything else is  
given a score of "1".  The scores are added up per ($file,  
$subsystem) pair and then during printing each subsystem's data is  
ordered by score (highest comes first).

*  It generally allows any field at all; eventually we might want to  
limit it to a fixed list to help avoid typos.

*  It has a little bit of magic logic for the "F:" field so that it  
figures out the relative directory for each field when generating the  
output.  For example, an entry of "asm-*/suspend.h" in a file  
"include/Maintainers" will produce the output file entry: "F: include/ 
asm-*/suspend.h"

*  The format isn't quite the same as the current MAINTAINERS file,  
to make parsing easier and more dummy-proof I changed the syntax for  
a subsystem-name to use square brackets (IE: "[SUSPEND TO RAM]").   
The samples I gave in my previous email are what I used to test it  
with, plus a little dummy file with some syntax errors to check out  
the error messages:

Maintainers:
> [EVERYTHING ELSE]
> P: Various Linux Kernel Developers
> L: linux-kernel@vger.kernel.org
> F: *

kernel/power/Maintainers:
> [SUSPEND TO RAM]
> P: Pavel Machek
> M: pavel@suse.cz
> P: Rafael J. Wysocki
> M: rjw@sisk.pl
> L: linux-pm@lists.linux-foundation.org
> S: Maintained
> F: *

include/Maintainers:
> [SUSPEND TO RAM]
> F: linux/suspend.h
> F: linux/freezer.h
> F: linux/pm.h
> F: asm-*/suspend.h



If you have any other questions, the perl script is pretty self- 
explanatory and I'll be completely back online this weekend.  With  
any luck I'll have some time in a hotel tomorrow (mmm, slow-as-dirt  
hotel wireless, what fun) to work on parts (c) and (d).

Cheers,
Kyle Moffett


--Apple-Mail-11-656376432
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	x-unix-mode=0755;
	name=maint-combine.txt
Content-Disposition: attachment;
	filename=maint-combine.txt

#! /usr/bin/perl

use strict;
use warnings;

## This table is for determining what order to show entries from different
## source "Maintainers" files.  They are prioritized based on the number and
## significance of each field, as listed in this table.  Any field not found
## here will be assumed to have a significance of "1".
my %fieldprio = (
	p => 5,  ## Person
	m => 5,  ## Email
	l => 5,  ## Mailing List
	f => 0,  ## File
);


my %mprio;
my %maint;
my $section;
my $origin;
my $pathprefix;
my $printorigin;

while (<>) {
	unless (defined $origin and $origin eq $ARGV) {
		undef $section;

		## Get rid of extra slashes, unnecessary "./" entries
		$ARGV =~ s{//+}{/}g;
		$ARGV =~ s{(^|/)\./}{$1};

		$origin = $ARGV;
	}

	chomp; s/\s+/ /g; s/^ //; s/ $//;
	/\S+/ or next;

	if (/^\[ ?([^]]+) ?\]$/) {
		$section = uc $1;

		$printorigin = 1 if $origin ne '-';

		$maint{$section}{$origin} ||= [];
		$mprio{$section}{$origin} ||= 0;

		## Figure out a useful path prefix if there is one
		$pathprefix = ($origin =~ m{(^.*/)(?!\.\.?$)[^/]+$})?$1:"";

		next;
	}

	unless (/^([^:]+?) ?: ?(.*)$/) {
		print STDERR "$ARGV:$.: Invalid line: $_\n";
		next;
	}

	my($field,$value) = (lc($1), $2);

	unless (defined $section) {
		print STDERR "$ARGV:$.: Found field '\u$field' before ",
				"any subsystem declaration: $_\n";
		next;
	}

	## Preprocess paths to make them absolute
	$value = $pathprefix.$value if $field eq 'f';

	## Update the sorting order
	if (exists $fieldprio{$field}) {
		$mprio{$section}{$origin} += $fieldprio{$field};
	} else {
		$mprio{$section}{$origin}++;
	}

	push @{$maint{$section}{$origin}}, [$field, $value];
}

sub priosort ( $@ )
{
	my $section = shift;
	return sort {$mprio{$section}{$b} <=> $mprio{$section}{$a}} @_;
}

for $section (sort {$a cmp $b} keys %maint) {
	print "[$section]\n";
	for my $origin (priosort $section, keys %{$maint{$section}}) {
		print "\nOrigin: $origin\n" if $printorigin;
		print "\u$_->[0]: $_->[1]\n" for @{$maint{$section}{$origin}};
	}
	print "\n\n";
}

# vim:set ft=perl:

--Apple-Mail-11-656376432--
