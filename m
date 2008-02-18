From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cvsexportcommit: be graceful when "cvs status" reorders
 the arguments
Date: Sun, 17 Feb 2008 19:03:14 -0800
Message-ID: <7vbq6fvudp.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0802180127100.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Langhoff <martin@catalyst.net.nz>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 18 04:04:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQwIY-0001Ze-Aa
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 04:04:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189AbYBRDDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 22:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754087AbYBRDDb
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 22:03:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55263 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695AbYBRDDa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 22:03:30 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 35C525C70;
	Sun, 17 Feb 2008 22:03:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 D21BE5C6C; Sun, 17 Feb 2008 22:03:21 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0802180127100.30505@racer.site> (Johannes
 Schindelin's message of "Mon, 18 Feb 2008 01:31:36 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74220>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I finally tracked it down to two filenames having the same basename.

Wonderful.

> 	Feel free to criticise/educate me on my Perl style.

Here it goes ;-)

> +    # "cvs status" reorders the parameters, notably when there are multiple
> +    # arguments with the same basename.  So be precise here.
> +    while (@canstatusfiles) {
> +      my @canstatusfiles2 = ();
> +      my %basenames = ();
> +      for (my $i = 0; $i <= $#canstatusfiles; $i++) {

The "$index <= $#array" termination condition feels so Perl4-ish.

	for (my $i = 0; $i < @canstatusfiles; $i++) {

> +        my $name = $canstatusfiles[$i];

> +	my $basename = $name;
> +	$basename =~ s/.*\///;

The script uses File::Basename upfront so perhaps just simply...

	my $basename = basename($name);

> +	$basename = "no file " . $basename if (grep {$_ eq $basename} @afiles);

Huh?  Perl or no Perl that is too ugly a hack...  What special
treatment do "added files" need?  We would want to make sure
that the files are not reported from "cvs status"?

> +	chomp($basename);

Huh?  Perhaps you wanted to chomp at the very beginning of the loop?

> +	if (!defined($basenames{$basename})) {
> +	  $basenames{$basename} = $name;
> +	  push (@canstatusfiles2, $name);
> +	  splice (@canstatusfiles, $i, 1);
> +	  $i--;
>          }
> +      }

> +      my @cvsoutput;
> +      @cvsoutput = xargs_safe_pipe_capture([@cvs, 'status'], @canstatusfiles2);
> +      foreach my $l (@cvsoutput) {
> +          chomp $l;
> +          if ( $l =~ /^File:\s+(.*\S)\s+Status: (.*)$/ ) {
> +            $cvsstat{$basenames{$1}} = $2 if defined($basenames{$1});
> +          }
> +      }

I think "exists $hash{$index}" would be easier to read and more
logical here and also if () condition above.

Without understanding what is really going on with the "added
files" case, here is how I would write your patch.

Side note.  I personally do not like naming hashes and arrays
plural, and call a hash of paths and list of files %path and
@file respectively.  That convention makes it easier to read
things like these:

	$file[4] ;# fourth file, not $files[4]
	$path{'hello.c'} ;# path for 'hello.c', not $paths{'hello.c'}

---

 git-cvsexportcommit.perl |   43 ++++++++++++++++++++++++++++++++++---------
 1 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 2a8ad1e..06e7fda 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -197,15 +197,40 @@ if (@canstatusfiles) {
       my @updated = xargs_safe_pipe_capture([@cvs, 'update'], @canstatusfiles);
       print @updated;
     }
-    my @cvsoutput;
-    @cvsoutput = xargs_safe_pipe_capture([@cvs, 'status'], @canstatusfiles);
-    my $matchcount = 0;
-    foreach my $l (@cvsoutput) {
-        chomp $l;
-        if ( $l =~ /^File:/ and  $l =~ /Status: (.*)$/ ) {
-            $cvsstat{$canstatusfiles[$matchcount]} = $1;
-            $matchcount++;
-        }
+
+    my %added = map { $_ => 1 } @afiles;
+
+    while (@canstatusfiles) {
+	    my %basename = ();
+	    my @status = ();
+	    my @leftover = ();
+	    for (my $i = 0; $i < @canstatusfiles; $i++) {
+		    my $name = $canstatusfiles[$i];
+		    my $basename = basename($name);
+		    if (exists $basename{$basename}) {
+			    push @leftover, $name;
+			    next;
+		    }
+		    if (exists $added{$name}) {
+			    # Hmph...
+			    next;
+		    }
+		    $basename{$basename} = $name;
+		    push @status, $name;
+	    }
+	    my @cvsoutput = xargs_safe_pipe_capture([@cvs, 'status'], @status);
+	    for my $l (@cvsoutput) {
+		    chomp $l;
+		    if ($l =~ /^File:\s+(.*\S)\s+Status: (.*)$/) {
+			    my ($n, $s) = ($1, $2);
+			    if (!exists $basename{$n}) {
+				    print STDERR "Huh ($n)?\n";
+			    } else {
+				    $cvsstat{$basename{$n}} = $s;
+			    }
+		    }
+	    }
+	    @canstatusfiles = @leftover;
     }
 }
 
