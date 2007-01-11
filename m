From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] cvsimport: skip commits that are too recent
Date: Thu, 11 Jan 2007 09:22:07 +0100
Organization: Dewire
Message-ID: <200701110922.07997.robin.rosenberg.lists@dewire.com>
References: <11682386193246-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Jan 11 09:18:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4v8m-0004vD-HJ
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 09:18:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbXAKIS0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 11 Jan 2007 03:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbXAKISZ
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 03:18:25 -0500
Received: from [83.140.172.130] ([83.140.172.130]:19446 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1030216AbXAKISY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Jan 2007 03:18:24 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 5B3728030A2;
	Thu, 11 Jan 2007 09:14:02 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 30491-10; Thu, 11 Jan 2007 09:14:01 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [10.1.2.238])
	by dewire.com (Postfix) with ESMTP id CA9D680265C;
	Thu, 11 Jan 2007 09:13:59 +0100 (CET)
To: Martin Langhoff <martin@catalyst.net.nz>
User-Agent: KMail/1.9.4
In-Reply-To: <11682386193246-git-send-email-martin@catalyst.net.nz>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36555>

The idea is nice,  but the downside of this patch is that I (and presum=
ably=20
others) have to rewrite the scripts to invoke cvsps explicitly now. The=
 fix=20
should really be in cvsps, not git-cvsimport (which is the reason I hav=
en't=20
fixed this). Running a full cvsps takes two hours and consumes more tha=
n a=20
gigabyte of memory for me, which makes it impossible to run on all but =
one=20
machine, wheras the incremental import runs in less than five minutes o=
n any=20
machine.

Add to that the risk that the buggy nature of cvsps probably increases =
the=20
risk of errors, so please make the old behaviour the default (import al=
l,=20
retain cvsps cache) and make the changed behaviour the result of an exp=
licit=20
switch.

-- robin

m=C3=A5ndag 08 januari 2007 07:43 skrev Martin Langhoff:
> With this patch, cvsimport will skip commits made
> in the last 10 minutes. The recent-ness test is of
> 5 minutes + cvsps fuzz window (5 minutes default).
>
> To force recent commits to be imported, pass the
> -a(ll) flag.
>
> When working with a CVS repository that is in use,
> importing commits that are too recent can lead to
> partially incorrect trees. This is mainly due to
>
>  - Commits that are within the cvsps fuzz window may later
>    be found to have affected more files.
>
>  - When performing incremental imports, clock drift between
>    the systems may lead to skipped commits.
>
> This commit helps keep incremental imports of in-use
> CVS repositories sane.
>
> Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>
> ---
>  Documentation/git-cvsimport.txt |    7 ++++++-
>  git-cvsimport.perl              |   20 ++++++++++++++++++--
>  2 files changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-cvsimport.txt
> b/Documentation/git-cvsimport.txt index d21d66b..6deee94 100644
> --- a/Documentation/git-cvsimport.txt
> +++ b/Documentation/git-cvsimport.txt
> @@ -90,7 +90,8 @@ If you need to pass multiple options, separate them=
 with
> a comma. Print a short usage message and exit.
>
>  -z <fuzz>::
> -        Pass the timestamp fuzz factor to cvsps.
> +	Pass the timestamp fuzz factor to cvsps, in seconds. If unset,
> +	cvsps defaults to 300s.
>
>  -s <subst>::
>  	Substitute the character "/" in branch names with <subst>
> @@ -99,6 +100,10 @@ If you need to pass multiple options, separate th=
em
> with a comma. CVS by default uses the unix username when writing its
>  	commit logs. Using this option and an author-conv-file
>  	in this format
> +
> +-a::
> +	Import all commits, including recent ones. cvsimport by default
> +	skips commits that have a timestamp less than 10 minutes ago.
>  +
>  ---------
>  	exon=3DAndreas Ericsson <ae@op5.se>
> diff --git a/git-cvsimport.perl b/git-cvsimport.perl
> index c5bf2d1..a75aaa3 100755
> --- a/git-cvsimport.perl
> +++ b/git-cvsimport.perl
> @@ -29,7 +29,7 @@ use IPC::Open2;
>  $SIG{'PIPE'}=3D"IGNORE";
>  $ENV{'TZ'}=3D"UTC";
>
> -our
> ($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_=
i,$opt
>_P, $opt_s,$opt_m,$opt_M,$opt_A,$opt_S,$opt_L); +our
> ($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_=
i,$opt
>_P, $opt_s,$opt_m,$opt_M,$opt_A,$opt_S,$opt_L, $opt_a); my
> (%conv_author_name, %conv_author_email);
>
>  sub usage() {
> @@ -37,7 +37,7 @@ sub usage() {
>  Usage: ${\basename $0}     # fetch/update GIT from CVS
>         [-o branch-for-HEAD] [-h] [-v] [-d CVSROOT] [-A author-conv-f=
ile]
>         [-p opts-for-cvsps] [-C GIT_repository] [-z fuzz] [-i] [-k] [=
-u]
> -       [-s subst] [-m] [-M regex] [-S regex] [CVS_module]
> +       [-s subst] [-a] [-m] [-M regex] [-S regex] [CVS_module]
>  END
>  	exit(1);
>  }
> @@ -105,6 +105,8 @@ if ($opt_d) {
>  }
>  $opt_o ||=3D "origin";
>  $opt_s ||=3D "-";
> +$opt_a ||=3D 0;
> +
>  my $git_tree =3D $opt_C;
>  $git_tree ||=3D ".";
>
> @@ -129,6 +131,11 @@ if ($opt_M) {
>  	push (@mergerx, qr/$opt_M/);
>  }
>
> +# Remember UTC of our starting time
> +# we'll want to avoid importing commits
> +# that are too recent
> +our $starttime =3D time();
> +
>  select(STDERR); $|=3D1; select(STDOUT);
>
>
> @@ -824,6 +831,15 @@ while (<CVS>) {
>  			$state =3D 11;
>  			next;
>  		}
> +		if ( !$opt_a && $starttime - 300 - (defined $opt_z ? $opt_z : 300)=
 <=3D
> $date) { +			# skip if the commit is too recent
> +			# that the cvsps default fuzz is 300s, we give ourselves another
> +			# 300s just in case -- this also prevents skipping commits
> +			# due to server clock drift
> +			print "skip patchset $patchset: $date too recent\n" if $opt_v;
> +			$state =3D 11;
> +			next;
> +		}
>  		if (exists $ignorebranch{$branch}) {
>  			print STDERR "Skipping $branch\n";
>  			$state =3D 11;

--=20
TESTMAIL
