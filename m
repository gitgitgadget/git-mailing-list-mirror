From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 00/43] refs lmdb backend
Date: Wed, 16 Sep 2015 20:09:12 -0400
Organization: Twitter
Message-ID: <1442448552.5140.3.camel@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
	 <xmqqfv2vgkve.fsf@gitster.mtv.corp.google.com>
	 <1441382482.25570.33.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 02:09:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcMlL-0004zb-3M
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 02:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753029AbbIQAJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 20:09:16 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33700 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbbIQAJP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 20:09:15 -0400
Received: by qkdw123 with SMTP id w123so843346qkd.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 17:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=oyh/b+DzEozbjPF6aQyvheif9e5lqAtKTr7g7WJqLsw=;
        b=EzVJCf+ggrGHfF01UTUjylQvm9iEWLaXdXYwTuSZwd8WN66VeWH+aUik6xQ0C1n8go
         F984oTyfiC6wtRg7s5pMxG8wDIV63ZDw3An6Fd9IRYtJE8zec9MDrNVMJ0E6H0sq9Kwo
         444xyevFalgEKy/XZIIpAzttK+93yJBbmpscXnrUHuZU57+wVRQu4YKF7yiDWvCQgjem
         daP7uE4GJdO+Y99QRcw0nkJx7A2iZ5N6DAAHT87mi3ychodjA/24bf8Kb1VnhSUDsIMm
         e6Lm99fUeUKAy+7FBx2nFJHR6hIuFVLXNGL2WMgFA9SUCz3VZ2Eun8rSDEbwFGCPBJay
         wQQQ==
X-Gm-Message-State: ALoCoQkhW7O9uIIwOmG78hWjseydVN9ufeMHZrFI8k2U91joX4Tux7qJyoosnLKqheqFiHYkhlD9
X-Received: by 10.55.221.79 with SMTP id n76mr45794051qki.62.1442448554180;
        Wed, 16 Sep 2015 17:09:14 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id k64sm174952qhk.2.2015.09.16.17.09.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2015 17:09:13 -0700 (PDT)
In-Reply-To: <1441382482.25570.33.camel@twopensource.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278089>

On Fri, 2015-09-04 at 12:01 -0400, David Turner wrote:
> On Thu, 2015-09-03 at 16:10 -0700, Junio C Hamano wrote:
> > David Turner <dturner@twopensource.com> writes:
> > 
> > > I think I've broken about all of the standalone stuff out, so here's
> > > the main enchilada.
> > >
> > > This series depends on at least the following topics in pu:
> > > dt/refs-bisection
> > > dt/refs-pseudo
> > > dt/reflog-tests
> > > kn/for-each-tag (patch 21 and corresponding bits of 42 depend on this;
> > > we could skip them, but I wanted this to apply on top of pu)
> > >
> > > As before, I tested by hacking the test suite to run under the lmdb
> > > backend and changing a few dozen tests.  The remaiing failures are
> > > documented in Documentation/technical/refs-be-lmdb.txt, except for one
> > > in t1404 where this version gives a different error message (but still
> > > an error).
> > >
> > > As Jeff King suggested last time I sent this around, I've made the
> > > reflog format slightly more efficient.  Now it stores shas in a binary
> > > format, and only uses a header entry if there are no real entries.
> > >
> > > Also, now per-worktree refs live in the filesystem.
> > >
> > > I've also made a number of fixes to memory leaks, formatting,
> > > factoring, etc.
> > >
> > > As Michael Haggerty suggested, I'm now using struct ref_transaction as
> > > a base struct for the ref transaction structs.
> > >
> > > Looking forward to reviews.
> > 
> > [03/43] seems to be missing
> 
> I just attempted to re-send it, but I still don't see it on gmane.
> Perhaps this is because it is greater than some size limit?  It's about
> 265k.  I've attached a gzipped version to this email.  

Just wanted to send a ping on this series.  I know it's a big set of
changes to review.  Let me know if there's anything else I can do to
help here.
