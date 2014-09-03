From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] cache-tree: do not try to use an invalidated subtree
 info to build a tree
Date: Wed, 3 Sep 2014 08:02:58 -0400
Message-ID: <CAPig+cQQH_W+J7=B4PWfUVfJpSqN69nLtK8PR3BPmokEBpD2cg@mail.gmail.com>
References: <1405140276-32162-1-git-send-email-dturner@twitter.com>
	<20140831120703.GA1240@serenity.lan>
	<xmqqfvg9zqw9.fsf@gitster.dls.corp.google.com>
	<xmqq8um1zq1q.fsf@gitster.dls.corp.google.com>
	<xmqq4mwpzpfw.fsf_-_@gitster.dls.corp.google.com>
	<xmqqvbp5y7ef.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, John Keeping <john@keeping.me.uk>,
	David Turner <dturner@twopensource.com>,
	David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 14:03:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XP9Ha-0004X8-HT
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 14:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755893AbaICMDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 08:03:00 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:64299 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760AbaICMC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 08:02:59 -0400
Received: by mail-yk0-f170.google.com with SMTP id 142so5037249ykq.29
        for <git@vger.kernel.org>; Wed, 03 Sep 2014 05:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=G6URPodgCPRDfthqWhPdkTdpmN41NSFK5uIidNl5Nug=;
        b=AYbLTt5iBRpJVqmY190My+CRS/LZt2DOWQmCM9cM40tWfLoGpAB6UZ2hLRuyb/qcEZ
         yTLQRntEJXomhLasi4/pmsegMSiMjJYkQBe6XRvhW2iEg3wFVdogGgYYpd5f3tfsp3+V
         LP6D7caNfvMMVzAg1tXxWRE2Ejdm6Eabuf5H9HhhlhYRbwihF0UYTWLRbeQUziu2K3uO
         O+NXCscbvmW0BEJf5mNwjEJLv+m4wz6fX8hsK0HAlaWva9hdbWNn1rT4H57HEFTk3J0o
         49Fr26nXGhjq2ue0ESCy76AQtSJgeZn+EEjY5lj4CMDXQbqMwY1rzG0123SkkRTwuxqn
         KeJg==
X-Received: by 10.236.19.196 with SMTP id n44mr61346917yhn.83.1409745779021;
 Wed, 03 Sep 2014 05:02:59 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Wed, 3 Sep 2014 05:02:58 -0700 (PDT)
In-Reply-To: <xmqqvbp5y7ef.fsf_-_@gitster.dls.corp.google.com>
X-Google-Sender-Auth: dQtwGo-zN_R4JrofWjo4SSX3-Yk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256389>

On Tue, Sep 2, 2014 at 6:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> We punt from repairing the cache-tree during a branch switching if
> it involves having to create a new tree object that does not yet
> exist in the object store.  "mkdir dir && >dir/file && git add dir"
> followed by "git checkout" is one example, when a tree that records
> the state of such "dir/" is not in the object store.
>
> However, after discovering that we do not have a tree object that
> records the state of "dir/", the caller failed to remember the fact
> that it noticed the cache-tree entry it received for "dir/" is
> invalidated, it already knows it should not be populating the level
> callchain to stop the code to attempt populating the level that has
> "dir/" as its immediate subdirectory, and it is not an error at all
> for the sublevel cache-tree entry gave it a bogus object name it
> shouldn't even look at.
>
> This led the caller detect and report a non-existent error.  The end

s/caller/caller to/

> result was the same and we avoided stuffing a non-existent tree to
> the cache-tree, but we shouldn't have issued an alarming error
> message to the user.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
