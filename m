From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCHv4] clone --single: limit the fetch refspec to fetched branch
Date: Mon, 17 Sep 2012 19:06:06 +0700
Message-ID: <CACsJy8Bsps_-RaXdBd9ipWPvJukjK7mRN_wG2ezEL5d4JLyx+g@mail.gmail.com>
References: <7vy5kc1avx.fsf@alter.siamese.dyndns.org> <1347783184-20045-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 14:07:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDa74-0008P8-EU
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 14:07:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756010Ab2IQMGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 08:06:38 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:56690 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755973Ab2IQMGh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 08:06:37 -0400
Received: by qcro28 with SMTP id o28so4372466qcr.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 05:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=un7udk9EiE4qsVh4TO4wFlUGavlcKa8QZ/viVyMczdU=;
        b=RHiR7i+B54R1YsiudFDtUbL/JPWngR1vTQFzr4qSbgQlVYtkw7pHuGPzARRqEXl1cR
         7SSd29VnCqqa7zueoOVLkSliVxLYUbXvOFaayUnwGjJJvlz4g/ls41j1VPjyecqQFD0T
         BzS4ldFkl25m3ugtA2b3ZN+CqtmIXsFY8f/OkUut4bqAIj+oNV8nvnasxY0CPJD6SgRb
         FczYxRvdw6BBZvqM0T0P8/XFH72R+5+0f2aBQ4qhnOiwHMrV8wdUmoSIZFk3kJw0DQPM
         N15I9u38xxnHeNQL3vKGecQzHBIZxIvmA+N7XWbgrp3h+wDxjZSfBcgC0Jn+sXqdfr2n
         tlAA==
Received: by 10.224.117.82 with SMTP id p18mr26856183qaq.21.1347883596915;
 Mon, 17 Sep 2012 05:06:36 -0700 (PDT)
Received: by 10.49.72.201 with HTTP; Mon, 17 Sep 2012 05:06:06 -0700 (PDT)
In-Reply-To: <1347783184-20045-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205677>

On Sun, Sep 16, 2012 at 3:13 PM, Ralf Thielow <ralf.thielow@gmail.com> wrote:
> +       if (option_mirror || !option_bare) {
> +               strbuf_reset(&value);

I think we should use a new strbuf local variable here to avoid
resetting this. At least reviewers don't have to check if this
statememt causes any effect later on because "value"'s value is gone.

> +               if (option_single_branch) {
> +                       if (option_branch)
> +                               strbuf_addf(&value, "+%s%s:%s%s",
> +                                               src_ref_prefix, option_branch,
> +                                               branch_top.buf, option_branch);
> +                       else if (remote_head_points_at)
> +                               strbuf_addf(&value, "+%s:%s%s",
> +                                               remote_head_points_at->name, branch_top.buf,
> +                                               skip_prefix(remote_head_points_at->name, "refs/heads/"));
> +                       /*
> +                        * otherwise, the next "git fetch" will
> +                        * simply fetch from HEAD without updating
> +                        * any remote tracking branch, which is what
> +                        * we want.
> +                        */

Maybe document updates too? Though if it's obvious that
--single-branch should prepare refspec so that only one branch is
fetched later on, then maybe not.

> +               } else {
> +                       strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
> +               }

--mirror --single-branch combination does not look right. The "heads/"
part is missing..

$ git branch
  master * wildmatch
$ LANG=C ./git clone --mirror --single-branch .git abc
Cloning into bare repository 'abc'...
done.
$ grep fetch abc/config
        fetch = +refs/heads/wildmatch:refs/wildmatch
$ rm -rf abc
$ LANG=C ./git clone --mirror --single-branch --branch=master .git abc
Cloning into bare repository 'abc'...
done.
$ grep fetch abc/config
        fetch = +refs/master:refs/master
-- 
Duy
