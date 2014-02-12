From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCH] Make the global packed_git variable static to sha1_file.c.
Date: Wed, 12 Feb 2014 20:29:55 +1300
Message-ID: <52FB22F3.8070100@gmail.com>
References: <20140212015727.1D63A403D3@wince.sfo.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Stefan Zager <szager@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 12 08:30:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDUGj-0008K8-0O
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 08:30:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbaBLH37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 02:29:59 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:42455 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbaBLH36 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 02:29:58 -0500
Received: by mail-pb0-f53.google.com with SMTP id md12so8817365pbc.26
        for <git@vger.kernel.org>; Tue, 11 Feb 2014 23:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=9TYAcUKSuq7vjM8APxj4YoLguP1/FEwlrMqI2sT2cjk=;
        b=UarsnovEafrBPuaNJ69nshaaAejOpu8PAekta/w0yD/TgTQK3lKx1ZvOgove/tgF2Y
         gF8+ZVQa3nWguubxz1K68Gxgbd9AgyCRU0FgneaueaNr8ad4JwikvXWlyZQ6LIyJwSOt
         fskRVJ4Gnw2Tsj1D14vYdL+QjXqdp5H6i0obPyTzAsTAvjGpSv/SW51WjzaSZqct+6tk
         K5Lhcwm+jKJ2XQpvllap4xMO6EY+0rnsD9C7zzCiFAiov+DPdWIkHnDWgCROI0d04irN
         6M2RK4gVn/Q5XfSFw1WBI+WKq9aNapKZUL4mYwufVsITKjHPRhmgYheT38mSFRhuHoR5
         K0IQ==
X-Received: by 10.66.141.165 with SMTP id rp5mr37762851pab.90.1392190198469;
        Tue, 11 Feb 2014 23:29:58 -0800 (PST)
Received: from linux.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id i10sm154372780pat.11.2014.02.11.23.29.56
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 11 Feb 2014 23:29:58 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140212015727.1D63A403D3@wince.sfo.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241975>

Hi,

On 12/02/14 14:57, Stefan Zager wrote:
> From b4796d9d99c03b0b7cddd50808a41413e45f1129 Mon Sep 17 00:00:00 2001
> From: Stefan Zager <szager@chromium.org>
> Date: Mon, 10 Feb 2014 16:55:12 -0800
> Subject: [PATCH] Make the global packed_git variable static to sha1_file.c.
> 
> This is a first step in making the codebase thread-safe.  By and
> large, the operations which might benefit from threading are those
> that work with pack files (e.g., checkout, blame), so the focus of
> this patch is stop leaking the global list of pack files outside of
> sha1_file.c.
> 
> The next step will be to control access to the list of pack files
> with a mutex.  However, that alone is not enough to make pack file
> access thread safe.  Even in a read-only operation, the window list
> associated with each pack file will need to be controlled.
> Additionally, the global counters in sha1_file.c will need to be
> controlled.
> 
> This patch is a pure refactor with no functional changes, so it
> shouldn't require any additional tests.  Adding the actual locks
> will be a functional change, and will require additional tests.
> 
> Signed-off-by: Stefan Zager <szager@chromium.org>
> ---
>  builtin/count-objects.c  |  44 ++++++-----
>  builtin/fsck.c           |  46 +++++++-----
>  builtin/gc.c             |  26 +++----
>  builtin/pack-objects.c   | 188 ++++++++++++++++++++++++++++-------------------
>  builtin/pack-redundant.c |  37 +++++++---
>  cache.h                  |  16 +++-
>  fast-import.c            |   4 +-
>  http-backend.c           |  28 ++++---
>  http-push.c              |   4 +-
>  http-walker.c            |   2 +-
>  pack-revindex.c          |  20 ++---
>  server-info.c            |  35 +++++----
>  sha1_file.c              |  35 ++++++++-
>  sha1_name.c              |  18 ++++-
>  14 files changed, 315 insertions(+), 188 deletions(-)

I'm not really qualified to comment on substance but there are some
basic style issues w.r.t. whitespace namely using 4 spaces for indent
and mixing tabs/spaces. This might seem pedantic for the first round of
a patch but it does put off reviewers.

>From Documentation/CodingGuidelines:

 - We use tabs to indent, and interpret tabs as taking up to
   8 spaces.
