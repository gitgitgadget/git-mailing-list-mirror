From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 5/8] branch: drop non-commit error reporting
Date: Wed, 23 Sep 2015 15:50:14 -0700
Message-ID: <xmqqeghowy1l.fsf@gitster.mtv.corp.google.com>
References: <1443031873-25280-1-git-send-email-Karthik.188@gmail.com>
	<1443031873-25280-6-git-send-email-Karthik.188@gmail.com>
	<xmqqfv25x80c.fsf@gitster.mtv.corp.google.com>
	<vpq6130ucbh.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 24 00:50:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zesrn-0002fo-M3
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 00:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137AbbIWWuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 18:50:18 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36346 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754887AbbIWWuR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 18:50:17 -0400
Received: by pacgz1 with SMTP id gz1so3106639pac.3
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 15:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=av6NBGeCsI8WreTjykEg3tpIK9vbd3jB293yZt0eQyc=;
        b=gq6e/hkEe+B5K9ojENh30GooUz6rIm3PlBbxiyCR0CdIQdtNM49HUeUpSr77CygbPX
         MF0w56zUEpeCmKKGQLc5vXEuLILEzsvy1re5SVVoWszcjsVgtQLQ4Gqa8Fh2MkQBbzjK
         ePt4dypGon97+DkFKm8cDMwEPsV1U2VR3IdXH3ZSdvmnCYncFiKf/cxi+i/aBY++iayj
         u+CBRm8SbCj4fjA642hyyEWpueDomhGXwCqmFGpntuc26s7cQ4GqD5nyrtO1Ofpas5lM
         P01xBSvH0+ZMYtPr5/RrTwe3DY4GXc+jxBYuUnPQdvkoR0Lu4sFss173N02fGP1O4bFp
         5Duw==
X-Received: by 10.68.200.40 with SMTP id jp8mr41242390pbc.16.1443048616965;
        Wed, 23 Sep 2015 15:50:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:a07c:76d3:22e9:4d3d])
        by smtp.gmail.com with ESMTPSA id qa5sm9841071pbc.70.2015.09.23.15.50.15
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 23 Sep 2015 15:50:16 -0700 (PDT)
In-Reply-To: <vpq6130ucbh.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Wed, 23 Sep 2015 22:10:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278518>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> To be sure, I tried:
>
>   echo ee0f5eeeae36cd1b5a346a1e2ae5c8cb841cd5da > .git/refs/heads/broken
>
> where the sha1 is the one of a blob.
> ...

After doing (something like) the above, running "git push --mirror"
to various Git repositories shows their slightly different
behaviour.

The most intriguing one was github.com:gitster/git.git repository.

To github.com:gitster/git.git
 ! [remote rejected] jk/transfer-limit-protocol -> jk/transfer-limit-protocol (failed)
 ! [remote rejected] ls/p4-lfs -> ls/p4-lfs (failed)
 ...
 ! [remote rejected] pu -> pu (failed)
 ! [remote rejected] broken -> broken (failed)
 ! [remote rejected] jc/fsck-dropped-errors -> jc/fsck-dropped-errors (failed)
 ! [remote rejected] kn/for-each-branch -> kn/for-each-branch (failed)

After removing the broken branch, retrying "git push --mirror
github.com:gitster/git.git" was successful.  I didn't dig further
(it didn't reproduce with a pair of toy local repositories).

It is puzzling that it is behaving as if I am trying to perform an
atomic push and rejection of "broken" is causing everything else to
be rejected or something like that.

Perhaps GitHub has a pre-receive hook to reject such nonsense?
