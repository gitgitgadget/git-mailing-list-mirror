From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Improve "git grep" flags handling
Date: Mon, 12 Sep 2005 16:46:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509121635060.3266@g5.osdl.org>
References: <Pine.LNX.4.58.0509121203210.4098@g5.osdl.org>
 <7vbr2y7yfd.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509121500400.3266@g5.osdl.org>
 <Pine.LNX.4.58.0509121519310.3266@g5.osdl.org> <7vd5nd7w0x.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0509121542050.3266@g5.osdl.org> <7vslw96f6j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 13 01:48:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEy1E-00041W-T8
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 01:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbVILXrA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 19:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbVILXrA
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 19:47:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3243 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932363AbVILXq7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 19:46:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8CNktBo031500
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Sep 2005 16:46:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8CNkrhX028864;
	Mon, 12 Sep 2005 16:46:55 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslw96f6j.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8452>



On Mon, 12 Sep 2005, Junio C Hamano wrote:
> 
> Yeah, let's see how tolerant your barf-o-meter is today.

I'm not barfing, but that's probably because my brain just shut down and 
is desperately trying to gouge my eyes out with a spoon.

Wouldn't it be _much_ nicer to just do

	pattern=
	flags=()
	git_flags=()
	while : ; do
		case "$1" in
		--cached|--deleted|--others|--killed|\
		--ignored|--exclude=*|\
		--exclude-from=*|\--exclude-per-directory=*)
			git_flags=("${git_flags[@]}" "$1")
			;;
		-e)
			pattern="$2"
			shift
			;;
		-A|-B|-C|-D|-d|-f|-m)
			flags=("${flags[@]}" "$1" "$2")
			shift
			;;
		--)
			shift
			break
			;;
		-*)
			flags=("${flags[@]}" "$1")
			;;
		*)
			if [ -z "$pattern" ]; then
				pattern="$1"
				shift
			fi
			break
			;;
		esac
		shift
	done
	git-ls-files -z "${git_flags[@]}" | 
		xargs -0 grep "${flags[@]}" "$pattern"

which does use bash array variables, but dang, it does so for a reason: 
they really are very very useful, and they make it _so_ much more pleasant 
to do these things..

		Linus
