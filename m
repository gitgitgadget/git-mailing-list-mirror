From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/5] sequencer: Expose code that handles files in .git/sequencer
Date: Thu, 11 Aug 2011 11:46:58 +0530
Message-ID: <CALkWK0kxtyPABBUOrXtKDxPCBKt3CynoP4Fm8f_+C1ymkLTo-w@mail.gmail.com>
References: <1312970151-18906-1-git-send-email-artagnon@gmail.com>
 <1312970151-18906-5-git-send-email-artagnon@gmail.com> <20110810152126.GE31315@elie.gateway.2wire.net>
 <CALkWK0nJUTtNgCHF6CE2-w+3ZwdBrscBRw0e0L8wX86Za0G=DA@mail.gmail.com> <20110810155332.GB4076@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 11 08:17:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrOa5-0002Xi-Go
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 08:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626Ab1HKGRU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Aug 2011 02:17:20 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43023 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465Ab1HKGRT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2011 02:17:19 -0400
Received: by wyg24 with SMTP id 24so1188327wyg.19
        for <git@vger.kernel.org>; Wed, 10 Aug 2011 23:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=cJAiI6Yxgbe4uYl+vdxxDU3EAsnnIF6hcUeF7gAEwMY=;
        b=jDCKBVI9b4roxu1w68OcK/HLdccmPuB0kH9pFHW6LVNBYoBy/aIlfxuVSVgbvjG1Qs
         16AH893qoUfWxha3uHmQfsDLskYurE8KX3PY1J1+ZlwvAcN9FfhFgOFMLJPlay8GyziD
         CXvos1yxpsDmljikiDXbtqXpl9le/dl736l7E=
Received: by 10.216.46.208 with SMTP id r58mr1374534web.78.1313043438053; Wed,
 10 Aug 2011 23:17:18 -0700 (PDT)
Received: by 10.216.139.31 with HTTP; Wed, 10 Aug 2011 23:16:58 -0700 (PDT)
In-Reply-To: <20110810155332.GB4076@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179082>

Hi Jonathan,

Jonathan Nieder writes:
> Well, "beautiful public API" means "just what cmd_cherry_pick and
> cmd_revert needs", right? =C2=A0So I'd suggest:

Yes, but I don't want to put stuff that's too specific to cherry-pick/
revert in the sequencer.

> [...]
> Luckily step (1) is already done. =C2=A0The functions are parse_args(=
)
> and pick_revisions() (though they could presumably use less generic
> names).

Are you certain about pick_revisions?  I've copied over the function
here for your reference.  My issue is that it's too specific
cherry-pick/ revert:
1. See what walk_revs_populate_todo does: It takes all the operands
and fills up "pick" as the operator.  Why would any other caller want
to do this?
2. You mentioned multiple entry points earlier, and that's something
I've been meaning to do: In the long run, I don't want callers to fill
up an opts structure to specify the subcommand! That'd be butt-ugly.

-- 8< --
static int pick_revisions(struct replay_opts *opts)
{
	struct replay_insn_list *todo_list =3D NULL;
	unsigned char sha1[20];

	read_and_refresh_cache(opts);

	/*
	 * Decide what to do depending on the arguments; a fresh
	 * cherry-pick should be handled differently from an existing
	 * one that is being continued
	 */
	if (opts->subcommand =3D=3D REPLAY_RESET) {
		remove_sequencer_state(1);
		return 0;
	} else if (opts->subcommand =3D=3D REPLAY_CONTINUE) {
		if (!file_exists(git_path(SEQ_TODO_FILE)))
			goto error;
		sequencer_read_opts(&opts);
		sequencer_read_todo(&todo_list);

		/* Verify that the conflict has been resolved */
		if (!index_differs_from("HEAD", 0))
			todo_list =3D todo_list->next;
	} else {
		/*
		 * Start a new cherry-pick/ revert sequence; but
		 * first, make sure that an existing one isn't in
		 * progress
		 */

		walk_revs_populate_todo(&todo_list, opts);
		if (sequencer_create_dir() < 0) {
			error(_("A cherry-pick or revert is in progress."));
			advise(_("Use --continue to continue the operation"));
			advise(_("or --reset to forget about it"));
			return -1;
		}
		if (get_sha1("HEAD", sha1)) {
			if (opts->action =3D=3D REPLAY_REVERT)
				return error(_("Can't revert as initial commit"));
			return error(_("Can't cherry-pick into empty head"));
		}
		sequencer_save_head(sha1_to_hex(sha1));
		sequencer_save_opts(opts);
	}
	return pick_commits(todo_list, opts);
error:
	return error(_("No %s in progress"), action_name(opts));
}
