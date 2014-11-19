From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/4] lock_ref_sha1_basic: simplify error code path
Date: Tue, 18 Nov 2014 18:00:09 -0800
Message-ID: <20141119020009.GR6527@google.com>
References: <20141119013532.GA861@peff.net>
 <20141119013739.GC2135@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>, sahlberg@google.com,
	gitster@pobox.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 03:00:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XquZ4-0008D0-EN
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 03:00:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754206AbaKSCAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 21:00:08 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36486 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542AbaKSCAH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 21:00:07 -0500
Received: by mail-ig0-f171.google.com with SMTP id uq10so2125955igb.10
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 18:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KF67WPkDcvrNvSRDeeKJ8RfvIojPV4fwYSToh0rpBIw=;
        b=dsaCn12dYXdX0QYmp5qKZukwIiPZwPy0uYLZg8RuoEt+BbEF5wKpPTeMufG/RuRk5X
         UUOvnAHUDbmqQIBCaVcTWJ23v0XJrpiB4QpiHZwEzaHaD8J9yoTBwlPPmGZCqrVGT3bP
         CmZST8YfYB3W828S2zBYvSenVtt76WVqsTDoDxwcPe0vMeL+3OV4AevvOpT9X0PBs6jA
         5eYEJm3mBLeHXu5TKNxdFZiQ6sbbPffDbInvQgWRcW1IxcKZtzx0ceTlxznuauzy2eXX
         RpP6lGOqaEOVROnUA+J5UGpuGHvaR2gIrLkbzW9UHxtBOVMShhP/4JvH7dl+FBT6nzZw
         L7rg==
X-Received: by 10.50.66.144 with SMTP id f16mr7468654igt.3.1416362406520;
        Tue, 18 Nov 2014 18:00:06 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:48de:79f7:30eb:4507])
        by mx.google.com with ESMTPSA id c17sm156534ioc.9.2014.11.18.18.00.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Nov 2014 18:00:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141119013739.GC2135@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> For most errors, we jump to a goto label that unlocks the
> ref and returns NULL. However, in none of these error paths
> would we ever have actually locked the ref. By the time we
> actually take the lock, we follow a different path that does
> not ever hit this goto (we rely on verify_lock to unlock if
> it finds an error).
[...]
>  refs.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

Wouldn't this leak lock (in all cases) and lock->ref_name and
lock->orig_ref_name (on safe_create_leading_directories failure)?
