From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH] git-send-email: handle email address with quoted comma
Date: Fri, 19 Dec 2008 16:10:10 +0800
Message-ID: <20081219081010.GA12494@localhost>
References: <1229658012-9240-1-git-send-email-fengguang.wu@intel.com> <7vej04d5wy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Matt Kraai <kraai@ftbfs.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 19 09:11:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDaSS-0007lg-D7
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 09:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbYLSIKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 03:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753101AbYLSIKW
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 03:10:22 -0500
Received: from mga03.intel.com ([143.182.124.21]:47509 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752710AbYLSIKV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 03:10:21 -0500
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 19 Dec 2008 00:10:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.36,248,1228118400"; 
   d="scan'208";a="92005637"
Received: from unknown (HELO localhost) ([10.254.154.10])
  by azsmga001.ch.intel.com with ESMTP; 19 Dec 2008 00:10:15 -0800
Received: from wfg by localhost with local (Exim 4.69)
	(envelope-from <fengguang.wu@intel.com>)
	id 1LDaR0-0003TC-IX; Fri, 19 Dec 2008 16:10:10 +0800
Content-Disposition: inline
In-Reply-To: <7vej04d5wy.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103553>

On Fri, Dec 19, 2008 at 08:40:13AM +0200, Junio C Hamano wrote:
> Wu Fengguang <fengguang.wu@intel.com> writes:
> 
> > Correctly handle email addresses containing quoted commas, e.g.
> >
> > 	"Zhu, Yi" <yi.zhu@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>
> >
> > Here the commas inside the double quotes are NOT email separators.
> 
> Thanks.
> 
> > @@ -359,6 +360,12 @@ foreach my $entry (@bcclist) {
> >  	die "Comma in --bcclist entry: $entry'\n" unless $entry !~ m/,/;
> >  }
> >  
> > +sub split_addrs($) {
> > +	my ($addrs) = @_;
> > +
> > +	return &quotewords('\s*,\s*', 1, $addrs);
> > +}
> > +
> 
> Does it add real value (e.g. type safety, simplified interface to the
> caller, etc.) to force scalar context to the callers?  It has been my
> experience that use of prototypes (aka "parameter context templates") in
> Perl programs tend to make the code less readable and more error prone in
> longer term.  I would further say that, even though you do not have any
> existing caller of split_addrs sub that uses it for more than two values,
> not using the prototype would be a better way to write this sub in this
> particular case, because it would allow callers to say [*1*]:
> 
> 	@addrs = split_addr(@list_of_addr_lines);
> 
> It also is a bit funny-looking to invoke &function() (it is Perl4 style,
> isn't it?)
> 
> IOW, wouldn't this be a better alternative?
> 
> 	sub split_addrs {
>         	return quotewords('\s*,\s*', 1, @_);
> 	}

Hi Junio and Matt, 

Thank you for the helpful information. The patch is updated and tested
according to your comments.

Thanks,
Fengguang
---
git-send-email: handle email address with quoted comma

Correctly handle email addresses containing quoted commas, e.g.

	"Zhu, Yi" <yi.zhu@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>

Here the commas inside the double quotes are NOT email separators.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 git-send-email.perl |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 3112f76..6114401 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -20,6 +20,7 @@ use strict;
 use warnings;
 use Term::ReadLine;
 use Getopt::Long;
+use Text::ParseWords;
 use Data::Dumper;
 use Term::ANSIColor;
 use File::Temp qw/ tempdir /;
@@ -359,6 +360,10 @@ foreach my $entry (@bcclist) {
 	die "Comma in --bcclist entry: $entry'\n" unless $entry !~ m/,/;
 }
 
+sub split_addrs {
+	return parse_line('\s*,\s*', 1, @_);
+}
+
 my %aliases;
 my %parse_alias = (
 	# multiline formats can be supported in the future
@@ -367,7 +372,7 @@ my %parse_alias = (
 			my ($alias, $addr) = ($1, $2);
 			$addr =~ s/#.*$//; # mutt allows # comments
 			 # commas delimit multiple addresses
-			$aliases{$alias} = [ split(/\s*,\s*/, $addr) ];
+			$aliases{$alias} = [ split_addrs($addr) ];
 		}}},
 	mailrc => sub { my $fh = shift; while (<$fh>) {
 		if (/^alias\s+(\S+)\s+(.*)$/) {
@@ -379,7 +384,7 @@ my %parse_alias = (
 			chomp $x;
 		        $x .= $1 while(defined($_ = <$fh>) && /^ +(.*)$/);
 			$x =~ /^(\S+)$f\t\(?([^\t]+?)\)?(:?$f){0,2}$/ or next;
-			$aliases{$1} = [ split(/\s*,\s*/, $2) ];
+			$aliases{$1} = [ split_addrs($2) ];
 		}},
 	gnus => sub { my $fh = shift; while (<$fh>) {
 		if (/\(define-mail-alias\s+"(\S+?)"\s+"(\S+?)"\)/) {
@@ -588,7 +593,7 @@ if (!@to) {
 	}
 
 	my $to = $_;
-	push @to, split /,\s*/, $to;
+	push @to, split_addrs($to);
 	$prompting++;
 }
 
-- 
1.6.0.4
