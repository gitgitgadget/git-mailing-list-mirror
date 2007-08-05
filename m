From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: possible bug in git apply?
Date: Sat, 4 Aug 2007 21:48:08 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708042141510.5037@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0708041243070.6905@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, rob@landley.net
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sun Aug 05 06:48:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHY2q-0003JK-TK
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 06:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbXHEEse (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 00:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751664AbXHEEse
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 00:48:34 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34162 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751612AbXHEEsd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 00:48:33 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l754mEa9001648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 4 Aug 2007 21:48:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l754m8uP025255;
	Sat, 4 Aug 2007 21:48:09 -0700
In-Reply-To: <Pine.LNX.4.64.0708041243070.6905@asgard.lang.hm>
X-Spam-Status: No, hits=-2.722 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54943>



On Sat, 4 Aug 2007, david@lang.hm wrote:
>
> since git doesn't track directories, only content (per the big discussion
> recently) I beleive that doing a checkout would leave Rob without the
> directories that he emptied out, so shouldn't git apply also clear the
> directories to end up in the same state?

It should. I thought we did that, but maybe there's some bug there.

See "remove_file()" in builtin-apply.c.

But yeah, it seems that the file *rename* ends up not triggering that 
logic! Very annoying.

Does this fix it? Totally untested, but it _looks_ obvious enough..

		Linus

---
diff --git a/builtin-apply.c b/builtin-apply.c
index 0a0b4a9..da27075 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2508,7 +2508,7 @@ static void write_out_one_result(struct patch *patch, int phase)
 	 * thing: remove the old, write the new
 	 */
 	if (phase == 0)
-		remove_file(patch, 0);
+		remove_file(patch, patch->is_rename);
 	if (phase == 1)
 		create_file(patch);
 }
