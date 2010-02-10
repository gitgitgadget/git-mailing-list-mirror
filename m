From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCHv2 04/10] gitweb: Use Cache::Cache compatibile (get, set) output caching
Date: Wed, 10 Feb 2010 12:28:14 +0100
Message-ID: <201002101228.15732.jnareb@gmail.com>
References: <1265711427-15193-1-git-send-email-jnareb@gmail.com> <201002100212.26157.jnareb@gmail.com> <20100210012343.GS9553@machine.or.cz>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PhpcLpHC8MS7Xd0"
Cc: git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Feb 10 12:28:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfAkB-00046K-MC
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 12:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755166Ab0BJL20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 06:28:26 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:33612 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754894Ab0BJL2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 06:28:24 -0500
Received: by fxm20 with SMTP id 20so1082037fxm.21
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 03:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :message-id;
        bh=4Hn4yo2xeYzxB2sSQU1V9Kqf38n9JTRe0Bwc/Zkd6j4=;
        b=WjxKkRpeC0GVUw8oCPyFBEiNMtqs50eGbMslpht62HKd2UigvOM1030mDJE8J4mnCk
         jELv/1BWY8EX8cy9ZXSEFSrWkiY+HqqEK+7WfCS/cdkjy7X/Vinu7e8meI4mcgSsojGu
         WGX3Ae7YQND88iehgbh/6QCRJtgalirMcMIuA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:message-id;
        b=HP1gga1xniY/R4xNKtqhrr2PPflkgg9x+ME6/roEucVWGExuGIE5GnLSxOwBfC6MFD
         sqA+qoEW5WkvI+zGifORaGJOzPWdM7UVu7ehivR11XBZ6Tnj/B4Q9ZE9+WDXalTTb2JV
         xhWmQdyLIlgFzxJtvDCVBhKRrMNu2p1j1BV0w=
Received: by 10.223.95.69 with SMTP id c5mr117622fan.44.1265801300678;
        Wed, 10 Feb 2010 03:28:20 -0800 (PST)
Received: from ?192.168.1.13? (abvh24.neoplus.adsl.tpnet.pl [83.8.205.24])
        by mx.google.com with ESMTPS id 18sm1824362fks.4.2010.02.10.03.28.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Feb 2010 03:28:18 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20100210012343.GS9553@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139506>

--Boundary-00=_PhpcLpHC8MS7Xd0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 10 Feb 2010, Petr Baudis wrote:
> On Wed, Feb 10, 2010 at 02:12:24AM +0100, Jakub Narebski wrote:
> > On Tue, 9 Feb 2010 at 11:30 +0100, Jakub Narebski wrote:
> > 
> > > The cache_fetch subroutine captures output (from STDOUT only, as
> > > STDERR is usually logged) using either ->push_layer()/->pop_layer()
> > > from PerlIO::Util submodule (if it is available), or by setting and
> > > restoring *STDOUT.  Note that only the former could be tested reliably
> > > to be reliable in t9503 test!
> > 
> > Scratch that, I have just checked that (at least for Apache + mod_cgi,
> > but I don't think that it matters) the latter solution, with setting
> > and restoring *STDOUT doesn't work: I would get data in cache (so it
> > can be restored later), but instead of output I would get Internal Server
> > Error ("The server encountered an internal error or misconfiguration and
> > was unable to complete your request.") without even a hint what the
> > problem was.  Sprinkling "die ...: $!" didn't help to catch this error:
> > I suspect that the problem is with capturing.
> > 
> > So we either would have to live with non-core PerlIO::Util or (pure Perl)
> > Capture::Tiny, or do the 'print -> print $out' patch...
> 
> All the magic methods seem to be troublesome, but in that case I'd
> really prefer a level of indirection instead of filehandle - as is,
> 'print (...) -> output (...)' ins. of 'print (...) -> print $out (...)'
> (or whatever). That should be really flexible and completely
> futureproof, and I don't think the level of indirection would incur any
> measurable overhead, would it?

First, it is not only 'print (...) -> print $out (...)'; you need to
do all those:

   print  <sth>            ->  print  $out <sth>
   printf <sth>            ->  printf $out <sth>
   binmode STDOUT, <mode>  ->  binmode $out, <mode>

Second, using "tie" on filehandle (on *STDOUT) can be used also for 
just capturing output, not only for "tee"-ing; what's more to print
while capturing one has to do extra work.  It is quite similar to
replacing 'print (...)' with 'output (...)' etc., but using
tie/untie doesn't require large patch to gitweb.

Third, as you can see below tie-ing is about 1% slower than using
'output (...)', which in turn is less than 10% slower than explicit
filehandle solution i.e. 'print $out (...)'... and is almost twice
slower than solution using PerlIO::Util

Benchmark: timing 50000 iterations of output, perlio, print \$out, tie *STDOUT...
     output: 1.81462 wallclock secs ( 1.77 usr +  0.00 sys =  1.77 CPU) @ 28248.59/s (n=50000)
     perlio: 1.05585 wallclock secs ( 1.03 usr +  0.00 sys =  1.03 CPU) @ 48543.69/s (n=50000)
print \$out: 1.70027 wallclock secs ( 1.66 usr +  0.00 sys =  1.66 CPU) @ 30120.48/s (n=50000)
tie *STDOUT: 1.82248 wallclock secs ( 1.79 usr +  0.00 sys =  1.79 CPU) @ 27932.96/s (n=50000)
               Rate tie *STDOUT      output print \$out      perlio
tie *STDOUT 27933/s          --         -1%         -7%        -42%
output      28249/s          1%          --         -6%        -42%
print \$out 30120/s          8%          7%          --        -38%
perlio      48544/s         74%         72%         61%          --

Benchmark: running output, perlio, print \$out, tie *STDOUT for at least 10 CPU seconds...
     output: 10.7199 wallclock secs (10.53 usr +  0.00 sys = 10.53 CPU) @ 28029.63/s (n=295152)
     perlio: 11.2884 wallclock secs (10.46 usr +  0.00 sys = 10.46 CPU) @ 49967.11/s (n=522656)
print \$out: 10.5978 wallclock secs (10.43 usr +  0.00 sys = 10.43 CPU) @ 30318.79/s (n=316225)
tie *STDOUT: 11.3525 wallclock secs (10.68 usr +  0.00 sys = 10.68 CPU) @ 27635.96/s (n=295152)
               Rate tie *STDOUT      output print \$out      perlio
tie *STDOUT 27636/s          --         -1%         -9%        -45%
output      28030/s          1%          --         -8%        -44%
print \$out 30319/s         10%          8%          --        -39%
perlio      49967/s         81%         78%         65%          --
need

Attached there is script that was used to produce those results.
-- 
Jakub Narebski
Poland

--Boundary-00=_PhpcLpHC8MS7Xd0
Content-Type: text/plain;
  charset="iso-8859-1";
  name="print_to_scalar_benchmark.pl"
Content-Transfer-Encoding: 8bit
Content-Description: Benchmark of different ways of capturing output in Perl code
Content-Disposition: inline;
	filename="print_to_scalar_benchmark.pl"

#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Time::HiRes;
use Benchmark qw(:all :hireswallclock);
use Data::Dumper;

use PerlIO::Util;

my $chunk = "test\n";

my $lorem = <<'EOF';
Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do
eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad
minim veniam, quis nostrud exercitation ullamco laboris nisi ut
aliquip ex ea commodo consequat. Duis aute irure dolor in
reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
culpa qui officia deserunt mollit anim id est laborum.

Sed ut perspiciatis unde omnis iste natus error sit voluptatem
accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae
ab illo inventore veritatis et quasi architecto beatae vitae dicta
sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit
aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos
qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui
dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed
quia non numquam eius modi tempora incidunt ut labore et dolore magnam
aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum
exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex
ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in
ea voluptate velit esse quam nihil molestiae consequatur, vel illum
qui dolorem eum fugiat quo voluptas nulla pariatur?
EOF

sub capture_perlio {
	my $data = '';

	*STDOUT->push_layer(scalar => \$data);

	print $chunk;

	*STDOUT->pop_layer();

	return $data;
}

my $out = \*STDOUT;

sub capture_filehandle {
	my $data = '';

	open my $data_fh, '>', \$data;
	$out = $data_fh;

	print $out $chunk;

	$out = \*STDOUT;
	close $data_fh;

	return $data;
}

sub output {
	print $out @_;
}

sub capture_indirection {
	my $data = '';

	open my $data_fh, '>', \$data;
	$out = $data_fh;

	output $chunk;

	$out = \*STDOUT;
	close $data_fh;

	return $data;
}

sub capture_tied {
	my $data = '';

	tie *STDOUT, 'CatchSTDOUT', \$data;

	print $chunk;

	untie *STDOUT;

	return $data;
}

{
	package CatchSTDOUT;

	use strict;
	use warnings;
	use Data::Dumper;

	sub TIEHANDLE {
		my ($proto, $dataref) = @_;
		my $class = ref($proto) || $proto;

		my $self = {};
		$self = bless($self, $class);
		$self->{'scalar'} = $dataref;
		return $self;
	}

	sub PRINT {
		my $self = shift;
		${$self->{'scalar'}} .= join('',@_);
	}
}

# ----------------------------------------------------------------------

print 'capture_perlio      = '.capture_perlio();
print 'capture_filehandle  = '.capture_filehandle();
print 'capture_indirection = '.capture_indirection();
print 'capture_tied        = '.capture_tied();

$chunk = "another test\n";
print 'capture_perlio      = '.capture_perlio();
print 'capture_filehandle  = '.capture_filehandle();
print 'capture_indirection = '.capture_indirection();
print 'capture_tied        = '.capture_tied();

print "\n";


$chunk = $lorem;

my $result = timethese(50_000, {
	'perlio'      => \&capture_perlio,
	'print \$out' => \&capture_filehandle,
	'output'      => \&capture_indirection,
	'tie *STDOUT' => \&capture_indirection,
});
cmpthese($result);
print "\n";

$result = timethese(-10, {
	'perlio'      => \&capture_perlio,
	'print \$out' => \&capture_filehandle,
	'output'      => \&capture_indirection,
	'tie *STDOUT' => \&capture_indirection,
});
cmpthese($result);
print "\n";

--Boundary-00=_PhpcLpHC8MS7Xd0--
