From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: SP in committer line in fast-import stream
Date: Mon, 18 Jul 2011 16:57:52 +0000 (UTC)
Message-ID: <loom.20110718T184404-335@post.gmane.org>
References: <CAE3X6mwJquoHj06FVGTsg0qtzyTwbd6gNqy7J4yWiVF-+p-23Q@mail.gmail.com> <loom.20110718T172927-173@post.gmane.org> <CAE3X6mxbMBwd5O+md0J3M6DUu38Q1uzDHNhAU7iGbqYVm2TyRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 18:58:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qir94-0002AX-Dm
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 18:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473Ab1GRQ6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 12:58:09 -0400
Received: from lo.gmane.org ([80.91.229.12]:57987 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753155Ab1GRQ6I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 12:58:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Qir8t-00026j-Ab
	for git@vger.kernel.org; Mon, 18 Jul 2011 18:58:03 +0200
Received: from dhcp249-230.yandex.net ([87.250.249.230])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 18:58:03 +0200
Received: from divanorama by dhcp249-230.yandex.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 18:58:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.250.249.230 (Opera/9.80 (X11; Linux x86_64; U; en) Presto/2.9.168 Version/11.50)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177386>

SASAKI Suguru <sss.sonik <at> gmail.com> writes:

> >
> > The shortest fix is to read documentation as
> > 'committer' SP <name> SP LT <email> GT SP <when> LF
> 
> Thanks.  I understand what happens.
> For now, I'll write some wrapper around git-fast-import as a workaound for 
this.
> 
> But, if git-fast-import successfully import and git-fsck will confuse,
> aren't some fixes necessary?
> It might be too done if git-fast-import will check as if git-fsck does,
> but I think some simple checks will help us.
> 
> Any comments?
One patch is at the bottom, it makes fast-import behave well on proper input 
streams like yours.
Making fast-import stricter is worthy but will be a larger patch and effort. 
I'll try not to forget about and at least to write some failing tests.

> 
> Regards,
> 

Name cannot contain LT or GT and ident comes after SP in fast-import. So 
pretend there was a <empty name> SP if there is no name at all.

Parsing isn't strict still.
diff --git a/fast-import.c b/fast-import.c
index 78d9786..91a90e2 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1971,6 +1971,9 @@ static char *parse_ident(const char *buf)
        size_t name_len;
        char *ident;
 
+       /* ensure there is a space delimiter even if there is no name */
+       if (*buf == '<')
+               --buf;
        gt = strrchr(buf, '>');
        if (!gt)
                die("Missing > in ident string: %s", buf);
