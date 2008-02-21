From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFH] index_name_exists() conversion
Date: Thu, 21 Feb 2008 08:15:22 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802210806540.7833@woody.linux-foundation.org>
References: <7v7igywvnj.fsf@gitster.siamese.dyndns.org> <7vy79evfsn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 17:23:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSECj-0001F9-2M
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 17:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932905AbYBUQWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 11:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932834AbYBUQWU
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 11:22:20 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56060 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932699AbYBUQWQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Feb 2008 11:22:16 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1LGFN9C011337
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Feb 2008 08:15:24 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1LGFMPE029983;
	Thu, 21 Feb 2008 08:15:23 -0800
In-Reply-To: <7vy79evfsn.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.238 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74627>



On Thu, 21 Feb 2008, Junio C Hamano wrote:
>
>          struct dir_entry *dir_add_name(struct dir_struct *dir, const c...
>          {
>         -	if (cache_name_pos(pathname, len) >= 0)
>         +	if (cache_name_exists(pathname, len))
>                         return NULL;
> 
>                 ALLOC_GROW(dir->entries, dir->nr+1, dir->alloc);
> 
> This used to check if there is a stage#0 entry of that name in
> the index.  But the name-hash based index look-up does not care
> about the stage as far as I can tell.

I think the new code is much more correct, and we should always care about 
whether the name exists in the index, not whether it exists in stage#0.

IOW, if we ask for "show other files", we definitely want to ignore 
paths we already know about, and conversely, if we do an operation that is 
supposed to care about files in a directory we already know about, then an 
unmerged entry should count the same as a merged one.

> This could be related to the recent "status segfaults, bisected
> to cf558704" issue posted to the list.  I dunno.

Is there a backtrace for that? It's certainly possible that some strange 
path depended on only matching merged entries, but I would consider that 
unlikely and buggy.

The segfault is more likely related to something more subtle, like 
actually freeing a "cache_entry" after having removed it from the index 
(which we should never do - they were always supposed to stay around 
because they might not have been allocated with 'malloc()' in the first 
place, but with the name indexing thing it now is *always* a bug to do it, 
even if you _did_ allocate it with free()).

(Also, some code used to just reuse the same cache entry multiple times, 
and that got illegal for the same reason).

		Linus
