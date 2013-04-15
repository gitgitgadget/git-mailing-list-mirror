From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v3] cherry-pick: make sure all input objects are commits
Date: Mon, 15 Apr 2013 10:44:01 +0200
Message-ID: <87vc7odvzi.fsf@linux-k42r.v.cablecom.net>
References: <20130403092704.GC21520@suse.cz>
	<7v38v1yn8o.fsf@alter.siamese.dyndns.org>
	<20130411092638.GA12770@suse.cz>
	<CALkWK0n6FjGbXTqiOT_O6NbB5h0DLaNWKCCTQAFSO_BL-pPdBA@mail.gmail.com>
	<20130411110324.GD12770@suse.cz>
	<CALkWK0kb+2KZLvRJDJb_VrNNs1k4grsfyFv0HfYv0Kr9v4sChQ@mail.gmail.com>
	<20130411130652.GG12770@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	<git@vger.kernel.org>
To: Miklos Vajna <vmiklos@suse.cz>
X-From: git-owner@vger.kernel.org Mon Apr 15 10:44:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URf1H-0008C2-KA
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 10:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947Ab3DOIoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 04:44:06 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:26283 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934635Ab3DOIoE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 04:44:04 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 15 Apr
 2013 10:43:59 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 15 Apr 2013 10:44:01 +0200
In-Reply-To: <20130411130652.GG12770@suse.cz> (Miklos Vajna's message of "Thu,
	11 Apr 2013 15:06:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221204>

Miklos Vajna <vmiklos@suse.cz> writes:

> Fix this bug and make sure all arguments are commits, and
> for the first non-commit, error out with:
>
> 	fatal: <name>: Can't cherry-pick a <type>

> @@ -1067,6 +1068,23 @@ int sequencer_pick_revisions(struct replay_opts *opts)
>  	if (opts->subcommand == REPLAY_CONTINUE)
>  		return sequencer_continue(opts);
>  
> +	for (i = 0; i < opts->revs->pending.nr; i++) {
> +		unsigned char sha1[20];
> +		const char *name = opts->revs->pending.objects[i].name;
> +
> +		/* This happens when using --stdin. */
> +		if (!strlen(name))
> +			continue;

This is undefined behavior; the pending.objects[i].name has been freed
already.  Luckily valgrind points you right at it:

  ==9178== Invalid read of size 1
  ==9178==    at 0x4CEFB4: sequencer_pick_revisions (sequencer.c:1077)
  ==9178==    by 0x45E7F2: cmd_cherry_pick (revert.c:236)
  ==9178==    by 0x40523C: handle_internal_command (git.c:292)
  ==9178==    by 0x405467: main (git.c:500)
  ==9178==  Address 0x5bedbd0 is 0 bytes inside a block of size 1,001 free'd
  ==9178==    at 0x4C2ACDA: free (vg_replace_malloc.c:468)
  ==9178==    by 0x4D96C7: strbuf_release (strbuf.c:40)
  ==9178==    by 0x4C9AAE: setup_revisions (revision.c:1285)
  ==9178==    by 0x45E6FA: parse_args (revert.c:203)
  ==9178==    by 0x45E7EA: cmd_cherry_pick (revert.c:235)
  ==9178==    by 0x40523C: handle_internal_command (git.c:292)
  ==9178==    by 0x405467: main (git.c:500)

>From a cursory glance it looks like it's actually an existing bug in
read_revisions_from_stdin or handle_revision_arg, depending on which way
you look at it.  read_revisions_from_stdin passes its temporary buffer
down to handle_revision_arg:

        struct strbuf sb;
        [...]
        strbuf_init(&sb, 1000);
        while (strbuf_getwholeline(&sb, stdin, '\n') != EOF) {
                [...]
                if (handle_revision_arg(sb.buf, revs, 0, REVARG_CANNOT_BE_FILENAME))
                        die("bad revision '%s'", sb.buf);
        }

But handle_revision_arg ends up just stuffing that parameter into the
revision-walker options via some helpers:

	add_rev_cmdline(revs, object, arg_, REV_CMD_REV, flags ^ local_flags);
	add_pending_object_with_mode(revs, object, arg, oc.mode);

This seems to have been lurking since 281eee4 (revision: keep track of
the end-user input from the command line, 2011-08-25).

Junio, at which level should we fix it?  We could of course have
read_revisions_from_stdin make a copy of the buffers it passes down, but
perhaps it would be less surprising to instead have handle_revision_arg
make sure it makes a copy of everything it "keeps"?

The easy fix of course is just this:

diff --git i/revision.c w/revision.c
index 3a20c96..181a8db 100644
--- i/revision.c
+++ w/revision.c
@@ -1277,7 +1277,8 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 			}
 			die("options not supported in --stdin mode");
 		}
-		if (handle_revision_arg(sb.buf, revs, 0, REVARG_CANNOT_BE_FILENAME))
+		if (handle_revision_arg(xstrdup(sb.buf), revs, 0,
+					REVARG_CANNOT_BE_FILENAME))
 			die("bad revision '%s'", sb.buf);
 	}
 	if (seen_dashdash)


-- 
Thomas Rast
trast@{inf,student}.ethz.ch
