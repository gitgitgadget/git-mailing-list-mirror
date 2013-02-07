From: Jed Brown <jed@59A2.org>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Thu, 07 Feb 2013 09:58:00 -0600
Message-ID: <87pq0c15h3.fsf@59A2.org>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com> <5110BD18.3080608@alum.mit.edu> <7v8v72u0vw.fsf@alter.siamese.dyndns.org> <51122D9D.9040100@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 16:58:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3Trs-0003L9-GR
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 16:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758656Ab3BGP6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 10:58:09 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55464 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758166Ab3BGP6H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 10:58:07 -0500
Received: by mail-ie0-f174.google.com with SMTP id k10so3641473iea.5
        for <git@vger.kernel.org>; Thu, 07 Feb 2013 07:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version:content-type;
        bh=FGv/s7LnZr43Ip+A3o55YVT7I+keWE+fokKso+J5UXU=;
        b=b+YzJ5/77lnlhCTlKtj3MXOVWENz0O7f83JovtnyMzex5BOEJvajMq/XzAvqJz/Bml
         fRxeLim7uNnYEy6Bm1ZiO7OHwBJEh0NzesFp8dfgbByLniPOl/TenuYCOM0zYaLv532T
         MfKnbcZQpJAhqA7gbGabuN4npUf1RppC5Q9vvp+KzhNHtlvt+T89oBjZ2kRfmN5FV7m4
         Vu0qufoHm9E3Os6SKy73GJS9nn2XwWBhQD5zKnk4n/7IsHzBKQ+rgL+ghjiT7Hgypnwe
         C8nDrCWQvIupQW222HuQl4XjcrAeLzBhgjzr75BuWhureQPHq0WZHRqoJKIR9m83h4zP
         viQg==
X-Received: by 10.50.170.4 with SMTP id ai4mr3854759igc.40.1360252686561;
        Thu, 07 Feb 2013 07:58:06 -0800 (PST)
Received: from batura (vis-v410v070.mcs.anl-external.org. [130.202.17.70])
        by mx.google.com with ESMTPS id br7sm9392624igb.0.2013.02.07.07.58.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 07 Feb 2013 07:58:04 -0800 (PST)
In-Reply-To: <51122D9D.9040100@alum.mit.edu>
User-Agent: Notmuch/0.15 (http://notmuchmail.org) Emacs/24.2.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215701>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> A first weakness of your proposal is that even though the hidden refs
> are (optionally) fetchable, there is *no* way to discover them remotely
> or to bulk-download them; they would have to be retrieved one by one
> using out-of-band information.  And if I understand correctly, there
> would be no way to push hidden references remotely (whether manually or
> from some automated process).  Such processes would have to be local to
> the machine holding the repository.

I'm the author of git-fat [1], a smudge/clean filter system for managing
large files.  I currently store files in the file system
(.git/fat/objects) and transfer them via rsync because I want to be able
to transfer exact subsets requested by the user.  I would like to put
this data in a git repository so that I can take advantage of packfile
compression when applicable and so that I can use existing access
control, but I would need to store a separate reference to each blob (so
that I can transfer exact subsets).  My refs would be named like
'fat-<SHA1_OF_SMUDGED_DATA>' and are known on the client side because
they are in the cleaned blob (which contains only this SHA1 and the
number of bytes [2]).

I believe that my use case would be well supported if git could push and
pull unadvertised refs, as long as basic operations were not slowed down
by the existence of a very large number of such refs.


[1] https://github.com/jedbrown/git-fat

[2] We could eliminate the performance problem of needing to buffer the
entire file if the smudge filter could be passed the object size as an
argument and if we could forward that size in a stream to 'git
hash-object --stdin'.
