From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 11/17] revert: Save data for continuing after conflict resolution
Date: Tue, 19 Jul 2011 01:01:55 +0530
Message-ID: <CALkWK0kZ3nWnnGe1OHXWgiZ8ik9iNW803wi2d6kUiNDpiOWNDA@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-12-git-send-email-artagnon@gmail.com> <20110712193716.GB14909@elie>
 <CALkWK0nyu6W2Nd=qcrjZZwkAdFGqTqAe53FmecS_n2cK_4UWMg@mail.gmail.com> <20110717184057.GD27787@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 21:32:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QitYH-0006e8-Ba
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 21:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788Ab1GRTcR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jul 2011 15:32:17 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37097 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106Ab1GRTcQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2011 15:32:16 -0400
Received: by wwe5 with SMTP id 5so3492045wwe.1
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 12:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=RP+/IeELSnf2E1kWNsGi+cZrKRD2H426jucEfpnb78I=;
        b=fYX91IAMlhoJ9efkAnytsMXOqeTp9ecDjWjsS3M8MKBmcvePXVnCPp0g1j6z/AmFkR
         KGcwkaX5u0AeuZS+NjUDzyfJIp0SVZ3xgq+ncZ1V5/qub1hP959mX0KR3Up3KdLBsaEg
         sWPWrJ1RgdwE3mW/P/gAKhiPnOYBnvQdCu8yw=
Received: by 10.227.207.15 with SMTP id fw15mr6024525wbb.66.1311017535203;
 Mon, 18 Jul 2011 12:32:15 -0700 (PDT)
Received: by 10.216.234.143 with HTTP; Mon, 18 Jul 2011 12:31:55 -0700 (PDT)
In-Reply-To: <20110717184057.GD27787@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177400>

Hi again,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> fatal: Malformed instruction sheet: .git/sequencer/todo
>> Technically speaking, this is correct. =C2=A0However, this may not b=
e ideal
>> from an end-user's perspective. =C2=A0Anyway, this is going to chang=
e soon
>> -- do you think this is worth correcting here and now?
>
> Yes, thanks. =C2=A0(A bird in the hand and all that.)

Okay, I thought about this for a while.  Either we can:
1. Assume that there'll never be a stray "revert" somewhere in the
middle of the instruction sheet when we invoke a "cherry-pick
--continue" and viceversa (ie. the instruction sheet is not corrupt/
hand-edited).  We can return a special exit status from the parser the
moment we encounter a "revert" during a "cherry-pick" assuming that
the entire sheet is filled with "revert" instructions, and die in
process_subcommand (now changed to pick_revisions) with a beautiful
message like "You're trying to resume a previous revert using
cherry-pick --continue, and we don't currently support this".
2. We can modify the API of the parser heavily to parse action +
commit instead of just commits.  Then, we can iterate through the list
and find/ report inconsistencies in process_subcommand.  In this case,
we can say "You're trying to resume a cherry-pick, but your
instruction sheet contains some revert instructions" or "You're trying
to resume a previous revert using cherry-pick --continue, and we don't
currently support this" as appropriate (after counting).  Although
this has a very beautiful end-user effect, I don't like the idea of
returning action + commit and counting.
3. Instead of just saying "fatal: Malformed instruction sheet" like we
do now, we can put in something a little more helpful like "error:
Cannot cherry-pick during a revert" before this message.  So:

$ git cherry-pick moo
=2E.. conflict ...
# resolve conflict
$ git revert --continue
error: Cannot cherry-pick during a revert
fatal: Malformed instruction sheet

This makes it clear to the user that the instruction sheet is to
blame, and in what way.  This is simple, and makes no assumptions
about whether or not the instruction sheet was hand-edited by the
user, so I like this.

Thoughts?

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
diff --git a/builtin/revert.c b/builtin/revert.c
index 0df724f..fcbf2a1 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -667,8 +667,13 @@ static struct commit *parse_insn_line(char
*start, struct replay_opts *opts)
 	 * Verify that the action matches up with the one in
 	 * opts; we don't support arbitrary instructions
 	 */
-	if (action !=3D opts->action)
+	if (action !=3D opts->action) {
+		const char *action_str;
+		action_str =3D action =3D=3D REVERT ? "revert" : "cherry-pick";
+		error(_("Cannot %s during a %s"), action_str,
+			action_name(opts));
 		return NULL;
+	}

 	if ((get_sha1(sha1_abbrev, commit_sha1) < 0)
 		|| !(commit =3D lookup_commit_reference(commit_sha1)))
