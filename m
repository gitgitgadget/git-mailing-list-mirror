Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAE0B1FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 14:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbdCMOzO (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 10:55:14 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33562 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751920AbdCMOzN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 10:55:13 -0400
Received: by mail-wm0-f51.google.com with SMTP id v203so8660539wmg.0
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 07:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xnFhtt90bNt732oO2zUyM+dqcehfmf/GHzjCmI7Sqmw=;
        b=VE24tk/b4h9BrJf8Oe3o4NIGNQ6sW81d/Jy3KZT27iXcr/NsTndaH2W41X5ubucqT7
         rtqsz4c8pGccgbdar82r+SP+2c6av/kLSbzgzScEk9yMc2nqAQ/96iJMX/6U5I0UpqeZ
         YH3jh5OICggA1ZXF9nlmw/Nv31RIFhSuuNHEeBZfDtm259hP0RkTkIcPL/v67QwcV6PB
         4lMK8VezxVfsfET2nIPomOPUIx62OjxfFaIE+XSr+guQKKv9YnoXoS2C4xabHAkkxOSv
         CNCjxRz9Zi8qCSyjL52Nb6+wMY++RrNwMM3qzJtrLZf+8EBQ74AGPQVGEpvLMUDMJJiK
         qsAw==
X-Gm-Message-State: AFeK/H2QBa7PMbU/9xxCcSlViOFmxF8Mg3ELBgF0vwqTI0Zvduya+qfD2R+NbAxdlNAwSA==
X-Received: by 10.28.196.68 with SMTP id u65mr10895112wmf.8.1489416911012;
        Mon, 13 Mar 2017 07:55:11 -0700 (PDT)
Received: from caroline.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q5sm25509593wrd.32.2017.03.13.07.55.08
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Mar 2017 07:55:09 -0700 (PDT)
Received: by caroline.localdomain (Postfix, from userid 1000)
        id 7971712054D; Mon, 13 Mar 2017 15:55:08 +0100 (CET)
Date:   Mon, 13 Mar 2017 15:55:08 +0100
From:   Martin Kletzander <mk@linux.com>
To:     git@vger.kernel.org
Subject: Possible tiny bug in reset's error message
Message-ID: <20170313145508.GA3222@wheatley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

when I was trying to learn some details about various types of resets, I
found out that the default reset type is --mixed, but not specifying it
is not the same as specifying it.  That's mostly because there are some
checks for reset_type before setting it to default value.  Since one of
the checks seem deliberate, I'm rather asking here before sending wrong
patch.

The "bug" I am talking about is:

  $ g reset -p --mixed
  fatal: --patch is incompatible with --{hard,mixed,soft}
  $ g reset -p
  No changes.

Despite the fact that `git help reset` says:

  If <mode> is omitted, defaults to "--mixed".


The reason why I'm rather asking is the part of the code that handles
the warning message for:

  $ git reset --mixed -- path
  warning: --mixed with paths is deprecated; use 'git reset -- <paths>'
  instead.

Specifically:
	/* git reset tree [--] paths... can be used to
	 * load chosen paths from the tree into the index without
	 * affecting the working tree nor HEAD. */
	if (pathspec.nr) {
		if (reset_type == MIXED)
			warning(_("--mixed with paths is deprecated; use 'git reset -- <paths>' instead."));
		else if (reset_type != NONE)
			die(_("Cannot do %s reset with paths."),
					_(reset_type_names[reset_type]));
	}

See how NONE and MIXED are both purposefully checked?

So my question is, should reset_type be set to MIXED if it was not
specified on the command-line before all these checks?  If not, what's
the reason for that?

Have a nice day,
Martin
