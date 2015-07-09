From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 2/8] cherry-pick: treat CHERRY_PICK_HEAD and REVERT_HEAD as refs
Date: Wed, 08 Jul 2015 22:55:15 -0700
Message-ID: <xmqqmvz5x4cc.fsf@gitster.dls.corp.google.com>
References: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
	<1436316963-25520-2-git-send-email-dturner@twopensource.com>
	<559D6208.8090607@kdbg.org> <1436382962.4542.8.camel@twopensource.com>
	<559D92CF.7000408@kdbg.org>
	<xmqq4mlexmh3.fsf@gitster.dls.corp.google.com>
	<1436399058.4542.26.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 07:55:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZD4nt-0005HI-6m
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 07:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbbGIFzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 01:55:21 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:34396 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbbGIFzS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 01:55:18 -0400
Received: by iebmu5 with SMTP id mu5so169714817ieb.1
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 22:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Mg04YmTmOcwZJby0x9HqCSt3UM377up86EfoUeCHHIM=;
        b=FYLquyh+DZdAISUNME2AHYkW4JQVp8MjDwdDIRHrTTrvq19sKcLS9I+xhlem6wyyF3
         D2blfpNvwhFoWTCyVr4n/ZmmgA4OzcdhnMBm/X78vs2VB2lNGFksxDvo+CS869IW6oBh
         uUvIz25+Mn3VRDTzncl9U9SyWMyRsnsV+fkhH+RInTc8MDZUDhl3PKS2lvXBllTaX9V0
         y5twJuuxcSdhaYU6yv841p152QYs4eU0QimiIqtbJLa5DGJJAnPMidKdgnd15s8rECEH
         RRdRbPtZYcTTvLYwsHRowDgJeLJbd07M4JfocZGe76Svtkzs5VZJPfe/tbvT3OCxwaBh
         g87w==
X-Received: by 10.50.18.43 with SMTP id t11mr95465305igd.25.1436421318151;
        Wed, 08 Jul 2015 22:55:18 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6567:f006:f2bd:2568])
        by smtp.gmail.com with ESMTPSA id q187sm3538708ioe.37.2015.07.08.22.55.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 Jul 2015 22:55:16 -0700 (PDT)
In-Reply-To: <1436399058.4542.26.camel@twopensource.com> (David Turner's
	message of "Wed, 08 Jul 2015 19:44:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273725>

David Turner <dturner@twopensource.com> writes:

> I didn't see this until after I had sent my previous message.  I think
> the "multiple working trees" argument is strong enough that I will
> change the code (and tests). 

Not just code, but we probably should step back a bit and clearly
define what we are trying to achieve.  I _think_ what we want are:

 - Everything under refs/* and their associated logs would be handed
   off to the "pluggable ref backend" when one is in use.

 - All ref-like things with one-level ALL_CAPS names are per working
   tree.

   - They do not participate in "prunable?" reachability
     computation.
   - They (typically) do not want "logs".
   - Each may have extra information specific to it.
   - You can however read an object name off of them.

One possible and straight-forward implementation to achieve
"ref-like things with one-level ALL_CAPS names are per working tree"
is to declare that they will not be handed off to the backend, but
will always be implemented as files immediately under $GIT_DIR/.

But note that there is no fundamental reason we have to do it that
way; an alternative would be to allow backends to store these things
per working tree, but then the interface to drive backends need to
tell them which working tree we are working from.

Unlike branches, HEAD must be per working tree; the "pluggable ref
backend" needs to be able handle HEAD when you introduce it.  So
from that point of view, "multiple working tree" is *not* a valid
argument why they *have* to be implemented as files under $GIT_DIR/.
If you plan to let the pluggable ref backend to handle HEAD, you
must have a solution for per working tree ref-like things anyway.

As to J6t's "no excessive plumbing invocations", I think the right
approach is to have a single "git prompt--helper" command that does
what the current script does to compute $r.  "we want to keep
peeking into files under $GIT_DIR/" alone is not a valid enough
reason to constrain us (I am fine if the solution we find
appropriate for the 'multiple working trees' and other issues ends
up being "we solve it by having them as files in $GIT_DIR" for other
reasons, though).
