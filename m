From: Elijah Newren <newren@gmail.com>
Subject: Re: [RFC PATCH 06/15] Automatically reuse sparse limiting arguments
 in revision walking
Date: Sat, 4 Sep 2010 22:50:34 -0600
Message-ID: <AANLkTi=ywOZfkxfr1Gt3AMMbWDphKjTBudG=E4+xer-P@mail.gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
	<1283645647-1891-7-git-send-email-newren@gmail.com>
	<AANLkTik1E=7Uawq-fGXppac3ur-oohq104A5wEgxv8cL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 06:50:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os7Bt-0007zm-OR
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 06:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752Ab0IEEug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 00:50:36 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36971 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740Ab0IEEuf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 00:50:35 -0400
Received: by fxm13 with SMTP id 13so2008917fxm.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 21:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=SgLWYaIedBZa8jqtuglxM2oXSW3eLXUHETL8klUQ+qA=;
        b=pLwCJCeAkcwOa+cDHwp2VzToSVAyhHdPN3Odt4PyQjnQV0HoKu5pyrDH8w66o5x7xR
         xY1WGhJKY9s1vvHWKVkEnOI10vruu2Qoi+1ACyf462KsIv9fiqU/uS8rydb6ErpGJw4m
         VTNL7TMY/ujapJOnBn13JXobWfbbT0yYSypw0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=YsK2eQUeQhNZ6VvdlzMHEhenYcKdZ5GAeE4tc1XXELhS3QYXmQ+VFExlsZie16lVxc
         wi5jkSX9F7wCdd41O959UKuuYTLzWI+8sg1mQ20TNdyRnUCsknr74I36iw55aMbGz6X/
         WmhcczrYyWHV/t8go1ALeBc6Z4N6cicWZHLRo=
Received: by 10.223.125.196 with SMTP id z4mr1114355far.80.1283662234052; Sat,
 04 Sep 2010 21:50:34 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Sat, 4 Sep 2010 21:50:34 -0700 (PDT)
In-Reply-To: <AANLkTik1E=7Uawq-fGXppac3ur-oohq104A5wEgxv8cL@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155422>

On Sat, Sep 4, 2010 at 7:58 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Sun, Sep 5, 2010 at 10:13 AM, Elijah Newren <newren@gmail.com> wrote:
>> In a sparse repository, by automatically making use of sparse limits
>> specified at clone time, we can avoid walking uninteresting commits and

>
> I have a nicer approach here. Instead of modifying setup_revisions()
> and similar functions, I update get_pathspec() to rewrite the
> pathspecs from command line in narrow/shallow repos. get_pathspec()
> currently does some form of rewriting already (prepending prefix).
>
> So if you do "git log", get_pathspec() would return "git log -- PATH1
> PATH2...". Will repost my series soon, or I can send that particular
> patch to you.

Ooh, that's clever.  I like it.  Do you also do verification that any
paths specified by the user are a subset of the paths the sparse clone
is limited to?  That'd be really nice.  Much better than my simple
dumb "just append" logic.

How do you reconcile conflicting needs, though?  For most cases,
whenever the user specifies paths, get_pathspec should make sure those
paths are a subset of the sparse paths (throwing an error if they're
not) and then just use the user-specified ones.  However, I think
doing this in all cases would break ls-files/cat-file -p, as the
pathspecs passed to those are not necessarily rooted at the toplevel
of the repository (and the prefix doesn't correct for that either).

Also, when no paths are specified by the user, the correct answer can
still vary by command.  ls-tree should be given no pathspecs in such a
case, even in a sparse clone.  Nor should commit (it wouldn't hurt too
bad to send it the sparse pathspecs, though it'd send commit through
the "partial commit" section of the code base each time rather than
the "as-is commit" section, which seems suboptimal).  And on the other
end of the spectrum, log/rev-list/diff should all take the sparse
pathspecs in such a case.
