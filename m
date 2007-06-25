From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svnimport: added explicit merge graph option -G
Date: Mon, 25 Jun 2007 00:05:56 -0700
Message-ID: <7vtzsw344r.fsf@assigned-by-dhcp.pobox.com>
References: <437777.72821.qm@web43141.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stas Maximov <smaximov@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 09:06:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2ie7-0006t1-R9
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 09:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536AbXFYHF6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 03:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753659AbXFYHF6
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 03:05:58 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:48966 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299AbXFYHF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 03:05:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070625070558.GTKW2558.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Mon, 25 Jun 2007 03:05:58 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Fj5w1X0081kojtg0000000; Mon, 25 Jun 2007 03:05:57 -0400
In-Reply-To: <437777.72821.qm@web43141.mail.sp1.yahoo.com> (Stas Maximov's
	message of "Sun, 24 Jun 2007 16:10:42 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50866>

Stas Maximov <smaximov@yahoo.com> writes:

> From fd83a4e003802b6cb4dc8a2d058310f235f65e17 Mon Sep 17 00:00:00 2001
> From: Stas Maximov <smaximov@yahoo.com>
> Date: Sat, 23 Jun 2007 09:06:30 -0700
> Subject: [PATCH] git-svnimport: added explicit merge graph option -G
>
> Allows explicit merge graph information to be provided. Each line
> of merge graph file must contain a pair of SVN revision numbers
> separated by space. The first number is child (merged to) SVN rev
> number and the second is the parent (merged from) SVN rev number.
> Comments can be started with '#' and continue to the end of line.
> Empty and space-only lines are allowed and will be ignored.
>
> Signed-off-by: Stas Maximov <smaximov@yahoo.com>
>
> diff --git a/Documentation/git-svnimport.txt b/Documentation/git-svnimport.txt
> old mode 100644
> new mode 100755
> index e97d15e..c902b64

Executable documentation ;-)?

> diff --git a/git-svnimport.perl b/git-svnimport.perl
> index f459762..113b252 100755
> --- a/git-svnimport.perl
> +++ b/git-svnimport.perl
> ...
> @@ -80,6 +81,39 @@ if ($opt_M) {
>      unshift (@mergerx, qr/$opt_M/);
>  }
>  
> +
> +# merge_graph will be used for finding all parent SVN revisions for a given SVN
> +# revision. It will be implemented as a hash of hashes. First level hash will
> +# be keyed with the child SVN rev and contain a hash keyed with the parent SVN
> +# revisions. Values of the second level hash are not important (1 will be
> +# used). The keys will be used to store the parent revs for uniqueness.
> +our %merge_graph;
> +
> +
> +# read-in the explicit merge graph specified with -G option
> +if ($opt_G) {
> +    open(F,"cat $opt_G | sed -e 's/#.*\$//' -e '/^\$/d' |") or
> +        die("Can not open $opt_G");
> +    while(<F>) {
> +        chomp;
> +        die "ERROR: invalid line in $opt_G: $_" unless /^\s*(\d+)\s+(\d+)\s*$/;
> +        # $merge_graph{child_rev}{parent_rev} = 1;
> +        $merge_graph{$1}{$2} = 1;
> +    }

Many issues here.

 * Don't cat a single file into a pipe;
 * Don't invoke "sed" when you are writing in Perl;
 * Statement modifier with side effects is extremely hard to read;
 * Does the order of parents for a single child matter?  Do you
   ever have a look-up that says "I have a SVN child Id, and
   another commit Id.  Check quickly if the latter is one of the
   parents of the child"?  Otherwise nested hash is probably not
   the right data structure to use.

How about...

	open F, '<', $opt_G
        	or die("Cannot open '$opt_G'");
	while (<F>) {
		chomp;
		s/#.*//;
                next if ($_ eq '');
                if (/^\s*(\d+)\s+(\d+)\s*$/) {
			$merge_graph{$1} ||= [];
                        push @{$merge_graph{$1}}, $2;
                } else {
                	die "$opt_G:$. :malformed input $_\n";
		}
	}

You would need to change merge_graph_get_parents() as well, if
you do this; see below.

> +    close(F);
> +}
> +
> +
> +# Given an SVN revision (string), finds all its parent SVN revisions in the
> +# merge graph.
> +sub merge_graph_get_parents($)
> +{
> +    my $child_svnrev = shift;
> +    my @parents = keys(%{$merge_graph{$child_svnrev}});
> +    return @parents;
> +}

Can the caller ever call this with a svnrev not in $opt_G file?
Do we want to protect ourselves against it?

	sub merge_graph_get_parents {
		my $child_svnrev = shift;
		if (exists $merge_graph{$child_svnrev}) {
                	return @{$merge_graph{$child_svnrev}};
		}
                return ();
	}

> +
> +
>  # Absolutize filename now, since we will have chdir'ed by the time we
>  # get around to opening it.
>  $opt_A = File::Spec->rel2abs($opt_A) if $opt_A;
> @@ -356,6 +390,24 @@ if ($opt_A) {
>  
>  open BRANCHES,">>", "$git_dir/svn2git";
>  
> +
> +# Given an SVN revision (string), returns all corresponding GIT revisions.
> +#
> +# Note that it is possible that one SVN revision needs to be split into two or
> +# more GIT commits (revision). For example, this will happen if SVN user
> +# commits two branches at once.
> +sub svnrev_to_gitrevs($)
> +{
> +    my $svnrev = shift;
> +    my @gitrevs;
> +    for my $b (keys(%branches)) {
> +        push (@gitrevs, $branches{$b}{$svnrev})
> +            if defined($branches{$b}{$svnrev});
> +    }
> +    return @gitrevs;
> +}

Hmph.  The computation cost for this is proportional to the
number of branches on the SVN side?  Would that be a problem in
real-life (not an objection, but am just wondering.  "Not a
problem, because..." is an acceptable answer).

> @@ -815,6 +867,19 @@ sub commit {
>                      }
>                  }
>              }
> +
> +            # add parents from explicit merge graph (-G)
> +            {
> +                my @svnpars = merge_graph_get_parents($revision);
> +                foreach my $svnp (@svnpars) {
> +                    my @gitpars = svnrev_to_gitrevs($svnp);
> +                    foreach my $gitp (@gitpars) {
> +                        push (@parents, $gitp);
> +                        #print OUT "MG: $svnp -merge-> $revision\n";
> +                    }
> +                }
> +            }
> +

Leftover debugging print?

> From 7008a13f1fe00fdbd90be6a12ad1197dceedaebb Mon Sep 17 00:00:00 2001
> From: Stas Maximov <smaximov@yahoo.com>
> Date: Sun, 24 Jun 2007 14:23:29 -0700
> Subject: [PATCH] Fixed permissions of Documentation/git-svnimport.txt
>
>
> Signed-off-by: Stas Maximov <smaximov@yahoo.com>
>
> diff --git a/Documentation/git-svnimport.txt b/Documentation/git-svnimport.txt
> old mode 100755
> new mode 100644

Nah.  Fold this part to the previous commit and start the
document as a nonexecutable file from the beginning.
