From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notes: Use get_sha1_committish instead of read_ref in init_notes()
Date: Tue, 16 Jun 2015 20:17:03 -0700
Message-ID: <xmqq1thb58i8.fsf@gitster.dls.corp.google.com>
References: <1434503731-26414-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jun 17 05:17:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z53qj-0001nA-Mz
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 05:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755393AbbFQDRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 23:17:09 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38297 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbbFQDRG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 23:17:06 -0400
Received: by igblz2 with SMTP id lz2so28063468igb.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 20:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=TYXWqwqIBt2ld6+1WGpm6wKr2kxPphLPATAJCCeGO7M=;
        b=Mh7jLeDzCWa4YZPn4wwrXolkZkAvz03sNp+WjwwmqkKtv+Q7hwU1urcFTMttCrjs0r
         HXSEKp0oz6+qQy9kHhLeAqsezKS9FG09y8MW9mr2XzYst2ujAm+a4SGd358GJZhFE9SD
         rUH9cT84YQh2ghp0/qvfO1QUljlmInNdVJGSPuVkX8Nn1MhTNR32xen+7Qx9I4odITep
         T2s6rXXMez4cZIzSNcunjo2UfVO56Q3ve1wVKGvP5zrDxnW2QnpPwsWI1ZjdtL3Ub8bG
         OKTkDPjdtmcrOzCE/gnprBD8b4qkMvkDrpm6q37HXFRM0QpKcksS4iXKCa3xk8d1oWPt
         rSmg==
X-Received: by 10.107.26.207 with SMTP id a198mr4713430ioa.5.1434511026426;
        Tue, 16 Jun 2015 20:17:06 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6c2b:219c:23d9:cf91])
        by mx.google.com with ESMTPSA id j20sm11162585igt.5.2015.06.16.20.17.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jun 2015 20:17:04 -0700 (PDT)
In-Reply-To: <1434503731-26414-1-git-send-email-mh@glandium.org> (Mike
	Hommey's message of "Wed, 17 Jun 2015 10:15:31 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271807>

Mike Hommey <mh@glandium.org> writes:

> init_notes() is essentially the only point of entry to the notes API.
> It is an arbitrary restriction that all it allows as input is a strict
> ref name, when callers may want to give an arbitrary committish.

While it may be a good idea to allow reading from any note-shaped
tree-ish, not just what is at the tip of a ref, I suspect that the
use of read_ref() is not an arbitrary restriction, but is an
effective way to achieve safety against callers that update notes.

That is, you can feed refs/notes/commit@{4.days.ago} to the
machinery and show you notes from 4 days ago, but you cannot update
that as if it were a ref.

Hence, if you are loosening the safety at init_notes() site, you
would at least need to add a similar safety in the write codepath, I
would think.  

One thing you would need to be careful about is that you would give
users a crappy experience, if an operation reads notes, does its own
thing, and then tries to write updated notes (think: rebase that
transplants notes from original to rewritten commits), and you fail
the operation only at the very last phase of updating.  In order to
prevent that, "in the write codepath" above has to be "reject any
non-ref note, e.g. --notes=refs/notes/commit@{4.days.ago} upfront,
if the operation will write updated notes".
