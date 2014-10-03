From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/2] config: Add safe-include directive
Date: Thu, 2 Oct 2014 22:27:11 -0700
Message-ID: <CAPc5daV_txE9NrwvH5VWhXK+UmE7Avy8R2QaZaX0SsTC_+TU-A@mail.gmail.com>
References: <xmqqy4t7a5vx.fsf@gitster.dls.corp.google.com> <1412300254-11281-1-git-send-email-rv@rasmusvillemoes.dk>
 <1412300254-11281-2-git-send-email-rv@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Joe Perches <joe@perches.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>
X-From: git-owner@vger.kernel.org Fri Oct 03 07:27:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZvP5-0001Z2-97
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 07:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077AbaJCF1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 01:27:35 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:63457 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051AbaJCF1d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 01:27:33 -0400
Received: by mail-lb0-f179.google.com with SMTP id l4so397352lbv.38
        for <git@vger.kernel.org>; Thu, 02 Oct 2014 22:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=YRHUvwV6NB7EhTz3J7ZLEuf/mVRfz7RE9Mvw29T2ngk=;
        b=VOFvatY081O+TSeRTiWudYnxqg1MilZvbjS8PGZoWiYEByMH2p3ZGcT53rUI2JE5uB
         XBD31fUER3EJFgYSCVQWpFmGShS+wEYBV1Pvs3qBrsN6SR1T7bWJh2ztQOSY5pIMMom7
         K8eRyHMq1ahgGhdPw9Mfo0PDeN8/PvvKHyGcjyiu9pPehBkG/niU041ILlSDB5S6+ewt
         QurqQ7TDmCMA4M7i+aTo2ING2g+1HZEkCcWPFhOBLHgkB6SUEpzz9erHGMWywEMlPynq
         t47RBbPQCDcqclyo2+tU8DgvXbz7HRSZExVYHHvC2GmBqcxawTUx3Rdh02X7munfcnlv
         sM0Q==
X-Received: by 10.152.88.43 with SMTP id bd11mr3220336lab.62.1412314051219;
 Thu, 02 Oct 2014 22:27:31 -0700 (PDT)
Received: by 10.112.209.35 with HTTP; Thu, 2 Oct 2014 22:27:11 -0700 (PDT)
In-Reply-To: <1412300254-11281-2-git-send-email-rv@rasmusvillemoes.dk>
X-Google-Sender-Auth: skc7zKGn5MP8XYYyY_-E-ZLC7pg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257831>

On Thu, Oct 2, 2014 at 6:37 PM, Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
> This adds a variant of the include directive, where only certain
> config variables in the included files are honoured. The set of
> honoured variables consists of those the user has mentioned in a
> safe-include.whitelist directive, along with a small set of git.git
> blessed ones.
>
> This can, for example, be used by a project to supply a set of
> suggested configuration variables, such as "diff.renames = true". The
> project would provide these in e.g project.gitconfig, and the user then
> has to explicitly opt-in by putting
>
> [safe-include]
>     path = ../project.gitconfig
>
> into .git/config, possibly preceding the path directive with a
> whitelist directive.

Good thinking to protect against accidental inclusion by older versions of Git.

Even though I did allude to ../project.gitconfig in the original message, I
think there should probably be an explicit syntax to name a path that is
relative to the root level of the working tree. People do funky things using
$GIT_DIR and $GIT_WORK_TREE to break the ".. relative to the config
file is the root level of the working tree" assumption, and also a repository
can have a regular file ".git" that points at the real location of the directory
that has "config" in it, in which case its parent directory is very unlikely to
be the root level of the working tree.

That syntax _could_ be just a relative path (e.g. project.gitconfig names
the file with that name at the top-level of the working tree), and if we are
to do so, we should forbid any relative path that escapes from the working
tree (e.g. ../project.gitconfig is forbidden, but down/down/../../.gitconfig
could be OK as it is the same as .gitconfig). For that matter, anything with
/./ and /../ in it can safely be forbidden without losing functionality.

The reason why I think it is sufficient to take a relative path as relative
to the working tree is primarily because I do not see a reason why we
would want to do a safer inclusion of anything inside $GIT_DIR (which
would be the natural interpretation if the relatigve path is taken as relative
to the including config file, in the same way as how the regular include
is processed). But I could be missing some other useful use cases.

And we can allow absolute path, e.g. /etc/gitconfig, of course, but I'd
prefer to at least initially forbid an absolute path, due to the same worries
I have against the "unset some variables defined in /etc/gitconfig" topic
we discussed earlier today in a separate thread.
