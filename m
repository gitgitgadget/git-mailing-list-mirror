From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH, 2nd version] git-archimport: allow remapping branch names
Date: Wed, 07 Mar 2007 00:57:43 -0800
Message-ID: <7vlki9h1mg.fsf@assigned-by-dhcp.cox.net>
References: <eslrcr$9rc$1@sea.gmane.org>
	<7vodn5iiew.fsf@assigned-by-dhcp.cox.net>
	<45EE7442.6030308@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: bonzini@gnu.org
X-From: git-owner@vger.kernel.org Wed Mar 07 09:57:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOry3-0007gM-EF
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 09:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161318AbXCGI5p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 03:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161335AbXCGI5p
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 03:57:45 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:52346 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161318AbXCGI5o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 03:57:44 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070307085743.EDAO2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Mar 2007 03:57:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Xkxj1W00H1kojtg0000000; Wed, 07 Mar 2007 03:57:43 -0500
In-Reply-To: <45EE7442.6030308@lu.unisi.ch> (Paolo Bonzini's message of "Wed,
	07 Mar 2007 09:13:54 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41658>

Paolo Bonzini <paolo.bonzini@lu.unisi.ch> writes:

> 	Great idea.  Thanks.  By the way, this patch was tested on
> 	my Arch repositories.

Just to make sure.  Was it tested with AND WITHOUT the new colon
feature?  I am asking how likely is there a regression.

> diff --git a/git-archimport.perl b/git-archimport.perl
> index 0fcb156..1044695 100755
> --- a/git-archimport.perl
> +++ b/git-archimport.perl
> @@ -89,7 +89,11 @@ usage if $opt_h;
>  # values associated with keys:
>  #   =1 - Arch version / git 'branch' detected via abrowse on a limit
>  #   >1 - Arch version / git 'branch' of an auxiliary branch we've merged
> -my %arch_branches = map { $_ => 1 } @ARGV;
> +my %arch_branches = map { my $branch = $_; $branch =~ s/:.*//; $branch => 1 } @ARGV;

I am a bit puzzled here.  Let's consider four cases.

 (0) No colon in arch archive, no mapping
 (1) No colon in arch archive, mapped to 'master'
 (2) A colon in arch archive, no mapping specified
 (3) A colon in arch archive, mapped to 'master'

The above s/:.*// would do:

 (0) bonzini-2005/devo ==> bonzini-2005/devo
 (1) bonzini-2005/devo:master ==> bonzini-2005/devo
 (2) bonzini:gnu-2005/devo ==> bonzini
 (3) bonzini:gnu-2005/devo:master ==> bonzini

and then later branch_name_map splits them to:

 (0) bonzini-2005/devo ==> no entry in %branch_name_map
 (1) bonzini-2005/devo ==> no entry in %branch_name_map
 (2) bonzini:gnu-2005/devo ==> (bonzini => gnu-2005/devo)
 (3) bonzini:gnu-2005/devo:master ==> (bonzini:gnu-2005/devo => master)

In effect, (2) is an error, which is fine, because if the arch
archive had colon in its name then the user can ask explicitly
to map it by having an extra ':<branchname>'.  However, I think
your s/:.*// above breaks case (3).

> +
> +# $branch_name_map:
> +# maps arch branches to git branch names
> +my %branch_name_map = map { m/^(.*):([^:]*)$/; $1 => $2 } grep { m/:/ } @ARGV;
> ...
> @@ -104,6 +108,7 @@ ...
> +sub git_branchname {
> +    my $revision = shift;
> +    my $name = extract_versionname($revision);
> +
> +    if (defined $branch_name_map{$name}) {
> +	return $branch_name_map{$name};

This is purely a style issue, but I tend to prefer 'exists' over
'defined' when checking if a name is something that was placed
in a hash we set up earlier by reading configuration or command,
even if we _know_ that the hash was created with 'defined' values
in them.

>  sub process_patchset_accurate {
>      my $ps = shift;
> @@ -333,19 +365,23 @@ sub process_patchset_accurate {
>          if ($ps->{tag} && (my $branchpoint = eval { ptag($ps->{tag}) })) {
>              
>              # find where we are supposed to branch from
> -            system('git-checkout','-f','-b',$ps->{branch},
> -                            $branchpoint) == 0 or die "$! $?\n";
> -            
> +	    if (! -e "$git_dir/refs/heads/$ps->{branch}") {
> +		system('git-branch',$ps->{branch},$branchpoint) == 0 or die "$! $?\n";

Strictly speaking (-e "$git_dir/refs/heads/$branch") test would
not work if the repository was pack-ref'ed with --all option.
Run "git show-ref -q --verify refs/heads/$branch" and check its
exit status, or run it without -q and read its output.

> @@ -830,8 +871,9 @@ sub tag {
>      if ($opt_o) {
>          $tag =~ s|/|--|g;
>      } else {
> -        # don't use subdirs for tags yet, it could screw up other porcelains
> -        $tag =~ s|/|,|g;
> +	my $patchname = $tag;
> +	$patchname =~ s/.*--//;
> +        $tag = git_branchname ($tag) . '--' . $patchname;
>      }
>      
>      if ($commit) {

The call to git_branchname() is essential for mapping the name
we get from arch using the command line mapping, but if the user
is not using this remapping feature, does this keep the original
behaviour?

With the original code, a tag "t--a/g" was mapped to "t--a,g" in
the else clause, but the new code yields git_branchname("t--a/g")
followed by '--' followed by "g", which would evaluate to I do
not know what exactly, but I am sure it would not evaluate to
"t--a,g".  Would it be a non-issue?  As archimport seems to support
incremental import, I suspect it might upset existing users.
