From: Junio C Hamano <junkio@twinsun.com>
Subject: Re: [RFC PATCH] cogito --- don't overwrite metadata files in place (breaks CoW use)
Date: Tue, 12 Jul 2005 21:37:00 +0000 (UTC)
Message-ID: <loom.20050712T233332-364@post.gmane.org>
References: <20050712190552.GA7178@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jul 12 23:45:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsSYP-0007mr-EK
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 23:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbVGLVn7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 17:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbVGLVjW
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 17:39:22 -0400
Received: from main.gmane.org ([80.91.229.2]:38033 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262373AbVGLVhU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2005 17:37:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DsSRI-0006UR-OY
	for git@vger.kernel.org; Tue, 12 Jul 2005 23:37:16 +0200
Received: from ip-66-80-53-59.lax.megapath.net ([66.80.53.59])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Jul 2005 23:37:16 +0200
Received: from junkio by ip-66-80-53-59.lax.megapath.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Jul 2005 23:37:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 66.80.53.59 (Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.8) Gecko/20050511 Firefox/1.0.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Chris Wedgwood <cw <at> f00f.org> writes:

>  if [ "$newhead" ]; then
>  	echo "Committed as $newhead."
> -	echo $newhead >$_git/HEAD
> +	echo_to_file $newhead $_git/HEAD
>  	[ "$merging" ] && rm $_git/merging $_git/merging-sym $_git/merge-base

Good intentions, but wouldn't the above clobber symlinked HEAD?

Not a fundamental flaw, though.  You need to see if it is a symlink,
readlink it (repeatedly until you get a regular file or dangling symlink
target that does not exist --- immediately after git-init-db has such a
HEAD) and run your echo_to_file on the link target.
