From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [ANNOUNCE] git reintegrate v0.3; manager of integration branches
Date: Tue, 20 May 2014 16:06:41 -0500
Message-ID: <537bc3e1c605c_a6f166b3088f@nysa.notmuch>
References: <53795175664d5_10da88d308ce@nysa.notmuch>
 <xmqqha4lxyqt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 23:17:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmrQ6-000557-VF
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 23:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbaETVRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 17:17:54 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:56254 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbaETVRx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 17:17:53 -0400
Received: by mail-ob0-f170.google.com with SMTP id uy5so1165609obc.15
        for <git@vger.kernel.org>; Tue, 20 May 2014 14:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=ZoQgGdtcjYwtaYgGPz7KGWnnE/dDCYVIhFglj0ZzQBA=;
        b=iLxlOBHpi5ec/QILixA0kaeDTnd1D5oIWYvscyyVstRt8Bza8D8nocDLiGyjx2XJYQ
         4vxsR87OwtAdGj9FhjQcXRiksYq4ErfB7zFGgUSo/47yFpeiL4oKxBOaDC79Px0TLvyT
         ANbr7ZAKWjPGDkuuPxmmAYGSJAOoCgBubvM23viMVuquHki20AOpcie8xK9vHhz5XDIl
         +VGlaYzPNidJX1kwkUFE7cdhVbkb1Lv7sQDboglECN8ngeh1uZmR6900yM7WiFmU0rmy
         GrOmZidpXaPi04XkVanXTyjAa0csDKk8CZpp5iAyyIv9kaeixRrXdBWqrqt7aSixCHI2
         vEEw==
X-Received: by 10.182.60.4 with SMTP id d4mr47082397obr.4.1400620673502;
        Tue, 20 May 2014 14:17:53 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ko3sm52261265oeb.1.2014.05.20.14.17.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 May 2014 14:17:52 -0700 (PDT)
In-Reply-To: <xmqqha4lxyqt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249745>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > ...
> > Which will generate the integration instructions for you:
> >
> >   % git reintegrate --cat
> >   base master
> >   merge jl/submodule-mv
> >
> >     Moving a regular file in a repository with a .gitmodules file was
> >     producing a warning 'Could not find section in .gitmodules where
> >     path=<filename>'.
> >
> >   merge ap/remote-hg-unquote-cquote
> >
> > It also has support for "evil merges", so it should be perfectly
> > usable for git.git maintenance.
> 
> Yeah, it sounds like it is almost there.
> 
> I think the infrastructure to maintain "What's cooking" could be
> updated to use these comments after "merge" instructions if I wanted
> to.
> 
> I build two branches on top of 'master', one is called 'jch' and has
> a marker line somewhere that says '### match next' that is turned
> into an empty commit, and 'pu' that is built on top of the tip of
> 'jch'.  The marker line is used to apply only an earlier part of the
> instruction stream to build 'jch' on top of 'master' on top of
> 'next' (i.e. "base master" in the above example will not be applied
> to hard-reset 'next' to match master) and stop there, and is meant
> to be a way to sanity check 'next' (which is made by repeated
> incremental merges on top of 'master' without rewinding) by
> comparing the "### match next" commit between 'master' and 'jch'
> (which is made afresh from 'master' by taking only the necessary
> topics).  They must match or I caught a possible mismerge on 'next'.
> 
> I presume that the workflow can be mimicked by having another branch
> 'match-next' and building it on top of 'master', and then building
> 'jch' on top of it, and then building 'pu' on top of it.  Then you
> should be able to play 'match-next' instruction on top of 'next'
> (provided that there is a way to tell it to replay on HEAD and
> ignore "base" and have "merge" instruction become a no-op when the
> branch has already been merged)

Or have an option to specify a dynamic instruction sheet, so you can cat
the instructions of 'match-next' and replace the base. However, I don't
see the point of re-applying the branches for 'next' if you already know
that 'next' and 'match-next' are the same.

I would have two branches: 1) 'match-next' (or 'integration-next') that
has the instructions to build 'next' on top of 'master', and 2) 'pu',
which has the instructions to build 'pu' on top of 'next'.

-- 
Felipe Contreras
