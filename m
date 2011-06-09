From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Thu, 9 Jun 2011 13:15:38 -0400
Message-ID: <BANLkTinyYjXeg_khoU1dJVenP0mO2++hsw@mail.gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
	<m339jps1wt.fsf@localhost.localdomain>
	<BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
	<201106051311.00951.jnareb@gmail.com>
	<BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
	<7vwrgza3i2.fsf@alter.siamese.dyndns.org>
	<4DF08D30.7070603@alum.mit.edu>
	<20110609161832.GB25885@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 09 19:21:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUivO-0005RD-LD
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 19:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753682Ab1FIRVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 13:21:38 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:50402 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753038Ab1FIRVh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 13:21:37 -0400
Received: by yie30 with SMTP id 30so916413yie.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 10:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zU7xmb95tf8lpxh2dRrWFzy34catfamCKXHBI/sr3/Q=;
        b=XirYV2ANrFiI85KOWmAqmrc4qIQsjwaAWXOZ07b/MT1mT7qrn8kNA5PHz10iLAB0mw
         ZSf62QlSls9xMo5iMFsgEgJgtjBeGxwnVhjHHX7fU6SCoL2WfZgNB+aC/7l2zPOHa9cy
         +jwzYnoekZ4A95yF+/O7/i/VcWlTlWr03/McQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=SoKCus5F+LmOwEC6gsxO3JJK0Mw+KP2cuP32FGERHHwmO6+0Og4D9KEXBKnKR2ZIkD
         uKplyJBnzVnYJ/u7L30vt9O+/vyCPqXyDiOOig1YrPacd+26YkSFNbrKRkx9KeLRQaq4
         /1WPTBOckbfe7MlFj710SNHfDkbu87qkX7m9M=
Received: by 10.236.76.194 with SMTP id b42mr1235256yhe.446.1307639738691;
 Thu, 09 Jun 2011 10:15:38 -0700 (PDT)
Received: by 10.147.169.1 with HTTP; Thu, 9 Jun 2011 10:15:38 -0700 (PDT)
In-Reply-To: <20110609161832.GB25885@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175556>

On Thu, Jun 9, 2011 at 12:18 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Jun 09, 2011 at 11:06:56AM +0200, Michael Haggerty wrote:
>
>> My naive understanding is that in the case of a merge commit, the index
>> contains information equivalent to *multiple* trees:
>>
>> NEXT -- HEAD plus the files that have been resolved
>> BASE -- the contents of the common ancestor
>> OURS -- equivalent to the tree from HEAD
>> THEIRS -- equivalent to the tree from MERGE_HEAD
>
> Almost. Remember that as part of the merge resolution process,
> higher-level stages will collapse down to 0. So the "theirs" stage of
> the index is equivalent to MERGE_HEAD only if you have a conflict in
> every file and have resolved nothing. Otherwise, any resolved entries
> will not have a "theirs" entry at all.
>
> So when I do "git diff", we will see for resolved entries that the
> working tree matches stage 0 in the index, and show nothing. Whereas
> unresolved entries will have their diff shown. But with "git diff
> MERGE_HEAD", we will see differences from the other branch, even if
> those differences are simply resolutions or even changes made on the
> "ours" branch.
>
> So the index is not quite simply a set of four trees. The presence of
> various stages for each entry tells us the progress of resolution.

However, it would be useful I think to expose it as four separate
trees. During conflict resolution, I often want to look at the
conflicted files in these various states, and end up using various
incantations that are somewhat baroque.

e.g.:

  $ git diff ...MERGE_HEAD -- /path/to/file

is probably less clear than:

  $ git diff BASE THEIRS -- /path/to/file

In fact, my first step after a conflicted merge is:

  $ git tag -f ours HEAD
  $ git tag -f theirs MERGE_HEAD
  $ git tag -f base $(git merge-base HEAD MERGE_HEAD)

j.
