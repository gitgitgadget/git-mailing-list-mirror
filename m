From: Ciro Santilli <ciro.santilli@gmail.com>
Subject: Stop prepending /usr/bin to hooks PATH, or document it very clearly
Date: Fri, 17 Oct 2014 13:25:42 +0200
Message-ID: <CAFXrp_c+dxafLOO6T=LDd6OxhfpamkJsUc8iBwB-B41z8Htc4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 17 13:25:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xf5fJ-0000mc-23
	for gcvg-git-2@plane.gmane.org; Fri, 17 Oct 2014 13:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbaJQLZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2014 07:25:45 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:41310 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343AbaJQLZo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2014 07:25:44 -0400
Received: by mail-lb0-f175.google.com with SMTP id u10so487152lbd.20
        for <git@vger.kernel.org>; Fri, 17 Oct 2014 04:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=tcHODiyTsOT0xc2Tpk/ho+EtG792W18qPG9JMMy/Grw=;
        b=Wwt54ZRyhrmM8F0NUqH8gFGWtDTMQH22j8NxslH0Y/bjVqxVPrI65NRZx1lL1A1ECv
         o0m2vy/y2FDnZCmP0uEYqXO9UUuQvh+fqbqApmnc8TMjW88hDitwTNYuZMyNHbC9p/lk
         XxcfXh/gQJXI0wHxlnQRN3LYxm0XfQKBYqtngD0270X8/IwHVBLjMBEz6p8ENBi+MZDn
         wSlPGEzCIArYxx2js2yxABGkbhUkunpVQOk142xXs+VlVwkHmh61pOSKfBwBq5QJ3FFi
         RC7/7AHPrY8hKvPWn/WyZA675F18DnPGoICuOlMelI9bwdUmm3Do9ykEU9xIzQTKMY7P
         NjFw==
X-Received: by 10.152.87.98 with SMTP id w2mr7972922laz.27.1413545142952; Fri,
 17 Oct 2014 04:25:42 -0700 (PDT)
Received: by 10.152.170.133 with HTTP; Fri, 17 Oct 2014 04:25:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On hooks Git automatically prepends to the `PATH` via the `setup_path` function:

- `git --exec-path` (`/usr/lib/git-core`)
- the directory of `$0` (`/usr/bin`) if you call it with the full path

The problem is that the `/usr/bin` breaks "interpreter version manager
systems" like RVM, rbenv, virtualenv, etc. since people will write
hooks like:

    #!/usr/bin/env ruby

and the `/usr/bin` ruby will get run instead of the managed one
(`~/.rvm/some/path/bin).

I recommend either:

- not adding the `$0` if possible (ideal but backwards incompatible
unless a new config is added)
- documenting this behavior *very* clearly on `man githooks`
- proposing some other mechanism that neatly solves the problem

I will try to submit a patch for the desired solution if within my
technical capability.

Samples of problems this has caused people:

- https://github.com/gitlabhq/gitlabhq/issues/8045
- http://stackoverflow.com/questions/9037284/how-can-i-run-a-virtualenv-python-script-as-a-git-pre-commit-hook
- http://stackoverflow.com/questions/17515769/why-is-my-ruby-git-script-hook-run-with-the-wrong-path
- https://github.com/sstephenson/rbenv/issues/374
- https://github.com/magit/magit/issues/498
