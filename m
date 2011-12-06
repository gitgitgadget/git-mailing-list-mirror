From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2011, #02; Mon, 5)
Date: Wed, 7 Dec 2011 02:00:52 +0530
Message-ID: <CALkWK0nNtvrLHxQv17jfrFQ=BcwLfgh7eE9X-nDCCYY0nsOskg@mail.gmail.com>
References: <7v8vmqi98f.fsf@alter.siamese.dyndns.org> <CALkWK0mpPoZJWviBesWgy2dZ4xJrNyhED2znFid8iGbSTirPhQ@mail.gmail.com>
 <7vliqph8a6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 21:32:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY1gL-0006bN-86
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 21:32:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753707Ab1LFUbP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Dec 2011 15:31:15 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45899 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806Ab1LFUbO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2011 15:31:14 -0500
Received: by wgbdr13 with SMTP id dr13so6843552wgb.1
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 12:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=fllm4zap1NCHpaC3/d5bR/YvVwpvoQpJaNcK56Zbmyg=;
        b=J/uS07ivCKkRgyUMBpwK+/hPvC5ciQRIl3z+kS9LPAdAZGr1IHU1LmtH00i/Q3sveA
         9+U8NsdBkHDkoEtGtsD/30Ns5Ub+e+Hr77zURNZmqYNHLBs2pVzqPl8iUH7paNcXVky1
         78gJTA4Ws7oFXaihOnP5ubB84NIF03RmjQxIQ=
Received: by 10.227.209.9 with SMTP id ge9mr3071400wbb.1.1323203473236; Tue,
 06 Dec 2011 12:31:13 -0800 (PST)
Received: by 10.216.51.141 with HTTP; Tue, 6 Dec 2011 12:30:52 -0800 (PST)
In-Reply-To: <7vliqph8a6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186379>

Hi Junio,

Junio C Hamano wrote:
> A few comments and thoughts, all minor.
>
> =C2=A0* On "revert: simplify getting commit subject in format_todo()"
>
> =C2=A0 The old code used to use get_message() on cur->item, checked i=
ts return
> =C2=A0 value (if cur->item is not parsed, or has already been used an=
d its buffer
> =C2=A0 cleared, cur->item->buffer would be NULL and get_message() ret=
urns -1) and
> =C2=A0 issued an error. The new code uses find_commit_subject without=
 first
> =C2=A0 checking if cur->item->buffer is NULL.
>
> =C2=A0 Does this mean the old code was overly defensive, or is the ne=
w code too
> =C2=A0 lax?
>
> =C2=A0 I understand that parse_insn_line() uses lookup_commit_referen=
ce() which
> =C2=A0 calls parse_object() on the object name (and if it is a tag, d=
eref_tag()
> =C2=A0 will parse the tagged object until we see something that is no=
t a tag), so
> =C2=A0 we know cur->item is parsed before we see it, so I suspect you=
 merely were
> =C2=A0 being overly defensive, but I may be missing something.

Right.  Actually, I was being overly defensive because I was being
lazy about having to deal the an empty-commit-subject case in the
parser.  With "revert: make commit subjects in insn sheet optional",
that's no more a concern- I'll reorder these two patches, and explain
this detail in the commit message in the re-roll.

> =C2=A0* On "revert: make commit subjects in insn sheet optional"
>
> =C2=A0 After finding the verb and advancing the pointer "bol" at the =
beginning of
> =C2=A0 the object name, end_of_object_name variable points at the fir=
st SP or LF
> =C2=A0 using strcspn(bol, " \n"), but I wonder why we are not grabbin=
g a run of
> =C2=A0 hexdigits instead, i.e. strspn(bol, "0123456789abcdef"). Is th=
is so that
> =C2=A0 we can allow something like "pick rr/revert-cherry-pick~3"?

Yes, it is exactly for that reason :)

> =C2=A0 I also wonder if this should be (sorry for pcre) "(pick|revert=
)\s+(\S+)\s"
> =C2=A0 instead, i.e. allow users with fat fingers to use one or more =
SP or even HT
> =C2=A0 to separate the verb and the operand.

Hm, I'm not too enthusiastic about this change, because we don't
advertise hand-editing the instruction sheet yet: it's just some extra
parsing cruft along with guardian buffer-overflow code that buys us no
immediate benefits.

> =C2=A0 The last test you added to 3510 in this patch runs test_line_c=
ount
> =C2=A0 unconditionally, by the way.

Good catch.  Missing the chaining '&&' seems to be quite a common
error: I vaguely remember seeing a patch to detect this sometime ago.
Jonathan?

> =C2=A0* On "revert: allow mixed pick and revert instructions"
>
> =C2=A0 Reporting what we did not understand from parse_insn_line() is=
 a good
> =C2=A0 idea, but I think the line number should be reported at the be=
ginning
> =C2=A0 of the same line.

Makes sense.  Do you like this?

diff --git a/builtin/revert.c b/builtin/revert.c
index e447449..cfa770e 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -715,7 +715,8 @@ static int format_todo(struct strbuf *buf, struct
replay_insn_list *todo_list)
 	return 0;
 }

-static int parse_insn_line(char *bol, char *eol, struct replay_insn_li=
st *item)
+static int parse_insn_line(char *bol, char *eol,
+			struct replay_insn_list *item, int lineno)
 {
 	unsigned char commit_sha1[20];
 	char *end_of_object_name;
@@ -731,7 +732,8 @@ static int parse_insn_line(char *bol, char *eol,
struct replay_insn_list *item)
 		size_t len =3D strchrnul(bol, '\n') - bol;
 		if (len > 255)
 			len =3D 255;
-		return error(_("Unrecognized action: %.*s"), (int)len, bol);
+		return error(_("Line %d: Unrecognized action: %.*s"),
+			lineno, (int)len, bol);
 	}

 	end_of_object_name =3D bol + strcspn(bol, " \n");
@@ -741,11 +743,11 @@ static int parse_insn_line(char *bol, char *eol,
struct replay_insn_list *item)
 	*end_of_object_name =3D saved;

 	if (status < 0)
-		return error(_("Malformed object name: %s"), bol);
+		return error(_("Line %d: Malformed object name: %s"), lineno, bol);

 	item->operand =3D lookup_commit_reference(commit_sha1);
 	if (!item->operand)
-		return error(_("Not a valid commit: %s"), bol);
+		return error(_("Line %d: Not a valid commit: %s"), lineno, bol);

 	item->next =3D NULL;
 	return 0;
@@ -760,8 +762,8 @@ static int parse_insn_buffer(char *buf, struct
replay_insn_list **todo_list)

 	for (i =3D 1; *p; i++) {
 		char *eol =3D strchrnul(p, '\n');
-		if (parse_insn_line(p, eol, &item) < 0)
-			return error(_("on line %d."), i);
+		if (parse_insn_line(p, eol, &item, lineno) < 0)
+			return -1;
 		next =3D replay_insn_list_append(item.action, item.operand, next);
 		p =3D *eol ? eol + 1 : eol;
 	}
--

> I'd say that I'd prefer queuing re-rolled patches posted on the list;=
 I'll
> discard the rr/revert-cherry-pick (6a156fd) from my tree.

Thanks for letting me know -- will post shortly.

-- Ram
