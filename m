From: Elijah Newren <newren@gmail.com>
Subject: Re: [ANNOUNCE] git_fast_filter
Date: Wed, 8 Apr 2009 10:55:20 -0600
Message-ID: <51419b2c0904080955u71d18093rd3e8b6a29cf9bbfb@mail.gmail.com>
References: <51419b2c0904072035u1182b507o836a67ac308d32b9@mail.gmail.com>
	 <alpine.DEB.1.00.0904081144580.9157@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 08 18:58:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lrb5X-0005oW-0U
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 18:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765879AbZDHQzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 12:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759824AbZDHQzY
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 12:55:24 -0400
Received: from mail-gx0-f160.google.com ([209.85.217.160]:52293 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757457AbZDHQzW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 12:55:22 -0400
Received: by gxk4 with SMTP id 4so462630gxk.13
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 09:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Br+Pfg6xlQHx/WhNyp1qEA0Yam1q2ImH8yiCYksY750=;
        b=S3cCXaPdkCEkHWzk4YB3iPNStxlIfh2M241CHF5+Gqgb1/Z3PWFP5sSXjNmohbTDGK
         CRzVrr5vfGB4uL9JX8NVODPr/bBZCRBx4qNj8Zu3MIIeHCwJru7ku0dGi7CV9C4tRnfr
         HISttbtUX/sddYnMdACHobMQcMpMUG9++0spE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NWbVqoV3ciRNBT++j3skOEm5U0Pd80TJAodQ+CCzzcn4FM0YT0j7Ns9q+DXrczQF6T
         QXoHodGjDSoNzsOt4gSDG6z5lmRSpwjyoJBJqbkCYJyW+T3uBvCalJbHeGh+EY2l9Uqv
         dDeo0ccFsg2Uk3oyYQRffyKI78g5PEr1GtrOI=
Received: by 10.231.16.129 with SMTP id o1mr412102iba.9.1239209720664; Wed, 08 
	Apr 2009 09:55:20 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904081144580.9157@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116096>

Hi,

On Wed, Apr 8, 2009 at 3:45 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Tue, 7 Apr 2009, Elijah Newren wrote:
>
>> Just thought I'd make this available, in case there's others with niche
>> needs that find it useful...
>
> Have you seen
>
>        http://thread.gmane.org/gmane.comp.version-control.git/52323
>
> I was rather disappointed that skimo left the patch series in a rather
> half-useful state.

No, I had not.  Looks useful, though it appears to be missing a number
of options from git-filter-branch, such as --subdirectory-filter,
--tree-filter, and --prune-empty.  I'm guessing that's related to your
"half-useful" comment?

I was particularly interested in --tree-filter for my rewrite, since I
needed it (to remove all cvs keywords and a few other touch-ups) and
it was the slowest of the filters I'd be using.  Problem is, in a
repository with 40,000 commits and 70,000 files in the latest commits,
--tree-filter is unacceptably slow.  On average, a commit would have
about 35,000 files (assuming approximately linear growth over the
commit history), meaning that I'd have to modify 40,000 x 35,000 files
= 1,400,000,000 files[1].  However, on average, less than a dozen
files changed per commit, so there are less than 40,000 x 12 = 480,000
unique files that actually need to be rewritten.  git-fast-export
provides (and git-fast-import expects) just those half million files,
and rewriting half a million files instead of 1.4 billion files is the
difference between a 45 minute rewrite and a 3 month one.

I didn't see a way to easily avoid the 1.4 billion file rewrite using
git-filter-branch (or git-rewrite-commits had I known about it), and
writing something to parse and modify git-fast-export output seemed
like the easiest solution.  Perhaps I could have written some fancy
index-filter script that recorded original and modified file sha1sums
somewhere and used that to only check out certain files and rewrite
them, but such an idea hadn't occurred to me (and I'm not sure it
would have been the better route even if it had).  Maybe there's
something I missed that would have made this easy, though?


Elijah

[1] For simplicity, I'm ignoring the 'binary' files that should not
have any cvs-keyword unmunging performed on them.  However, it does
present an issue, particularly with extra process forks, since you
need to determine which files are safe to modify.  I used libmagic
(the library behind the unix 'file' command) to avoid the need to run
'file' repeatedly.
