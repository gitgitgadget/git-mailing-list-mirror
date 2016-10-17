Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF7EE2098B
	for <e@80x24.org>; Mon, 17 Oct 2016 01:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756917AbcJQBiG (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 21:38:06 -0400
Received: from avasout03.plus.net ([84.93.230.244]:35937 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756707AbcJQBiE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 21:38:04 -0400
Received: from [10.0.2.15] ([194.75.29.46])
        by avasout03 with smtp
        id wRe01t0060zhorE01Re1W0; Mon, 17 Oct 2016 02:38:02 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=YLLd8lOx c=1 sm=1 tr=0
 a=g54qAj+LxVGqXy9pVcJ+0w==:117 a=g54qAj+LxVGqXy9pVcJ+0w==:17
 a=r77TgQKjGQsHNAKrUKIA:9 a=EBOSESyhAAAA:8 a=5rxgeBVgAAAA:8
 a=4NlYWzJJ9bddJ8o3ZPEA:9 a=pILNOxqGKmIA:10 a=oTGeyFvmkqhZoMKAvEkA:9
 a=U99dQBmVe6UA:10 a=yJM6EZoI5SlJf8ks9Ge_:22 a=PwKx63F5tFurRwaNxrlG:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] convert: mark a file-local symbol static
To:     Lars Schneider <larsxschneider@gmail.com>
References: <b21c8a92-4dd5-56d6-ec6a-5709028eaf5f@ramsayjones.plus.com>
 <A430A9E0-B2A2-4857-8DEA-EBD7AA2C9E29@gmail.com>
 <de24ed05-2857-9c17-920f-66770f898f80@ramsayjones.plus.com>
 <B7662EA0-3181-413E-A40B-69C88FC46F96@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <5a9a1c44-8a3f-1894-c4c5-8f1fa96b63b9@ramsayjones.plus.com>
Date:   Mon, 17 Oct 2016 02:37:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <B7662EA0-3181-413E-A40B-69C88FC46F96@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------129BE3B594FD582EAD5A7AA1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------129BE3B594FD582EAD5A7AA1
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit



On 16/10/16 01:15, Lars Schneider wrote:
>> On 15 Oct 2016, at 14:01, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
>> On 15/10/16 16:05, Lars Schneider wrote:
>>>> On 11 Oct 2016, at 16:46, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
>> [snip]
>>>> -void stop_multi_file_filter(struct child_process *process)
>>>> +static void stop_multi_file_filter(struct child_process *process)
>>>
>>> Done! Do you have some kind of script to detect these things
>>> automatically or do you read the code that carefully?
>>
>> Heh, I'm _far_ too lazy to read the code that carefully. :-D
>>
>> A combination of 'make sparse' and a perl script (originally
>> posted to the list by Junio) find all of these for me.
> 
> Interesting. Do you have a link to this script?

I'm attaching _a_ version of the script (you would think that
I would have it under version control; but no, I copy versions
around the several machines/git.git repos I have ... :-P ).

> Does it generate false positives? 

Hmm, well, you have to remember that 'make clean' sometimes
doesn't make clean. Ever since the Makefile was changed to only
remove $(OBJECTS), rather than *.o xdiff/*.o etc., you have to
remember to 'make clean' _before_ you switch branches. Otherwise,
you risk leaving some objects laying around. Since the script
runs 'nm' on all objects it finds, any stale ones can cause problems.
(Of course, I almost always forget, so I frequently have to manually
check for and remove stale objects!)

Also, you have to interpret the results of the script. Just because
it shows you an unused external, that doesn't make it an error.
The way I use it, BTW, is to run it on a freshly built branch (saving
to a file) and then compare the files from master->next->pu.
I don't bother looking at the output on master (the 'stop list' in
the script is _way_ out of date), just the diffs master->next and
next->pu.

The current next->pu diff looks like:

    $ diff nsc psc
    0a1,2
    > attr.o	- attr_name_valid
    > attr.o	- invalid_attr_name_message
    17a20
    > convert.o	- stop_multi_file_filter
    34d36
    < quote.o	- sq_quotef
    43a46
    > sequencer.o	- append_new_todo
    50a54
    > trailer.o	- conf_head
    55a60,61
    > wt-status.o	- has_uncommitted_changes
    > wt-status.o	- has_unstaged_changes
    $ 

I have already sent mails about 'stop_multi_file_filter',
'append_new_todo' and 'conf_head'. The symbols in attr.o are
part of the revamp of the attribute system that Junio and Stefan
are working on, which is very much in flux. If they are still
there when it looks to have firmed up, then I will take a look.
The 'sq_quotef' symbol is an example of a useful function that was
written without having an immediate user (actually, if memory serves
correctly, it was originally used in the series which introduced it,
but later modifications removed the caller). It now has a user. The wt-status.o symbols have been introduced by Johannes in his 'rebase -i'
series (of series) and I am assuming that these symbols will find
additional external callers in up-coming series.

> Maybe I can add `make sparse` to the TravisCI build?

I don't know how feasible that would be. Apparently, the version of
sparse in most distribution repositories is so old that it spews so
many spurious errors as to make it unusable. See, for example:

https://public-inbox.org/git/56CA5753.9030308@ramsayjones.plus.com/

So, you would need to build from source to get a usable version (I am
currently running a version built with some local patches). If you were
to build from the sparse repo's master branch, then it would work great
on Linux, at least. I have no idea if it would work on mac OS X.

However, even then, a single sparse warning is issued on Linux (for
the master branch, several others on pu):

        SP pack-revindex.c
    pack-revindex.c:65:23: warning: memset with byte count of 262144

This is a problem with sparse (the byte count limit used is hardcoded
into sparse), but I haven't sent a patch upstream to fix it yet.
(I've been looking at that warning for _many_ years, so don't hold
your breath!)

ATB,
Ramsay Jones



--------------129BE3B594FD582EAD5A7AA1
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


--------------129BE3B594FD582EAD5A7AA1--
