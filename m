From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] patch-ids.c: cache patch IDs in a notes tree
Date: Sat, 11 May 2013 15:41:35 -0700
Message-ID: <CA+55aFzinmXA2HtA3hmN1VVOcLPWedfqJRws0RJMEc1By1VLLg@mail.gmail.com>
References: <9d9e56d323b40fe9ea2a6484e35f0afcd3a3a85b.1368301939.git.john@keeping.me.uk>
	<CA+55aFyn0+Q4CA6yQZipaCRB0w9cW4YpuL3XuxU2JR5QPp98XQ@mail.gmail.com>
	<20130511214900.GF2299@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun May 12 00:41:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbIU0-0001y8-Pe
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 00:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754506Ab3EKWlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 18:41:37 -0400
Received: from mail-vc0-f178.google.com ([209.85.220.178]:41039 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754482Ab3EKWlg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 18:41:36 -0400
Received: by mail-vc0-f178.google.com with SMTP id id13so1296151vcb.37
        for <git@vger.kernel.org>; Sat, 11 May 2013 15:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=XZFAbjKZS4EJw/NEWjdvlN0du9qGRTK6rFRC8YkfdeE=;
        b=DWcN8NuHVmd/TJpVMWFPmlDptOgWd4JwiuAGINvkI7s6EMq54T0V6OnyUusU2vqnfh
         mgcFTZtQtx0VWL1N1fIvECn7giF8hoiF+64h0b3haEJblcKl7diEbzBfEAfxMNF9jz6x
         i1zPVBCvx/Wasv2sznzZkLxocqoQZ4ArmQ0njh+ZOHZ+atKQZ45Y5hI+oATu0/uocPnN
         UXGrLFnUiBXghBrzmjh7O/73TMVQlpAha2ZO/V77lLPukzKmnfiU4tMGFUq1kqVWQEkC
         ImkMbdFQBnlRBDZa4zeGbCWFpo1Wd+zJtGJ2OH+ELI4tOaSJyhNss76+L5geM9JZXeOt
         JbuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=XZFAbjKZS4EJw/NEWjdvlN0du9qGRTK6rFRC8YkfdeE=;
        b=cif3notHO03X1DtSMPugxRMGsu2bkG0GLU1fVlrXofXPf/eeDPjbdzZoS8dZRGRRZr
         Y2/u/3OHQ//A9ywuXn9wPWdwCJYmUASges6oqS3koKUXK19C+LdA1bzWTVn9TAAZGXZd
         m0B5YX7rCFsDL9BhVQt9HAGlDZQdUevCW6VTY=
X-Received: by 10.52.95.39 with SMTP id dh7mr12845574vdb.26.1368312095691;
 Sat, 11 May 2013 15:41:35 -0700 (PDT)
Received: by 10.220.8.71 with HTTP; Sat, 11 May 2013 15:41:35 -0700 (PDT)
In-Reply-To: <20130511214900.GF2299@serenity.lan>
X-Google-Sender-Auth: xo1HR84Zh6gLRaRQv8mo6WkUI9g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224018>

On Sat, May 11, 2013 at 2:49 PM, John Keeping <john@keeping.me.uk> wrote:
>
> Hmm... I hadn't realised that.  Looking a bit closer, it looks like
> init_patch_ids sets up its own diffopts so its not affected by the
> command line (except for pathspecs which would be easy to check for).
> Of course that still means it can be affected by settings in the user's
> configuration.

.. and in the actual diff algorithm.

The thing is - patches ARE NOT STABLE. There are many valid ways to
get a patch from one version to another, and even without command line
changes, we've had different versions of git generating different
patches. There are heuristics in xdiff to avoid some nasty "use up
tons of CPU-time" things that have been tweaked over time. And even
for simple cases there are ambiguous ways to describe the patch.

Now, maybe we don't care, because in practice, most of the time this
just doesn't much matter. And anybody who uses patch-ID's had better
not rely on them being guaranteed to be unique anyway, so it's more of
a "if the patch ID is the same, it's almost guaranteed to be the same
patch", but that's a big "almost". And no, it's not some theoretical
"SHA1 collisions are very unlikely" kind of thing, it's a "the patch
ID actually ignores a lot of data in order to give the same ID even if
lins have been added above it, and the patch is at different line
numbers etc".

So maybe it doesn't matter. But at the same time, I really think
caching patch ID's should be something people should be aware of is
fundamentally wrong, even if it might work.

And quite frankly, if you do rebases etc so much that you think patch
ID's are so important that they need to be cached, you may be doing
odd/wrong things.

             Linus
