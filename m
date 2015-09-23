From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 5/8] branch: drop non-commit error reporting
Date: Wed, 23 Sep 2015 12:14:59 -0700
Message-ID: <xmqqfv25x80c.fsf@gitster.mtv.corp.google.com>
References: <1443031873-25280-1-git-send-email-Karthik.188@gmail.com>
	<1443031873-25280-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 21:15:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZepVW-0005Ns-UJ
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 21:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806AbbIWTPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 15:15:03 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:32910 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbbIWTPB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 15:15:01 -0400
Received: by pacex6 with SMTP id ex6so48377520pac.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 12:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=dZsqBOBkrFFVfcruwDylEfrWPBXEjIyVZy6Tc3k6Awc=;
        b=e2oCOFeozbXdYKJjTjL44w/MCn6Dmqb47gRMUSsvtxiBvsfsW5Fi8JH/e02PuOTD/B
         BvKIW6R/zp32+kV/jzPL/NP9PpgQZlyCwh7MONFwKoOu44pvdKcsosZGSR9+9D96/RTa
         yqp1Sf2xFiTz6HxkErX9okol7NddK3F8UyIDxuBBGk0FKSDxVsOee7oLum9VCaWt//sX
         868ZB3XsWbdvycQv+A6d5bDKBubHdexthky0f/IJYefWOc0Yl9zSF6DbeBMnJE3ojHdk
         8XysJWj1gGrMHwAH840UdctnGCu+Q5PQG0QBCU1E5hwS4p15C0GcYdHOvRcGGx9rlm99
         5CGw==
X-Received: by 10.66.138.11 with SMTP id qm11mr23694616pab.126.1443035700825;
        Wed, 23 Sep 2015 12:15:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:a07c:76d3:22e9:4d3d])
        by smtp.gmail.com with ESMTPSA id rl17sm9436962pab.2.2015.09.23.12.14.59
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 23 Sep 2015 12:15:00 -0700 (PDT)
In-Reply-To: <1443031873-25280-6-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Wed, 23 Sep 2015 23:41:10 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278504>

Karthik Nayak <karthik.188@gmail.com> writes:

> Remove the error reporting variable to make the code easier to port
> over to using ref-filter APIs.
>
> This also removes the error from being displayed. As branch.c will use
> ref-filter APIs in the following patches, the error checking becomes
> redundant with the error reporting system found in the ref-filter
> (ref-filter.c:1336).

Hmm, do you mean these lines by the above reference?

	if (filter->merge_commit || filter->with_commit) {
		commit = lookup_commit_reference_gently(oid->hash, 1);
		if (!commit)
			return 0;

That is "silently return ignoring it if it is not a commit", i.e.  I
do not think that deserves to be called error REPORTING system.

Do you really understand what the error message you are removing is
trying to diagnose?  A branch ref must not point at a blob or any
non-commit object, and if we find such a branch ref, we report it as
error.  That is what the error message is about.

Now, ref-filter.c:1336 has in no position to issue that same error
message because it does not know what it is looking at is supposed
to be a branch ref, so it is WRONG if it gave the same error
message.  After all, the caller may be using ref-filter to filter
refs/tags/* with merge_commit or with_commit and found a
light-weight tag in refs/tags/* that points at a blob.  That is not
an event we want to get an error at all.

I do not think we terribly mind if this message goes away from this
location.  "It is a wrong codepath whose purpose is not to diagnose
and report a repository corruption.  If we care about such a
repository corruption, we should report it from fsck instead", would
bea valid justification for the removal of the message.

It is not a valid justification to claim that it is made redundant,
when you actually are simply LOSING the error reporting without
giving the same error message from another codepath to make it truly
redundant.
