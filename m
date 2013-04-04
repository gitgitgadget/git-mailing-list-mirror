From: Jed Brown <jed@59a2.org>
Subject: Re: [PATCH v2 11/13] remote-hg: force remote push
Date: Thu, 04 Apr 2013 15:14:33 -0500
Message-ID: <87ppyaqcie.fsf@59A2.org>
References: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com> <1365089422-8250-12-git-send-email-felipe.contreras@gmail.com> <87y5cyqhya.fsf@59A2.org> <CAMP44s1b_SWkVXe2Vyzs2yj1M9Z-2KcCXbp9LCJ_oWxuC+2pAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 22:15:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNqYs-0007OB-KN
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 22:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764724Ab3DDUOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 16:14:38 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:56900 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764690Ab3DDUOh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 16:14:37 -0400
Received: by mail-ob0-f179.google.com with SMTP id vb8so3005155obc.10
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 13:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version:content-type;
        bh=ydSbamcztUsjyQYnsvMrkmxpSdLuHpS4+c5m49YO2No=;
        b=G9TLDjFGdBlBSpfQnG/KsgTR08oSFW4z7zxZYUyWDzK/+HhbbNT7ZD7Uxm0h/M5d8+
         uozEHedNFMrtOReL9j4zyVFK4XOnZRZ5BAD+CbG+q76LI7366j1c9Z0H0gkgTSzp4YUl
         iY6/nSxA3mrm3j5DaPE3zur5+nkH8VLiTp2gvQVr6BoxVacqo74aut2JDB8ksgB0ekUw
         oxz0LN0JkTenoQO40XkOmuMj2OjQT6FStOLx5driSOQkO7bwyDtlptjKfh3EXbVysLSc
         gIrLT/gO8sLbgEgsN8Pzguc76ExnYz0rhANomF8F6uFr7u8/Qei4tEHvnocQqnuctbb6
         /kiA==
X-Received: by 10.60.9.1 with SMTP id v1mr5515584oea.130.1365106476698;
        Thu, 04 Apr 2013 13:14:36 -0700 (PDT)
Received: from localhost (vis-v410v070.mcs.anl-external.org. [130.202.17.70])
        by mx.google.com with ESMTPS id qk4sm8313144obc.5.2013.04.04.13.14.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 13:14:35 -0700 (PDT)
In-Reply-To: <CAMP44s1b_SWkVXe2Vyzs2yj1M9Z-2KcCXbp9LCJ_oWxuC+2pAg@mail.gmail.com>
User-Agent: Notmuch/0.15.2 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220087>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> If that's the case, they should disable in the server, just like some
> people disable non-fast-forward pushes in git.

I don't know how to make Hg allow new branches and bookmarks, but not
new anonymous heads.  Vanishly few Hg projects use a workflow anything
like topic branches so it's normally not a common thing to be creating
new heads.  If someone is using remote-hg, we can be pretty sure they
are not the primary maintainer, so if they are pushing, they'll be aware
of upstream policy and will need to play by those rules.

> The problem is Mercurial, purely and simple, without forcing the push,
> how do you expect this to work?
>
> % git clone hg::whatever
> % git checkout -b feature-a master
> # do stuff
> % git push -u origin feature-a

There is a difference between pushing a new branch (see 'hg push
--new-branch -b branch-name') and creating arbitrary new heads.  In a
very common case where multiple people are pushing to the same
branch/bookmark, force push creates new anonymous heads that share the
same branch.  (For less familiar readers, hg branches can have multiple
heads, though most commands will behave as though the latest head to
appear in the repository is the unique head associated with a given
branch.  Yes, it's insane.)

Normal workflow in case of new commits upstream is to 'hg pull --rebase' or
to pull and merge (yucky for first-parent, but most Hg users are far
from caring about such things).  Silently creating new anonymous heads
is a bad default.

Note: I don't know of any way to avoid the race condition when pushing
a bookmark that creates a new head since there is no 'hg push --new-bookmark'.
