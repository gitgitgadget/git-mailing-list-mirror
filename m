From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git-commit fatal: Out of memory? mmap failed: Bad file descriptor
Date: Tue, 15 Jan 2008 13:43:22 -0600
Message-ID: <478D0CDA.5050709@nrlssc.navy.mil>
References: <4787E981.7010200@nrlssc.navy.mil> <478C1D7A.6090103@nrlssc.navy.mil> <alpine.LFD.1.00.0801142140560.2806@woody.linux-foundation.org> <478CECAB.2030906@nrlssc.navy.mil> <alpine.LFD.1.00.0801150931260.2806@woody.linux-foundation.org> <478CFAFF.6010006@nrlssc.navy.mil> <alpine.LFD.1.00.0801151036110.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, drafnel@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	=?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 15 20:45:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEria-0000Fi-O0
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 20:45:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbYAOTod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 14:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbYAOTod
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 14:44:33 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:49716 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097AbYAOToc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 14:44:32 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0FJhM4J014875;
	Tue, 15 Jan 2008 13:43:24 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 15 Jan 2008 13:43:22 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <alpine.LFD.1.00.0801151036110.2806@woody.linux-foundation.org>
X-OriginalArrivalTime: 15 Jan 2008 19:43:22.0373 (UTC) FILETIME=[E2F59350:01C857AE]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15666001
X-TM-AS-Result: : Yes--10.957400-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1NzA0Mi03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwNzc2MC03MTE5NTMtNzAxNDU1LTE4NjAzNS03?=
	=?us-ascii?B?MDIwMjAtNzAyMTU3LTEzNzcxNy03MDEwMDUtNzA5MDUwLTcwMDM5?=
	=?us-ascii?B?OC03MDEwNTMtNzA0NDI1LTcwMDk3MS03MDU3MTgtNzAxMjAyLTcw?=
	=?us-ascii?B?NjY0OS03MDQyNTctMTg4MDE5LTcwNjI5MC03MDQ3NDctMTQ4MDM5?=
	=?us-ascii?B?LTE0ODA1MS0yMDA0MA==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70543>

Linus Torvalds wrote:
> 
> On Tue, 15 Jan 2008, Brandon Casey wrote:
>> Linus Torvalds wrote:
>>> It would obviously be interesting to see the base repository and the 
>>> commit you are trying to do - is that possibly publicly available?
>> I wish it was.
> 
> It's ok, I found the bug in your full strace.

Good catch, but that wasn't it. Still getting the same error.

> and now it's trying to close that fd *again*

In that same vein, just above your changes in prepare_index() is:

	if (!pathspec || !*pathspec) {
		fd = hold_locked_index(&index_lock, 1);
		refresh_cache(REFRESH_QUIET);
		if (write_cache(fd, active_cache, active_nr) ||
		    close(fd) || commit_locked_index(&index_lock))
			die("unable to write new_index file");
		commit_style = COMMIT_AS_IS;
		return get_index_file();
	}

If I followed hold_locked_index() correctly, then fd and index_lock.fd
are equal, and commit_locked_index() does a close(lk->fd) making the
close(fd) above, redundant (or vice-versa).

Probably not causing the error at hand, but not good.

-brandon


diff --git a/builtin-commit.c b/builtin-commit.c
index 1e55c2e..3b4f4e2 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -256,7 +256,7 @@ static char *prepare_index(int argc, const char **argv, cons
		fd = hold_locked_index(&index_lock, 1);
		refresh_cache(REFRESH_QUIET);
		if (write_cache(fd, active_cache, active_nr) ||
-		    close(fd) || commit_locked_index(&index_lock))
+		    commit_locked_index(&index_lock))
			die("unable to write new_index file");
		commit_style = COMMIT_AS_IS;
		return get_index_file();
