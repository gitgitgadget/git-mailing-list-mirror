From: Junio C Hamano <junkio@cox.net>
Subject: Re: Improve "git grep" flags handling
Date: Mon, 12 Sep 2005 16:26:28 -0700
Message-ID: <7vslw96f6j.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0509121203210.4098@g5.osdl.org>
	<7vbr2y7yfd.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509121500400.3266@g5.osdl.org>
	<Pine.LNX.4.58.0509121519310.3266@g5.osdl.org>
	<7vd5nd7w0x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509121542050.3266@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 13 01:27:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EExhI-0006he-P9
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 01:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbVILX0d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 19:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbVILX0d
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 19:26:33 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:10960 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932357AbVILX0c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2005 19:26:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050912232629.OOFH20473.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Sep 2005 19:26:29 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509121542050.3266@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 12 Sep 2005 15:43:52 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8451>

Linus Torvalds <torvalds@osdl.org> writes:

> Good point. However, since it's unlikely that anybody will use it, maybe 
> it's not important - more of a "this is how you could do it if you fixed 
> the globbing problem" ;)

Yeah, let's see how tolerant your barf-o-meter is today.  This
would make even *me* barf ;-), but it sometimes may be useful to
be able to say:

    git grep --others --exclude='*.[oa]' '@@GIT_'

------------
#!/bin/sh

# git grep <flags>... <pattern> <path>...

{
    # Pick ls-files arguments only.
    first=yes skip=no pattern_found=no
    for x
    do
	case "$skip" in yes) skip=no; continue ;; esac 
    	case "$x" in
	--cached|--deleted|--others|--killed|--ignored|--exclude=*|\
	--exclude-from=*|\--exclude-per-directory=*)
		test 'yes' = "$first" && set x
		set "$@" "$x"
		first=no
		;;
	-A|-B|-C|-D|-d|-f|-m)
		skip=yes
		;;
	-e)
		skip=yes
		pattern_found=yes
		;;
	-*)
		;;
	*)
		case "$pattern_found" in
		yes)
			test 'yes' = "$first" && set x
			set "$@" "$x"
			;;
		no)
			;; # not for us, but for grep
		esac
		;;
	esac
    done
    case "$first" in
    yes) # we did not get *any* ls-files parameter.
    	set x ;;
    esac
    shift
    git-ls-files -z "$@"
} | {
    first=yes eat=no pattern_found=no
    for x
    do
	case "$eat" in
	yes)
		eat=no;
		set "$@" "$x"
		continue
		;;
	esac 
    	case "$x" in
	--cached|--deleted|--others|--killed|--ignored|--exclude=*|\
	--exclude-from=*|\--exclude-per-directory=*)
		;;
	-A|-B|-C|-D|-d|-f|-m)
		test 'yes' = "$first" && set x
		set "$@" "$x"
		first=no
		eat=yes
		;;
	-e)
		test 'yes' = "$first" && set x
		set "$@" "$x"
		eat=yes
		pattern_found=yes
		;;
	-*)
		test 'yes' = "$first" && set x
		set "$@" "$x"
		first=no
		;;
	*)
		case "$pattern_found" in
		yes)
			;; # not for us, but for ls-files
		no)
			test 'yes' = "$first" && set x
			set "$@" "$x"
			pattern_found=yes
		esac
		;;
	esac
    done
    case "$eat,$pattern_found" in
    yes,* | *,no)
    	echo >&2 "* malformed grep parameters"
	exit 1
    esac
    shift
    xargs -0 grep "$@"
}
