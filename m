From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [RFC] Add bad-branch-first option for git-bisect
Date: Mon, 24 Jan 2011 12:28:50 -0800
Message-ID: <AANLkTinwbm9gcZhGeQCbOEPov0_xV7uJyQvC7J13qO15@mail.gmail.com>
References: <4D3CDDF9.6080405@intel.com> <AANLkTimUkv9+g_+wFcyGhwMjE9zYAKjMn32GL-WOVmoe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Shuang He <shuang.he@intel.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 24 21:29:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhT2N-0005bV-JJ
	for gcvg-git-2@lo.gmane.org; Mon, 24 Jan 2011 21:29:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314Ab1AXU3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jan 2011 15:29:12 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:45542 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735Ab1AXU3L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jan 2011 15:29:11 -0500
Received: by qwa26 with SMTP id 26so4416985qwa.19
        for <git@vger.kernel.org>; Mon, 24 Jan 2011 12:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=QY/OyTIEHyUU53p4plchYajy/kxtqyslANsrRMuWCd8=;
        b=cM2JbitaE1JUbyIbGn7tUFupnbtNOj50Myyo4H+Kr60z4GXhepFwW2shZl7YVPno9C
         hgBr69RqOYq14Otyr9jUmHDZcWitaDZQxlnUIVrgfIJEycZOlgBamx4HRd0J+t+dgUBs
         6KNTlODYaUKF7wzIHYBjpSLP1SlSCDVtSklcE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=S0l3Wioo7nrMgkaEb0fWGV4yeF//5TcHc1PNWVcsIoUJlFcXU3rs9TFA6cg0wwa6yR
         hT4BnHDGULr6AUEz0AEsXlPNais8yCjyaU7cwcx57fpMRor+hkEKDBEDC7R2ynXSLGZv
         yK3+S8Xrt3J+aNWouH+y3OnhAlFiGODTDtBvw=
Received: by 10.229.215.76 with SMTP id hd12mr4263727qcb.125.1295900950268;
 Mon, 24 Jan 2011 12:29:10 -0800 (PST)
Received: by 10.220.194.141 with HTTP; Mon, 24 Jan 2011 12:28:50 -0800 (PST)
In-Reply-To: <AANLkTimUkv9+g_+wFcyGhwMjE9zYAKjMn32GL-WOVmoe@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165456>

On Mon, Jan 24, 2011 at 1:53 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> I am not opposed to an option to bisect on the first parents of the
> bad commit only. And after a very fast look at your patch it seems to
> be what it does. By the way Avery Pennarun's gitbuilder
> (https://github.com/apenwarr/gitbuilder) does the same thing. So I
> know some people are interested in such a feature.

Just some notes on gitbuilder's algorithm, since I haven't spent the
time to fully understand Shuang's proposal.

I do understand at least one of his concerns, that is, that people
like to do a lot of "messy" development on a branch, and when the
branch is done, merge the whole messy branch into the "mainline".  The
messy branch would then have a lot of commits that break a lot of
things before fixing them again later.

In a corporate environment, this method allows people to work all day,
make frequent commits, pull from other branches at will, and never
risk their lives by doing poorly-educated rebases.  It works pretty
well *until* you try to bisect, at which time all these messy commits
start to bite you.

gitbuilder's bisection is a total hack around this situation, although
it happens to work perfectly in the workflow it was designed for, thus
making me feel clever.

Basically, we push/fetch *all* the branches from *everybody* into a
single repo, and build all of them as frequently as we can.  If you
think about it, if you have all the branches that someone might have
pulled/merged from, then you don't have to think of the git history as
a whole complicated DAG; you can just think of it as a whole bunch of
separate chunks of linear history.  Moreover, as long as people are
careful to only pull from a branch when that branch is passing all
tests - which you can easily see by looking at the gitbuilder console
- then playing inside each of these chunks of linear history can help
you figure out where particular bugs were introduced during "messy"
branches.

It also allows you a nice separation of concerns.  The owner of the
mainline branch (the "integration manager" person) only really cares
about which branch they merged that caused a problem, because that
person doesn't want to fix bugs, he/she simply wants to know who owns
the failing branch, so that person can fix *their* bug and their
branch will merge without breaking things.

So this is why gitbuilder uses "git rev-list --first-parent" during
its "fake bisection" operation: because a different person is
responsible for each "linear chunk" of history.

Note that you have to use --no-ff when merging if you want this to
work reliably.  But the build manager person can just remember to do
that.  Combining --no-ff and --ff-only (which sound mutually exclusive
but aren't) is a way to be extra specially sure.

Now, if you aren't using gitbuilder, what we want from "bisection" is
not quite the same, but let's imagine that you at least have a similar
setup, where people *only* ever merge into the mainline by using
--no-ff.  In that case, you'd like a bisect operation that *starts* by
using --first-parent, which will tell you which merge caused the
problem.  After that, you might want to bisect into the branch.

(I don't actually remember if 'git bisect' understands --first-parent
correctly.  gitbuilder doesn't exactly bisect either, but that's
another story and not relevant right now.)

I can actually imagine that there are many more projects that do what
I'm talking about - "messy" branches that get broken and fixed over
time, then merge into a "clean" mainline - than projects (like the
kernel and git.git) that try to keep all branches clean at all times.
Thus, I could see some argument that a "--first-parents first"
bisection would actually help out a lot of people, and maybe even
deserves to be the default.

I don't really care though, I just use gitbuilder :)

Have fun,

Avery
