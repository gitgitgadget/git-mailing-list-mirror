From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: split index: sparse warning
Date: Thu, 01 May 2014 00:44:58 +0100
Message-ID: <53618AFA.6070602@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 01 01:45:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfeBd-0003Zd-1D
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 01:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759651AbaD3XpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 19:45:06 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:53599 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751565AbaD3XpF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 19:45:05 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id D47AC4005AA;
	Thu,  1 May 2014 00:45:03 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 60DC44005A9;
	Thu,  1 May 2014 00:45:03 +0100 (BST)
Received: from [192.168.254.9] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Thu,  1 May 2014 00:45:01 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247801>

Hi Duy,

I haven't looked at your split-index series at all. However, sparse has
nagged me to take a quick squint at the result of the series as it
appears in the 'pu' branch.

In particular, sparse complains thus:

      SP sequencer.c
  sequencer.c:690:49: error: incompatible types for operation (>=)
  sequencer.c:690:49:    left side has type int ( extern [toplevel] *<noident> )( ... )
  sequencer.c:690:49:    right side has type int

... which is fair enough; index_fd is, indeed, a function (pointer) and
not an int file descriptor! The offending code looks like:

683 static void read_and_refresh_cache(struct replay_opts *opts)
684 {
685         static struct lock_file index_lock;
686         hold_locked_index(&index_lock, 0);
687         if (read_index_preload(&the_index, NULL) < 0)
688                 die(_("git %s: failed to read the index"), action_name(opts));
689         refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
690         if (the_index.cache_changed && index_fd >= 0) {
691                 if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
692                         die(_("git %s: failed to refresh the index"), action_name(opts));
693         }
694         rollback_lock_file(&index_lock);
695 }


It seems that, in an earlier commit (33c297aa), index_fd was declared
as a local int variable (hiding the global function) which was then
initialised by a call to hold_locked_index().

I assume that the conditional should be changed to something like:

690         if (the_index.cache_changed && index_lock.fd >= 0) {

... but I haven't spent any time investigating this, so take this
suggestion which a large pinch of salt! :-P

ATB,
Ramsay Jones
