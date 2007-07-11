From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvsserver: detect/diagnose write failure, etc.
Date: Wed, 11 Jul 2007 14:52:02 -0700
Message-ID: <7v1wfe38xp.fsf@assigned-by-dhcp.cox.net>
References: <87vecx4tel.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Frank Lichtenheld <frank@lichtenheld.de>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Wed Jul 11 23:52:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8k6T-0004er-OH
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 23:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756895AbXGKVwG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 17:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756506AbXGKVwF
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 17:52:05 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:37763 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761581AbXGKVwE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 17:52:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070711215202.DDLN1428.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Wed, 11 Jul 2007 17:52:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NMs21X00U1kojtg0000000; Wed, 11 Jul 2007 17:52:03 -0400
In-Reply-To: <87vecx4tel.fsf@rho.meyering.net> (Jim Meyering's message of
	"Fri, 06 Jul 2007 14:18:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52214>

Jim Meyering <jim@meyering.net> writes:

> Beware: in some contexts (when running as server), one must
> not "die", but rather return an "error" indicator to the client.
> I did that in the second hunk.  However, I haven't carefully
> audited the others, and so, some of the "die" calls I added may
> end up killing the server, when a gentler failure is required.
>
> I've just looked, and can confirm that my change to req_Modified
> (first hunk) is wrong.  It should not die.  Rather, it should probably
> do something like the "print "E ... in hunk#2.  Ideally, someone
> would write a test to exercise code like this, to make sure it works.
>
> Jim

> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index 5cbf27e..8d8d6f5 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -644,7 +644,7 @@ sub req_Modified
>          $bytesleft -= $blocksize;
>      }
>  
> -    close $fh;
> +    close $fh or die "Failed to write temporary, $filename: $!";

True; dying is not appropriate here.

> @@ -901,8 +901,13 @@ sub req_update
>      # projects (heads in this case) to checkout.
>      #
>      if ($state->{module} eq '') {
> +	my $heads_dir = $state->{CVSROOT} . '/refs/heads';
> +	if (!opendir HEADS, $heads_dir) {
> +	  print "E [server aborted]: Failed to open directory, $heads_dir: $!\n"
> +	    . "error\n";
> +	  return 0;
> +	}
>          print "E cvs update: Updating .\n";
> -	opendir HEADS, $state->{CVSROOT} . '/refs/heads';
>  	while (my $head = readdir(HEADS)) {
>  	    if (-f $state->{CVSROOT} . '/refs/heads/' . $head) {
>  	        print "E cvs update: New directory `$head'\n";

Hmph.  The clients get no entries in the listing either way, but
I would say this is an improvement.

> @@ -1754,7 +1759,9 @@ sub req_annotate
>          # git-jsannotate telling us about commits we are hiding
>          # from the client.
>  
> -        open(ANNOTATEHINTS, ">$tmpdir/.annotate_hints") or die "Error opening > $tmpdir/.annotate_hints $!";
> +        my $a_hints = "$tmpdir/.annotate_hints";
> +        open(ANNOTATEHINTS, '>', $a_hints)
> +	  or die "Failed to open '$a_hints' for writing: $!";
>          for (my $i=0; $i < @$revisions; $i++)
>          {
>              print ANNOTATEHINTS $revisions->[$i][2];

Hmph, we seem to have:

                $log->warn("Error in annotate output! LINE: $_");
                print "E Annotate error \n";

which suggest me that throwing "E error" at the client and
returning might be better?

> @@ -1765,11 +1772,11 @@ sub req_annotate
>          }
>  
>          print ANNOTATEHINTS "\n";
> -        close ANNOTATEHINTS;
> +        close ANNOTATEHINTS or die "Failed to write $a_hints: $!";
>  
> -        my $annotatecmd = 'git-annotate';
> -        open(ANNOTATE, "-|", $annotatecmd, '-l', '-S', "$tmpdir/.annotate_hints", $filename)
> -	    or die "Error invoking $annotatecmd -l -S $tmpdir/.annotate_hints $filename : $!";
> +        my @cmd = (qw(git-annotate -l -S), $a_hints, $filename);
> +        open(ANNOTATE, "-|", @cmd)
> +	    or die "Error invoking ". join(' ',@cmd) .": $!";
>          my $metadata = {};
>          print "E Annotations for $filename\n";
>          print "E ***************\n";

Likewise...

> @@ -1996,12 +2003,12 @@ sub transmitfile
>          {
>              open NEWFILE, ">", $targetfile or die("Couldn't open '$targetfile' for writing : $!");
>              print NEWFILE $_ while ( <$fh> );
> -            close NEWFILE;
> +            close NEWFILE or die("Failed to write '$targetfile': $!");
>          } else {
>              print "$size\n";
>              print while ( <$fh> );
>          }
> -        close $fh or die ("Couldn't close filehandle for transmitfile()");
> +        close $fh or die ("Couldn't close filehandle for transmitfile(): $!");
>      } else {
>          die("Couldn't execute git-cat-file");
>      }

Ok.

> @@ -2501,17 +2508,14 @@ sub update
>                      if ($parent eq $lastpicked) {
>                          next;
>                      }
> -                    open my $p, 'git-merge-base '. $lastpicked . ' '
> -                    . $parent . '|';
> -                    my @output = (<$p>);
> -                    close $p;
> -                    my $base = join('', @output);
> +                    my $base = safe_pipe_capture('git-merge-base',
> +						 $lastpicked, $parent);
>                      chomp $base;
>                      if ($base) {
>                          my @merged;
>                          # print "want to log between  $base $parent \n";
>                          open(GITLOG, '-|', 'git-log', "$base..$parent")
> -                        or die "Cannot call git-log: $!";
> +			  or die "Cannot call git-log: $!";
>                          my $mergedhash;
>                          while (<GITLOG>) {
>                              chomp;

Ok.
