From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v6 6/7] git-reflog: add create and exists functions
Date: Tue, 07 Jul 2015 20:49:37 -0400
Organization: Twitter
Message-ID: <1436316577.5521.25.camel@twopensource.com>
References: <1435609076-8592-1-git-send-email-dturner@twopensource.com>
	 <1435609076-8592-7-git-send-email-dturner@twopensource.com>
	 <559AB200.5020108@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jul 08 02:49:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCdYY-0003pX-Ng
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 02:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753835AbbGHAtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 20:49:42 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36031 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580AbbGHAtk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 20:49:40 -0400
Received: by qkei195 with SMTP id i195so152822979qke.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 17:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=C9TW8T+8f+2wfiLgjdTO1wJ2y1sxMZEtgqUgTN+YRig=;
        b=Cq0dZ/X9rN//V1GSpRNizfM2GlC7i73wg9YCyhjBnkjA3nbOaqpCgQ/gOiBxbrTY/F
         KyuVnkWrzuKuSyrxwAbgOcKUZPJKnenVxmdhl0fOOMZy7tDpfpIRk0D/00benCBs3gRJ
         4eCTye1LvitwKzepM6I2YJ/O5jQ0n1w+DeybjCn+g31eDYheh2uvWSwT84cFkzy0Jcj/
         /Va3ekV33ioZlogBz8QYZvHAeKfBeO6qzyVsXprgSC6faL7lgeveyhDEnua2LBnH+eDi
         RPxRSlFfe+LdVtFFhoWaVQF9l0GFfm3VDrtisLZ7/zTw3DHlvzHeLHkDH0uu9DNRq9yv
         iijg==
X-Gm-Message-State: ALoCoQljhmddntcyoOKQVNJkD7eCy9YQeENIRvZYeewqlFxQ/Elo5mPQMNO9bKjQT0s11oo/9B1j
X-Received: by 10.55.15.99 with SMTP id z96mr11614161qkg.75.1436316579821;
        Tue, 07 Jul 2015 17:49:39 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id m134sm267831qhb.30.2015.07.07.17.49.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2015 17:49:38 -0700 (PDT)
In-Reply-To: <559AB200.5020108@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273621>

On Mon, 2015-07-06 at 18:51 +0200, Michael Haggerty wrote:

> > +{
> > +	int i, status = 0, start = 0;
> 
> It looks like start is initialized unconditionally after the first loop,
> so the initialization here is a red herring.

Will fix.

> So, I have a philosophical question here with a practical side...
> 
> It appears that this command allows you to create a reflog for a
> reference that doesn't yet exist. At first blush, this seems to make
> sense. Suppose you want the creation of a reference to be logged. Then
> you can first turn on its reflog, then create it.
> 
> But I think this is going to create problems. Reflogs are rather
> intimately connected to their references. For example, writes to a
> reflog are guarded by locking the corresponding reference. And currently
> a reflog file is deleted when the corresponding reference is deleted.
> Also, there are constraints about which references can coexist; for
> example, references "refs/heads/foo" and "refs/heads/foo/bar" cannot
> exist at the same time, because (at least when using the filesystem
> backend), "refs/heads/foo" would have to be both a file and a directory
> at the same time. So if one of these references already exists, it would
> be an error to create a reflog for the other one.
> 
> Similarly, if there is a reflog file for one of these references that
> was created by this command, but there is not yet a corresponding
> reference, then any command that later tries to create the other
> reference will not be able to create the reflog for *that* reference
> because it will conflict with the existing reflog. I doubt that the
> reference creation is smart enough to deal with this situation.
> 
> So all in all, I think it is unwise to allow a reflog to be created
> without its corresponding reference.
> 
> This, in turn, suggests one or both of the following alternatives:
> 
> 1. Allow "git reflog create", but only for references that already exist.

This turns out not to work for git stash, which wants to create a reflog
for stash creation.

> 2. If we want to allow a reflog to be created at the same time as the
> corresponding reference, the reference-creation commands ("git branch",
> "git tag", "git update-ref", and maybe some others) probably need a new
> option like "--create-reflog" (and, for symmetry, probably
> "--no-create-reflog").

git branch should already autocreate reflogs, since the refs it creates
are under refs/heads.

> At the API level, it might make sense for the ref-transaction functions
> to get a new "REF_FORCE_CREATE_REFLOG" flag or something.

Junio was opposed to the converse flag, so I'm going to just add
manually add code to create reflogs.
