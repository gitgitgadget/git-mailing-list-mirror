From: Brian Gesiak <modocache@gmail.com>
Subject: [GSoC14][RFC] Proposal Draft: Refactor tempfile handling
Date: Sun, 2 Mar 2014 06:04:39 +0900
Message-ID: <CAN7MxmVQuk96dmXfxZ5kRZPTXNwpz2RY=y8HyqX4mZzrZUVbNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 22:05:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJr5s-00006e-Bs
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 22:05:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228AbaCAVEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 16:04:40 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:35765 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbaCAVEk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 16:04:40 -0500
Received: by mail-ie0-f180.google.com with SMTP id as1so251758iec.39
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 13:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=QzaXg2PrYVUmjizSKuW6MqOf1alPgpzadotMQZCfdUM=;
        b=das5H6lqP2/a6q/hMQSHPGn3egmdK8wOT/mofw9oo6L4bya9SME2dFN7zS2u9ipT7C
         9JZlyAuMkmoAyTwJqaWMUlyfSf1mCxbTUbG0o4QZ9FI9xwzv8Nyu3l+4UvQD7tFsvI6M
         3nFEAlRg88dXg3jApMbs5NIdYUNePX2kl3qF+Nj1ZwYVvtYElojVFZfKsmv7NgLXfmgr
         SYMHemoFCIIrzKvwQFETW1O3BkQ/xxHmJ27HPecIKmrH92IulBF4LYzmZ9MjapSvcsou
         mW19Ie+F2H4a1PZUMTf5KgHaxBfHm2zYTcrtskWXk6kHYNwyPi3iQ2NhNjliyi/rlU+s
         l5Jw==
X-Received: by 10.50.93.106 with SMTP id ct10mr12694338igb.21.1393707879581;
 Sat, 01 Mar 2014 13:04:39 -0800 (PST)
Received: by 10.64.55.161 with HTTP; Sat, 1 Mar 2014 13:04:39 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243110>

Hello all,

My name is Brian Gesiak. I'm a research student at the University of
Tokyo, and I'm hoping to participate in this year's Google Summer of
Code by contributing to Git. I'm a longtime user, first-time
contributor--some of you may have noticed my "microproject"
patches.[1][2]

I'd like to gather some information on one of the GSoC ideas posted on
the ideas page. Namely, I'm interested in refactoring the way
tempfiles are cleaned up.

The ideas page points out that while lock files are closed and
unlinked[3] when the program exits[4], object pack files implement
their own brand of temp file creation and deletion. This
implementation doesn't share the same guarantees as lock files--it is
possible that the program terminates before the temp file is
unlinked.[5]

Lock file references are stored in a linked list. When the program
exits, this list is traversed and each file is closed and unlinked. It
seems to me that this mechanism is appropriate for temp files in
general, not just lock files. Thus, my proposal would be to extract
this logic into a separate module--tempfile.h, perhaps. Lock and
object files would share the tempfile implementation.

That is, both object and lock temp files would be stored in a linked
list, and all of these would be deleted at program exit.

I'm very enthused about this project--I think it has it all:

- Tangible benefits for the end-user
- Reduced complexity in the codebase
- Ambitious enough to be interesting
- Small enough to realistically be completed in a summer

Please let me know if this seems like it would make for an interesting
proposal, or if perhaps there is something I am overlooking. Any
feedback at all would be appreciated. Thank you!

- Brian Gesiak

[1] http://thread.gmane.org/gmane.comp.version-control.git/242891
[2] http://thread.gmane.org/gmane.comp.version-control.git/242893
[3] https://github.com/git/git/blob/v1.9.0/lockfile.c#L18
[4] https://github.com/git/git/blob/v1.9.0/lockfile.c#L143
[5] https://github.com/git/git/blob/v1.9.0/pack-write.c#L350
