From: Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 3/4] status: give more information during rebase -i
Date: Tue, 9 Jun 2015 10:57:38 +0200 (CEST)
Message-ID: <1393139524.297448.1433840258348.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433775308-5451-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr> <xmqq7frd97g7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 10:57:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2FLH-00065F-Ll
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 10:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756AbbFII5D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2015 04:57:03 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:49719 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752228AbbFII5A convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 04:57:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id AE6E9487DB;
	Tue,  9 Jun 2015 10:56:58 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SyTeNKMXPMam; Tue,  9 Jun 2015 10:56:58 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 945AE20B6;
	Tue,  9 Jun 2015 10:56:58 +0200 (CEST)
In-Reply-To: <xmqq7frd97g7.fsf@gitster.dls.corp.google.com>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF37 (Linux)/8.0.9_GA_6191)
Thread-Topic: status: give more information during rebase -i
Thread-Index: p/cJgPn4g3Xg3fZFiVBLYHqWSZhuUA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271155>

"Junio C Hamano" <gitster@pobox.com> writes:

>Guillaume Pag=C3=A8s <guillaume.pages@ensimag.grenoble-inp.fr> writes:=
=20

>> git status gives more information during rebase -i, about the list o=
f=20
>> command that are done during the rebase. It displays the two last=20
>> commands executed and the two next lines to be executed. It also giv=
es=20
>> hints to find the whole files in .git directory.=20
>> ---=20

>Without 1/4 and 2/4 in the same thread, it is hard to guess what you=20
>wanted to do with these two patches. Remember, reviewers review not=20
>just your patches but those from many others.=20

>I would in the meantime assume these are replacement patches for the=20
>ones in=20

>http://thread.gmane.org/gmane.comp.version-control.git/270743/focus=3D=
270744=20

You assumed correctly, I didn't wanted to flood the mailing list and I
assumed it would be linked correctly with the previous since. Looks lik=
e
I was wrong.

>> diff --git a/wt-status.c b/wt-status.c=20
>> index c83eca5..7f88470 100644=20
>> --- a/wt-status.c=20
>> +++ b/wt-status.c=20
>> @@ -1026,12 +1026,73 @@ static int split_commit_in_progress(struct w=
t_status *s)=20
>> return split_in_progress;=20
>> }=20
>>=20
>> +static void show_rebase_information(struct wt_status *s,=20
>> + struct wt_status_state *state,=20
>> + const char *color)=20
>> +{=20
>> + if (state->rebase_interactive_in_progress) {=20
>> + int i, begin;=20
>> + int lines_to_show_nr =3D 2;=20

>"lines_to_show =3D 2" or "nr_lines_to_show =3D 2" would be easier to r=
ead.=20

Done

>> +=20
>> + struct strbuf buf =3D STRBUF_INIT;=20
>> + struct string_list have_done =3D STRING_LIST_INIT_DUP;=20
>> + struct string_list yet_to_do =3D STRING_LIST_INIT_DUP;=20
>> +=20
>> + strbuf_read_file(&buf, git_path("rebase-merge/done"), 0);=20
>> + stripspace(&buf, 1);=20
>> + have_done.nr =3D string_list_split(&have_done, buf.buf, '\n', -1);=
=20
>> + string_list_remove_empty_items(&have_done, 1);=20
>> + strbuf_release(&buf);=20
>> +=20
>> + strbuf_read_file(&buf, git_path("rebase-merge/git-rebase-todo"), 0=
);=20
>> + stripspace(&buf, 1);=20
>> + string_list_split(&yet_to_do, buf.buf, '\n', -1);=20
>> + string_list_remove_empty_items(&yet_to_do, 1);=20
>> + strbuf_release(&buf);=20
>> +=20
>> + if (have_done.nr =3D=3D 0)=20
>> + status_printf_ln(s, color, _("No commands done."));=20

>Do the users even need to be told that, I wonder?=20

I guess it removes the ambiguity of being told nothing.

>> + else{=20

>Style: "else {"=20

Ok thanks.

>> + status_printf_ln(s, color,=20
>> + Q_("Last command done (%d command done):",=20
>> + "Last commands done (%d commands done):",=20
>> + have_done.nr),=20
>> + have_done.nr);=20
>> + begin =3D (have_done.nr > lines_to_show_nr) ? have_done.nr-lines_t=
o_show_nr : 0;=20
>> + for (i =3D begin; i < have_done.nr; i++) {=20
>> + status_printf_ln(s, color, " %s", have_done.items[i].string);=20
>> + }=20

>Hmm, perhaps fold lines like this (and you do not need "begin")?=20

>for (i =3D (lines_to_show_nr < have_done.nr)=20
>? have_done.nr - lines_to_show_nr : 0;=20
>i < have_done.nr;=20
>i++)=20
>status_printf_ln(...);



>> + if (have_done.nr > lines_to_show_nr && s->hints)=20
>> + status_printf_ln(s, color,=20
>> + _(" (see more in file %s)"), git_path("rebase-merge/done"));=20

>That's a nice touch ;-)=20

>> + }=20
>> + if (yet_to_do.nr =3D=3D 0)=20
>> + status_printf_ln(s, color,=20
>> + _("No commands remaining."));=20

>This I can see why we may want to say it.=20

>> + else{=20
>> +=20
>> + status_printf_ln(s, color,=20
>> + Q_("Next command to do (%d remaining command):",=20
>> + "Next commands to do (%d remaining commands):",=20
>> + yet_to_do.nr),=20
>> + yet_to_do.nr);=20
>> + for (i =3D 0; i < lines_to_show_nr && i < yet_to_do.nr; i++) {=20
>> + status_printf_ln(s, color, " %s", yet_to_do.items[i].string);=20
>> + }=20
>> + if (s->hints)=20
>> + status_printf_ln(s, color,=20
>> + _(" (use \"git rebase --edit-todo\" to view and edit)"));=20
>> + }=20

>Make sure you do not leak memory used by two string lists here...=20

Done, thanks again.
