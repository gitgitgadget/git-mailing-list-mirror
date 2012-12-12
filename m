From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC/PATCH] ignoring a fetch that overwrites local symref
Date: Wed, 12 Dec 2012 11:13:01 -0800
Message-ID: <CAJo=hJu2X5u4oCGRVHK5a4sbf4X2meUbq_8kaGiQB1mdQspaXw@mail.gmail.com>
References: <1271694343-31876-2-git-send-email-jaysoffian@gmail.com>
 <1271714912-56659-1-git-send-email-jaysoffian@gmail.com> <7v62488j8a.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, Jay Soffian <jaysoffian@gmail.com>,
	Stefan Zager <szager@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 20:13:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TirkR-0005qS-VO
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 20:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295Ab2LLTNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 14:13:22 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:44516 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766Ab2LLTNV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 14:13:21 -0500
Received: by mail-qa0-f53.google.com with SMTP id a19so1568184qad.19
        for <git@vger.kernel.org>; Wed, 12 Dec 2012 11:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=95QexTOny30fzIji5EqX/1VRAdpoDvGJ4Rf8XKWbAOc=;
        b=fhMwCYiTHu3UmDe8/U1OlX/x/FSkr76jtokUIfP4QVueG2CfGab3TURz5MBhAfvXWU
         FtNp1wP7p7Xx5rwNBILTXo8C+zft+769lNZo95ymlDq6Go/AqepCX6cP4enkqdQXnQPm
         C9qhO8cUIp5DRLSakkuNn8LaGp6+Qk3dz8Pxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=95QexTOny30fzIji5EqX/1VRAdpoDvGJ4Rf8XKWbAOc=;
        b=K+13QLTkr/T1K5jp33JY2uQVzBTUG6sWkvHzO4KKyRgPo8P9J8UguWk3tDlvx2puhJ
         bOScuEd8Hpx6HQeo90d0Ht3e3UOFbQaTEofLc46ZMevjLX4M9Y2xBQtw9usSc9qMXGJp
         vPLu9hzj7l6jYpZFsS7Yzu3uwvG37t7j6tZrt3syYUwHeI0L7lyiIwZTqa+L+oLxZWYc
         QUhHnLahDP6TxjoJgMx5FI6eOHkNO5KFPlJYF/vzzbsEOKnrQy2WrYnM6blBiyT/971w
         y+zjQSC5CwL/WCl7+LRdLUyFN1V4C1o6KB5zPX3/9XRZcPk+peOLUijgKVC/SH6cOfL0
         782A==
Received: by 10.229.75.224 with SMTP id z32mr1037853qcj.148.1355339601147;
 Wed, 12 Dec 2012 11:13:21 -0800 (PST)
Received: by 10.49.60.198 with HTTP; Wed, 12 Dec 2012 11:13:01 -0800 (PST)
In-Reply-To: <7v62488j8a.fsf_-_@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQmlfdbBJRrIY06gISwPqr0xcbziC6hqlVURYYpbIHlP1j6RxFyWihXqCFZLvz0uLlqTtkP6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211383>

On Tue, Dec 11, 2012 at 11:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> This is a companion to an ancient thread
>
>     http://thread.gmane.org/gmane.comp.version-control.git/145311/focus=145337
>
> in which an error was dealt with while pushing into a "mirror"
> repository that has a symbolic reference refs/remotes/origin/HEAD
> pointing at refs/remotes/origin/master with "git push --mirror".
> The issue was that the receiving end was told to update origin/HEAD
> and origin/master separately; if origin/HEAD is updated, that would
> update origin/master at the same time, and then when attempting to
> update origin/master, it would notice that it no longer has the
> expected old value and barf.  After the series, we started ignoring
> such pushes to HEAD on the receiving end.
>
> But you can suffer from a similar issue transferring objects in the
> opposite direction.  If you run "fetch --mirror" in to such a
> "mirror" repository, the other side would advertise both 'master'
> and 'HEAD' under refs/remotes/origin/ hierarchy, and refs/*:refs/*
> wildcard would try to grab both of them.
>
> Work it around by noticing a wildcard match that attempts to update
> a local symbolic ref and ignoring it.

At what point should we just support symrefs on the protocol? :-(
