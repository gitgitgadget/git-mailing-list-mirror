From: Jakob Stoklund Olesen <stoklund@2pi.dk>
Subject: Re: git-svn performance
Date: Mon, 20 Oct 2014 06:46:19 -0700
Message-ID: <00E02C52-67BC-461B-BF46-0EEDCFFFDFB1@2pi.dk>
References: <CABBCAiv0WXNzo7W9PB_o_enLjtUO_rNRb4UBEqDPeSkBj1k-Ww@mail.gmail.com> <20141019003256.GA18532@dcvr.yhbt.net> <20141019022953.GA6537@dcvr.yhbt.net> <20141019023358.GA2946@dcvr.yhbt.net> <B5419560-60BC-4228-B1BA-9BAD5E4D58B9@2pi.dk> <20141020011601.GA17345@dcvr.yhbt.net>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Fabian Schmied <fabian.schmied@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"sam@vilain.net" <sam@vilain.net>,
	"stevenrwalter@gmail.com" <stevenrwalter@gmail.com>,
	"waste.manager@gmx.de" <waste.manager@gmx.de>,
	"amyrick@apple.com" <amyrick@apple.com>,
	Hin-Tak Leung <htl10@users.sourceforge.net>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Oct 20 15:46:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgDIA-0006Hy-9i
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 15:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889AbaJTNqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 09:46:31 -0400
Received: from sub5.mail.dreamhost.com ([208.113.200.129]:39707 "EHLO
	homiemail-a81.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752816AbaJTNq0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Oct 2014 09:46:26 -0400
Received: from homiemail-a81.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a81.g.dreamhost.com (Postfix) with ESMTP id 8B2F5A806F;
	Mon, 20 Oct 2014 06:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=2pi.dk; h=references
	:mime-version:in-reply-to:content-type:content-transfer-encoding
	:message-id:cc:from:subject:date:to; s=2pi.dk; bh=RZ/WDWyMSLLoNn
	cJb305EeMHS1A=; b=u91qWQXwAJLeSphTak9Vx1l7k1vfww31F8+bXIHoZwHae3
	nJh4dxAc0NmwHnpocQiDvyDba6w0YK8HBWRD4qMWjQUe56ubndhooZEksZSbnlkY
	eEn4b1Wpokb5gbP2PVocbGglIGAVeNXYFl0Zygv0PxTADz+1BIA9G4OqfkqW8=
Received: from [100.159.216.178] (unknown [172.56.15.153])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: stoklund@2pi.dk)
	by homiemail-a81.g.dreamhost.com (Postfix) with ESMTPSA id CC5FAA806E;
	Mon, 20 Oct 2014 06:46:24 -0700 (PDT)
In-Reply-To: <20141020011601.GA17345@dcvr.yhbt.net>
X-Mailer: iPhone Mail (11D257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On Oct 19, 2014, at 18:16, Eric Wong <normalperson@yhbt.net> wrote:
> 
> Jakob Stoklund Olesen <stoklund@2pi.dk> wrote:
>> If cached_mergeinfo is using too much memory, you can probably drop
>> that cache entirely. IIRC, it didn't give that much of a speed up.
>> 
>> I am surprised that it is using a lot of memory, though. There is only
>> one entry per SVN branch.
> 
> Something like the below?  (on top of your original two patches)
> Pushed to my master @ git://bogomips.org/git-svn.git

Yes, but I think you can remove cached_mergeinfo_rev too. 

Thanks
/Jakob


>    Eric Wong (2):
>          git-svn: reduce check_cherry_pick cache overhead
>          git-svn: cache only mergeinfo revisions
> 
>    Jakob Stoklund Olesen (2):
>          git-svn: only look at the new parts of svn:mergeinfo
>          git-svn: only look at the root path for svn:mergeinfo
> 
> git-svn still seems to have some excessive memory usage problems,
> even independenty of mergeinfo stuff.
> --------------------------8<----------------------------
> From: Eric Wong <normalperson@yhbt.net>
> Date: Mon, 20 Oct 2014 01:02:53 +0000
> Subject: [PATCH] git-svn: cache only mergeinfo revisions
> 
> This should reduce excessive memory usage from the new mergeinfo
> caches without hurting performance too much, assuming reasonable
> latency to the SVN server.
> 
> Cc: Hin-Tak Leung <htl10@users.sourceforge.net>
> Suggested-by: Jakob Stoklund Olesen <stoklund@2pi.dk>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
> perl/Git/SVN.pm | 22 ++++++++--------------
> 1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
> index 171af37..f8a75b1 100644
> --- a/perl/Git/SVN.pm
> +++ b/perl/Git/SVN.pm
> @@ -1713,13 +1713,10 @@ sub mergeinfo_changes {
>    # Initialize cache on the first call.
>    unless (defined $self->{cached_mergeinfo_rev}) {
>        $self->{cached_mergeinfo_rev} = {};
> -        $self->{cached_mergeinfo} = {};
>    }
> 
>    my $cached_rev = $self->{cached_mergeinfo_rev}{$old_path};
> -    if (defined $cached_rev && $cached_rev == $old_rev) {
> -        $old_minfo = $self->{cached_mergeinfo}{$old_path};
> -    } else {
> +    unless (defined $cached_rev && $cached_rev == $old_rev) {
>        my $ra = $self->ra;
>        # Give up if $old_path isn't in the repo.
>        # This is probably a merge on a subtree.
> @@ -1728,19 +1725,16 @@ sub mergeinfo_changes {
>                "directory didn't exist in r$old_rev\n";
>            return {};
>        }
> -        my (undef, undef, $props) =
> -            $self->ra->get_dir($old_path, $old_rev);
> -        if (defined $props->{"svn:mergeinfo"}) {
> -            my %omi = map {split ":", $_ } split "\n",
> -                $props->{"svn:mergeinfo"};
> -            $old_minfo = \%omi;
> -        }
> -        $self->{cached_mergeinfo}{$old_path} = $old_minfo;
> -        $self->{cached_mergeinfo_rev}{$old_path} = $old_rev;
>    }
> +    my (undef, undef, $props) = $self->ra->get_dir($old_path, $old_rev);
> +    if (defined $props->{"svn:mergeinfo"}) {
> +        my %omi = map {split ":", $_ } split "\n",
> +            $props->{"svn:mergeinfo"};
> +        $old_minfo = \%omi;
> +    }
> +    $self->{cached_mergeinfo_rev}{$old_path} = $old_rev;
> 
>    # Cache the new mergeinfo.
> -    $self->{cached_mergeinfo}{$path} = \%minfo;
>    $self->{cached_mergeinfo_rev}{$path} = $rev;
> 
>    my %changes = ();
> -- 
> EW
