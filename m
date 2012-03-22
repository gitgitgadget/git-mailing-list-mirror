From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 10/9 v4] difftool: fix regression in '--prompt' options
Date: Thu, 22 Mar 2012 09:19:26 +0100
Message-ID: <871uoljbe9.fsf@thomas.inf.ethz.ch>
References: <1332358560-13774-4-git-send-email-tim.henigan@gmail.com>
	<1332381236-16004-1-git-send-email-tim.henigan@gmail.com>
	<7viphxz37j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Tim Henigan <tim.henigan@gmail.com>, <git@vger.kernel.org>,
	<davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 09:19:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAdFO-0006BM-Ks
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 09:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756269Ab2CVITj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 04:19:39 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:53723 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755994Ab2CVIT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 04:19:29 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 22 Mar
 2012 09:19:25 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 22 Mar
 2012 09:19:27 +0100
In-Reply-To: <7viphxz37j.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 21 Mar 2012 21:09:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193636>

Junio C Hamano <gitster@pobox.com> writes:

> Tim Henigan <tim.henigan@gmail.com> writes:
>
>> +# the '--prompt' and '--no-prompt' options require special treatment
>> +# because they may be specified more than once...the last one "wins".
>> +for (@ARGV) {
>> +	if (($_ eq "-y") or ($_ eq "--no-prompt")) {
>> +		$prompt = 0;
>> +	} elsif ($_ eq "--prompt") {
>> +		$prompt = 1;
>> +	} else {
>> +		push(@diffargs, $_);
>> +	}
>> +}
>
> I really do not like the direction in which this series is going.  We do
> not have a similar --no-gui option to defeat --gui option that may appear
> earlier on the command line, but when we fix that bug (isn't it a bug?),
> we would have to teach this loop about that option, wouldn't we?
>
> In the end, won't you end up resurrecting the argument parsing loop that
> you got rid of with the first patch in your series?  Isn't this working
> around the problem introduced only because you are using Getopt::Long and
> hitting its limitations?

Limitations?  You can basically steal code from git-send-email.  As an
example:

---- 8< ----
#!/usr/bin/perl

use strict;
use warnings;
use Getopt::Long;

my $foo = 0;
my $rc = GetOptions("foo!" => \$foo,
		    "n" => sub { $foo = 0; },
		    "y" => \$foo);

print "$foo\n";
---- 8< ----

$ ./getopt-test.perl -n
0
$ ./getopt-test.perl -y
1
$ ./getopt-test.perl --foo
1
$ ./getopt-test.perl --no-foo
0
$ ./getopt-test.perl --foo --no-foo
0
$ ./getopt-test.perl -y -n
0
$ ./getopt-test.perl --foo -n
0

--
Thomas Rast
trast@{inf,student}.ethz.ch
