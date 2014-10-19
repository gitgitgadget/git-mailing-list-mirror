From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] revision: remove definition of unused 'add_object' function
Date: Sun, 19 Oct 2014 11:16:00 +0100
Message-ID: <54438F60.1020500@ramsay1.demon.co.uk>
References: <5442DD4C.9050908@ramsay1.demon.co.uk> <20141019013646.GA17908@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 19 12:16:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XfnX2-00066U-SE
	for gcvg-git-2@plane.gmane.org; Sun, 19 Oct 2014 12:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbaJSKQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2014 06:16:10 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:36099 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751646AbaJSKQH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2014 06:16:07 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id A99A46F917A;
	Sun, 19 Oct 2014 11:15:37 +0100 (BST)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 5B3D56F9163;
	Sun, 19 Oct 2014 11:15:37 +0100 (BST)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Sun, 19 Oct 2014 11:15:36 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141019013646.GA17908@peff.net>
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/10/14 02:36, Jeff King wrote:
> On Sat, Oct 18, 2014 at 10:36:12PM +0100, Ramsay Jones wrote:
> 
>> I noticed that your 'jk/prune-mtime' branch removes the last caller
>> of the add_object() function; specifically commit 5f78a431a
>> ("reachable: use traverse_commit_list instead of custom walk", 15-10-2014).
> 
> Thanks. I usually rely on the compiler to catch any static instances
> that I missed, but of course this one is extern. Did you use an
> automated tool for this

Yes, see below.

>                         (I know you often catch "X has no declaration;
> should it be static?" with clang,

No, these are caught with sparse.

>                                    but does clang catch this, too?).
> 
>> If you need to re-roll those patches, could you please squash this
>> patch into the above commit. (unless you have plans to add some new
>> callers, of course! ;-) ).
> 
> Nope, I just didn't notice that I dropped the last caller. I don't think
> we need another re-roll (fingers crossed), but I'd be happy to have this
> on top.

OK, Thanks!

The tool that I use to spot these situations is actually my evolution
of a perl script that Junio sent to the list ages ago! ;-)

I made only minor alterations so that it would work on MinGW 32-bit
(well, actually msysGit, to be more precise), Cygwin 32-bit and 64-bit.
(The 'stop list' of acceptable symbols is _way_ out of date, but the
way I use the script that doesn't matter; still its on my TODO).

I run the script over each branch I build, master then next then pu, and
diff the results (ie ignoring the master base symbols), so I generally
only notice new symbols introduced into pu by new topics. It has been on
my TODO list for a while (OK years!) to go through the output from the
master branch and remove/make static those symbols which shouldn't be
external. (There are currently 53 symbols on 64-bit Linux. The list is
not identical on every platform, so you need to be careful. Also cgit
uses some symbols which would otherwise be static in git! ;-) ).

Ahem, I don't use git to version the script (static-check.pl), so I'm
only reasonable confident that the script I have easily to hand (Linux
Mint 64-bit) is the same on all platforms ... included below.

ATB,
Ramsay Jones

-- >8 --
#!/usr/bin/perl -w

my %defd = ();
my %used = ();
my %def_ok = map { $_ => 1 } qw(
	main
	alloc_report
	have_git_dir
	prepare_git_cmd
	print_string_list
	tm_to_time_t
	unsorted_string_list_has_string
	xdl_atol
	xdl_cha_first
	xdl_cha_next
	xdl_mmfile_size
	xdl_num_out
	xdl_recs_cmp
);

for (<*.o>, <*/*.o>, <*/*/*.o>) {
	my $obj = $_;
	open(I, "-|", qw(nm -gC), $obj) or die;
	while (<I>) {
		unless (/^[0-9a-f ]+([A-Z]) (\S*)$/) {
			print STDERR "? $_";
			next;
		}
		next if ($2 =~ /^\.refptr\./);
		if (($1 eq "U") || $1 eq "C") {
			$used{$2}++;
		}
		else {
			push @{$defd{$obj}}, $2;
		}
	}
	close I;
}

for my $obj (sort keys %defd) {
	my $syms = $defd{$obj};
	for my $sym (@$syms) {
		next if exists $used{$sym} or exists $def_ok{$sym};
		print "$obj	- $sym\n";
	}
}
