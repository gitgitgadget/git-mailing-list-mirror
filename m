From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/19] add strbuf_set operations
Date: Wed, 11 Jun 2014 04:09:17 -0400
Message-ID: <CAPig+cRJJ6byQi6+=+8r3Ohyt9FvMHwQViq+MNR1DcD2t8w+NQ@mail.gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 10:09:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wudb7-0007l4-Fw
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 10:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbaFKIJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 04:09:21 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:59248 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718AbaFKIJS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2014 04:09:18 -0400
Received: by mail-yk0-f178.google.com with SMTP id q9so2496724ykb.23
        for <git@vger.kernel.org>; Wed, 11 Jun 2014 01:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=x5o3jQCXg622/JX42v3dZfKZyqP1KzKX4r53M7pJTL0=;
        b=p78VgLKix5aWI9AiVdYoJuO3XJIAga0XDYgVzaBBmlTVMbsggdhI8qljljkDthzHU5
         UmcQgGzFBr2maDF0sCr5GkyyutJXu4mxWm0ZLrlyIA15rjbKybf6IOPhc8y4kNyOTObc
         5XtMt3nxm2LJzTj7YzKeVaHuTbV82UxD2EH50ugcGVx9zlJJsS59upruezvhaclXZ3Gv
         btfOP7fAqckBWPhVyfzWxoVIib47NnjMTFLp/waHI2ayXJ8vUp+e98SsnLjUEYhJulNZ
         yp40AuocAvrMGz002thL74iR7OOwQPVhoydtAy/EPZrtlEndT/dN3tjmz2j0XRgPCFLX
         /fiQ==
X-Received: by 10.236.30.105 with SMTP id j69mr3508912yha.19.1402474157439;
 Wed, 11 Jun 2014 01:09:17 -0700 (PDT)
Received: by 10.170.36.19 with HTTP; Wed, 11 Jun 2014 01:09:17 -0700 (PDT)
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
X-Google-Sender-Auth: xnoX30o7VR9bJpR6w0YEnPZxGQU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251342>

On Mon, Jun 9, 2014 at 6:19 PM, Jeremiah Mahler <jmmahler@gmail.com> wrote:
> Version 2 of the patch set to add strbuf_set operations.
>
> Includes suggestions from Eric Sunshine [1]:
>
> [...snip...]
>
> Using strbuf_set before a sequence of adds can be confusing.  But using
> strbuf_add when nothing important was being added to can also be
> confusing.  strbuf_set can be used to make these cases more clear.
>
>   struct strbuf mybuf = STRBUF_INIT;
>
>   strbuf_add(&mybuf, ...);  /* Was something there before? */
>
>   strbuf_set(&mybuf, ...);  /* Replace everything. */
>
> Several single line replacements were made for this reason.
>
> Additional files have also been converted compared to version 1 [1].
>
> [1]: http://marc.info/?l=git&m=140230874124060&w=2

Food for thought: This patch series has now likely entered the
territory of unnecessary code churn. Quoting from
Documentation/CodingGuidelines:

    Fixing style violations while working on a real change as a
    preparatory clean-up step is good, but otherwise avoid useless
    code churn for the sake of conforming to the style.

    "Once it _is_ in the tree, it's not really worth the patch noise
    to go and fix it up."
    Cf. http://article.gmane.org/gmane.linux.kernel/943020

Rewriting code merely for the sake of replacing strbuf_reset() +
strbuf_add() with strbuf_set(), while not exactly a style cleanup,
falls into the same camp. (The patch which introduces strbuf_set(),
however, is not churn.) Each change you make can potentially conflict
with other topics already in-flight (see [1], for example), thus
making more work for Junio.

Also, these sorts of apparently innocuous "mechanical" changes can
have hidden costs [2], so it's useful to weigh carefully how lengthy
you want to make this patch series.

Having said that, patch 4/19, particularly the changes to
builtin/remote.c:mv(), in which multiple strbufs are reused
repeatedly, does seem to make the code a bit easier to read and likely
reduces cognitive load.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/245133/focus=245147
[2]: http://thread.gmane.org/gmane.comp.version-control.git/245133/focus=245144

> Jeremiah Mahler (19):
>   add strbuf_set operations
>   sha1_name: simplify via strbuf_set()
>   fast-import: simplify via strbuf_set()
>   builtin/remote: simplify via strbuf_set()
>   branch: simplify via strbuf_set()
>   builtin/branch: simplify via strbuf_set()
>   builtin/checkout: simplify via strbuf_set()
>   builtin/mailinfo: simplify via strbuf_set()
>   builtin/tag: simplify via strbuf_set()
>   date: simplify via strbuf_set()
>   diffcore-order: simplify via strbuf_set()
>   http-backend: simplify via strbuf_set()
>   http: simplify via strbuf_set()
>   ident: simplify via strbuf_set()
>   remote-curl: simplify via strbuf_set()
>   submodule: simplify via strbuf_set()
>   transport: simplify via strbuf_set()
>   vcs-svn/svndump: simplify via strbuf_set()
>   wt-status: simplify via strbuf_set()
>
>  Documentation/technical/api-strbuf.txt | 18 +++++++++++
>  branch.c                               |  6 ++--
>  builtin/branch.c                       |  3 +-
>  builtin/checkout.c                     | 18 ++++-------
>  builtin/mailinfo.c                     | 18 ++++-------
>  builtin/remote.c                       | 59 ++++++++++++----------------------
>  builtin/tag.c                          |  3 +-
>  date.c                                 |  3 +-
>  diffcore-order.c                       |  3 +-
>  fast-import.c                          |  6 ++--
>  http-backend.c                         |  6 ++--
>  http.c                                 |  3 +-
>  ident.c                                |  6 ++--
>  remote-curl.c                          |  3 +-
>  sha1_name.c                            | 15 +++------
>  strbuf.c                               | 21 ++++++++++++
>  strbuf.h                               | 14 ++++++++
>  submodule.c                            |  5 ++-
>  transport.c                            |  3 +-
>  vcs-svn/svndump.c                      |  3 +-
>  wt-status.c                            |  3 +-
>  21 files changed, 110 insertions(+), 109 deletions(-)
>
> --
> 2.0.0.592.gf55b190
