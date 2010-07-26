From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/24] Documentation: Add variable-substitution script
Date: Mon, 26 Jul 2010 21:49:36 +0000
Message-ID: <AANLkTinM8w4MiwdNmiUzLDRvR-NqSxNn0I1avQDt9QtR@mail.gmail.com>
References: <cover.1280169048.git.trast@student.ethz.ch>
	<049043aa444288fd9409a3706fe3190fd679cb7d.1280169048.git.trast@student.ethz.ch>
	<m3wrsikkol.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 23:49:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdVYN-0001Pq-78
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 23:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754055Ab0GZVti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 17:49:38 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49300 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782Ab0GZVth (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 17:49:37 -0400
Received: by gwb20 with SMTP id 20so257168gwb.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 14:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=bB3M3Ls7Rkt3j8LTBopb+kJQORHEIjSh8EtOsEbPyic=;
        b=WJ0qN7gaACdmbsLdxmeanJy3+qVPmEPr5A2VAhnnTm30dBKXm5Diu3lNWgch8nlsT8
         eQKVCSA927RdG37KquqyumYGQLq1mZSJm6HU0jwJrjgfxAQQFZ9dTajAdwmtIve+bod3
         FWEVnrqoEk5NLXGhVPI1RqmdNTPIY9HKwL8BU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=d8Gejk06OEo0NBnSnxEB6qhym1x67HPMouST5FkxySJdUS3xaqbtskhjSSJmWyUvP2
         8hyJw3OrnCGrf4XdfAAH6YiV2aGUB2PH0zk+aPZ7b8ZHLkiorx5Ar6mWZJNWYyyS0ZKN
         WNzUsrj4/W7Kzljyui4nQFFgqMM91Jppz9yr4=
Received: by 10.150.217.11 with SMTP id p11mr1554139ybg.32.1280180976815; Mon, 
	26 Jul 2010 14:49:36 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Mon, 26 Jul 2010 14:49:36 -0700 (PDT)
In-Reply-To: <m3wrsikkol.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151898>

On Mon, Jul 26, 2010 at 21:17, Jakub Narebski <jnareb@gmail.com> wrote:

Well caught. Those were on me, here's the fixed up version (in my
branch, which Thomas can pull in to his):

#!/usr/bin/perl
use 5.006002;
use strict;
use warnings;
use Getopt::Long;

Getopt::Long::Configure qw/ pass_through /;

my $rc = GetOptions(
	"varlist=s" => \my $varlist,
	"input=s"	=> \my $input,
	"output=s"	=> \my $output,
);

if (!$rc or (!-r $varlist or !-r $input)) {
	print "$0 --varlist=<varlist> --input=<in> --output=<out>\n";
	exit 1;
}

my $vars = read_varlist($varlist);
substitute_variables($vars, $input, $output);
exit 0;

sub read_varlist {
	my ($file) = @_;

	open my $fh, "<", $file or die "Can't open $file: $!";
	my %vars;

	my ($v, $last_v);
	my $in_block = 0;
	while (<$fh>) {
		if (/^(\S+)::/) {
			$v = lc $1;
			$in_block = 0;
			push @{$vars{$v}}, $_;
		} elsif (/^$/ && !$in_block) {
			if (defined $last_v && !$#{$vars{$last_v}}) {
				$vars{$last_v} = $vars{$v};
			}
			$last_v = $v;
		} elsif (defined $v) {
			push @{$vars{$v}}, $_;
			$in_block = !$in_block if /^--$/;
		}
	}

	close $fh or die "Closing $file failed: $!";

	return \%vars
}

sub substitute_variables {
	my ($varlist, $in, $out) = @_;

	open my $infh, "<", $in or die "Can't open $in: $!";
	open my $outfh, ">", $out or die "Can't open $out: $!";

	while (<$infh>) {
		if (/^\@\@CONFIG\((\S+)\)\@\@$/) {
			my $v = lc $1;
			die "Key $v not documented" unless exists $varlist->{$v};
			print $outfh @{$varlist->{$v}};
			print $outfh "\n";
		} else {
			print $outfh $_;
		}
	}

	close $infh or die "Closing $in failed: $!";
	close $outfh or die "Closing $out failed: $!";

	return;
}
