From: Alexey Muranov <alexey.muranov@gmail.com>
Subject: Re: [RFC 0/3] Reflogs for deleted refs: fix breakage and suggest namespace change
Date: Mon, 20 Aug 2012 00:09:16 +0200
Message-ID: <9E4BBC27-5B26-4048-93D4-FE02C550F4E2@gmail.com>
References: <20120719213311.GA20385@sigill.intra.peff.net> <1345310086-20089-1-git-send-email-mhagger@alum.mit.edu> <7vboi8rl2q.fsf@alter.siamese.dyndns.org> <B88EFDF9-0AB6-49AC-87E5-7515B99AE601@gmail.com> <7vehn3rbom.fsf@alter.siamese.dyndns.org> <A15D5621-7EF5-4409-967A-0DA20B007899@gmail.com> <7v1uj2pysd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 00:09:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3DgV-0002PY-HK
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 00:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310Ab2HSWJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 18:09:21 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:53185 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab2HSWJU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Aug 2012 18:09:20 -0400
Received: by eeil10 with SMTP id l10so1601412eei.19
        for <git@vger.kernel.org>; Sun, 19 Aug 2012 15:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=RCl35h1ggzLp+3ouyIgaFz4IbJh2BdlZSupelHBC3MQ=;
        b=bU4yrCfMXh81jlnhXZAoNuSYht0F2ayfnHAmjB1DSOUA8BW+XD1ZVIG8v/ThBjz/Ai
         TJPB5DmgZNUvqLAycDKQoNbyA6tRpNwQpOZC5YkalXu6M8HwTFXr7o2QNOdrRARn/ZG0
         OKTEtREXsNgGkbr2G3t8gj7H8Ws4bO8SBs3K8EnGHKB6VugeUtZbM/Yy3f+4BSMjBT2B
         ikcfDqT6lXBSr4kZmqpFskC9BmG3QBmWqpNPStC8jabpilfbuBuTtmK4HS8UKTV/O98u
         5c71VVjwCdVr5WJJlPz+5Mfvc+L9AlKy+vT/cV2DAZcWsAUICPu5Q/aAyRrImEU4HXBj
         S0kA==
Received: by 10.14.172.193 with SMTP id t41mr6051162eel.25.1345414158899;
        Sun, 19 Aug 2012 15:09:18 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2f10:380:223:12ff:fe56:641a? ([2a01:e35:2f10:380:223:12ff:fe56:641a])
        by mx.google.com with ESMTPS id a7sm36655939eep.14.2012.08.19.15.09.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Aug 2012 15:09:18 -0700 (PDT)
In-Reply-To: <7v1uj2pysd.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203738>

On 19 Aug 2012, at 19:38, Junio C Hamano wrote:

> Alexey Muranov <alexey.muranov@gmail.com> writes:
> 
>> 2. I think that allowing both "next" and "next/foo" complicates
>> the mapping from branch names to file paths, and it does not seem
>> necessary if dead reflogs are moved away to "graveyard" anyway.
> 
> It is unclear why the first two lines above leads to the conclusion
> "it does not seem necessary" (but honestly, I do not particularly
> care).

I thought that the first reason that allowing "next" and "next/foo" seemed necessary was avoiding conflicts with dead reflogs or between dead reflogs.  If dead reflog for "next/foo" is moved away, it will not conflict with a new one for "next".  There remains a problem with a conflict between dead "next/foo" and dead "next".  This can be solved as Jeff suggested by adding special "escape" symbols, or as i suggested below, by keeping reflogs deleted on different occasions in different "timestamp" directories.

>> 3. There remains the question what to do with dead reflogs for
>> different branches having the same name.  Maybe, keep the death
>> date and time under the graveyard directory and not allow the user
>> to delete 2 times in less than 1 second?
>> 
>> /logs/graveyard/yyyy-mm-dd-hhmmss/refs/heads/next/foo
> 
> How would that help us in what way?
> 
> When I ask "git log -g next/foo" for the "next/foo" branch that
> currently exists, I want to see the update history of its tip since
> I created it for the last time, and then an entry that says I
> created it at such and such time.  If I used to have the branch
> before but deleted, then the output should be followed by another
> entry that says I deleted it at such and such time, followed by the
> history of the tip updates.

I only suggested how to resolve conflicts between dead reflogs in graveyard if "next" and "next/foo" cannot coexist.
For example, if first "next/foo" was created and deleted, and then "next" was created and deleted.  It also seems nice to me to have dead reflogs for different identically named branches (created and deleted independently) in separate files.

It is possible to collect the information for "git log -g next/foo" by looking through all "timestamp" subdirectories in graveyard.

-Alexey.