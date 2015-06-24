From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Enable core.fsyncObjectFiles by default
Date: Tue, 23 Jun 2015 22:20:44 -0700
Message-ID: <xmqqlhf9bs2b.fsf@gitster.dls.corp.google.com>
References: <1435096643-18159-1-git-send-email-sbeller@google.com>
	<20150624033725.GA19321@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Theodore Ts'o <tytso@mit.edu>,
	git@vger.kernel.org, torvalds@linux-foundation.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 24 07:20:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7d7F-00033M-4b
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 07:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbbFXFUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 01:20:49 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:37664 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbbFXFUs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 01:20:48 -0400
Received: by igblr2 with SMTP id lr2so26724843igb.0
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 22:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=gp8djT81TFR0Jc0ke+3Tphx801bqLpbfKyZ2OSMdNLk=;
        b=eQRTnTIuWgdgCmoyAaod3DpYJnDBeMaXktkArFldoY+HOXEaQgIT1dV5ntM+gY/s+P
         yXKuHSahOdKnmKzOn8e2eJCQEh1UxeiErBjYfO+IytsQSE54MF7FUf3rSVwgHYgKMigi
         eFSD57RZJlE3aO4MIJYWhDR6Y9hR92NdeKIkGB9+tFtzzKXMPhYf6eh6Zl/knzmGienX
         MqQl4OZcvVnlJ4fjVWBGjEBVKP7miM/gQExSfwvLD121H6d1IJNeh79VugvzXAEqFasW
         eIlxEmS7jTrWQUKFJsFEgVaeLSwUiKr8FoInrQ/tjAWDLuIGiVcp1oI90vPcYxnbT5pi
         saNw==
X-Received: by 10.50.61.241 with SMTP id t17mr853732igr.34.1435123247558;
        Tue, 23 Jun 2015 22:20:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1c05:dbc5:2f2f:d033])
        by mx.google.com with ESMTPSA id b17sm16490231iod.32.2015.06.23.22.20.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jun 2015 22:20:46 -0700 (PDT)
In-Reply-To: <20150624033725.GA19321@peff.net> (Jeff King's message of "Tue,
	23 Jun 2015 23:37:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272531>

Jeff King <peff@peff.net> writes:

> I had always assumed this was fine on ext4 with data=ordered (i.e.,
> either the rename and its pointed-to content will go through, or not; so
> you either get your update or the old state, but not a garbage or empty
> file). But it sounds from what Ted wrote in:
>
>   http://article.gmane.org/gmane.linux.file-systems/97255
>
> that this may not be the case. If it's not, I think we should consider
> fsyncing ref writes.

That matches my understanding.  IIRC, we do fsync (without a knob to
turn it off) packs, we do not fsync refs (as you described above),
the index, or working tree files (via write_entry()).  Among these:

 * If we are so paranoid that loss of new loose objects matter (as
   opposed to "Heh, it is just the matter of 'git add' again") to
   cause us to set core.fsyncObjectFiles, we should definitely fsync
   ref writes.  They are even more precious.

 * The index is much less precious.  In the worst case, you can 'git
   reset' (no flags) and re-add from the working tree and nothing
   unrecoverable is lost.  I do not mind a knob to force us fsync,
   but we may want it to be separate from core.fsyncObjectFiles.

 * The working tree files?  I am not sure.  Again, recovery is just
   to run "git diff" to notice what was eaten by the power failure
   and then "git checkout $path" to restore from a known state,
   so...
