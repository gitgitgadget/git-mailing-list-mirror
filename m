From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/3] worktree: add top-level worktree.c
Date: Mon, 21 Sep 2015 18:17:16 -0700
Message-ID: <xmqq7fnj6yn7.fsf@gitster.mtv.corp.google.com>
References: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
	<1441402769-35897-2-git-send-email-rappazzo@gmail.com>
	<CAPig+cQRx-uKZnnx2O0pG34HkcEdg1GbGNFd9PHdw+m0O3aJEA@mail.gmail.com>
	<CANoM8SWP9YrZoUx5w9Do18uZf=5RrCV_ShvyaPQF4=9-vuFVbg@mail.gmail.com>
	<CAPig+cRPbFw8oTQ63rPtp1cyKms9zi0QkZNvkOWZoxb+mnpZrA@mail.gmail.com>
	<CANoM8SWV0r9sHUTk3Rfu=psZLKmnjD19Dn_atCuDmc=41420-w@mail.gmail.com>
	<CAPig+cQjhoVhQtP4_ZYTyLX3-GBXRx2eKM8Yv1=i=pSg=ZuM=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mike Rappazzo <rappazzo@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 03:17:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeCD1-0005qE-Ki
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 03:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757576AbbIVBRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 21:17:21 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35317 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852AbbIVBRT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 21:17:19 -0400
Received: by pacfv12 with SMTP id fv12so134475719pac.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 18:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=mUOWRHtb4yNwLGhu13Pf9wtaDCCM006yUG53eLURp6c=;
        b=mPW0AXQOHAtunx7YMmqciU050hfvcs9r/AqaFK+KipNxw+bMJip8o1B2fS4O64HGJN
         p+3LoQlYxCxws0yk5NgKQyN+GPiDOJiqXyzJHF+ulcgZFfGKah/gB1L+roAwzcCmHjaG
         x7IeCwmCzJ1rrg+XH7OJkLxyytQJHF8xvEIaBRkN1PKIT2X8xT5u9uy0pJeSI5PEVxEc
         tpmu4uSg3dbi3Oev0CX5f6zEs+0p3wGikQpjV/FoWSxrjpYRttvAsox2B0IayyaPUcFd
         w6BAF3QEWxtdHxgPc+YWJ5DkuROJgMvhjLeTt1FuPOTyS0t7fC64AGMLmrr0qgpJ15Wx
         MTfg==
X-Received: by 10.66.139.196 with SMTP id ra4mr28483784pab.88.1442884638934;
        Mon, 21 Sep 2015 18:17:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id xi1sm27080882pac.48.2015.09.21.18.17.17
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 21 Sep 2015 18:17:17 -0700 (PDT)
In-Reply-To: <CAPig+cQjhoVhQtP4_ZYTyLX3-GBXRx2eKM8Yv1=i=pSg=ZuM=Q@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 21 Sep 2015 21:05:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278374>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Making the last entry a NULL means get_worktrees() would have to
> return an array of pointers rather than an array of structures, which
> is more syntactically noisy, and complex since it's harder to reason
> about pointer-to-pointer. In my mind, at least, the simplicity of the
> array of structures approach (even with the slight ugliness of the
> dummy sentinel) outweighs the complexity of the array-of-pointers
> approach.

Hmph, I think the bog-standard way in our code is an array of
pointers.  An array of structures have a few downsides:

 - You have to copy a lot when you do realloc(3);

 - You have to move a lot when you insert a new element;

 - Individual structure cannot be pointed at by a pointer sensibly.
   Passing &worktree[4] to a function that expects "struct worktree *"
   is unsafe unless you are sure nobody is mucking with the worktree[]
   array.

For the read-only operation "worktree list", the last one may not
matter much because you would build all the elements before doing
anything else, but once you want to run this inside a library and
maintain the in-core forest of worktrees that are in sync with what
your running process does (i.e. create a new or destroy an existing
worktree), it may become problematic.
