From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v4] Allow update hooks to update refs on their own.
Date: Sun, 2 Dec 2007 23:01:09 -0500
Message-ID: <20071203040108.GS14735@spearce.org>
References: <7vr6i8sfsa.fsf@gitster.siamese.dyndns.org> <20071202212224.GA22117@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 05:01:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz2VF-0000qI-KX
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 05:01:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392AbXLCEBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 23:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752361AbXLCEBN
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 23:01:13 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41676 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbXLCEBN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 23:01:13 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iz2UN-0007qw-80; Sun, 02 Dec 2007 23:00:59 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5A16320FBAE; Sun,  2 Dec 2007 23:01:09 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20071202212224.GA22117@midwinter.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66855>

Steven Grimm <koreth@midwinter.com> wrote:
> This is useful in cases where a hook needs to modify an incoming commit
> in some way, e.g., fixing whitespace errors, adding an annotation to
> the commit message, noting the location of output from a profiling tool,
> or committing to an svn repository using git-svn.
...
> +/* Update hook exit code: hook has updated ref on its own */
> +#define EXIT_CODE_REF_UPDATED 100

Hmm.  I would actually rather move the ref locking to before we run
the update hook, so the ref is locked *while* the hook executes.
If we ran a hook and it exited 0 then re-read the ref to see if the
value differs from old_sha1; if it does then we can assume the update
hook took care of the update.  If the value is still old_sha1 then we
know the hook didn't do the update and we need to do it for the hook.

This probably requires exporting the name of the ref we currently
have locked in an environment variable (and teach lockfile.c it)
so we can effectively do recursive locking.  That way the update
hook can still use git-update-ref to change the ref safely.

The advantage of this approach is the hook programmer doesn't need
to implement their own locking scheme and we also don't make a
special case exit code where there wasn't one before.

-- 
Shawn.
