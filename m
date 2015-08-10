From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/17] removing questionable uses of git_path
Date: Mon, 10 Aug 2015 10:31:32 -0700
Message-ID: <xmqqr3nbuk23.fsf@gitster.dls.corp.google.com>
References: <20150810092731.GA9027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 10 19:31:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOqvD-0000Q1-Fw
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 19:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754794AbbHJRbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 13:31:35 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:36500 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753598AbbHJRbe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 13:31:34 -0400
Received: by pdco4 with SMTP id o4so73762131pdc.3
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 10:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=nA8ZQmh/4ColFKMA3i46CwcvwLs1tMtvpcBIXExmyuE=;
        b=oGTMqtspxFKHdFH1why9DBd8sI+DKXeuZueB/neDvQKh6tRs165qRyv6PAZ8S7EdYx
         3qFsfOxyxjyl+gxzOFUB9niY0H2V3XqLmWB4dyfuSGsfzEnX2X+Py2sIzKCLZx2Wj4Yl
         s07kK9+E6BIQWDOZuk+BUmq7H8+qAVq/mVRF0IG5qV4rAEA4rVdQgBuIbn7iXubM39gS
         tNw1yIOYShfpCXh9OjUwdRh4K9DtACAw02c0D4giuLeB1RSWcIJ4A4D1ajwdIsysGs7l
         Fh2ErvBYMTfQK/eQ90MRua9ALpToQRUn1gjvwmHqhPWS+MciHfzONIaMbAFoUItbz/Cf
         FoVw==
X-Received: by 10.70.126.193 with SMTP id na1mr47171230pdb.26.1439227894180;
        Mon, 10 Aug 2015 10:31:34 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d90:bc93:a451:6e95])
        by smtp.gmail.com with ESMTPSA id pt3sm20593488pbb.38.2015.08.10.10.31.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 10 Aug 2015 10:31:33 -0700 (PDT)
In-Reply-To: <20150810092731.GA9027@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 10 Aug 2015 05:27:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275638>

Jeff King <peff@peff.net> writes:

> The problem is that git_path uses a static buffer that gets overwritten
> by subsequent calls.

As the rotating static buffer pattern used in get_pathname() was
modeled after sha1_to_hex(), we have the same issue there.  They are
troubles waiting to happen unless the callers are careful.

> producing a fairly tame-looking set of function calls. It's OK to pass
> the result of git_path() to a system call, or something that is a thin
> wrapper around one (e.g., strbuf_read_file).

That is a short and good rule to follow, but the problem is that not
everybody has good taste to interpret the above rule and apply it with
an eye toward maintainability X-<.

> Along the way, there are a few cleanups (e.g., I polished off the recent
> hold_lock_file_for_append topic which was on the list, as it had some
> problematic calls).
>
>   [01/17]: cache.h: clarify documentation for git_path, et al
>   [02/17]: cache.h: complete set of git_path_submodule helpers
>   [03/17]: t5700: modernize style
>   [04/17]: add_to_alternates_file: don't add duplicate entries
>   [05/17]: remove hold_lock_file_for_append
>   [06/17]: prefer git_pathdup to git_path in some possibly-dangerous cases
>   [07/17]: prefer mkpathdup to mkpath in assignments
>   [08/17]: remote.c: drop extraneous local variable from migrate_file
>   [09/17]: refs.c: remove extra git_path calls from read_loose refs
>   [10/17]: path.c: drop git_path_submodule
>   [11/17]: refs.c: simplify strbufs in reflog setup and writing
>   [12/17]: refs.c: avoid repeated git_path calls in rename_tmp_log
>   [13/17]: refs.c: avoid git_path assignment in lock_ref_sha1_basic
>   [14/17]: refs.c: remove_empty_directories can take a strbuf
>   [15/17]: find_hook: keep our own static buffer
>   [16/17]: get_repo_path: refactor path-allocation
>   [17/17]: memoize common git-path "constant" files

Nice.  Thanks.
