From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH] builtin-commit: fix partial-commit support
Date: Mon, 19 Nov 2007 11:47:35 -0500
Message-ID: <1195490855.16221.2.camel@hinata.boston.redhat.com>
References: <1195381287-26823-1-git-send-email-gitster@pobox.com>
	 <1195381287-26823-2-git-send-email-gitster@pobox.com>
	 <1195381287-26823-3-git-send-email-gitster@pobox.com>
	 <1195381287-26823-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 17:58:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu9xP-000667-Jv
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 17:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbXKSQ61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 11:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbXKSQ60
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 11:58:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45579 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751861AbXKSQ60 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 11:58:26 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lAJGlgjQ006384;
	Mon, 19 Nov 2007 11:47:42 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lAJGlfcp032414;
	Mon, 19 Nov 2007 11:47:41 -0500
Received: from [192.168.1.100] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lAJGlfcl018611;
	Mon, 19 Nov 2007 11:47:41 -0500
In-Reply-To: <1195381287-26823-4-git-send-email-gitster@pobox.com>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65468>

On Sun, 2007-11-18 at 02:21 -0800, Junio C Hamano wrote:
> When making a partial-commit, we need to prepare two index
> files, one to be used to write out the tree to be committed
> (temporary index) and the other to be used as the index file
> after the commit is made.
> 
> The temporary index needs to be initialized to HEAD and then all
> the named paths on the command line need to be staged on top of
> the index.  For this, running add_files_to_cache() that compares
> what is in the index and the paths given from the command line
> is not enough -- the comparison will miss the paths that the
> user previously ran "git add" to the index since the HEAD
> because the index reset to the HEAD would not know about them.
> The index file needs to get the same modification done when
> preparing the temporary index as described above.
> 
> This implementation mimics the behaviour of the scripted
> version of git-commit.  It first runs overlay_tree_on_cache(),
> which was stolen from ls-files with the earlier change, to get
> the list of paths that the user can potentially mean, and then
> uses pathspec_match() to find which ones the user meant.  This
> list of paths is used to update both the temporary and the real
> index file.

Oh boy, this turns out to be much more involved than what I thought.
Thanks for fixing up this part of builtin-commit.

> Additionally:
> 
>  - remove the temporary index file .git/next-index-* after
>    commit is done or aborted.

Hmm, I see the left-over next-index-* files too, but I though the lock
file would be cleaned up automatically by the atexit handler?

cheers,
Kristian
