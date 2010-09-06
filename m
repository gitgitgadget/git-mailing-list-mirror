From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/4] tree-walk: actually move tree_entry_interesting() to tree-walk.c
Date: Mon, 6 Sep 2010 09:31:57 -0600
Message-ID: <AANLkTinV+Bo_EijJU2q5GVG=jr9GFAuQGo5KQpvf0K-V@mail.gmail.com>
References: <1283645647-1891-8-git-send-email-newren@gmail.com>
	<1283748429-31076-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 17:32:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osdfw-0007Br-Ol
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 17:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321Ab0IFPb7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 11:31:59 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47926 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab0IFPb6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 11:31:58 -0400
Received: by fxm13 with SMTP id 13so2509483fxm.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 08:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zxMDBYwARVseyveA41CxjIOpu9gvWmtaqsAVop0ORps=;
        b=BMdK/2PhYC+MM16hOJ5UyGvVpGOp0WnYjsFk/DnMnNh2XlFUl5/WxGHqYAjKlOgBxm
         BydM3txjmyxJ4CUy0vTnFOc6XePdi+R08HGcCg4l2YFSVJy0XryepNp08kpvwPbWRs9h
         djJ5o8pMEHnRSTHy94LZIjAPjdcaoZhsd/cWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OmGwwNse9hSp3Hw1xB+qjWxhxUqVTdi9HJbjla4O6BWXvJXGq+0taGyhviyHXMjxyN
         WitByUDAu5z5o94svr+9OCKpYHd2Mtdm+fuN6gkjeIXbKxy4sJOqQBsv/oT5isyCP41x
         cYW+z8gyalp9XrtC0/jkXMDxlxZoESWHDB1E8=
Received: by 10.223.108.71 with SMTP id e7mr209990fap.13.1283787117243; Mon,
 06 Sep 2010 08:31:57 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Mon, 6 Sep 2010 08:31:57 -0700 (PDT)
In-Reply-To: <1283748429-31076-4-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155577>

2010/9/5 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>:
> This function can be potentially used in more places than just
> tree-diff.c. This patches removes struct diff_options dependency from
> the function, and moves it to tree-walk.c.
>
> No functionality change intended.

Thanks for working on this.  I like having the declaration of
tree_entry_interesting() moved to tree_walk.h, at the very least.  The
change to make tree_entry_interesting() take an entry instead of a
tree_desc makes sense too.

I'm unsure about replacing the diff_options with paths + pathlens +
nr_paths -- that might be exposing too much implementation detail in
the API.  In particular, I'm worried that if we try to add support for
negated pathspecs or globs or regexes to tree_entry_interesting(),
then we'll need to pass different data to this function and update an
awful lot of callers.

Perhaps we should make a new struct containing paths + pathlens +
nr_paths, make tree_entry_interesting() take such a struct, modify
diff_options have such a struct instead of the current three paths,
pathlens, and nr_paths fields, and modify diff_tree_setup_path()s to
take such a struct instead of a diff_options* (and perhaps move
diff_tree_setup_paths() out of diff.h and tree-diff.c into some other
file(s)?).

Thoughts?

Elijah
