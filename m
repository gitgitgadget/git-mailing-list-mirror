From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] xread(): Fix read error when filtering >= 2GB on Mac OS X
Date: Sat, 17 Aug 2013 14:23:14 -0700
Message-ID: <20130817212314.GC2904@elie.Belkin>
References: <1376743205-12618-1-git-send-email-prohaska@zib.de>
 <0EC822B9-E5BB-4FF5-B054-167866EA2075@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 17 23:23:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAnyB-0006ur-1W
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 23:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754559Ab3HQVXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Aug 2013 17:23:19 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:41478 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754351Ab3HQVXS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Aug 2013 17:23:18 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so3508773pdj.2
        for <git@vger.kernel.org>; Sat, 17 Aug 2013 14:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PmhTZ25wNw5bfee6wPYwSMEgXl/Mm+J+ewwb1gx6r7o=;
        b=gYqSfcWvGLa3bsVcdVgtUkzqYn6N0qckyVvUpQC93KBB0tik1GaZtVFdLJD8KyygW8
         lcXtX3tscUR86z9El/P4I/VUaX1jaUC5XK2DjWrWOMb8/0AVjRNbmaJzn4A/BJIfceT1
         1q0qA5yRYCmspOLsVT2GmAc8sPDSOej/ko1byNTYseciTXmkT4HfQia7pbxXc6KFw2Ju
         JulQZdksDjeV2HXz2ieIeTNvYKkDRjxb1ejoQ0PWKIJh6IEtw+Phm5VtmWA5Bo8treLN
         D3VyVAw1dQnbaIjaDZ6HG9Q5hVzPB2hKnd5FAb2i/x0g5rITmBI6nZP+x+epwoxXnrbi
         O0Xg==
X-Received: by 10.68.164.1 with SMTP id ym1mr4739339pbb.33.1376774598034;
        Sat, 17 Aug 2013 14:23:18 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id ut7sm5550550pbc.31.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 17 Aug 2013 14:23:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <0EC822B9-E5BB-4FF5-B054-167866EA2075@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232471>

Kyle J. McKay wrote:

> According to POSIX [1] for read:
>
> If the value of nbyte is greater than {SSIZE_MAX}, the result is
> implementation-defined.

Sure.

[...]
> Since OS X still supports running 32-bit executables, and SSIZE_MAX is 2GB -
> 1 when running 32-bit it would seem the same limit has been imposed on
> 64-bit executables.  In any case, we should avoid "implementation-defined"
> behavior

Wait --- that's a big leap.

In a 64-bit executable, SSIZE_MAX is 2^63 - 1, so the behavior is not
implementation-defined.  I'm not sure if Steffen's copy of git is
32-bit or 64-bit --- my guess would be 64-bit.  So at first glance
this does look like an XNU-specific bug, not a standards thing.

What about the related case where someone does try to "git add"
a file with a clean filter producing more than SSIZE_MAX and less
than SIZE_MAX bytes?

strbuf_grow() does not directly protect against a strbuf growing to >
SSIZE_MAX bytes, but in practice on most machines realloc() does.  So
in practice we could never read more than SSIZE_MAX characters in the
strbuf_read() codepath, but it might be worth a check for paranoia
anyway.

While we're here, it's easy to wonder: why is git reading into such a
large buffer anyway?  Normally git uses the streaming codepath for
files larger than big_file_threshold (typically 512 MiB).
Unfortunately there are cases where it doesn't.  For example:

  - convert_to_git() has not been taught to stream, so paths
    with a clean filter or requiring crlf conversion are read or
    mapped into memory.

  - deflate_to_pack() relies on seeking backward to retry when
    a pack would grow too large, so "git hash-object --stdin"
    cannot use that codepath.

  - a "clean" filter can make a file bigger.

  Perhaps git needs to learn to write to a temporary file
  when asked to keep track of a blob that is larger than fits
  reasonably in memory.  Or maybe not.

So there is room for related work but the codepaths that read()
indefinitely large files do seem to be needed, at least in the short
term.  Working around this Mac OS X-specific limitation at the read()
level like you've done still sounds like the right thing to do.

Thanks, both, for your work tracking this down.  Hopefully the next
version of the patch will be in good shape and then it can be applied
quickly.

Thanks and hope that helps,
Jonathan
