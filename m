From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2] improve git svn performance
Date: Wed, 22 Jan 2014 20:25:01 +0000
Message-ID: <20140122202501.GA31356@dcvr.yhbt.net>
References: <1390378103-24392-1-git-send-email-manjian2006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: manjian2006@gmail.com
X-From: git-owner@vger.kernel.org Wed Jan 22 21:25:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W64Mn-0001Mh-8y
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 21:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331AbaAVUZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 15:25:04 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:54567 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788AbaAVUZD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 15:25:03 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A37C51FAAF;
	Wed, 22 Jan 2014 20:25:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1390378103-24392-1-git-send-email-manjian2006@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240854>

manjian2006@gmail.com wrote:
> * perl/Git/SVN.pm
>   Modified according to Eric Wong <normalperson@yhbt.net>
> 
> >Hi, I'm interested in this.  How much did performance improve by
> >(and how many revisions is the repository)>

> Our svn server are built in a LAN,15152 revisions.Not optimized
> git-svn used 10 hours or more to accomplish, while optimized one using
> only 3-4 hours.
> 
> According to some profiling data,_rev_list subroutine and rebuild
> subroutine are consuming a large proportion of time.  So I improve
> _rev_list's performance by memoize its results,and avoid subprocess
> invocation by memoize rebuild subroutine's key data.

Impressive!  Thanks for that info.

> Signed-off-by: manjian2006 <manjian2006@gmail.com>

Real name is preferred by this project, I think.

A proper patch would start something like this:
-------------------------------8<------------------------------------
From: Your Name <manjian2006@gmail.com>
Subject: git-svn: memoize _rev_list and rebuild

According to profile data, _rev_list and rebuild consume a large
portion of time.  Memoize the results of _rev_list and memoize
rebuild internals to avoid subprocess invocation.

When importing 15152 revisions on a LAN, time improved from 10
hours to 3-4 hours.

Signed-off-by: Your Name <manjian2006@gmail.com>
---------------------- a few more comments below -------------------

>  sub rebuild {
>  	my ($self) = @_;
>  	my $map_path = $self->map_path;
>  	my $partial = (-e $map_path && ! -z $map_path);
> -	return unless ::verify_ref($self->refname.'^0');
> +	my $verify_key = $self->refname.'^0';
> +	if (! exists $rebuild_verify_status{$verify_key} || ! defined $rebuild_verify_status{$verify_key} ) {

80 column wrap, please.

However, I think just having a single
"!$rebuild_verify_status{$verify_key}" check is enough, no need for
extra defined/exists checks for %rebuild_verify_status nor %rebuild_status.
Neither of them load untrusted data.

> -	    command_output_pipe(qw/rev-list --pretty=raw --reverse/,
> -				($head ? "$head.." : "") . $self->refname,
> +		command_output_pipe(qw/rev-list --pretty=raw --reverse/,
> +				$key_value,	

Please do not leave trailing whitespace.  Thanks.
