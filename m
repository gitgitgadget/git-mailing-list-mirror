From: Paul Tan <pyokagan@gmail.com>
Subject: git-pull --tags with no merge candidates case gives confusing error message
Date: Tue, 12 May 2015 13:59:04 +0800
Message-ID: <CACRoPnQvNvBv1_wBzWQH6A8XRvWZ+HURvtkqtgYpwjjNXuCERg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 12 07:59:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ys3Dj-0003VS-FL
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 07:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbbELF7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 01:59:07 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:33491 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574AbbELF7F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 01:59:05 -0400
Received: by layy10 with SMTP id y10so109059731lay.0
        for <git@vger.kernel.org>; Mon, 11 May 2015 22:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=VNSCMA3pd9DYpKYWSmQdRgCVTtdLcqQiuXFWF4Ctpxc=;
        b=a6f/C53MpPDwpj/wSatDR77nPQNHkpdal8x23nDxP9FiZ71/mYq8MWOArXj5HYIDY7
         KacSC4PoU8naRxXeiwOoBCJNdOlz9feKVvO97M4w6dXHa9G9VQ+ioYdhjLG8mpFSCfJL
         ASmmK8mCo2QxfK3nZFRux0jmJSZw2L6/khbdR917jdmI09rRZ0O4wXu8cNY43G2dBary
         jsxPAu2jazYsiPknC2QfysXpWywRMrlLfzsy2Y0v7QMQhs5F4NjubuFurVEhUdQS4Ypp
         yMd6G74ls7C/kh9FsDyN/WQqld0Rh5T0mmGhsRIQalv4MCScD2R2VC4DkJX2ydEuNQU0
         wB1Q==
X-Received: by 10.112.142.232 with SMTP id rz8mr10324395lbb.74.1431410344082;
 Mon, 11 May 2015 22:59:04 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Mon, 11 May 2015 22:59:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268844>

Hi all,

Calling git-pull --tags, and hitting the no merge candidates case,
currently gives the following error message:

    It doesn't make sense to pull all tags; you probably meant:
        git fetch --tags

This error message comes from the following code block in git-pull.sh:

    for opt
    do
        case "$opt" in
        -t|--t|--ta|--tag|--tags)
            echo "It doesn't make sense to pull all tags; you probably meant:"
            echo "  git fetch --tags"
            exit 1
        esac
    done

This behavior was introduced in 441ed41 ("git pull --tags": error out
with a better message., 2007-12-28), which stated that:

    In the longer term, it would be a better approach to change the
    semantics of --tags option to make "git fetch" and "git pull"
    to:

     (1) behave as if no --tags was given (so an explicit refspec on
         the command line overrides configured ones, or no explicit
         refspecs on the command line takes configured ones); but

     (2) no auto-following of tags is made even when using
         configured refspecs; and

     (3) fetch all tags as not-for-merge entries".

    Then we would not need to have this separate error message, as
    the ordinary merge will happen even with the --tags option.

Given that as of c5a84e9 (fetch --tags: fetch tags *in addition to*
other stuff, 2013-10-30), git-pull --tags will fetch tags in addition
to the configured refspecs, so if there are no merge candidates, it
would not be because --tags was specified on the command line.

As such, I wonder if the error message should be removed, since it
conceals the actual reason of why there are no merge candidates.
Unless there is a reason why this special error message was kept?

Thanks,
Paul
