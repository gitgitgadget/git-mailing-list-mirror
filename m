From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] use refnames instead of "left"/"right" in dirdiffs
Date: Wed, 27 Mar 2013 23:07:16 +0000
Message-ID: <20130327230715.GU2286@serenity.lan>
References: <1364422397.8091.1.camel@heisenberg.scientia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
X-From: git-owner@vger.kernel.org Thu Mar 28 00:08:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKzSD-0004AP-Ic
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 00:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754712Ab3C0XHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 19:07:54 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:38035 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754413Ab3C0XHX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 19:07:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 9A1A0CDA55F;
	Wed, 27 Mar 2013 23:07:22 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w3xit+YoLXqB; Wed, 27 Mar 2013 23:07:21 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 7FF2FCDA57C;
	Wed, 27 Mar 2013 23:07:18 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <1364422397.8091.1.camel@heisenberg.scientia.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219354>

On Wed, Mar 27, 2013 at 11:13:17PM +0100, Christoph Anton Mitterer wrote:
> Currently, when a dir-diff is made with git-difftool the two revisions are
> stored in two temporary directories ".../left" and ".../right".
> Many difftools show these pathnames in ther UI and therefore it would be helpful
> for users, if actual reference names specified as progam arguments was used
> instead.
> 
> Reference names might contain slash / characters which are not allowed to be
> part of a file name. These must therefore be encoded.
> 
> Also, reference names that would could possibly "break out" of the temporary
> directory (e.g. "/foo", "foo/../bar" or "foo/././bar") must be sanitised.
> * Added a subroutine escape_reference_to_single_directory_name() which encodes a
>   reference name to a valid single directory name.
>   Any occurance of a slash / is replaced by two backslashes \\.
>   Having a backslash \ in a reference name should be forbidden, but just to be
>   save from collisions, any occurance of a backslash \ is replaced by a
>   backslash followed by an underscore \_ at first.
> 
> * Use this new function to construct the pathnames of the temporary directories
>   for the two revisions in dir-diffs.
> 
> Signed-off-by: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
> 
> diff --git a/git-difftool.perl b/git-difftool.perl
> index 12231fb..53e756d 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -83,6 +83,28 @@ sub exit_cleanup
>         exit($status | ($status >> 8));
>  }
>  
> +sub escape_reference_to_single_directory_name
> +{
> +       # Git allows reference names (see git-check-ref-format(1)) which cannot
> +       # be directly mapped to a single directory name.
> +       #
> +       # This subroutines replaces any occurance of a slash / by two
> +       # backslashes \\.
> +       # Thereby, break-out attempts like "/foo", "foo/../bar" or "foo/././bar"
> +       # are prevented, too.

That's not going to work well on Windows, is it?  Anything with two dots
in is already forbidden so we don't need to worry about that; I'm not
sure we need to remove forward slashes at all, until we consider the
"commit containing" syntax ':/fix nasty bug' or 'master^{/fix bug}'.

I'm more concerned with specifiers containing '^', '@', '{', ':' - see
'SPECIFYING REVISIONS' in git-rev-parse(1) for the full details of
what's acceptable.  At some point I think it may be better to fall back
to the SHA1 of the relevant commit.

> +       #
> +       # Having a backslash \ in a reference name should be forbidden, but just
> +       # to be save from collisions, any occurance of a backslash \ is replaced
> +       # by a backslash followed by an underscore \_ at first.
> +
> +       my ($commit_name)  = @_;
> +
> +       $commit_name =~ s/\\/\\_/g;
> +       $commit_name =~ s/\//\\\\/g;
> +
> +       return $commit_name;
> +}
> +
>  sub setup_dir_diff
>  {
>         my ($repo, $workdir, $symlinks) = @_;
> @@ -169,8 +191,13 @@ EOF
>  
>         # Setup temp directories
>         my $tmpdir = tempdir('git-difftool.XXXXX', CLEANUP => 0, TMPDIR => 1);
> -       my $ldir = "$tmpdir/left";
> -       my $rdir = "$tmpdir/right";
> +       my $ldir = "$tmpdir/" . escape_reference_to_single_directory_name($ARGV[0]);
> +       my $rdir = "$tmpdir/";
> +       if (@ARGV < 2) {
> +               $rdir .= 'HEAD';
> +       } else {
> +               $rdir .= escape_reference_to_single_directory_name($ARGV[1]);
> +       }

I don't think this approach is general enough, since git-difftool
accepts the same range of arguments that git-diff does.

We need to walk over @ARGV here, ignore anything starting with '-', stop
when we reach '--' and handle the arguments found in there including the
three acceptable range forms:

    <commit> <commit>
    <commit>..<commit>
    <commit>...<commit>

replacing missing commits with HEAD.

>         mkpath($ldir) or exit_cleanup($tmpdir, 1);
>         mkpath($rdir) or exit_cleanup($tmpdir, 1);
>  
> 
