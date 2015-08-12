From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pack negotiation algorithm between 2 share-nothing repos
Date: Wed, 12 Aug 2015 08:55:05 -0700
Message-ID: <xmqqk2t0mrhi.fsf@gitster.dls.corp.google.com>
References: <CACsJy8AKKYux6w=6X392mJhGFfqfEvJsrX0PjcivHPt2PYVKAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 17:55:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPYNK-0007UY-LK
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 17:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbbHLPz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 11:55:29 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35026 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932114AbbHLPzI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 11:55:08 -0400
Received: by pacgr6 with SMTP id gr6so17156578pac.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 08:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=lmiRgr/c6DLQFwaMxxpC0TvR+uLiFjWc6+bMyDx1gCo=;
        b=AD0hf+62JlRWmnP5cjgA4agLxdb6ReTE6wtzD4vsNh9mGkOLLrMwWVhteGXD6qxyH5
         nRUgx6mlFUM3WXXRzCAtRzW1vACm+iYnBQoD3VzjU9CRSYD4/i0ydbFZwrOuyG6xko8U
         AOIYsuT5XD2gALtTexJLGVshdB+D94Qe0179Bv2Bqp4p1G8C49mMegX5CxtS5G5rfvPo
         0XtsLljIDhAndT/BE9CPcsAPAr42bLz9iCdROunnFr79n9dPeEsOKXlnfMfCAgSGeI5x
         7dvkQCPmOTv+P1IA9FX1uxY0aRxyFZoGCqiHHpvUfHR9Xi0b1e7LZCWKjh7o3gdUX086
         +8yw==
X-Received: by 10.68.200.72 with SMTP id jq8mr42493853pbc.91.1439394908134;
        Wed, 12 Aug 2015 08:55:08 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:755f:3d29:a826:eda6])
        by smtp.gmail.com with ESMTPSA id tm3sm6907357pbc.27.2015.08.12.08.55.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 08:55:07 -0700 (PDT)
In-Reply-To: <CACsJy8AKKYux6w=6X392mJhGFfqfEvJsrX0PjcivHPt2PYVKAw@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 12 Aug 2015 18:27:24 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275776>

Duy Nguyen <pclouds@gmail.com> writes:

> I know this is a corner case, but because it has a valid use case,
> maybe we should do something about it. Immediate reaction is to add an
> option to send no "have"s. But maybe you guys have better ideas.

This and similar corner cases were discussed in very early days of
Git.

One interesting idea floated back then but was not pursued was to
dig and send have's sparsely and then back up.  Instead of digging
and sending _all_ commits in a contiguous history, after sending the
tip, you skip the commits from the history before sending the next
one, and progressively make the skipping larger (e.g. Fibonacci, or
exponential).  You need to remember what you sent and for each of
what you sent its topologically-oldest descendant you sent earlier
that you heard the other side does not have.

Then, when you get an Ack, you know a stretch of history between a
commit that is known to be common (i.e. the one you heard an Ack
just now) and its descendant that is known only to you (i.e. the
topologically-oldest one you remember that you did send and they
didn't say is common).  At that point, you and the other end can
bisect that range.
