From: Ingo Molnar <mingo@elte.hu>
Subject: Re: git-rerere observations and feature suggestions
Date: Mon, 23 Jun 2008 11:49:06 +0200
Message-ID: <20080623094906.GA8284@elte.hu>
References: <20080616110113.GA22945@elte.hu> <7vej6xb4lr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Cc: git@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Chris Mason <chris.mason@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 11:51:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAihP-0006rc-G6
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 11:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660AbYFWJtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 05:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbYFWJtk
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 05:49:40 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:38955 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758156AbYFWJth (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 05:49:37 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1KAife-0000b7-Pe
	from <mingo@elte.hu>; Mon, 23 Jun 2008 11:49:16 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 89D4A3E21DD; Mon, 23 Jun 2008 11:49:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vej6xb4lr.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85848>


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


another git-rerere observation: occasionally it happens that i 
accidentally commit a merge marker into the source code.

That's obviously stupid, and it normally gets found by testing quickly, 
but still it would be a really useful avoid-shoot-self-in-foot feature 
if git-commit could warn about such stupidities of mine.

( and if i could configure git-commit to outright reject a commit like 
  that - i never want to commit lines with <<<<<< or >>>>> markers)

Another merge conflict observation is that Git is much worse at figuring 
out the right merge resolution than our previous Quilt based workflow 
was. I eventually found it to be mainly due to the following detail: 
sometimes it's more useful to first apply the merged branch and then 
attempt to merge HEAD, as a patch.

I've got a script for that which also combines it with the "rej" tool, 
and in about 70%-80% of the cases where Git is unable to resolve a merge 
automatically it figures things out. ('rej' is obviously a more relaxed 
merge utility, but it's fairly robust in my experience, with a very low 
false positive rate.)

The ad-hoc "tip-mergetool" script we are using is attached below. It's 
really just for demonstration purposes - it doesnt work when there's a 
rename related conflict, etc.

Peter Zijstra also wrote a git-mergetool extension for the 'rej' tool 
btw., he might want to post that patch. I've attached Chris Mason's rej 
tool too.

	Ingo


[ "$#" = 0 ] && {
  SRC=`git-ls-files -u | cut -f2 | head -1`
} || {
  SRC=`git-ls-files -u | grep $1 | cut -f2 | head -1`
}

[ "$SRC" = "" -o ! -f "$SRC" ] && { echo "$1 has no conflicts!"; exit -1; }

SRC_SED=`echo $SRC | sed 's/\//\\\\\//g'`

SHA_1=`git-ls-files -u | grep $SRC | grep '^.* .* 1\>' | cut -d' ' -f2`
SHA_2=`git-ls-files -u | grep $SRC | grep '^.* .* 2\>' | cut -d' ' -f2`
SHA_3=`git-ls-files -u | grep $SRC | grep '^.* .* 3\>' | cut -d' ' -f2`

mv -b $SRC $SRC.automerge             || { echo error1; exit -1; }

git-diff $SHA_1 $SHA_2 | sed "s/$SHA_1/$SRC_SED/g" |
   sed "s/$SHA_2/$SRC_SED/g" > $SRC.diff-v1 || { echo error2; exit -1; }

git-diff $SHA_1 $SHA_3 | sed "s/$SHA_1/$SRC_SED/g" |
   sed "s/$SHA_3/$SRC_SED/g" > $SRC.diff-v2 || { echo error2; exit -1; }

git-cat-file -p $SHA_1 > $SRC         || { echo error4; exit -1; }

ls -l $SRC.automerge $SRC $SRC.diff-v1 $SRC.diff-v2

patch -p1 < $SRC.diff-v2 || { echo error5; exit -1; }
patch -p1 < $SRC.diff-v1 || {
    echo "reject file ..."
    ls -l $SRC.rej
    echo "trying auto-merge ..."
    OK=$(rej -dry-run $SRC.rej 2>&1 | grep ', 0 conflicts remain')
    [ "$OK" = "" ] && { echo "$OK"; exit -1; }
    rej -a $SRC.rej
}

echo "adding $SRC to the commit"
git-add $SRC
echo 'if happy with the result, do: git-commit -m "Manual merge of conflicts."'

echo "merge successful!"
exit 0


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=rej

#!/usr/bin/perl
# Reject merging program, released under GPLv2
# Contact Chris Mason <mason@suse.com> with bugs or patches
#

use strict;
use Getopt::Long qw(:config no_ignore_case);
use File::Temp;
use IO::File;
use POSIX ":sys_wait_h";

my @file; 			# array with the contents of the file
my @merged_file; 		# temporary copy of the file for merging
my $diff_mode = 0;		# running a multi-file diff instead of a reject
my @hunks;			# array of hashes for all the hunks
my $hunk_num = 0;  		# total number of hunks
my $rejfh;			# handle for the reject file
my $filefh;			# handle for the file
my $mergefh;			# handle for the merge stream
my $VERSION = "0.15";
my $context = 0;		# prefer context from the reject?
my $merge_prog = "gvimdiff";    # merge program to run
my $source_file;		# name of the source file
my $reject_file;		# name of the reject file
my $orig_reject_file;		# original name of the reject file
my $output_file;		# name of merge output (skips merge prog)
my $auto;			# auto mode, put results into source file
my $interactive = 0;		# go into command mode
my $editor = "gvim";		# selected editor for opening the reject
my $open_reject = 0;		# should the reject be opened?
my $report_only = 0;		# only try to place the hunks
my $exit_value = 0;		# our return value;
my $fully_matched_hunks = 0;	# lines that match the -/+ lines in hunk
my $strip_level = 0;		# how many path components to strip in diffmode
my $last_diff_line;		# for buffering input lines
my $total_hunks;		# total hunks found
my $reverse_patch = 0;		# should we reverse the input patch?
my $no_forward_search = 0;      # only try to match reverse hunks
my $quick = 0;			# stop trying after the first conflict
my $skip_merge = 0;		# don't run the merge prog at all
my $global_matched_hunks = 0;   # total for whole diff
my $global_reject_hunks = 0;	# 
my $global_conflicts = 0;	# number of conflicts for the last rej run


# string equality ignoring whitespace
# the first string has a leading control char from the reject,
# either ' ', '-' or '+'
sub fuzzy_eq($$) {
    my ($hunk, $file) = @_;
    my $line;

    $line = $hunk;
    $line =~ s/^.//;

    if ($line eq $file) {
        return 1;
    }
    # strip all whitespace and try agin
    $line =~ s/\s//g;
    $file =~ s/\s//g;
    if ($line eq $file) {
        return 1;
    }
}

# places the aligned hunk into the merge stream.
# in context mode, or if this was a forward match
# all context is taken from the reject file
#
# otherwise, this tries to take as much context as possible from the source
# file.
sub place_hunk($$$) {
    my ($hunk, $start, $end) = @_;
    my $fhunk = \@{$hunk->{'fwhunk'}};
    my $rhunk = $hunk->{'aligned_hunk'};
    my $size = scalar(@file);
    my $i;
    my $k;
    my $merged_index = 0;
    my $hunk_index = 0;
    my $hunk_len = scalar(@$fhunk);
    my $line;
    my $file_hunk = $hunk->{'file_hunk'};
    my @tmp_hunk;
    my $file_index;
    my $c;
    my $fline;

    @merged_file = ();
    # check for a change that is already applied.  print a warning as well
    # since this is not a 100% reliable check.
    #
    if ($hunk->{'method'} eq "forward" && 
        $hunk->{'hunk_match'} == count_hunk_changed($hunk, "forward")) {
	print STDERR "WARNING: skipping hunk already applied: $hunk->{'desc'}";
        return;
    }
    # try to maximize context from the reject file 
    # if we matched the forward hunk, it means the file
    # already had some form of the change applied.  Don't
    # try to be smart, just use the context from the reject
    if ($hunk->{'options'} =~ m/context/ || $context || 
        $hunk->{'method'} eq "forward") {
        @merged_file = @file [ 0 .. $start - 1];
	
	foreach $line (@$fhunk) {
	    $line =~ s/^.//;
	    push @merged_file, $line;
	}
	push @merged_file, @file[$end+1 .. scalar(@file)];
	@file = @merged_file;
	return;
    }
    # align to the start of the reverse hunk
    while($hunk_index < scalar(@$rhunk)) {
        $line = $rhunk->[$hunk_index];    
	$fline = $file_hunk->[0];
	$fline =~ s/^.//;
	last if (fuzzy_eq($line, $fline));
	$hunk_index++;
    }

    $file_index = 0;
    while($file_index < scalar(@$file_hunk)) {
        $line = $rhunk->[$hunk_index];    
	$fline = $file_hunk->[$file_index];
	if ($line =~ m/^\|/) {
	    $fline =~ s/^./\+/;
	    push @tmp_hunk, $fline;
	} elsif ($line =~ m/^ /) {
	    push @tmp_hunk, $fline;
	} elsif ($line =~ m/^-/) {
	    my $tline = $fline;
	    $tline =~ s/^.//;
	    if (!fuzzy_eq($line, $tline)) {
		my $cline = $line;
		$cline =~ s/^.//;
	        push @tmp_hunk, "+<<<<<<< delete $cline";
	    }
	}
	$file_index++;
	$hunk_index++;
	if ($hunk_index > scalar(@$rhunk)) {
	    print STDERR "warning: hunk_index is $hunk_index, limit " . 
	                  scalar(@$rhunk) . "\n";
	}
    }
    @$file_hunk = @tmp_hunk;
    @tmp_hunk = ();
    $size = scalar(@$file_hunk);
    $hunk_index = 0;
    $file_index = 0;
    while($hunk_index < scalar(@$fhunk)) {
        $line = $fhunk->[$hunk_index];    
	$fline = $file_hunk->[0];
	if (!($fline =~ m/^\|/)) {
	    $fline =~ s/^.//;
	    last if (fuzzy_eq($line, $fline));
	}
	last if ($line =~ m/^\+/) ;
	$hunk_index++;
    }
    while($file_index < $size || $hunk_index < scalar(@$fhunk)) {
	$fline = $file_hunk->[$file_index];
	if ($fline =~ m/^\+/ || $hunk_index >= scalar(@$fhunk)) {
	    $fline =~ s/^.//;
	    push @tmp_hunk, $fline;
	    $file_index++;
	    next;
	}
        $line = $fhunk->[$hunk_index];    
	if ($line =~ m/^\+/) {
	    $line =~ s/^.//;
	    push @tmp_hunk, $line;
	} elsif ($file_index < scalar(@$file_hunk)) {
	    if ($fline =~ m/^ /) {
		$fline =~ s/^.//;
		push @tmp_hunk, $fline;
	    }
	    $file_index++;
	}
	$hunk_index++;
    }
    @merged_file = @file[ 0 .. $start -1];
    push @merged_file, @tmp_hunk;
    push @merged_file, @file [ $end+1 .. scalar(@file) ];
    @file = @merged_file;
}

# try to find the next line in the file or the hunk that
# match.  The entire hunk is searched for a line matching the
# file, 20 lines forward are searched in the file.
#
# $aligned_hunk and $file_hunk are pointers to arrays, a line
# containing "|\n" is inserted to indicate missing lines in the
# file or hunk:
#
# FILE				HUNK:
#  A				 A
# |				 B
#  C				 C
#  D				|
# There is a leading control char on each line in each of the aligned
# arrays
#
sub align_match($$$$$$) {
    my ($hunk, $aligned_hunk, $file_hunk, $hindex, $findex, $hunk_changed) = @_;
    my $hunk_len = scalar(@$hunk);
    my $i;
    my $hline;
    my $fline;
    my $s;
    my $limit = 20;
    if ($$findex + $limit > scalar(@file)) {
        $limit = scalar(@file) - $$findex;
    }

    # look forward in the hunk for this line from the file
    $fline = $file[$$findex];
    for ($i = $$hindex; $i < $hunk_len; $i++) {
        if ($i != $$hindex && $hunk->[$i] =~ m/^\S/) {
	    $hunk_changed++;
	}
	if (fuzzy_eq($hunk->[$i], $fline)) {
	    for ($s = 0 ; $s < $i - $$hindex ; $s++) {
		push @$file_hunk, "|\n";
		push @$aligned_hunk, $hunk->[$$hindex + $s];		
	    }	    
	    push @$file_hunk, " $fline";
	    push @$aligned_hunk, $hunk->[$i];
	    $$hindex = $i;
	    return 1;
	}
    }
    # look forward in the file for this line from the hunk
    $hline = $hunk->[$$hindex];
    for ($i = $$findex; $i < $$findex + $limit; $i++) {
	if (fuzzy_eq($hline, $file[$i])) {
	    for ($s = 0 ; $s < $i - $$findex ; $s++) {
		push @$aligned_hunk, "|\n";
		push @$file_hunk, " $file[$$findex + $s]";
	    }
	    push @$file_hunk, " $file[$i]";
	    push @$aligned_hunk, $hline;
	    $$findex = $i;
	    return 1;
	}
    }
    return 0;
}

# once a matching line is found between the hunk and the file,
# test match walks through both trying to find out how many total
# matching lines there are.
sub test_match($$$$) {
    my ($hunk, $hunk_line, $file_line, $direction) = @_;
    my $line;
    my $i;
    my $file_len = scalar(@file);
    my $hunk_len = scalar(@$hunk);
    my @file_hunk = ();
    my @aligned_hunk = ();
    my $match_len = 0;
    my $last_match_line = -1;
    my $score = 0;
    my $consec = 0;
    my $ws_match = 0;
    my $hunk_match = 0;
    my $hunk_changed = 0;
    while($hunk_line < $hunk_len) {
	$line = $hunk->[$hunk_line];
	if ($line =~ m/^\S/) {
	    $hunk_changed++;
	}
	if (fuzzy_eq($line,$file[$file_line])) {
	    # each line in the file hunk has one char for 
	    # special chars
	    #
	    push @file_hunk, " $file[$file_line]";
	    push @aligned_hunk, $line;
	    $match_len++;
	    $last_match_line = $file_line;
	    # bump the score if we're matching a non-context line
	    # or if this is a consecutive match
	    if ($line =~ m/^\S/) {
	        $hunk_match++;
		$score++;
	    }
	    if ($consec) {
	        $score++;
	    }
	    $consec = 1;
	    # count matches that are whitespace alone.  These are
	    # very unreliable.
	    if ($file[$file_line] =~ m/^\s*$/) {
	        $ws_match++;
	    }
	} else {
	    # walk the hunk and the file trying to find the next match
	    $consec = 0;
	    if (align_match($hunk, \@aligned_hunk, \@file_hunk, 
	                \$hunk_line, \$file_line, \$hunk_changed)) {
		$match_len++;
		if ($hunk->[$hunk_line] =~ m/^\S/) {
		    $score++;
		    $hunk_match++;
		}
	    } else {
		if ($file_line < scalar(@file)) {
		    push @file_hunk, " $file[$file_line]";
		} else {
		    push @file_hunk, "|\n";
		}
		push @aligned_hunk, $line;
	    }
	    $last_match_line = $file_line;
	}
	$file_line++;
	$hunk_line++;
    }
    
    if ($match_len == $ws_match) {
        $match_len = 0;
	$score = 0;
	$last_match_line = -1;
    }
    
    return ($match_len, $hunk_match, $score, $last_match_line, 
            \@aligned_hunk, \@file_hunk)
}

sub count_hunk_changed($$) {
    my ($hunk, $method) = @_;
    my $fhunk;
    my $changed = 0;
    
    if ($method eq "forward") {
	$fhunk = \@{$hunk->{'fwhunk'}};
    } else {
	$fhunk = \@{$hunk->{'revhunk'}};
    }
    foreach my $l (@$fhunk) {
	if ($l =~ m/^\S/) {
	    $changed++;
	}
    }
    return $changed;
}
# start of the fuzzy matching engine, try to find matching lines
# between the hunk and the file.
sub _find_hunk($$$) {
    my ($struct, $hunk, $direction) = @_;
    my $hunk_len = scalar(@$hunk);
    my $file_len = scalar(@file);
    my $i;
    my $k;
    my $hunk_line;

    # for each line in the hunk, try to fuzz it into the file
    for ($i = 0 ; $i < $file_len; $i++) {
        for ($k = 0; $k < $hunk_len; $k++) {
	    $hunk_line = $hunk->[$k];
	    # if the hunk lines remaining are less then the best match
	    # so far, we're done
	    #
	    if (scalar(@$hunk) - $k < $struct->{'match_count'}) {
	        last;
	    }
	    # don't try too far into the hunk, after a while there's
	    # no chance we'll find any useful match
	    if ($k > 10) {
	        last;
	    }
	    if (fuzzy_eq($hunk_line, $file[$i])) {
		my ($match_len, $hunk_match, $score, $file_end, 
		    $aligned_hunk, $file_hunk) = test_match($hunk, $k, $i, 
		    					    $direction);
		if ($match_len > $struct->{'match_count'} || 
		    ($match_len == $struct->{'match_count'} && 
		    $score > $struct->{'score'})) {
		    # don't pick the forward hunk over the reverse hunk
		    # if the reverse hunk made any matches to non-context lines
		    # and we don't have a perfect forward match
		    if ($direction eq "forward" && $struct->{'method'} eq
		        "reverse") {
			if ($hunk_match != 
			    count_hunk_changed($struct,"forward")) {
			    my $rch = count_hunk_changed($struct, "reverse");
			    if ($rch > 0 && $struct->{'hunk_match'} > 0) {
				next;
			    } elsif ($rch == 0 && $struct->{'match_count'} > 2){
			        next;
			    } elsif ($rch == $struct->{'hunk_match'}) {
			        next;
			    }
			}

		    }
		    $struct->{'match_count'} = $match_len;
		    $struct->{'score'} = $score;
		    $struct->{'start'} = $i;
		    $struct->{'end'} = $file_end;
		    $struct->{'method'} = $direction;
		    $struct->{'aligned_hunk'} = $aligned_hunk;
		    $struct->{'file_hunk'} = $file_hunk;
		    $struct->{'hunk_match'} = $hunk_match;
		}
		# when deciding we've perfectly placed the change
		# allow for fuzz of two on either side, unless
		# there are no non-context lines in this part of the patch.
		# in that case, be fuzz free.
		# this code needs a little more work, disabled for now
		#my $fuzz = 4;
		#if ($struct->{'hunk_match'} == 0) {
		#    $fuzz = 0;
		#}
		#if ($struct->{'match_count'} >= (scalar(@$hunk) - $fuzz) &&
		#    $struct->{'hunk_match'} >= 
		#    count_hunk_changed($struct,$direction)) {
		#    #return;
		#}
		last;
	    }
	}
    }
}

# figures out where the hunk should go into the file, and
# inserts it into the merge stream.  If no suitable location is found
# the hunk is merged at the top.
#
sub find_hunk($) {
    my ($hunk) = @_;
    my $fhunk = \@{$hunk->{'fwhunk'}};
    my $hc;
    my $ret = 0;
    if (!($hunk->{'options'} =~ m/forward/)) {
        _find_hunk($hunk, \@{$hunk->{'revhunk'}}, "reverse");
    }
    if (!$no_forward_search && !($hunk->{'options'} =~ m/reverse/)) {
        _find_hunk($hunk, $fhunk, "forward");
    }
    $hc = count_hunk_changed($hunk, "reverse");
    if ($hunk->{'method'} eq "reverse" &&
        $hunk->{'hunk_match'} == count_hunk_changed($hunk, "reverse")) {
	# if hunk_mach is zero, then our patch is only adding new lines.
	# make sure we've found some reasonable context in the patch
	# before calling it a fully matched hunk
	if ($hunk->{'hunk_match'} > 0 || $hunk->{'match_count'} > 2) {
            $fully_matched_hunks++;
	    $ret = 1;
        }
    }
    if ($hunk->{'match_count'} >= 2) {
        place_hunk($hunk, $hunk->{'start'}, $hunk->{'end'});
    } else {
	$hunk->{'method'} = "forward";
        place_hunk($hunk, 0, 0);
    }
    return $ret;
}

sub print_interactive_usage {
    print "[c]ontext: toggle the context command line parameter off/on\n";
    print "[d]one: exit interactive mode\n";
    print "[h]elp: this screen\n";
    print "[m]erge: run the merge program again\n";
    print "[p]rocess: process the hunks again.  This will write over the output file\n";
    print "[r]eject: open in the reject in \$REJEDITOR or \$EDITOR\n";
    print "\t\$REJEDITOR is used first if it exists\n";
    print "[t]empreject: copy the reject to a temp file and open for editing\n";
    print "\tany later process commands will use the temp file\n";
    print "restore: restore backup copy of source file in auto mode\n";
    print "\n";
}
sub run_interactive($$$) {
    my ($pid, $file, $file2) = @_;
    my $editor_pid = 0;
    my $tfh;

    print ">> rej $VERSION interactive mode (type help for help)\n";
    print ">> ";
    while(<STDIN>) {
        chomp;
	if (m/^(h|help)$/) {
	    print_interactive_usage();
	} elsif (m/^restore$/) {
	    if ($auto) {
	        `cp $source_file.mergebackup $source_file`;
		if ($?) {
		    print "cp $source_file.mergebackup $source_file \n";
		    print "exited with " . $? >> 8 . "\n";
		}
	    }
	} elsif (m/^(r|reject)$/) {
	    open_reject();
	} elsif (m/^(t|tempreject)$/) {
	    $rejfh = new IO::File;
	    $rejfh->open("<$orig_reject_file") || 
	            die "Unable to open $orig_reject_file";
	    $tfh = new IO::File;
	    $tfh->open(">$orig_reject_file.tmp") || 
	          die "Unable to open $orig_reject_file.tmp";
	    while(<$rejfh>) {
	        print $tfh $_;    
	    }
	    close($rejfh);
	    close($tfh);
	    $reject_file = "$orig_reject_file.tmp";
	    print "Switching reject to $orig_reject_file.tmp";
	    open_reject();
	} elsif (m/^(c|context)$/) {
	    $context = ($context + 1) % 2;
	    print "context mode toggled to $context\n";
	} elsif (m/^(p|process)$/) {
	    print "processing reject again\n";
	    process_reject();
	} elsif (m/^(m|mergewindow)$/) {
	    waitpid(-1, WNOHANG);
	    $pid = fork();
	    if (!$pid) {
	        _run_merge($file, $file2);
		exit 0;
	    }
	} elsif (m/^(d|done|quit)$/) {
	    last;
	}
	print ">> ";
    }
    print "waiting for merge windows\n";
    wait;
    if (!$auto) {
        unlink($file2);
    }
}

sub open_reject {
    if (defined($editor)) {
	print "opening reject $reject_file in $editor\n";
	system("$editor $reject_file");
    } else {
	print "please define \$EDITOR or \$REJEDITOR in your env\n";
    }
}

sub _run_merge($$) {
    my ($file, $file2) = @_;
    my $ret;
    my $pid;

    if ($merge_prog eq "kdiff3") {
	$ret = system("kdiff3 -o $file $file $file2");
    } elsif ($merge_prog eq "tkdiff") {
        $ret = system("tkdiff -o $file $file $file2");
    } elsif ($merge_prog =~ m/vimdiff/) {
        $ret = system("$merge_prog -f $file $file2");
    } else {
        $ret = system("$merge_prog $file $file2");
    }
    if ($ret) {
        $ret = $ret >> 8;
	print STDERR "warning: $merge_prog exited with $ret\n";
    }
}

# run the merge program, with a little customization for each kind
#
sub run_merge($$) {
    my ($file, $file2) = @_;
    my $ret;
    my $pid;

    if ($interactive) {
        $pid = fork();
	if ($pid) {
	    run_interactive($pid, $file, $file2);
	    return;
	}
    }
    _run_merge($file, $file2);

    if (!$auto && !$interactive) {
        unlink $file2;
    }
    if ($interactive) {
        exit 0;
    }
}

# look forward in the hunk for three more consecutive context lines
# this is used to split a large hunk into smaller ones
sub three_more_context($$$$) {
    my ($rev, $fw, $rindex, $findex) = @_;
    my $revctx = 0;
    my $fwctx = 0;
    
    while($rindex < scalar(@$rev) && $findex < scalar(@$fw)) {
        if ($rev->[$rindex++] =~ m/^ /) {
	    $revctx++;
	} else {
	    $revctx = 0;
	}
        if ($fw->[$findex++] =~ m/^ /) {
	    $fwctx++;
	} else {
	    $fwctx = 0;
	}
	last if($revctx > 3 && $fwctx > 3);
    }
    return ($revctx > 3 && $fwctx > 3);
}

# walk a hunk and divide it into smaller pieces.  The smaller pieces should
# be easier to place in the file.
#
sub split_and_push_hunk($$) {
    my ($hunks, $hunk) = @_;
    my $rev;
    my $fw;
    my $line;
    my $i;
    my @tmp;
    my $tmp_hash;
    my $fw_index;
    my $context;
    my $nonctx;
again:
    @tmp = ();
    $tmp_hash = {};
    $fw_index = 0;
    $context = 0;
    $i = 0;
    $rev = \@{$hunk->{'revhunk'}};
    $fw = \@{$hunk->{'fwhunk'}};
    $nonctx = 0;

    while($i < scalar(@$rev) && $fw_index < scalar(@$fw)) {
	$line = $rev->[$i];
        if ($line =~ m/^ / && $fw->[$fw_index] =~ m/^ /) {
	    $context++;
	} else {
	    $nonctx = 1;
	    # walk both arrays forward until we get to the next next bit
	    # of context in both
	    while($fw_index < scalar(@$fw) && !($fw->[$fw_index] =~ m/^ /)) {
	        $fw_index++;
	    }
	    while($i < scalar(@$rev) && !($rev->[$i] =~ m/^ /)) {
	        $i++;
	    }
	    $context = 1;
	}

	# split the hunk if we've seen a non-context line,
	# we've seen three context lines already, and the hunk
	# still has three context lines in a row later on.
	if ($nonctx && $context >= 3 && 
	    three_more_context($rev, $fw, $i, $fw_index)) {
	    my $t;
	    # for both the rev and forward arrays, copy the 
	    # first part of the hunk to a tmp array and assign it
	    # back into the old hunk.  
	    #
	    # Then make a new hunk comprised
	    # of the remaining parts of both arrays.
	    # Make sure the context we've found is put into both
	    # old and new hunks.
	    for ($t = $i - $context + 1 ; $t < scalar(@$rev); $t++) {
	        push @tmp, $rev->[$t];
	    }
	    $tmp_hash->{'revhunk'} = [@tmp];
	    @tmp = ();
	    for ($t = 0; $t <= $i; $t++) {
	        push @tmp, $rev->[$t];
	    }
	    $hunk->{'revhunk'} = [@tmp];
	    $tmp_hash->{'desc'} = $tmp[0];

	    @tmp = ();
	    for ($t = $fw_index - $context + 1 ; $t < scalar(@$fw); $t++) {
	        push @tmp, $fw->[$t];
	    }
	    $tmp_hash->{'fwhunk'} = [@tmp];
	    @tmp = ();
	    for ($t = 0; $t <= $fw_index; $t++) {
	        push @tmp, $fw->[$t];
	    }
	    $hunk->{'fwhunk'} = [@tmp];
	    push @$hunks, $hunk;
	    $hunk = {%$tmp_hash};
	    goto again;
	}
	$fw_index++;
	$i++;
    }
    push @$hunks, $hunk;
}

sub print_usage {
    print STDERR "usage: rej [-acdeiFMqrR] [-p num] [-o file] [-m prog] file file.rej\n";
    print STDERR "\t-a replace file with merged result.  Use with care!\n";
    print STDERR "\t\tbackup of original file created as file.mergebackup\n";
    print STDERR "\t-c maximize context from the reject.  This makes it\n";
    print STDERR "\t\teasier to figure out stubborn rejets\n";
    print STDERR "\t-dry-run check for conflicts, but do nothing\n";
    print STDERR "\t-i interactive mode\n";
    print STDERR "\t-F don't check for already applied changes\n";
    print STDERR "\t-M don't run the external merge program at all\n";
    print STDERR "\t-p num: strip num levels off the paths found in the diff\n";
    print STDERR "\t-q in dry-run mode, exit once a conflict is found\n";
    print STDERR "\t\totherwise, only run merge prog when there are conflicts\n";
    print STDERR "\t-r open the reject file in \$EDITOR\n";
    print STDERR "\t-R reverse the diff or reject\n";
    print STDERR "\t-o file specify output file for merge\n";
    print STDERR "\t\tThe merge program will not be run in this case\n";
    print STDERR "\t-m prog specify merge progam.  You can use:\n";
    print STDERR "\t\t[g]vimdiff (default), kdiff3, tkdiff and meld\n";
    print STDERR "\t\tothers called as: mergeprog foo.c foo.c.tmp\n";
    print STDERR "\t\tThe REJMERGE environment var specifies the merge program as well\n";
    print STDERR "\t-r open the reject with \$REJEDITOR or \$EDITOR\n";
    print STDERR "\n";
    exit 1;
}

sub strip_path($) {
    my ($p) = @_;

    #if ($p =~ m/(.*\/){$strip_level}?(.*)/) {
    if ($p =~ m/([^\/]+\/){$strip_level}?(.*)/) {
        $p = $2;
	return $p;
    }
    return undef;
}

sub reverse_line($) {
    my ($line) = @_;
    my $orig_line = $line;
    if (!$reverse_patch) {
        return $line;
    }
    if ($line =~ s/^-([^-].*)/\+$1/) {
        return $line;    
    } elsif ($line =~ s/^\+([^\+].*)/-$1/) {
        return $line;
    }
    return $line;
}

sub process_reject {
    if (!defined($rejfh) || !$diff_mode) {
	$rejfh = new IO::File;
	$rejfh->open("<$reject_file") || die "Unable to open $reject_file";
    }
    # in diff mode, find the first file indicator
    if ($diff_mode) {
	if ($rejfh->eof()) {
	    return 1;
	}
        while(defined($last_diff_line) || !$rejfh->eof()) {
	    if (defined($last_diff_line))  {
	        $_ = $last_diff_line;
		undef $last_diff_line;
	    } else {
	        $_ = <$rejfh>;
	    }
	    if (m/^--- (\S*)/) {
	        my $fname = $1;
		$fname = strip_path($fname);
		if ( -f $fname) {
		    $source_file = $fname;
		    last;
		} else {
		    my $t = <$rejfh>;
		    if ($t =~ m/^\+\+\+ (\S*)/) {
		        $fname = strip_path($1);
			if (-f $fname) {
			    $source_file = $fname;
			    last;
			}
		    }
		}
	    }
	}
    }

    $filefh = new IO::File;
    $filefh->open("<$source_file") || die "Unable to open $source_file";

    # struct hunk {
    #     @fwhunk;
    #     @revhunk;
    #     $hunk_offset; offset in hunk where matching started
    #     $start; 
    #     $end;
    #     $score;
    #     $match_count;
    #     $desc; @@ line
    #	  $options; # string with the special options for this hunk
    #     $aligned_hunk; points to array of @revhunk aligned with file
    #     $file_hunk; points to array of file lines aligned with aligned_hunk
    #     $method; "forward" or "reverse" defines how the hunk was matched
    # }

    #build the arrays of hunks
    my $hunk;
    my @fw;
    my @rev;
    my $more;
    my $last = 0;
    my $exclude = 0;
    my $hunk_opt = "";
    @hunks = ();
    $fully_matched_hunks = 0;
    $total_hunks = 0;
    $hunk_num = 0;
    while(<$rejfh>) {
	if ($diff_mode && m/^--- /) {
	    $last_diff_line = $_;
	    last;
	}
	$_ = reverse_line($_);
	if (m/^(@@|\*\*\* )/) {
again:
	    last if ($last);
	    # special options string
	    $hunk_opt = "";
	    if (m/###(.*)/) {
	        $hunk_opt = $1;
		if ($hunk_opt =~ m/only/) {
		    @hunks = ();
		    $hunk_num = 0;
		    $last = 1;
		} 
		if ($hunk_opt =~ m/exclude/) {
		    while(<$rejfh>) {
			if ($diff_mode && m/^--- /) {
			    $last_diff_line = $_;
			    goto read_file;
			}
			if (m/^(@@|\*\*\* )/) {
			    goto again;
			}
		    }
		} 
		if ($hunk_opt =~ m/last/) {
		    $last = 1;
		}
	    }
	    if ($hunk_num > 0) {
		$hunk->{'fwhunk'} = [@fw];
		$hunk->{'revhunk'} = [@rev];
		split_and_push_hunk(\@hunks, $hunk);
	    }
	    @fw = ();
	    @rev = ();
	    $hunk = {};
	    $hunk_num++;
	    $hunk->{'desc'} = $_;
	    $hunk->{'options'} = $hunk_opt;
	    # not a unified diff?
	    # process the whole thing right here
	    if (!m/^@@/) {
		if ($diff_mode) {
		   die "Unable to handle multi file context diffs";
		}
		$more = 0;
		while(<$rejfh>) {
		    $_ = reverse_line($_);
		    last if (m/^--- \d+,\d+ ---/);
		    s/(^.)./$1/;
		    if ($reverse_patch) {
			push @fw, $_;
		    } else {
			push @rev, $_;
		    }
		}
		while(<$rejfh>) {
		    $_ = reverse_line($_);
		    if (m/^\*\*\* /) {
			$more = 1;
			last;
		    }
		    if (!(m/^\*/)) {
			s/(^.)./$1/;
			if ($reverse_patch) {
			    push @rev, $_;
			} else {
			    push @fw, $_;
			}
		    }
		}
		if ($more) {
		    goto again;
		}
	    }
	} elsif (m/^-[^-]/) {
	    push @rev, $_;
	} elsif (m/^\+[^\+]/) {
	    push @fw, $_;
	} elsif (m/^ /) {
	    push @fw, $_;
	    push @rev, $_;
	}
    }
read_file:
    if (!$diff_mode) {
	$rejfh->close();
    }

    # push any leftover hunks from the loop above
    if (defined($hunk->{'desc'})) {
	$hunk->{'fwhunk'} = [@fw];
	$hunk->{'revhunk'} = [@rev];
	split_and_push_hunk(\@hunks, $hunk);
    }

    @file = ();
    # build the file array
    while(<$filefh>) {
	push @file, $_;
    }
    $filefh->close();

    $total_hunks += scalar(@hunks);
    # try to place each hunk into the file
    my $ret;
    foreach my $href (@hunks) {
	$ret = find_hunk($href);
	if ($report_only && $quick && $ret == 0) {
	    last;
	}
    }
    my $conflicts = $total_hunks - $fully_matched_hunks;
    $global_matched_hunks += $fully_matched_hunks;
    $global_reject_hunks += $total_hunks;
    $global_conflicts = $conflicts;
    if ($conflicts > 0) {
        $exit_value = 1;
    }
    if ($report_only && $quick && $conflicts > 0) {
        $conflicts = "some";
    }
    print STDERR "\t$source_file: $fully_matched_hunks matched, $conflicts conflicts remain\n";
    if ($report_only) {
	if ($quick && $exit_value) {
	    return 1;
	}
        return 0;
    }

    if (!defined($mergefh)) {
	# from here down either copies the merge result to $output_file or
	# runs the merge program
	if (defined($auto)) {
	    my $ret;
	    $ret = rename $source_file, "$source_file.mergebackup";
	    if (!$ret) {
		die "Unable to rename $source_file to $source_file.mergebackup";
	    }
	    $output_file = $source_file;
	}
	if (defined($output_file)) {
	    $mergefh = new IO::File;
	    $mergefh->open(">$output_file") || 
	              die "Unable to open $output_file";
	} else {
	    $mergefh = new File::Temp(TEMPLATE => "$source_file.XXXXX", 
				      UNLINK => 0) ||
				      die "Unable to create temp file";
	}
    } else {
	# mergefh is only defined when we're reloading.  
	# Just truncate and seek to 0
	if ($output_file) {
	    $mergefh->open(">$output_file")||die "Unable to open $output_file";
	} else {
	    $mergefh->truncate(0); 
	    seek $mergefh, 0, SEEK_SET;
	}
    }
    foreach my $l (@file) {
	print $mergefh $l;
    }
    $mergefh->flush();
    if ($output_file) {
        $mergefh->close();
    }
    return 0;
}

if (defined($ENV{'REJMERGE'})) {
    $merge_prog = $ENV{'REJMERGE'};
}
if (defined($ENV{'REJEDITOR'})) {
    $editor = $ENV{'REJEDITOR'};
} elsif (defined($ENV{'EDITOR'})) {
    $editor = $ENV{'EDITOR'};
}

GetOptions("context" => \$context,
	   "auto" => \$auto,
	   "dry-run" => \$report_only,
	   "out=s" => \$output_file,
	   "F|no-forward" => \$no_forward_search,
	   "interactive" => \$interactive,
	   "reject" => \$open_reject,
	   "Reverse" => \$reverse_patch,
	   "p|strip-level=s" => \$strip_level,
	   "quick" => \$quick,
	   "M|no-merge" => \$skip_merge,
           "merge=s" => \$merge_prog) || print_usage();;

$source_file = $ARGV[0];
$reject_file = $ARGV[1];
if (scalar(@ARGV) < 2) {
    if ($ARGV[0] =~ m/\.rej$/) {
        $reject_file = $ARGV[0];
	$source_file = $reject_file;
	$source_file =~ s/\.rej$//;
    } elsif (-f $source_file && -f "$source_file.rej") {
        $reject_file = "$source_file.rej";
    } elsif (-f $source_file) {
	$reject_file = $source_file;
	undef($source_file);
        $diff_mode = 1;
    } else {
        print_usage();
    }
}

$orig_reject_file = $reject_file;

if (!$diff_mode) {
    foreach my $f ($source_file, $reject_file) {
	if (! -f $f) {
	    print STDERR "Unable to find $f\n";
	    exit 1;
	}
    }
}

while(1) {
    if (process_reject()) {
        if ($diff_mode) {
	    print STDERR "$reject_file: total of $global_matched_hunks / $global_reject_hunks matched\n";
	}
        last;
    }
    if (!$report_only) {
	if ($open_reject) {
	    open_reject();
	}
	if (!$skip_merge && (!$quick || $global_conflicts > 0)) {
	    if (!defined($output_file)) {
		run_merge($source_file, $mergefh);
	    } elsif ($auto) {
		run_merge($source_file, "$source_file.mergebackup");
	    }
	}
    }
    if ($diff_mode) {
        undef($mergefh);
    } else {
        last;
    }
}

exit $exit_value;

--TB36FDmn/VVEgNH/--
