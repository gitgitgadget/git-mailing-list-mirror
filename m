From: David Aguilar <davvid@gmail.com>
Subject: Re: [RFC PATCH 3/3] core: improve header dependencies
Date: Tue, 2 Sep 2014 12:19:02 -0700
Message-ID: <20140902191901.GA78128@gmail.com>
References: <1409515893-48017-1-git-send-email-davvid@gmail.com>
 <1409515893-48017-2-git-send-email-davvid@gmail.com>
 <1409515893-48017-3-git-send-email-davvid@gmail.com>
 <xmqqr3zt27rx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 21:18:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOtaf-0002zy-JS
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 21:18:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754967AbaIBTSD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 15:18:03 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:58210 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754871AbaIBTSB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 15:18:01 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so9310588pdj.32
        for <git@vger.kernel.org>; Tue, 02 Sep 2014 12:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=O8GDNHNzxbZ3NUTHFJ2yyJPuM/ohCJJumkUn3WG6vBE=;
        b=LHJ4xdxOJdetR6fcLw7P6l1tNeJI0XGfngfMmLDidr9ZWQZ+Gf+mCJiMz4koem/ZFg
         noSHx0YwTlgmHD/knFP2ov9/rhN8k81gH+Vji0V3H4LAGtkHnTDh38b1SfNH+ANMw9jb
         2rkGy266gdg8hVhRomWIboJjrU3UDGP6on7gDhKEzMXsWb0QGcsP8NlMV2rN0lE+A+iw
         o5kejNDz+KqcKoMZi+IbD6y+P3d9y5tKdSH7AAmqemM14qlZBVcMx9b6XtezEXp6iQh+
         HIdTpv68S+5TLQPkAoiBvkXrQOv4Xu5sQALyUVbvDNKL4F0nbl8o6UJi/RYhu6gN+lqH
         Gxcg==
X-Received: by 10.70.47.2 with SMTP id z2mr51074446pdm.38.1409685480657;
        Tue, 02 Sep 2014 12:18:00 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id cl2sm6514735pdb.59.2014.09.02.12.17.59
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 02 Sep 2014 12:17:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqr3zt27rx.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256340>

On Tue, Sep 02, 2014 at 11:32:02AM -0700, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > Remove includes that have already been included by another header.
> 
> Hmm, I am not sure if that is a good move, and suspect that it is
> incompatible with what your 2/3 attempts to do, at least at the
> philosophical level.
> 
> I am guessing that your 2/3 wants to see
> 
> 	gcc $header.h
> 
> to be happy.  One benefit from doing such a change is that sources
> that want to use declaration made in $header.h have to include that
> $header.h without having to worry about what other things the
> implementation detail of $header.h needs.  If function F or type T
> is declared in header H, you include H and you are done.
> 
> That is nice and tidy, but if that is the goal, then after making H
> include its own dependency H1 that happen to declare functions F1,
> F2 and types T1, T2 (which are necessary for H to be complete as
> standalone), if the source that used to include both H and H1
> because it uses F and F1 should still explicitly include H1, no?
> 
> For example, you dropped "diff.h" from builtin/add.c, but the
> implementation of builtin/add.c needs access to diff_options struct,
> which is in "diff.h", not whatever happened to include indirectly
> that is already included by builtin/add.c.  I do not think it is a
> good idea, and more importantly I suspect that it is not consistent
> with what you tried to do with your 2/3.
> 
> But it is entirely possible I am misunderstanding the real
> motivation behind these changes.  The log message justifies why
> removal is safe i.e. "have already been included indirectly", and
> the title claims it is an improvement, but there is no explanation
> why it is an improvement (which would have also explained the
> motivation behind it), so it is a bit hard for me to guess.

The commit messages can certainly be improved.

Patch 2/3 is really a question in patch form:

Should we (a) forward-declare structs in headers that use
pointers to those structs, or (b) full-on #include the headers
that define those structs?

Making "gcc $header.h" happy might be good but that wasn't the
original motivation; approach (b) would satisfy that.

This old (and maybe uneditable these days?) wiki page contains
items that were the motivation for these patches:

https://git.wiki.kernel.org/index.php/Janitor

- Some Git headers depend on other headers to compile cleanly,
  in this case it might be a good idea to include the needed
  headers in the header that needs them."

- For example "revision.h" depends on "commit.h" and "diff.h",
  so "revision.h" should include them.

- Of course after that it makes sense to clean up the "*.c"
  source files that include all these headers, to remove the
  headers that are no more needed there.

Most importantly, though, is this part:

- Contact the mail list to see how to proceed.

;-)

Patch 3/3 is the item about cleaning up *.c files, but we may
want to reformulate these items and take a different approach.

Thoughts?
-- 
David
