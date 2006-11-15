X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make cvsexportcommit work with filenames with spaces and non-ascii characters.
Date: Tue, 14 Nov 2006 22:08:45 -0800
Message-ID: <7v8xidqm1e.fsf@assigned-by-dhcp.cox.net>
References: <20061115005530.26560.18222.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 06:09:03 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061115005530.26560.18222.stgit@lathund.dewire.com> (Robin
	Rosenberg's message of "Wed, 15 Nov 2006 01:55:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31418>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkDx5-00007D-RD for gcvg-git@gmane.org; Wed, 15 Nov
 2006 07:08:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966526AbWKOGIs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 01:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932816AbWKOGIs
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 01:08:48 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:64212 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S932815AbWKOGIr
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 01:08:47 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061115060846.EAQD18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Wed, 15
 Nov 2006 01:08:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id mu8r1V0201kojtg0000000; Wed, 15 Nov 2006
 01:08:52 -0500
To: Robin Rosenberg <robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> From: Robin Rosenberg <robin.rosenberg@dewire.com>
>
> This patch uses git-apply to do the patching which simplifies the code a lot.
>
> Removed the test for checking for matching binary files when deleting them
> since git-apply happily deletes the file. This is matter of taste since we
> allow some fuzz for text patches also.
>
> Error handling was cleaned up, but not much testd (it did not work before).
>
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>

Thanks.  Allow me to put this in freezer for a few days while
releasing v1.4.4.

Some comments below.

> @@ -116,12 +115,18 @@ if ($opt_a) {
>  close MSG;
>  
>  my (@afiles, @dfiles, @mfiles, @dirs);
> -my @files = safe_pipe_capture('git-diff-tree', '-r', $parent, $commit);
> -#print @files;
> +my $files = safe_pipe_capture_blob('git-diff-tree', '-z', '-r', $parent, $commit);
>  $? && die "Error in git-diff-tree";
> +while ($files =~ m/(.*?\000.*?\000)/g) {
> +    my $f=$1;
> +    $f =~ m/^(\S+) (\S+) (\S+) (\S+) (\S+)\000(.*)\000/;
> +    my @fields = ();
> +    $fields[++$#fields] = $1;
> +    $fields[++$#fields] = $2;
> +    $fields[++$#fields] = $3;
> +    $fields[++$#fields] = $4;
> +    $fields[++$#fields] = $5;
> +    $fields[++$#fields] = $6;

my @fields = ($f =~ m/^.../);

>  my (@binfiles, @abfiles, @dbfiles, @bfiles, @mbfiles);
>  @binfiles = grep m/^Binary files/, safe_pipe_capture('git-diff-tree', '-p', $parent, $commit);
>  map { chomp } @binfiles;
>  @abfiles = grep s/^Binary files \/dev\/null and b\/(.*) differ$/$1/, @binfiles;
>  @dbfiles = grep s/^Binary files a\/(.*) and \/dev\/null differ$/$1/, @binfiles;
>  @mbfiles = grep s/^Binary files a\/(.*) and b\/(.*) differ$/$1/, @binfiles;
> +push @abfiles, grep s/^Binary files \/dev\/null and "b\/(.*)" differ$/$1/, @binfiles;
> +push @dbfiles, grep s/^Binary files "a\/(.*)" and \/dev\/null differ$/$1/, @binfiles;
> +push @mbfiles, grep s/^Binary files "a\/(.*)" and \"b\/(.*)\" differ$/$1/, @binfiles;
> +map { s/\\([\d]{3})/sprintf('%c',oct $1)/eg; } @abfiles;
> +map { s/\\([\d]{3})/sprintf('%c',oct $1)/eg; } @dbfiles;
> +map { s/\\([\d]{3})/sprintf('%c',oct $1)/eg; } @mbfiles;
> +

Logically these map {} should be done only on the c-quoted
names, but it is Ok because the names that have backslash with
octal are quoted.  However, what's inside the map is not correct
c dequoting (see how Jakub does it in gitweb -- you need to
worry about \\, \" and such).

I think it is perhaps safer to parse "diff --git" and remember
the filenames of the "current patch" and then notice only
/^Binary files / part of the message.

But all of the above shows deficiency in the current set of
tools -- they are not helping Porcelain writers enough.  I think
we should enhance 'apply --numstat' to let it show binary diffs
differently:

	git diff-tree -p $parent $commit >.tmpfile
        git apply --numstat -z <.tmpfile

would currently say "0 0" for binary files (the primary benefit
of using "--numstat -z" here is that it would give Perl scripts
pathnames parsable without C dequoting).  We should somehow have
a way to show it differently from text files without any
added/deleted lines (e.g. only the mode change), and that would
make the life of Porcelain writers who needs to write something
like the above code much more pleasant.  Perhaps show "- -"
instead of "0 0", since there is no notion of lines in "binary
files differ" case?

> -    `cvs add $d`;
> -    if ($?) {
> -	$dirty = 1;
> +    print "Adding directory $d";
> +    if (system('cvs','add',$d)) {
> +	$dirtypatch = 1;

Good.

>  ## apply non-binary changes
>  my $fuzz = $opt_p ? 0 : 2;
>  
> -print "Patching non-binary files\n";
> +print "Patching\n";

Leftover comment that does not apply anymore.

>  if (scalar(@afiles)+scalar(@dfiles)+scalar(@mfiles) != scalar(@bfiles)) {
> +    `git-diff-tree --binary -z -p $parent -p $commit >.cvsexportcommit.diff`;

Haven't you run this diff before to grep for "Binary files..."
Maybe doing a temporary file upfront once and using it would
make sense.

Also why multiple -p?  I do not think -z is wanted here, as -z
affects only output side of git apply and not input side (see
the above comment on --numstat -z).
