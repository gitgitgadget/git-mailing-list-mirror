From: =?UTF-8?Q?erik_elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: Re: [PATCH v5 5/5] clean: improve performance when removing lots of directories
Date: Tue, 28 Apr 2015 22:31:47 +0200
Message-ID: <CAMpP7Nbm9Gy6AgULBCCwgeEUBWU4M5r8+SC22iuu8VmaUtst_w@mail.gmail.com>
References: <xmqqfv7nzf56.fsf@gitster.dls.corp.google.com>
	<1430030985-14499-1-git-send-email-erik.elfstrom@gmail.com>
	<1430030985-14499-6-git-send-email-erik.elfstrom@gmail.com>
	<20150428062422.GM24580@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 28 22:31:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnCAb-0006hB-Uj
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 22:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965904AbbD1Ubt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 16:31:49 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36340 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965352AbbD1Ubs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 16:31:48 -0400
Received: by wizk4 with SMTP id k4so155390095wiz.1
        for <git@vger.kernel.org>; Tue, 28 Apr 2015 13:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mIHll2nMT4fAobM4E9xWS0a95gc04wX5rc+pTqWKjNU=;
        b=BNvL0pi+psM1vR6jVBqm6jyvRydyuU508KjuVXT9fIyGf4NvYJMMXzcvSy+B1e4b0R
         gkv2SMkfE6Uz5eL5TRSymZZXEc9G5elgVXNSeeJEVQ12n1RoCbTfVHLrmwpJfryCRDO1
         ZrGcQrytg/idGoiVx1Fo73W6zhM741bGPfa4y6/SvO8Z6KOZLkheazOpOKQtgxhuMG0G
         VeTVCElxaxpifSLweygJ4phz/7SX9SSgWDvtk0lBT9Fu0mT5mRHnBBnwW4GkdVgJBM4f
         UXHsyWA8OJql5FRllb/YV3Oj/9EUaMfGG5G1X1jvr8ZXelDwDFHtz1/GUtnyjNuDemf+
         MIrA==
X-Received: by 10.180.87.199 with SMTP id ba7mr33841649wib.81.1430253107816;
 Tue, 28 Apr 2015 13:31:47 -0700 (PDT)
Received: by 10.28.49.66 with HTTP; Tue, 28 Apr 2015 13:31:47 -0700 (PDT)
In-Reply-To: <20150428062422.GM24580@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267940>

On Tue, Apr 28, 2015 at 8:24 AM, Jeff King <peff@peff.net> wrote:
>
> This iteration looks reasonable overall to me.
>
> Should this is_git_repository() helper be available to other files? I
> think there are other calls to resolve_gitlink_ref() that would want the
> same treatment (e.g., I think "git status" may have a similar issue).
>
> -Peff

Yes that is probably the direction to go in but I think the current
version is too tailored to the clean case to be generally useful
(although I haven't check the status case). Right now this is more of
a is_this_a_repo_clean_should_care_about_ignoring_some_cornercase_quirks
than a true is_git_repository check.

I would think a general version would look more like this:

static int is_git_repository(struct strbuf *path)
{
    if (is_bare_repository(path))
        return BARE_REPO;
    if (is_submodule(path))
        return SUBMODULE;
    if (is_git_director(path))
        return REPO;
    return 0;
}

probably also communicating any errors back to the caller.

To sum it up I think you are correct in the direction but I suspect
that the current version is not sufficient for the general case and
that it would be best to leave the generalization and making it public
for future work.

/Erik
