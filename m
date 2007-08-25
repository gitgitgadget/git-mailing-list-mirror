From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Don't segfault if we failed to inflate a packed delta
Date: Sat, 25 Aug 2007 08:19:17 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708250815150.25853@woody.linux-foundation.org>
References: <20070825072604.GA20155@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 25 17:20:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOxR8-0003mp-P8
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 17:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbXHYPT5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 11:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbXHYPT4
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 11:19:56 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47944 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751049AbXHYPT4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2007 11:19:56 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7PFJIq0004191
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 25 Aug 2007 08:19:19 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7PFJHSH018986;
	Sat, 25 Aug 2007 08:19:18 -0700
In-Reply-To: <20070825072604.GA20155@spearce.org>
X-Spam-Status: No, hits=-4.75 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.28__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56641>



On Sat, 25 Aug 2007, Shawn O. Pearce wrote:
> 
> cate on #git noticed this failure in `git fsck --full` where the
> call to verify_pack() first noticed that the packfile was corrupt
> by finding that the packfile's SHA-1 did not match the raw data of
> the file.  After finding this fsck went ahead and tried to verify
> every object within the packfile, even though the packfile was
> already known to be bad.  If we are going to shovel bad data at
> the delta unpacking code, we better handle it correctly.

Hmm. We should actually make "unpack_entry()" return print an error and 
return NULL for these cases, rather than die, I think.

Most of the callers seem to already check for NULL (not "load_tree()" in 
fast-import.c), but for something like fsck, while "die()" is obviously 
better than a SIGSEGV, we should probably continue and try to see what 
else we find.

(Although, to be honest, it might not matter. If your pack-file is corrupt 
enough for this to trigger, there's seldom anything interesting fsck will 
tell, so in practical terms this probably isn't a big deal).

		Linus
