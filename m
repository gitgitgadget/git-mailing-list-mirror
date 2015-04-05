From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH 0/2] git-p4: Improve client path detection
Date: Sun, 5 Apr 2015 23:57:59 +0100
Message-ID: <20150405235759.392c0f2b@pt-vhugo>
References: <1427545730-3563-1-git-send-email-vitor.hda@gmail.com>
	<55218C8F.209@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Apr 06 00:59:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YetVo-0008O1-2e
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 00:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbbDEW7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2015 18:59:13 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35571 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbbDEW7M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2015 18:59:12 -0400
Received: by widdi4 with SMTP id di4so16703285wid.0
        for <git@vger.kernel.org>; Sun, 05 Apr 2015 15:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=COxTrWrAM+sCJnNmCo3xOgD+QmjLIO9Zf0Ji1KKSIhs=;
        b=N/cEd9qGHzRzxp/qILNd9V+NCn2Xlapttnoq8QEMOF+o94gx+St59Uhtk/Mfz4df+P
         YuEGSrDvJ0gdN88GGY1ddC9EyrKZcAo9CtagYKa/xWFu4lt+ruifiSih5yL+zKHjIe8f
         E+FFzy1UwDmYMkLF5o+ttjXKGfjMa7KjaOJ55+S3+eD/VfD2aXNWocEAGWzE9wHAZUY1
         BkpZpMfx2AXpJDzwpzsZ+qASVdYrFihv9xFZFa3Osl4E2ni1aaGR69GghgBEbEe6SiMT
         txK2zN27wAHvkl/HBY/002fGFeEKuFLg4tV83TgSRKqp4l4odFo/S7O5E9VJXdR3QjFz
         3hHg==
X-Received: by 10.194.63.172 with SMTP id h12mr25337974wjs.48.1428274750476;
        Sun, 05 Apr 2015 15:59:10 -0700 (PDT)
Received: from pt-vhugo (88.41.108.93.rev.vodafone.pt. [93.108.41.88])
        by mx.google.com with ESMTPSA id bp1sm4044808wjb.31.2015.04.05.15.59.09
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Sun, 05 Apr 2015 15:59:10 -0700 (PDT)
In-Reply-To: <55218C8F.209@diamand.org>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266824>

Luke Diamand <luke@diamand.org> wrote on Sun, 05 Apr 2015 20:27:11 +0100
> On 28/03/15 12:28, Vitor Antunes wrote:
> > I'm adding a test case for a scenario I was confronted with when using branch
> > detection and a client view specification. It is possible that the implemented
> > fix may not cover all possible scenarios, but there is no regression in the
> > available tests.
>
> Vitor, one thing I wondered about with this part of the change:
>
> -            if entry["depotFile"] == depotPath:
> +            if entry["depotFile"].find(depotPath) >= 0:
>
> Does this mean that if 'p4 where' produces multiple lines of output that
> this will get confused, as it's just going to search for an instance of
> depotPath.

The reason why I introduced that was because in the test case I implemented (and
which reflects a scenario I am confronted with in my workplace) the branches
have a base directory that is removed in the client view mapping.
As such, we will have a situation where depotPath is //depot/branch1/ while
runninng "p4 where" will result in //depot/branch1/base/. To overcome this I
used find() instead of a direct comparison. Now that I think about that, I could
probably have used the simpler `if depotPath in entry["depotFile"]`...

> The example in the Perforce man page for 'p4 where' would trigger this
> for example:
>
> http://www.perforce.com/perforce/r14.2/manuals/cmdref/p4_where.html
>
> -//a/b/file.txt //client/a/b/file.txt //home/user/root/a/b/file.txt
> //a/b/file.txt //client/b/file.txt /home/user/root/b/file.txt

These are examples where a simple comparison as was implemented would work.

> As an experiment, I hacked git-p4 to always use p4Where rather than
> getClientRoot(), which I would have thought ought to work, but while
> most of the tests passed, Pete's client-spec torture tests failed.

That was exactly my first approach and got to the same conclusion. I would have
investigated it further but since I haven't had much free time to invest in
solving this problem I decided to implement an intermediary solution that would
not introduce any regressions.

Vitor
