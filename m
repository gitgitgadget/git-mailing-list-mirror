From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Thu, 4 Apr 2013 12:04:05 -0700
Message-ID: <CA+55aFyQwJfiYo06y1bRNpKT6wOquhG9a9M_4YvLG_UT3b34-w@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
	<CA+55aFz1D_dMtMHHMpiGi3KL=Y-m4DVxHVr=1ZX8zYWQ2TPvwA@mail.gmail.com>
	<CALkWK0nNjvV5VGvT_eaubFoOhMnJ-N8FECAayd5A2K3BzeRh6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 21:04:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNpSj-0004DP-Fn
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 21:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764258Ab3DDTEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 15:04:09 -0400
Received: from mail-vc0-f175.google.com ([209.85.220.175]:60847 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763705Ab3DDTEH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 15:04:07 -0400
Received: by mail-vc0-f175.google.com with SMTP id hf12so2598369vcb.20
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 12:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=mRHJCV+UZ/o7n/5SaXRE8TNMKw541g4qAmoaLtWp4pA=;
        b=uuHfG19vJ6cZCSH/O0pSh8gUBYJisTaHEVIl+iK7srt356Q6qpKVmPRJWItKjiEiQB
         siPBN2Naq6ewiMld7XKekI9/RZgrEnnokQRbtjomjlMO0YRzGHFSsF+geKVzumZXzTES
         14o07DfOx6480844SgHhKKPn2HfUmR/X5AFTzCQXCxl5ePdGwO/+ymW7VU1g90I2lOEa
         w1cpRu/1PUOJTuC2r3pbpX3YxU5LyKNJw87zav87CvbYseJzD5k+p+lfBg/6E5m305w6
         BHzkJMvCgCas7UVhbXKU9jV88M2Q3PpODTOcNsn1goqT/XQa4FOqkbP9vR9TgS208utF
         45Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=mRHJCV+UZ/o7n/5SaXRE8TNMKw541g4qAmoaLtWp4pA=;
        b=UwbnF32ewA4z7KvLc9G4I0mgY/AzW5NQ81/Niy/3hUYNyt/eb+Yijb30bb+iNjTqJ7
         E1+3TI7EC4eqvbYX5H2remQDFze57JZJGsnQYi1sadVhlgG48p3nrFUCP2dpGS8hoX8N
         7Yemxon3bNG+5Vb33psPnw2/C8SB9OHxoNyD8=
X-Received: by 10.58.154.229 with SMTP id vr5mr5869346veb.11.1365102245890;
 Thu, 04 Apr 2013 12:04:05 -0700 (PDT)
Received: by 10.220.236.130 with HTTP; Thu, 4 Apr 2013 12:04:05 -0700 (PDT)
In-Reply-To: <CALkWK0nNjvV5VGvT_eaubFoOhMnJ-N8FECAayd5A2K3BzeRh6Q@mail.gmail.com>
X-Google-Sender-Auth: ageYNSdyPAuEWOjXm5vR7pbJlDY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220070>

On Thu, Apr 4, 2013 at 11:52 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
>
> 1. upstream_url: this records the upstream URL.  No need to keep a .gitmodules.
>
> 2. checkout_rev: this records the ref to check out the submodule to.
> As opposed to a concrete SHA-1, this allows for more flexibility; you
> can put refs/heads/master and have truly floating submodules.
>
> 3. ref_name: this specifies what name the ref under
> refs/modules/<branch>/ should use.
>
> 4. floating: this bit specifies whether to record a concrete SHA-1 in
> checkout_rev.
>
> 5. statthrough: this bit specifies whether git should stat() through
> the worktree.  We can turn it off on big repositories for performance
> reasons.

So the thing is (and this was pretty much the original basis for
.gitmodules) that pretty  much *all* of the above fields are quite
possibly site-specific, rather than globally stable.

So I actually conceptually like (and liked) the notion of a link
object, but I just don't think it is necessarily practically useful,
exactly because different installations of the *same* supermodule
might well want to have different setups wrt these submodule fields.

My gut feel is that yes, .gitmodules was always a bit of a hack, but
it's a *working* hack, and it does have advantages exactly because
it's more fluid than an actual git object (which by definition has to
be set 100% in stone). If there are things you feel it does wrong
(like the "git add" bug that is being discussed elsewhere), I wonder
if it's not best to at least try to fix/extend them in the current
model. The features you seem to be after (ie that whole
floating/refname thing) don't seem fundamentally antithetical to the
current model (a "commit" SHA1 of all zeroes for floating, with a new
refname field in .submodules? I dunno)..

                  Linus
