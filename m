From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v4.1 09/12] sequencer.c: teach append_signoff to avoid
 adding a duplicate newline
Date: Sun, 17 Feb 2013 22:49:20 +0000
Message-ID: <20130217224919.GA5011@serenity.lan>
References: <1360664260-11803-10-git-send-email-drafnel@gmail.com>
 <1360665222-3166-1-git-send-email-drafnel@gmail.com>
 <20130214175849.GA27958@farnsworth.metanate.com>
 <CA+sFfMecyfD7x_8Jk-hUDceL_nS5kuKq5nF0vRBqLROWFgdypA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
	jrnieder@gmail.com, Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 23:50:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7D3h-0002HU-CZ
	for gcvg-git-2@plane.gmane.org; Sun, 17 Feb 2013 23:50:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530Ab3BQWtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 17:49:39 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:43107 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753260Ab3BQWti (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 17:49:38 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 9B3E8CDA5B9;
	Sun, 17 Feb 2013 22:49:37 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 06fHSLsLhiqa; Sun, 17 Feb 2013 22:49:36 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 5067FCDA590;
	Sun, 17 Feb 2013 22:49:27 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CA+sFfMecyfD7x_8Jk-hUDceL_nS5kuKq5nF0vRBqLROWFgdypA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216410>

On Fri, Feb 15, 2013 at 10:58:38AM -0800, Brandon Casey wrote:
> On Thu, Feb 14, 2013 at 9:58 AM, John Keeping <john@keeping.me.uk> wrote:
> > As Jonathan Nieder wondered before [1], this changes the behaviour when
> > the commit message is empty.  Before this commit, there is an empty line
> > followed by the S-O-B line; now the S-O-B is on the first line of the
> > commit.
> >
> > The previous behaviour seems better to me since the empty line is
> > hinting that the user should fill something in.  It looks particularly
> > strange if your editor has syntax highlighting for commit messages such
> > that the first line is in a different colour.
> 
> Are you talking about the output produced by format-patch?  Or are you
> talking about what happens when you do 'commit --amend -s' for a
> commit with an empty commit message. (The email that you referenced
> was about the behavior of format-patch).

I'm talking about plain 'commit -s' which seems to use the same code
path.

> I'm thinking you must be talking about the 'commit --amend -s'
> behavior since you mentioned your editor.  Is there another case that
> is affected by this?  Normally, any extra blank lines that precede or
> follow a commit message are removed before the commit object is
> created.  So, I guess it wouldn't hurt to insert a newline (or maybe
> it should be two?) before the signoff in this case.  Would this
> provide an improvement or change for any other commands than 'commit
> --amend -s'?
> 
> If we want to do this, then I'd probably do it like this:
> 
> -               if (len && msgbuf->buf[len - 1] != '\n')
> +               if (!len || msgbuf->buf[len - 1] != '\n')
>                         append_newlines = "\n\n";
> -               else if (len > 1 && msgbuf->buf[len - 2] != '\n')
> +               else if (len == 1 || msgbuf->buf[len - 2] != '\n')
>                         append_newlines = "\n";
> 
> This would ensure there were two newlines preceding the sob.  The
> editor would place its cursor on the top line where the user should
> begin typing in a commit message.  If an editor was not opened up
> (e.g. if 'git cherry-pick -s --allow-empty-message ...' was used) then
> the normal mechanism that removes extra blank lines would trigger to
> remove the extra blank lines.
> 
> I think that's reasonable.

Two blank lines seems like an improvement to me, FWIW.


John
