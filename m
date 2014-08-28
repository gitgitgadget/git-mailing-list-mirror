From: Dan Lenski <dlenski@gmail.com>
Subject: Re: git stash doesn't always save work dir as-is: bug?
Date: Thu, 28 Aug 2014 02:54:26 +0000 (UTC)
Message-ID: <loom.20140828T044432-503@post.gmane.org>
References: <201309080040.r880ePlr094459@elf.torek.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 05:00:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMpwb-0001f8-78
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 05:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936174AbaH1DAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 23:00:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:50439 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932597AbaH1DAG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 23:00:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1XMpwR-0001Xl-C8
	for git@vger.kernel.org; Thu, 28 Aug 2014 05:00:03 +0200
Received: from jfdmzpr05-ext.jf.intel.com ([134.134.139.74])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Aug 2014 05:00:03 +0200
Received: from dlenski by jfdmzpr05-ext.jf.intel.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Aug 2014 05:00:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 134.134.139.74 (Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.153 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256070>

Chris Torek <chris.torek <at> gmail.com> writes:

> 
> When "git stash" does its work, if the index and the work
> directory are out of sync, but the work directory is in sync with
> the HEAD commit, the work directory commit does not contain the
> file in its work-directory state, but rather in its index-state.

I too encountered this bug while trying to design a custom pre-commit hook 
that would speculatively change the working tree and then "stash pop" its 
changes. Chris Torek alerted me to it on StackOverflow: 
http://stackoverflow.com/questions/25536034/modifying-working-directory-and-
staging-area-temporarily-in-git-pre-commit-hook

Another small issue I had in solving the same problem: there's no way to 
tell if "git stash save" has created a new stash or not, so it's hard to 
figure out whether one should be popped later.

It would be helpful if there were a specific non-zero return code assigned 
when no stash was generated due to no changes requiring it. Here's a simple 
patch for that:

--- a/git-stash
+++ b/git-stash
@@ -220,8 +220,7 @@ save_stash () {
        git update-index -q --refresh
        if no_changes
        then
-               say "$(gettext "No local changes to save")"
-               exit 0
+               die_with_status 9 "$(gettext "No local changes to save")"
        fi
        test -f "$GIT_DIR/logs/$ref_stash" ||
                clear_stash || die "$(gettext "Cannot initialize stash")"

Thanks,
Dan
