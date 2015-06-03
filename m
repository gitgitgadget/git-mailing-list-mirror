From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 1/2] status: give more information during rebase -i
Date: Wed, 03 Jun 2015 19:12:17 +0200
Message-ID: <vpqpp5cbtse.fsf@anie.imag.fr>
References: <1433320545-14244-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Guillaume =?iso-8859-1?Q?Pag=E8s?= 
	<guillaume.pages@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 03 19:12:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0CDj-0007zT-DU
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 19:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933368AbbFCRMf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2015 13:12:35 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45169 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933303AbbFCRMU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 13:12:20 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t53HCFA3007846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Jun 2015 19:12:15 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t53HCHYq010999;
	Wed, 3 Jun 2015 19:12:17 +0200
In-Reply-To: <1433320545-14244-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	("Guillaume \=\?iso-8859-1\?Q\?Pag\=E8s\=22's\?\= message of "Wed, 3 Jun 2015
 10:35:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 03 Jun 2015 19:12:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t53HCFA3007846
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433956335.37023@o4XUCN/TsjYj8sBvnEj80g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270700>

Hi,

Your code is not C90:

wt-status.c: In function =E2=80=98get_two_last_lines=E2=80=99:
wt-status.c:1030:2: error: ISO C90 forbids mixed declarations and code =
[-Werror=3Ddeclaration-after-statement]
  struct strbuf buf =3D STRBUF_INIT;
  ^
wt-status.c: In function =E2=80=98get_two_first_lines=E2=80=99:
wt-status.c:1050:2: error: ISO C90 forbids mixed declarations and code =
[-Werror=3Ddeclaration-after-statement]
  struct strbuf buf =3D STRBUF_INIT;
  ^

I have this to notice it:

$ cat config.mak
CFLAGS +=3D -Wdeclaration-after-statement -Wall -Werror #-O0 -g

Guillaume Pag=C3=A8s <guillaume.pages@ensimag.grenoble-inp.fr> writes:

> +void get_two_last_lines(char *filename,int * numlines, char ** lines=
)

Space after ,

> +{
> +	*numlines=3D0;

Spaces around =3D

> +	struct strbuf buf =3D STRBUF_INIT;
> +	FILE *fp =3D fopen(git_path("%s", filename), "r");
> +	if (!fp) {
> +		strbuf_release(&buf);
> +		return;
> +	}
> +	while (strbuf_getline(&buf, fp, '\n')!=3DEOF){

Spaces around !=3D

There are many other space issues, I won't list them all.

> +		(*numlines)++;
> +		lines[0]=3Dlines[1];
> +		lines[1]=3Dstrbuf_detach(&buf, NULL);
> +	}
> +	if (!fclose(fp))
> +		strbuf_detach(&buf, NULL);
> +	else
> +		strbuf_release(&buf);
> +}
> +
> +void get_two_first_lines(char *filename,int * numlines, char ** line=
s)

Stick the * to the corresponding variable.

Do: int *numlines
Don't: int * numlines, int* numlines

One rationale is that when you write

int *i, j;

it reads "*i is an int, and so is j" (which is right), while

int * i, j;

may read as "both i and j are int *" (which is not right).

> +{
> +	*numlines=3D0;
> +	struct strbuf buf =3D STRBUF_INIT;
> +	char *line;
> +	FILE *fp =3D fopen(git_path("%s", filename), "r");
> +	if (!fp) {
> +		strbuf_release(&buf);
> +		return;
> +	}
> +	while (strbuf_getline(&buf, fp, '\n')!=3DEOF){
> +		stripspace(&buf, 1);
> +		line =3D strbuf_detach(&buf, NULL);
> +		if (strcmp(line,"")=3D=3D0)
> +			continue;
> +		if (*numlines<2)
> +			lines[*numlines] =3D line;
> +		(*numlines)++;
> +	}
> +	if (!fclose(fp))
> +		strbuf_detach(&buf, NULL);
> +	else
> +		strbuf_release(&buf);
> +}
> +
> +void show_rebase_information(struct wt_status *s,
> +				    struct wt_status_state *state,
> +				    const char *color)

static?

> +{
> +	if (state->rebase_interactive_in_progress){
> +		int i, begin;
> +		int numlines =3D0;
> +		char* lines[2];
> +		get_two_last_lines("rebase-merge/done", &numlines, lines);
> +		if (numlines=3D=3D0)
> +			status_printf_ln(s,color,"No command done.");
> +		else{

Space before {. Several instances too.

> +			status_printf_ln(s,color,
> +				"Last command(s) done (%d command(s) done):",
> +				numlines);
> +			begin =3D numlines > 1? 0 : 1;
> +			for (i =3D begin; i < 2; i++){
> +				status_printf_ln(s,color,"   %s",lines[i]);
> +			}
> +			if (numlines>2 && s->hints )
> +			   status_printf_ln(s,color,
> +				"  (see more at .git/rebase-merge/done)");
> +		}
> +		numlines =3D0;
> +		get_two_first_lines("rebase-merge/git-rebase-todo",
> +					 &numlines, lines);
> +		if (numlines=3D=3D0)
> +			status_printf_ln(s,color,

Space after ,.

> +					 "No command remaining.");
> +		else{
> +
> +			status_printf_ln(s,color,
> +				"Next command(s) to do (%d remaining command(s)):",
> +				numlines);
> +			begin =3D numlines > 1? 0 : 1;
> +			for (i =3D 0; (i < 2 && i < numlines); i++){
> +				status_printf(s,color,"   %s",lines[i]);
> +			}
> +			if (s->hints )

No space before ).

> +			   status_printf_ln(s,color,
> +				"  (use git rebase --edit-todo to view and edit)");

Mark for translation -> _("..."). Many instances above.

> -	if (has_unmerged(s)) {
> +	show_rebase_information(s,state,color);
> +	if (has_unmerged(s) || state->rebase_in_progress || !stat(git_path(=
"MERGE_MSG"), &st)) {

The show_rebase_information() line does belong to this patch, but the
other change do not IHMO. It would be _much_ easier to review in its ow=
n
patch with an explicit title like "status: factor two rebase-related
messages together" or so.

> @@ -1327,7 +1410,10 @@ void wt_status_print(struct wt_status *s)
>  		else if (!strcmp(branch_name, "HEAD")) {
>  			branch_status_color =3D color(WT_STATUS_NOBRANCH, s);
>  			if (state.rebase_in_progress || state.rebase_interactive_in_progr=
ess) {
> -				on_what =3D _("rebase in progress; onto ");
> +				if (state.rebase_interactive_in_progress)
> +					on_what =3D _("interactive rebase in progress; onto ");
> +				else
> +					on_what =3D _("rebase in progress; onto ");

I wouldn't insist on that, but splitting this one in a separate patch
would make sense to me too. The patch would contain this change, and th=
e
impact on tests.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
