From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 02/17] revert: Inline add_message_to_msg function
Date: Tue, 19 Jul 2011 22:06:15 +0530
Message-ID: <CALkWK0mmPeYawqF-Dd3Sv_0qYjfYA-36POengYupfjwNBRDj-g@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-3-git-send-email-artagnon@gmail.com> <20110712165302.GA13578@elie>
 <CALkWK0kHutr41aH7OrmW3REV+YBUeHSryA9n62yxyF0qRd1FEw@mail.gmail.com> <20110713064240.GC31003@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 18:36:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjDHl-0000B8-N8
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 18:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333Ab1GSQgh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jul 2011 12:36:37 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45757 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab1GSQgg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jul 2011 12:36:36 -0400
Received: by wyg8 with SMTP id 8so2913727wyg.19
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 09:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ERerd31WyMkAvJq4UI8FWiNA+FhKXdEkmgjgxQL7uTU=;
        b=P7MpMC5BoQEexghf+sJIx3x4NhEib1V6PATjRffYouAral5HVn6lbUrQlCTozuE+nF
         KobDf8P0K1MbrpOEYP1CbvNO4EQbeJlLiQH5DNUfqTH648dHn1x6p8Y1wbaNwvvMspKw
         TSL6zU0op1VFwKcRQMt3x9DA/7/bSQ5nr0eSY=
Received: by 10.216.234.143 with SMTP id s15mr911199weq.66.1311093395130; Tue,
 19 Jul 2011 09:36:35 -0700 (PDT)
Received: by 10.216.234.143 with HTTP; Tue, 19 Jul 2011 09:36:15 -0700 (PDT)
In-Reply-To: <20110713064240.GC31003@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177461>

Hi again,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> Fixed all issues. =C2=A0The commit message now reads
>>
>> revert: Inline add_message_to_msg function
>>
>> The add_message_to_msg function is poorly implemented, has an unclea=
r
>> API, and only one callsite. =C2=A0Replace the callsite with a cleane=
r
>> implementation. =C2=A0Additionally, fix a bug introduced in 9509af6 =
(Make
>> git-revert & git-cherry-pick a builtin, 2007-03-01) -- a NULL pointe=
r
>> was being dereferenced when "\n\n" was not found in "message".
>
> That's basically the same as before, with "dereferenced" in place of
> "incremented". =C2=A0An improvement, sure, but it still doesn't answe=
r the
> basic questions like "how can I reproduce the bug?".

Thanks for poking -- I figured out what's going on.  The msg.message
doesn't just contain the commit message; it contains information like
tree, parent etc (all the information shown by cat-file).  A typical
msg.message looks like:

>>
tree cb35cb5a8736245fd669729ce40d790062f1d74b
parent dcab267d57895e9e8710f5a954e8b9bdfa459c71
author Ramkumar Ramachandra <artagnon@gmail.com> 1311091028 +0530
committer Ramkumar Ramachandra <artagnon@gmail.com> 1311091028 +0530

This is the subject of the message

This is the description of the message
<<

The strstr(msg.message, "\n\n") actually stops after the 0 in the
committer line.  It's trying to find out where the commit message
actually begins.  I even created a commit using commit-tree (not using
porcelain), but it's impossible to find a msg.message that doesn't
have a "\n\n" -- even one with an empty commit message looks like:

>>
tree cb35cb5a8736245fd669729ce40d790062f1d74b
parent dcab267d57895e9e8710f5a954e8b9bdfa459c71
author Ramkumar Ramachandra <artagnon@gmail.com> 1311091028 +0530
committer Ramkumar Ramachandra <artagnon@gmail.com> 1311091028 +0530

<<

The earlier logic was flawed:

	while (*p && (*p !=3D '\n' || p[1] !=3D '\n'))
		p++;

	if (!*p)
		strbuf_addstr(msgbuf, sha1_to_hex(commit->object.sha1));

Here, the !*p will never be satisfied even in the case of the empty
commit message because p reads "\n\n" at this point: the picked commit
will be filled up with an empty commit message as well.  This is also
shown by the tests in t3505-cherry-pick-emtpy.sh.  Perhaps this really
is the desired behavior: why should cherry-pick try to add something
to the commit message when we're picking a commit with an empty commit
message? Now I realize that the new logic is flawed too.  Since it's
totally impossible to reproduce this bug, it's not really a bug --
there's just some dead code in the older implementation, and we want
to remove it and make it clear.

New commit message and commit.

-- 8< --
Subject: [PATCH] revert: Simplify and inline add_message_to_msg

The add_message_to_msg function has some dead code, an unclear API,
only one callsite.  While it originally intended fill up an empty
commit message with the commit object name while picking, it really
doesn't do this -- a bug introduced in 9509af6 (Make git-revert &
git-cherry-pick a builtin, 2007-03-01).  Today, tests in
t3505-cherry-pick-empty.sh indicate that not filling up an empty
commit message is the desired behavior.  Re-implement and inline the
function accordingly.

Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   26 ++++++++++++--------------
 1 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 2df3f3b..2b5f261 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -185,19 +185,6 @@ static char *get_encoding(const char *message)
        return NULL;
 }

-static void add_message_to_msg(struct strbuf *msgbuf, const char *mess=
age)
-{
-       const char *p =3D message;
-       while (*p && (*p !=3D '\n' || p[1] !=3D '\n'))
-               p++;
-
-       if (!*p)
-               strbuf_addstr(msgbuf, sha1_to_hex(commit->object.sha1))=
;
-
-       p +=3D 2;
-       strbuf_addstr(msgbuf, p);
-}
-
 static void write_cherry_pick_head(void)
 {
        int fd;
@@ -462,11 +449,22 @@ static int do_pick_commit(void)
                }
                strbuf_addstr(&msgbuf, ".\n");
        } else {
+               const char *p;
+
                base =3D parent;
                base_label =3D msg.parent_label;
                next =3D commit;
                next_label =3D msg.label;
-               add_message_to_msg(&msgbuf, msg.message);
+
+               /*
+                * Append the commit log message to msgbuf; it starts
+                * after the tree, parent, author, committer
+                * information followed by "\n\n".
+                */
+               p =3D strstr(msg.message, "\n\n");
+               p +=3D 2;
+               strbuf_addstr(&msgbuf, p);
+
                if (no_replay) {
                        strbuf_addstr(&msgbuf, "(cherry picked from com=
mit ");
                        strbuf_addstr(&msgbuf,
sha1_to_hex(commit->object.sha1));
--=20
1.7.4.rc1.7.g2cf08.dirty
