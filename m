From: Andrej Manduch <amanduch@gmail.com>
Subject: Re: [PATCH] git-svn: doublecheck if really file or dir
Date: Sun, 03 Aug 2014 14:22:34 +0200
Message-ID: <53DE298A.9090505@gmail.com>
References: <1405657201-32035-1-git-send-email-amanduch@gmail.com> <20140723220414.GA14145@dcvr.yhbt.net> <53D46812.3020706@gmail.com> <20140803024520.GA12880@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Aug 03 14:23:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDuom-0005C4-Tl
	for gcvg-git-2@plane.gmane.org; Sun, 03 Aug 2014 14:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbaHCMWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2014 08:22:52 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38396 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbaHCMWv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2014 08:22:51 -0400
Received: by mail-wi0-f182.google.com with SMTP id d1so3578282wiv.15
        for <git@vger.kernel.org>; Sun, 03 Aug 2014 05:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=OvU8sytbple8chVlzagmxX+P7vnw8uCLkkSL2IIgn6Y=;
        b=S91jOboIgHGdSjyylq4VCQ9PruIuLdEYVRwSJgNHDRkc3aVkMlJshn+DLbCVkMb4yT
         JEIX/TRHgGuJ0Q2UCLiLoTCn6P2F5nWP0PEITdHui13sSQ7wSM58JwVW/1t4S+8qepH2
         w+uEY7UxOILdWxMFHmsFhYVTLusrcH+8EcCkx4OA9mDMEh2PrXUOAze5Onb8yuGz81A3
         S2IGdjHo9ALmDityL7jpm5/KleUBJhbLTDODKvG/l4pNb4j8XgwU05WnWSfCnLSt2spq
         FGJVNKkkNeXXqx5cQmou1Kg1HTwWR8Alr+C4W1LZUWi/L+l7nja769u3UJXAzqLdRynS
         Ao4A==
X-Received: by 10.194.189.230 with SMTP id gl6mr2667966wjc.118.1407068569193;
        Sun, 03 Aug 2014 05:22:49 -0700 (PDT)
Received: from [192.168.1.7] ([80.242.44.116])
        by mx.google.com with ESMTPSA id l7sm35501583wjx.7.2014.08.03.05.22.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Aug 2014 05:22:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <20140803024520.GA12880@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254722>

Hi Eric,

Nice touch, It works like charm. However unfortunatelly now I think you
introduced new bug :)

On 08/03/2014 04:45 AM, Eric Wong wrote:
> Hi Andrej, I could not help thinking your patch was obscuring
> another bug.  I think I have an alternative to your patch which
> fixes both our bugs.  Can you give this a shot?  Thanks.
> 
> --------------------------- 8< ----------------------------
> Subject: [PATCH] git svn: info: correctly handle absolute path args
> 
> Calling "git svn info $(pwd)" would hit:
>   "Reading from filehandle failed at ..."
> errors due to improper prefixing and canonicalization.
> 
> Strip the toplevel path from absolute filesystem paths to ensure
> downstream canonicalization routines are only exposed to paths
> tracked in git (or SVN).
> 
> Noticed-by: Andrej Manduch <amanduch@gmail.com>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>  git-svn.perl            | 21 +++++++++++++++------
>  t/t9119-git-svn-info.sh | 10 ++++++++++
>  2 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 1f41ee1..1f9582b 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1477,10 +1477,19 @@ sub cmd_commit_diff {
>  	}
>  }
>  
> -
>  sub cmd_info {
> -	my $path = canonicalize_path(defined($_[0]) ? $_[0] : ".");
> -	my $fullpath = canonicalize_path($cmd_dir_prefix . $path);
> +	my $path_arg = defined($_[0]) ? $_[0] : '.';
> +	my $path = $path_arg;
> +	if ($path =~ m!\A/!) {
> +		my $toplevel = eval {
> +			my @cmd = qw/rev-parse --show-toplevel/;
> +			command_oneline(\@cmd, STDERR => 0);
> +		};
> +		$path =~ s!\A\Q$toplevel\E/?!!;
I have problem with this line ^^^

Suppose your $toplevel is "/sometning" and you type in command line
something like that: "git svn info /somethingsrc" and as you see this
should end up with error. However "$path =~ s!\A\Q$toplevel\E/?!!;"
will just cut "/sometning" from "/somethingsrc" and and up with same
answer as for "svn git info src" which is not equivalent query.

Second scenario is something which worries me more: If your query look
like this: "git svn info /something//src" it will just end up with error
because it will set $path to "/src" witch is outside of repository.

Second scenario can be fixed with this:

diff --git a/git-svn.perl b/git-svn.perl
index a69f0fc..00f9d01 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1483,7 +1483,7 @@ sub cmd_info {
 			my @cmd = qw/rev-parse --show-toplevel/;
 			command_oneline(\@cmd, STDERR => 0);
 		};
-		$path =~ s!\A\Q$toplevel\E/?!!;
+		$path =~ s!\A\Q$toplevel\E/*!!;
 		$path = canonicalize_path($path);
 	} else {
 		$path = canonicalize_path($cmd_dir_prefix . $path);


However I'm not sure if this will work on windows (where slashes are in
different orientation).


On 08/03/2014 04:45 AM, Eric Wong wrote:
> +		$path = canonicalize_path($path);
> +	} else {
> +		$path = canonicalize_path($cmd_dir_prefix . $path);
> +	}
>  	if (exists $_[1]) {
>  		die "Too many arguments specified\n";
>  	}
> @@ -1501,14 +1510,14 @@ sub cmd_info {
>  	# canonicalize_path() will return "" to make libsvn 1.5.x happy,
>  	$path = "." if $path eq "";
>  
> -	my $full_url = canonicalize_url( add_path_to_url( $url, $fullpath ) );
> +	my $full_url = canonicalize_url( add_path_to_url( $url, $path ) );
>  
>  	if ($_url) {
>  		print "$full_url\n";
>  		return;
>  	}
>  
> -	my $result = "Path: $path\n";
> +	my $result = "Path: $path_arg\n";
>  	$result .= "Name: " . basename($path) . "\n" if $file_type ne "dir";
>  	$result .= "URL: $full_url\n";
>  
> @@ -1539,7 +1548,7 @@ sub cmd_info {
>  	}
>  
>  	my ($lc_author, $lc_rev, $lc_date_utc);
> -	my @args = Git::SVN::Log::git_svn_log_cmd($rev, $rev, "--", $fullpath);
> +	my @args = Git::SVN::Log::git_svn_log_cmd($rev, $rev, "--", $path);
>  	my $log = command_output_pipe(@args);
>  	my $esc_color = qr/(?:\033\[(?:(?:\d+;)*\d*)?m)*/;
>  	while (<$log>) {
> diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
> index ff19695..4f6e669 100755
> --- a/t/t9119-git-svn-info.sh
> +++ b/t/t9119-git-svn-info.sh
> @@ -74,6 +74,16 @@ test_expect_success 'info .' "
>  	test_cmp_info expected.info-dot actual.info-dot
>  	"
>  
> +test_expect_success 'info $(pwd)' '
> +	(cd svnwc; svn info "$(pwd)") >expected.info-pwd &&
> +	(cd gitwc; git svn info "$(pwd)") >actual.info-pwd &&
> +	grep -v ^Path: <expected.info-pwd >expected.info-np &&
> +	grep -v ^Path: <actual.info-pwd >actual.info-np &&
> +	test_cmp_info expected.info-np actual.info-np &&
> +	test "$(sed -ne \"/^Path:/ s!/svnwc!!\" <expected.info-pwd)" = \
> +	     "$(sed -ne \"/^Path:/ s!/gitwc!!\" <actual.info-pwd)"
> +	'
> +
>  test_expect_success 'info --url .' '
>  	test "$(cd gitwc; git svn info --url .)" = "$quoted_svnrepo"
>  	'
> 
