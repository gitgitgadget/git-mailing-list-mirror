From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/2] bisect per-worktree
Date: Sun, 02 Aug 2015 11:24:02 -0700
Message-ID: <xmqq1tfla6rh.fsf@gitster.dls.corp.google.com>
References: <1438387012-29229-1-git-send-email-dturner@twopensource.com>
	<55BC4438.8060709@alum.mit.edu>
	<CAPc5daVnfit8pkjc2HCSn0erW-q++We8gx8tPsb_ptd5H+CpJg@mail.gmail.com>
	<55BC6C5C.1070707@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Aug 02 20:24:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLxvg-0003uc-Rp
	for gcvg-git-2@plane.gmane.org; Sun, 02 Aug 2015 20:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbbHBSYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2015 14:24:07 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36111 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbbHBSYG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2015 14:24:06 -0400
Received: by pacgq8 with SMTP id gq8so7108961pac.3
        for <git@vger.kernel.org>; Sun, 02 Aug 2015 11:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ZxgSZZU+HoSsEI7QMKg5mubre/8cREtclOFoPk4rUGY=;
        b=PvQyge8QkBu5d323ys9HRqKE2dpyCeIKiwzMiHi35MiOL6cDsnnPHewggCBoKS6964
         AjUlfJ3giPJ5WgfjvzwhNo3xW9SE0+RkarGoq2Yl7qgIeYJUZxIPbWSiTB5ENX8cf22N
         yBaOzyWpoxKNQsp2cKSWD27eiHRp6HpKFRuvbdgkd01vCDMb9pCN7rhEZIG26QpimnnC
         r2M2tJj6iDBNNXeeEuezehGAUT0Xr+C0TWZ0f12qsSkpnJg77uKroAJJB0yDGq3B0pKK
         JEan6vmMR5/Bx461auNtpTfWIxPqzepnnABmXZ+wzsBlCF93eqdIFK2lVvd/goXcqRo7
         bzzA==
X-Received: by 10.68.219.97 with SMTP id pn1mr15155115pbc.60.1438539845266;
        Sun, 02 Aug 2015 11:24:05 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:9922:d65f:3652:1a73])
        by smtp.gmail.com with ESMTPSA id iw2sm5340787pbb.67.2015.08.02.11.24.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 02 Aug 2015 11:24:03 -0700 (PDT)
In-Reply-To: <55BC6C5C.1070707@alum.mit.edu> (Michael Haggerty's message of
	"Sat, 01 Aug 2015 08:51:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275148>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Hmm, ok, so you are thinking of a remote database with high latency. I
> was thinking more of something like LMDB, with latency comparable to
> filesystem storage.

Not necessarily.  The comment was more from conceptual point: "Why
share what needs not to be shared?"

> These worktree-specific references might be ephemeral, but they also
> imply reachability, which means that they need to be visible at least
> during object pruning.

True, but for bisect in particular, that is moot.  You are in
sightseer mode, marking various (older) points in time of an
existing history that is already anchored by branches and tags.

> Moreover, if the references don't live in the
> same database with the rest of the references, then we have to deal with
> races due to updating references in different places without atomicity.

Does that still hold true in the context of bisection?  You do not
even want atomicity to get in the way when you found this old commit
is bad and are about to mark the next one for testing by checking it
out.  You still want to mark the "bad" one (as it being bad is already
an established fact after testing), even if the subsequent checkout
of another commit (i.e. update to "HEAD") fails.

But these two comments above do take advantage of the fact that we
are discussing "bisect" and nothing else.  As a set of points to
consider in a more general context, I do agree that there are refs
and ref-like things that are per-worktree but still has to be part
of reachability, which "HEAD" is the prime example ;-), and some of
them may want to be part of a transaction.

I however think what David has been calling pseudo-refs falls more
in the "ephemeral and unnecessary to participate in reachabliity or
transaction" category (e.g. CHERRY_PICK_HEAD).  And I think the refs
used during bisection falls into the same category.

> For each worktree, we could then create a different view of the
> references by splicing parts of the full reference namespace together.
> ...
> "git prune" would see the whole namespace as it really is so that it can
> compute reachability correctly.

I really like this as a mechanism to include refs/ hierarchy, some
part of which is shared and some part of which is private.

I do not think bisect or pseudorefs needs that, though.
