Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBD1220C32
	for <e@80x24.org>; Thu,  7 Dec 2017 01:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752515AbdLGB7c (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 20:59:32 -0500
Received: from avasout01.plus.net ([84.93.230.227]:39597 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbdLGB7b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 20:59:31 -0500
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id MlTCecQBHJjiPMlTDeBs3I; Thu, 07 Dec 2017 01:59:29 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=O6ZJhF1W c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=r77TgQKjGQsHNAKrUKIA:9 a=5rxgeBVgAAAA:8 a=EBOSESyhAAAA:8
 a=JtrhiT9LD60LjktgsWYA:9 a=QEXdDO2ut3YA:10 a=oTGeyFvmkqhZoMKAvEkA:9
 a=U99dQBmVe6UA:10 a=PwKx63F5tFurRwaNxrlG:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: partial_clone_get_default_filter_spec has no callers
To:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <ec83f2d9-0d87-9d6b-4860-f4cd7c19984e@ramsayjones.plus.com>
 <89d06941-9bee-9334-d737-11ef7801cba2@jeffhostetler.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <44d0c556-d5ba-186f-7493-f9900eccb442@ramsayjones.plus.com>
Date:   Thu, 7 Dec 2017 01:59:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <89d06941-9bee-9334-d737-11ef7801cba2@jeffhostetler.com>
Content-Type: multipart/mixed;
 boundary="------------4E27EAE3A497AF122DFE4766"
Content-Language: en-GB
X-CMAE-Envelope: MS4wfGsx1pb9UNVUUFF4Js1Ol/GlHlU9CMiUWXcvIQLWtLsYBxdC0T1lVG28e372wPztM8w9qs6T14jhay3e97Tu+V+xt14vhXreH4TZiS+fn0DegS9vB1jE
 LDxgwyWmgHTaEP++VOnCSXkgPA/z9dyhFGLcbGTRCmaL019u+5tXoqvmYZQ6tuQBlx6e+6HS8H9FxQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------4E27EAE3A497AF122DFE4766
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit



On 06/12/17 21:07, Jeff Hostetler wrote:
> 
> 
> On 12/6/2017 12:39 PM, Ramsay Jones wrote:
>> Hi Jeff,
>>
>> commit f1862e8153 ("partial-clone: define partial clone settings
>> in config", 2017-12-05), which is part of your 'jh/partial-clone'
>> branch, introduces the partial_clone_get_default_filter_spec()
>> function without any callers. Could you please confirm that this
>> is intentional and that, presumably, a future series will include
>> a call to this function.
> 
> I'll double check.  Thanks.
> 
> BTW is there another tool that you're using to find these?
> I know I ran make DEVELOPER=1 and make sparse on everything
> and didn't see that come up.

In addition to sparse (which finds some of these), I also run a perl
script over the object files after a given build. (The script was
posted to the list by Junio, many moons ago, and I have made several
changes to my local copy).

I am attaching a copy of the script (static-check.pl). Note that the
'stop list' in the script (%def_ok) is _way_ out of date. However, the
way I use the script, that does not matter; I run the script over the
master->next->pu branches and (ignoring the master branch) diff the
result files from branch to branch. For example, tonight I have:

  $ wc -l sc nsc psc
    74 sc
    73 nsc
    75 psc
   222 total
  $ 
  $ diff sc nsc
  44d43
  < oidmap.o	- oidmap_remove
  $ 
  $ diff nsc psc
  43a44
  > list-objects-filter-options.o	- partial_clone_get_default_filter_spec
  58a60
  > sequencer.o	- sign_off_header
  $ 

You also have to be careful with leaving stale object files
laying around from previous builds ('make clean' sometimes
doesn't). Actually, it may be simpler to read a previous mailing
list thread on exactly this subject [1].

BTW, if you are using a version of sparse post v0.5.1, you can
get rid of the only sparse warning on Linux (assuming you don't
build with NO_REGEX set), by using the -Wno-memcpy-max-count option;
I have the following set in my config.mak:

  $ tail -2 config.mak
  pack-revindex.sp: SPARSE_FLAGS += -Wno-memcpy-max-count

  $ 

[I haven't sent a proper patch, since the required version of
sparse is not widely available yet.]

ATB,
Ramsay Jones

[1] https://public-inbox.org/git/%3Cb21c8a92-4dd5-56d6-ec6a-5709028eaf5f@ramsayjones.plus.com%3E/

--------------4E27EAE3A497AF122DFE4766
Content-Type: application/x-perl;
 name="static-check.pl"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="static-check.pl"

#!/usr/bin/perl -w

my %defd = ();
my %used = ();
my %comd = ();
my %trace = ();
my $show_common = 0;

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

while (@ARGV) {
	$_ = shift(@ARGV);

	if (/^-t$/) {
		my $trace_symbol = shift @ARGV;
		die("$0: missing argument to -t option") if !$trace_symbol;
		$trace{$trace_symbol}++;
		next;
	}

	if ($_ eq '-c') {
		$show_common = 1;
		next;
	}
}

for (<*.o>, <*/*.o>, <*/*/*.o>) {
	my $obj = $_;
	open(I, "-|", qw(nm -gC), $obj) or die;
	while (<I>) {
		unless (/^[0-9a-f ]+([A-Z]) (\S*)$/) {
			print STDERR "? $_";
			next;
		}
		next if ($2 =~ /^\.refptr\./);
		if (exists $trace{$2}) {
			print "-- $2: type $1, object $obj\n";
		}
		if ($1 eq "C") {
			if($show_common) {
				print "++ $2: type $1, object $obj\n";
			}
			if (exists $comd{$2}) {
				$used{$2}++;
			}
			else {
				$comd{$2}++;
				push @{$defd{$obj}}, $2;
			}
		} elsif ($1 eq "U") {
			$used{$2}++;
		} else {
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


--------------4E27EAE3A497AF122DFE4766--
