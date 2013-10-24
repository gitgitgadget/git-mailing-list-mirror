From: Maarten de Vries <maarten@de-vri.es>
Subject: Fwd: Bug report: reset -p HEAD
Date: Fri, 25 Oct 2013 01:05:03 +0200
Message-ID: <CAPWpf+x5KUjD2K81pJAsV_XuPkd=BT06qPjvr8s7tEe5YqBt=w@mail.gmail.com>
References: <CAPWpf+wi0zH2sOnuqiZuKkf+kC0RMug_ASb-J-TGGLd2RFT1wg@mail.gmail.com>
 <CAPWpf+xqutvhq1jyVkxr6LyKsANTCS6M=vj5XY=EgUfiS3Z8xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 25 01:05:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZTy5-0000X5-4N
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 01:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755133Ab3JXXFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 19:05:25 -0400
Received: from mail-qc0-f176.google.com ([209.85.216.176]:51172 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722Ab3JXXFY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 19:05:24 -0400
Received: by mail-qc0-f176.google.com with SMTP id s19so1778372qcw.7
        for <git@vger.kernel.org>; Thu, 24 Oct 2013 16:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type;
        bh=zQJ0/oQYfP5KAWSjQ1xWh0Oc3Cpo0mp2vG0qI0N9RcE=;
        b=X4Lz806oH8SMWpq+ZDcA89aOcKEwSmpbx2Y/AI4pXbdjaTtcXka/BYYl1LabUECixH
         8ruFo/9ewZ/anQLkYVSn0kX2nyuMxtk9uLmrCmmEytySQuWUJ/J8MVOvS80L6StnUI+y
         CD6Ylghg+h0X2aEcRejC5tVQ6czqiUT/bGKlKWM1gcoWzuIziELJF3zJP4j8+jyaFdgs
         I63aGc+vfn3IcaYUQVlZRXJuQFstPsCYCmC3GlDgHkSQUkyS7CogNLDgBgt4Jn0ujnC8
         7ot1sxudYGXGfzjWqSV+IWw14CJ8LKSaEDbipWOfZjrVzS6/r0qJlCYrQfOc+78wIjYh
         j7Yw==
X-Gm-Message-State: ALoCoQm090XwwscH/kW/bmuw5VjF5+k1UCQozidh4hkGPw1DSzXCiyS96TRODxmtO4lchB5b/PDo
X-Received: by 10.49.39.161 with SMTP id q1mr6887088qek.66.1382655923787;
        Thu, 24 Oct 2013 16:05:23 -0700 (PDT)
Received: from mail-qa0-x22e.google.com (mail-qa0-x22e.google.com [2607:f8b0:400d:c00::22e])
        by mx.google.com with ESMTPSA id e7sm12682362qag.7.2013.10.24.16.05.23
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 24 Oct 2013 16:05:23 -0700 (PDT)
Received: by mail-qa0-f46.google.com with SMTP id j15so165632qaq.5
        for <git@vger.kernel.org>; Thu, 24 Oct 2013 16:05:23 -0700 (PDT)
X-Received: by 10.224.37.198 with SMTP id y6mr7460473qad.104.1382655923126;
 Thu, 24 Oct 2013 16:05:23 -0700 (PDT)
Received: by 10.224.7.70 with HTTP; Thu, 24 Oct 2013 16:05:03 -0700 (PDT)
In-Reply-To: <CAPWpf+xqutvhq1jyVkxr6LyKsANTCS6M=vj5XY=EgUfiS3Z8xg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236636>

Hi,

I noticed that reset -p HEAD is inconsistent with checkout -p HEAD.
When running checkout -p you are asked to discard hunks from the index
and worktree, but when running reset -p you are asked to apply hunks
to the index. It would make more sense if reset -p asked to discard
(reversed) hunks from the index.

Digging a bit further, it looks like reset -p is actually intended to
show hunks to discard when resetting to HEAD. The
git-add--interactive.perl script has different cases for resetting to
the head and for resetting to anything else. However, builtin/reset.c
always passes a hash to run_add_interactive, even if HEAD is provided
explicitly on the command line or no revision is given. As a result,
the special case for resetting to the HEAD is never triggered and
git-add--interactive.perl always asks to apply hunks rather than
discard the reverse hunks.

The offending part in builtin/reset.c is on line 307. It's the bit
with sha1_to_hex(sha1):
>     if (patch_mode) {
>         if (reset_type != NONE)
>             die(_("--patch is incompatible with --{hard,mixed,soft}"));
>         return run_add_interactive(sha1_to_hex(sha1), "--patch=reset", &pathspec);
>     }

I'm not familiar enough with the git source, but it's probably a
fairly trivial fix for someone who is.


Kind regards,
Maarten de Vries


P.S.

This bit in git-add--interactive.perl convinced me that resetting to
HEAD interactively should be handled separately:
>     'reset_head' => {
>         DIFF => 'diff-index -p --cached',
>         APPLY => sub { apply_patch 'apply -R --cached', @_; },
>         APPLY_CHECK => 'apply -R --cached',
>         VERB => 'Unstage',
>         TARGET => '',
>         PARTICIPLE => 'unstaging',
>         FILTER => 'index-only',
>         IS_REVERSE => 1,
>     },
>     'reset_nothead' => {
>         DIFF => 'diff-index -R -p --cached',
>         APPLY => sub { apply_patch 'apply --cached', @_; },
>         APPLY_CHECK => 'apply --cached',
>         VERB => 'Apply',
>         TARGET => ' to index',
>         PARTICIPLE => 'applying',
>         FILTER => 'index-only',
>         IS_REVERSE => 0,
>     },
