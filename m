From: Jakob Stoklund Olesen <stoklund@2pi.dk>
Subject: Re: git-svn performance
Date: Sun, 19 Oct 2014 07:56:11 -0700
Message-ID: <B5419560-60BC-4228-B1BA-9BAD5E4D58B9@2pi.dk>
References: <CABBCAiv0WXNzo7W9PB_o_enLjtUO_rNRb4UBEqDPeSkBj1k-Ww@mail.gmail.com> <20141019003256.GA18532@dcvr.yhbt.net> <20141019022953.GA6537@dcvr.yhbt.net> <20141019023358.GA2946@dcvr.yhbt.net>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Fabian Schmied <fabian.schmied@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"sam@vilain.net" <sam@vilain.net>,
	"stevenrwalter@gmail.com" <stevenrwalter@gmail.com>,
	"waste.manager@gmx.de" <waste.manager@gmx.de>,
	"amyrick@apple.com" <amyrick@apple.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Oct 19 16:56:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XfruA-000605-31
	for gcvg-git-2@plane.gmane.org; Sun, 19 Oct 2014 16:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbaJSO4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2014 10:56:18 -0400
Received: from sub5.mail.dreamhost.com ([208.113.200.129]:57826 "EHLO
	homiemail-a80.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751979AbaJSO4R convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2014 10:56:17 -0400
X-Greylist: delayed 883 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Oct 2014 10:56:17 EDT
Received: from homiemail-a80.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a80.g.dreamhost.com (Postfix) with ESMTP id 5F5C737A06B;
	Sun, 19 Oct 2014 07:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=2pi.dk; h=references
	:mime-version:in-reply-to:content-type:content-transfer-encoding
	:message-id:cc:from:subject:date:to; s=2pi.dk; bh=CR4yh7lmxtQI6E
	S7o2KaJAnXo30=; b=ComKZC+g1hOnvzJNooev/LWBdIiMlqKC0WJp7UkTITNy7C
	q3rEdYwb0AYlE42z5EEqO+AVExpEvkiE7HsO6RBj4ns65lqx64XcQAjHnB3DdLi4
	cQcZlm1f7aFCs2/h8QNIHAMFkD4vE+7dh21XDi96wpQhircV4cWyisI2nBx64=
Received: from [100.159.216.178] (unknown [172.56.14.52])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: stoklund@2pi.dk)
	by homiemail-a80.g.dreamhost.com (Postfix) with ESMTPSA id 2498E37A020;
	Sun, 19 Oct 2014 07:56:17 -0700 (PDT)
In-Reply-To: <20141019023358.GA2946@dcvr.yhbt.net>
X-Mailer: iPhone Mail (11D257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On Oct 18, 2014, at 19:33, Eric Wong <normalperson@yhbt.net> wrote:
> 
> Eric Wong <normalperson@yhbt.net> wrote:
>> This reduces hash lookups for looking up cache data and will
>> simplify tying data to disk in the next commit.
> 
> I considered the following, but GDBM might not be readily available on
> non-POSIX platforms.  I think the other problem is the existing caches
> are still in memory (whether YAML or Storable) even if disk-backed,
> causing a large amount of memory usage anyways.

If cached_mergeinfo is using too much memory, you can probably drop that cache entirely. IIRC, it didn't give that much of a speed up.

I am surprised that it is using a lot of memory, though. There is only one entry per SVN branch.

> (Both patches on top of Jakob's)
> -------------------------
> Subject: [RFC] git-svn: tie cached_mergeinfo to a GDBM_File store
> 
> This should reduce per-instance memory usage by allowing
> serialization to disk.  Using the existing Memoize::Storable
> or YAML backends does not allow fast lookups.
> 
> GDBM_File should be available in most Perl installations
> and should not pose unnecessary burden
> ---
> perl/Git/SVN.pm | 19 ++++++++++++++++---
> 1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
> index 25dbcd5..3e477c7 100644
> --- a/perl/Git/SVN.pm
> +++ b/perl/Git/SVN.pm
> @@ -14,6 +14,7 @@ use IPC::Open3;
> use Memoize;  # core since 5.8.0, Jul 2002
> use Memoize::Storable;
> use POSIX qw(:signal_h);
> +use Storable qw(freeze thaw);
> 
> use Git qw(
>     command
> @@ -1713,10 +1714,21 @@ sub mergeinfo_changes {
> 
>    # Initialize cache on the first call.
>    unless (defined $cached_mergeinfo) {
> -        $cached_mergeinfo = $self->{cached_mergeinfo} = {};
> +        my %hash;
> +        eval '
> +        require File::Temp;
> +        use GDBM_File;
> +        my $fh = File::Temp->new(TEMPLATE => "mergeinfo.XXXXXXXX");
> +        $self->{cached_mergeinfo_fh} = $fh;
> +        $fh->unlink_on_destroy(1);
> +        tie %hash => "GDBM_File", $fh->filename, GDBM_WRCREAT, 0600;
> +        ';
> +        $cached_mergeinfo = $self->{cached_mergeinfo} = \%hash;
>    }
> 
>    my $cached = $cached_mergeinfo->{$old_path};
> +    $cached = thaw($cached) if defined $cached;
> +
>    if (defined $cached && $cached->[0] == $old_rev) {
>        $old_minfo = $cached->[1];
>    } else {
> @@ -1735,11 +1747,12 @@ sub mergeinfo_changes {
>                $props->{"svn:mergeinfo"};
>            $old_minfo = \%omi;
>        }
> -        $cached_mergeinfo->{$old_path} = [ $old_rev, $old_minfo ];
> +        $cached_mergeinfo->{$old_path} =
> +                    freeze([ $old_rev, $old_minfo ]);
>    }
> 
>    # Cache the new mergeinfo.
> -    $cached_mergeinfo->{$path} = [ $rev, \%minfo ];
> +    $cached_mergeinfo->{$path} = freeze([ $rev, \%minfo ]);
> 
>    my %changes = ();
>    foreach my $p (keys %minfo) {
> -- 
> EW
