From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: static variables
Date: Tue, 10 Dec 2013 17:45:01 -0800
Message-ID: <20131211014501.GI2311@google.com>
References: <CAHOQ7J-rO-KjHyYk1Gw6Wv+iH_M7DPr76t3G7YN_sUv3YqcJcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 11 02:45:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqYrP-0003dM-Ld
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 02:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424Ab3LKBpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 20:45:08 -0500
Received: from mail-yh0-f53.google.com ([209.85.213.53]:33469 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab3LKBpF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 20:45:05 -0500
Received: by mail-yh0-f53.google.com with SMTP id b20so4491779yha.26
        for <git@vger.kernel.org>; Tue, 10 Dec 2013 17:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4US/zJsSqqfyj2l9Jem05vl1rpa5A9cUeug1y34wMoU=;
        b=V9L1qWi0U6geRNsCo+cvarJRJyv7+TvXIWlobS/5vkOomZySF9Pvifd6gyog+V7VRu
         vN3lwq9vp11VlU3SYYZSneU0VD++MP7UTAf7m+1SgvBUYfofcJngwkA85mdl23+Uq8kI
         873hLHt6QMEOm+FOnzF5XVli0SwA3j2I64AD5i9WKMeG+S9x6OoDLsowvMG4diIq2AO7
         waVNZvhNE6ACo29RtUgUe5xCxZuAb/WzdRJl/QscIMCjJKjA3OHthbjYW0DSmQIKbyBN
         f+voA9aN8wPUdTXBUFIsoH7fmyc2sYmlAhOpS7GaCDl7IeFDAzcnmoV2CCGpFhRXM8kR
         LNVQ==
X-Received: by 10.236.129.135 with SMTP id h7mr3816381yhi.75.1386726305009;
        Tue, 10 Dec 2013 17:45:05 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id m68sm25641135yhj.22.2013.12.10.17.45.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 10 Dec 2013 17:45:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAHOQ7J-rO-KjHyYk1Gw6Wv+iH_M7DPr76t3G7YN_sUv3YqcJcg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239166>

Stefan Zager wrote:

> This is probably a naive question, but: there are quite a lot of static
> variables in the git code where it's really unnecessary.  Is that just a
> historical artifact, or is there some reason to prefer them?

Sometimes it's for convenience.  Other times it's to work around C89's
requirement that initializers can't include pointers to automatic
variables, so when using parse_options, old commands tend to use
statics for the variables initialized by options.  (Since then, git
has stopped following that so rigidly, which is probably a good
thing.)

Worse, some functions have static buffers when they need a large
buffer and want to avoid too much allocation churn.  As a general
rule, historically very little of git's code (mostly pack related)
needed to be usable with threads, though of course it would be
excellent to fix more code to be thread-safe.

> As an example, here's an excerpt from symlnks.c.  In addition to being
> static, if I'm reading this right, it appears that the 'removal' variable
> is used before it's initialized:

statics are allocated from the .bss section, where they are zeroed
automatically.

> static struct removal_def {
>   char path[PATH_MAX];
>   int len;
> } removal;

Plumbing this through the call stack instead of using a static sounds
like a good idea.  That would mean allocating the removal_def in
unpack-trees.c::check_updates, I think (see v1.6.3-rc0~147^2~16,
"unlink_entry(): introduce schedule_dir_for_removal()", 2009-02-09 for
context).  Then the loop could be divided into chunks that each use
their own removal_def or something.

Sometimes when git needs parallelism and threads don't work, it uses
fork + exec (aka run_command).  Making the relevant functionality
thread-safe is generally much nicer, though.

Thanks and hope that helps,
Jonathan
