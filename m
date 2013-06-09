From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Sun, 9 Jun 2013 18:32:58 +0100
Message-ID: <20130609173257.GE22905@serenity.lan>
References: <CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com>
 <CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com>
 <CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com>
 <20130609151235.GA22905@serenity.lan>
 <CAMP44s0L9nQxp5OeK8uT4Ls5WUerCjVpR9uONUcOwvTD6k7Jfg@mail.gmail.com>
 <20130609160225.GB22905@serenity.lan>
 <CAMP44s0Zsejk4Ex6QfzOFOom3cyWv_hziWGkAK-LawSUkT9V3Q@mail.gmail.com>
 <20130609164248.GD22905@serenity.lan>
 <CALkWK0k=39-Cq3vNdrpLPTWa0wgkqLM=7c=cAmL0nvx0MT5mkA@mail.gmail.com>
 <CAMP44s1PENiKMy03_mgZ_myiGP5+qpaE2bvo0LN3X3mZhSvT2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:33:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljUS-0006TV-NV
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409Ab3FIRdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 13:33:13 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:35630 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401Ab3FIRdM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:33:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 42C5E22F7A;
	Sun,  9 Jun 2013 18:33:11 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KqK1OlUa8Blp; Sun,  9 Jun 2013 18:33:10 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 3BC2822BAC;
	Sun,  9 Jun 2013 18:32:59 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAMP44s1PENiKMy03_mgZ_myiGP5+qpaE2bvo0LN3X3mZhSvT2g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227041>

On Sun, Jun 09, 2013 at 12:13:41PM -0500, Felipe Contreras wrote:
> On Sun, Jun 9, 2013 at 12:03 PM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
> > John Keeping wrote:
> >> Calling across from one builtin/*.c file to another is just as wrong as
> >> calling into a builtin/*.c file from a top-level file but the build
> >> system happens not to enforce the former.
> >
> > So libgit.a is a collection of everything that is shared between
> > builtins?  Does that correspond to reality?

I think that's *precisely* what libgit.a is.  It doesn't currently
correspond exactly to reality, but that's mostly for historic reasons
(see below).

> >   $ ls *.h | sed 's/.h$/.c/' | xargs file
> >
> > An example violation: builtin/log.c uses functions defined in
> > builtin/shortlog.c.
> >
> > What is the point of all this separation, if no external scripts are
> > ever going to use libgit.a?

Why do we structure code in a certain way at all?  The reason libgit.a
was introduced (according to commit 0a02ce7) is:

    This introduces the concept of git "library" objects that
    the real programs use, and makes it easier to add such
    things to a "libgit.a".

> And all the functions should be static, which doesn't seem to be the case:
> 
> 00000000000003c0 T add_files_to_cache
> 0000000000000530 T interactive_add
> 0000000000000410 T run_add_interactive
> 0000000000001920 T textconv_object
> 00000000000005b0 T fmt_merge_msg
> 0000000000000090 T fmt_merge_msg_config
> 0000000000000c00 T init_db
> 0000000000000b40 T set_git_dir_init
> 0000000000000360 T overlay_tree_on_cache
> 0000000000000500 T report_path_error
> 00000000000011a0 T copy_note_for_rewrite
> 0000000000001210 T finish_copy_notes_for_rewrite
> 0000000000001060 T init_copy_notes_for_rewrite
> 0000000000000000 T prune_packed_objects
> 0000000000000510 T shortlog_add_commit
> 00000000000006b0 T shortlog_init
> 0000000000000780 T shortlog_output
> 0000000000000000 T stripspace

A quick check with "git log -S..." shows that most of these have barely
been touched since the builtin/ directory was created.  So the reason
they're not static is most likely because no one has tidied them up
since the division between builtins was introduced.

It is a fact of life that as we live and work with a system we realise
that there may be a better way of doing something.  This doesn't mean
that someone needs to immediately convert everything to the new way,
it is often sufficient to do new things in the new way and slowly move
existing things across as and when they are touched for other reasons.
