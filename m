From: Leila <muhtasib@gmail.com>
Subject: Re: [PATCH/RFC] revision: Show friendlier message.
Date: Mon, 25 Jun 2012 15:14:50 -0400
Message-ID: <CAA3EhHJbKj+nbVsZtijsH+h7sFcyeBwT9K=BTeqAuMzSH0RGmg@mail.gmail.com>
References: <1340478681-58476-1-git-send-email-muhtasib@gmail.com> <7vobo8hsee.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 21:15:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjEks-0000SY-NZ
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 21:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754779Ab2FYTPO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jun 2012 15:15:14 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:41480 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113Ab2FYTPN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2012 15:15:13 -0400
Received: by vbbff1 with SMTP id ff1so2172150vbb.19
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 12:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=lvvTsUgBIOjFETe2OtLCT+lSep+LPqi554TNhXloztE=;
        b=iTw1TMKl3OphlCwrIQRffE4Qyd6gTeZJyBxT8gxE16QKpQBD4BcR71mq5k6tObQ15X
         S50dRis/EQepmcI3knGADeGkmGN8Gf4n5KkIO7Pwu9ANBMIndHnAJ8QO1kNo6hqgx6Uj
         Eu3lO2e9Mxix5ezOxg3kNP/29mPCFksMtso/3uD+XvSUn/0YiixWccVm4O2v/wc0yFpw
         KydwE7Nn0KuumakoZvvGUIiLa79oTt4dvrbReJ3DNLGJPI4tBIg2n8E8bkW/BldMRhs0
         qVKSpNr6bpfploydRMJtD96cEszUXhDJAZMImO36m8iVqZSPPPL3ksDjv/FBLvgdd0wg
         C0uA==
Received: by 10.52.97.230 with SMTP id ed6mr7273593vdb.65.1340651711295; Mon,
 25 Jun 2012 12:15:11 -0700 (PDT)
Received: by 10.52.37.233 with HTTP; Mon, 25 Jun 2012 12:14:50 -0700 (PDT)
In-Reply-To: <7vobo8hsee.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200592>

On Mon, Jun 25, 2012 at 1:28 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> But setup_revisions() is a very low level routine that is used by
> many plumbing commands, and it is a horrible layering violation to
> tweak its behaviour based on argv[0] and also it is too inflexible
> hack as a solution. =A0For example, don't you want to give a differen=
t
> error message for "git log HEAD" with an explicit "HEAD" from the
> command line? =A0Would you add a similar support for a command that i=
s
> not "log" by adding yet another strcmp() here?

I noticed that it was a very low level routine used by many commands.
Initially, I also thought it was a bit hacky to check argv[0], and yes
it would mean that we'd need to add more strcmps (or if the message
sufficed for all commands take out the comparison of argv[0]) in the
future to handle various cases. But I figured I'd use argv[0], since
it was avail to us in that routine. And since that routine is where we
displayed the error message, I tried to keep changes local to that
area. I was trying to change as little code as possible, because I
didn't want to affect the other commands. I've started implementing a
patch with your suggestions below.


> Wouldn't it be a more reasonable alternative solution if you do this:
>
> =A01. Check if HEAD points at a commit _before_ setting opt->def to i=
t
> =A0 =A0in "git log" (and other end-user facing programs in the "log"
> =A0 =A0family, possibly in cmd_log_init_finish() if that function is
> =A0 =A0not called by a program where the current message should not
> =A0 =A0change), and do _NOT_ set opt->def to it;

Ok. At the start of the cmd_log_init_finish, opt->def already points
to HEAD. But I can unset it if HEAD doesn't point at a commit.

> =A02. Make setup_revisions() expose got_rev_arg to its callers
> =A0 =A0(e.g. move it to struct rev_info);

Do you mean have got_rev_args be a wrapper of argc and argv?

Or is it just a mechanism to set a signal that the calling command is
'log', so that I can do something about it without checking argv[0]?

> =A03. If you did not pass HEAD in opt->def and setup_revisions() said
> =A0 =A0it did not "got_rev_arg", give whatever error message that you
> =A0 =A0think is more user friendly.
>

Sure, I can do this. Note: just to confirm the message/exit will still
come from inside of setup_revisions()?

> That way, if HEAD points at a commit, or if HEAD doesn't point at a
> commit but the user gave some existing commit from the command line,
> you wouldn't see "bad default revision" at all.
>
> And the most important part of this alternative is that the lower
> level machinery does not have to _care_ about the reason why the
> higher level passed a bad HEAD to it.
>

I'll wait to comment on this until I understand what get_rev_arg is
supposed to do/signify, as things will be clearer then.

> Personally, I tend to think that not saying anything and reporting
> success, instead of any error message, would be the right thing to
> do if you are changing the behaviour of this case anyway.
>
> Hrm?
>
Yes, I think reporting success would be right in this case. I think
the message "No commit(s) to display." is helpful, but I don't feel
strongly about this.

Thanks!
