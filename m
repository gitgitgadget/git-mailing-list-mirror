From: Phil Hord <phil.hord@gmail.com>
Subject: Ambiguous reference weirdness
Date: Tue, 21 Feb 2012 20:46:24 -0500
Message-ID: <CABURp0oAw7cvU7cwCZOtvqZ_oa0hDPsE_0Lm3kR1ctdNuxU3hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 02:47:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S01IL-0006rp-L3
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 02:47:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492Ab2BVBqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 20:46:47 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:60881 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753597Ab2BVBqq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2012 20:46:46 -0500
Received: by lagu2 with SMTP id u2so8386747lag.19
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 17:46:44 -0800 (PST)
Received-SPF: pass (google.com: domain of phil.hord@gmail.com designates 10.112.30.101 as permitted sender) client-ip=10.112.30.101;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of phil.hord@gmail.com designates 10.112.30.101 as permitted sender) smtp.mail=phil.hord@gmail.com; dkim=pass header.i=phil.hord@gmail.com
Received: from mr.google.com ([10.112.30.101])
        by 10.112.30.101 with SMTP id r5mr10508801lbh.90.1329875204466 (num_hops = 1);
        Tue, 21 Feb 2012 17:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=37IR1W/GPkO2ZhRdnOa9vk/cBNW0wOts3G/r47xlq0o=;
        b=YmV1WZ8o5QTVBKZ2sLKoihxsWkhSfkO0/jP0ZUcwu/XJ3sLJqq2Tfc8BzqottM3zkm
         cHcVJVoxx5SsQkSIHtVQIqEuHo3UMGYq97MmdoLEKEelGrnMKagtAE0y+BVdZEG3677J
         XxCdNiDg7kcoZjfTHH7ee0UmNo/ozB4puuNjw=
Received: by 10.112.30.101 with SMTP id r5mr8711022lbh.90.1329875204368; Tue,
 21 Feb 2012 17:46:44 -0800 (PST)
Received: by 10.112.4.101 with HTTP; Tue, 21 Feb 2012 17:46:24 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191217>

I accidentally ran into this today:
    $ git cherry-pick 1147
    fatal: BUG: expected exactly one commit from walk

git log shows no output:
    $ git log 1147

Neither of these are very helpful or reassuring.  I tried a few things
but I haven't looked the code yet.  I found lots of inconsistencies
along the way.

$ git clone https://github.com/git/git
$ cd git

$git log 114
fatal: ambiguous argument '114': unknown revision or path not in the
working tree.
Use '--' to separate paths from revisions

$ git checkout 114
error: pathspec '114' did not match any file(s) known to git.
$ git merge 114
fatal: '114' does not point to a commit
$ git cherry-pick 114
fatal: ambiguous argument '114': unknown revision or path not in the
working tree.
Use '--' to separate paths from revisions

$ git checkout 1147
fatal: reference is not a tree: 1147
$ git merge 1147
error: 1147: expected commit type, but the object dereferences to blob type
fatal: '1147' does not point to a commit
$ git cherry-pick 1147
fatal: BUG: expected exactly one commit from walk
$ git log 1147

$ git checkout 1146
error: short SHA1 1146 is ambiguous.
error: pathspec '1146' did not match any file(s) known to git.
$ git merge 1146
error: short SHA1 1146 is ambiguous.
fatal: '1146' does not point to a commit
$ git cherry-pick 1146
error: short SHA1 1146 is ambiguous.
error: short SHA1 1146 is ambiguous.
fatal: ambiguous argument '1146': unknown revision or path not in the
working tree.
Use '--' to separate paths from revisions
$ git log 1146
error: short SHA1 1146 is ambiguous.
error: short SHA1 1146 is ambiguous.
fatal: ambiguous argument '1146': unknown revision or path not in the
working tree.
Use '--' to separate paths from revisions

I can understand some of the inconsistent error reporting (checkout
may expect filenames, but cherry-pick and merge do not).  But this
seems too varied to me.

And the first two look like bugs.

Any comments or suggestions?

Phil
