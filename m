From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] refs.c: add an err argument to log_ref_setup
Date: Thu, 25 Jun 2015 09:15:41 -0700
Message-ID: <xmqqzj3nzrv6.fsf@gitster.dls.corp.google.com>
References: <1435173388-8346-1-git-send-email-dturner@twopensource.com>
	<1435173388-8346-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 18:15:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z89oa-0001nz-Ro
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 18:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbbFYQPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 12:15:45 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:34037 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbbFYQPn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 12:15:43 -0400
Received: by igcsj18 with SMTP id sj18so12291465igc.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=v57hCkjzu+qdvnl4lTpRJLLl8d3C1TLV0OoRsqcbmZs=;
        b=uJZ6MFuUdYxhfzir85IjbgmsdklzyTv0ExSElmDjzhJmn7uE3sWN0okU8pGNNDxhBR
         Sl550Yx70gILR6SCKFkGmd3KXOEqcyEr3q56lObx0nP129jY2NjJMDGKkdfjFHepEO4v
         mudnQLW00TL82s+MdzYVC97xngtXoXxKKxCLbzyMYp4xeEljKi0WyAUvd+GxgGpWDFBw
         NgbhLoU7e15ogYlTR/XCBLk+XLXdDU1/gkCdSgta7RhtpVGj171jmfxrIVESQlJkX2Ot
         LPlPqFMOsgGxeXuBpYyTT+9PS3g3TWPYkKnSqGIok8ScNL4NCk+4qNhavfMtO1plhR1h
         /ggA==
X-Received: by 10.50.43.131 with SMTP id w3mr5124890igl.8.1435248943421;
        Thu, 25 Jun 2015 09:15:43 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3512:3582:e5d3:22a9])
        by mx.google.com with ESMTPSA id d4sm19861059iod.17.2015.06.25.09.15.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 09:15:42 -0700 (PDT)
In-Reply-To: <1435173388-8346-2-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Wed, 24 Jun 2015 15:16:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272691>

David Turner <dturner@twopensource.com> writes:

> Add err argument to log_ref_setup that can explain the reason for a
> failure. This then eliminates the need to manage errno through this
> function since we can just add strerror(errno) to the err string when
> meaningful. No callers relied on errno from this function for anything
> else than the error message.

I think I saw Michael did something similar to other codepaths in
the ref API recently, and going in the same direction is generally a
good thing to do for consistency ;-)

> write_ref_to_lockfile is a private function that calls
> log_ref_setup. Update this function to also take an err argument and
> fill it in.  This again eliminates the need to manage errno in this
> function.

This particular patch is not just about log_ref_setup() and its
private friend write_ref_to_lockfile(), right?  It seems to also
touch commit_ref_update(), log_ref_write(), etc.  The overall
"theme" of this change is to teach parts of the ref API that deal
with writing reflogs to report errors the same way (i.e. as the
remainder of the ref API does by using &err), and that may be a
good single-line summary of the change (aka "Subject").

>  				if (ret) {
> -					fprintf(stderr, _("Can not do reflog for '%s'\n"),
> -					    opts->new_orphan_branch);
> +					fprintf(stderr, _("Can not do reflog for '%s'. %s\n"),
> +					opts->new_orphan_branch, err.buf);

Original is underindented but this makes it even worse.  Push
continuation line further to the right (or restructure the code so
that it does not have to indent too deeply in the first place).

Other than that, this step looks sensible.

Thanks.
