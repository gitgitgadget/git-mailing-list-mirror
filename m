X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: fetching packs and storing them as packs
Date: Sat, 28 Oct 2006 12:15:07 -0700
Message-ID: <7vfyd88d6s.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home>
	<4540CA0C.6030300@tromer.org>
	<Pine.LNX.4.64.0610271310450.3849@g5.osdl.org>
	<7v3b99e87c.fsf@assigned-by-dhcp.cox.net>
	<20061028034206.GA14044@spearce.org>
	<Pine.LNX.4.64.0610272109500.3849@g5.osdl.org>
	<7vwt6l9etn.fsf@assigned-by-dhcp.cox.net>
	<20061028072146.GB14607@spearce.org>
	<20061028084001.GC14607@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 28 Oct 2006 19:16:09 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061028084001.GC14607@spearce.org> (Shawn Pearce's message of
	"Sat, 28 Oct 2006 04:40:01 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30390>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gdtet-0006PQ-23 for gcvg-git@gmane.org; Sat, 28 Oct
 2006 21:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964855AbWJ1TPe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 15:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWJ1TPe
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 15:15:34 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:3801 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S932074AbWJ1TPI
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 15:15:08 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061028191507.WFXU28934.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Sat, 28
 Oct 2006 15:15:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id fvFB1V0061kojtg0000000 Sat, 28 Oct 2006
 15:15:12 -0400
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> Shawn Pearce <spearce@spearce.org> wrote:
>> Why not just use create a new flag file?
>> 
>> Lets say that a pack X is NOT eligible to be repacked if
>> "$GIT_DIR/objects/pack/pack-X.keep" exists.
>
> Here's the `git repack -a -d` portion of that.
> Thoughts?

> +	args=--unpacked
> +	active=
> +	if test -d "$PACKDIR"
> +	then
> +		for p in `find "$PACKDIR" -type f -name '*.pack' -print`

This change to run 'find "$PACKDIR"' is fragile when your
$GIT_OBJECT_DIRECTORY has $IFS in it; running "find ." after
"cd" in a subprocess was done very much on purpose to avoid that
issue.  Please don't break it.

> +		do
> +			n=`basename "$p" .pack`
> +			d=`dirname "$p"`
> +			if test -e "$d/$n.keep"
> +			then
> +				: keep
> +			else
> +				args="$args --unpacked=$p"
> +				active="$active $n"
> +			fi
> +		done
> +	fi
> +	if test "X$args" = X--unpacked
> +	then
> +		args='--unpacked --incremental'
> +	fi
>  	;;
>  esac

I do not remember offhand what --incremental meant, but
presumably this is for the very initial "repack" (PACKDIR did
not exist or find loop did not find anything to repack) and the
flag would not make a difference?  Care to explain?

Other than that, the overall structure seems quite sane.

