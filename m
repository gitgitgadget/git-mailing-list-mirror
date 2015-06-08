From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] status: give more information during rebase -i
Date: Mon, 08 Jun 2015 15:11:20 -0700
Message-ID: <xmqq7frd97g7.fsf@gitster.dls.corp.google.com>
References: <1433775308-5451-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
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
To: Guillaume =?utf-8?Q?Pag=C3=A8s?= 
	<guillaume.pages@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 09 00:11:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z25GY-0005um-BI
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 00:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753093AbbFHWLZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2015 18:11:25 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34197 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080AbbFHWLX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 18:11:23 -0400
Received: by igbhj9 with SMTP id hj9so797206igb.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 15:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=Rd4TbG4qXhDfB5nrW/FhgrNrcnWv3ESwKzfsM8/smK0=;
        b=cF3CBs/Qk4gUXHznZoyjXA2NeSuWKfg3lHCAgnjBHA3r7PbMZjCr3KAPKI/Y7QIoK0
         N6ojwK3tdXZ0w1d/hdUBbDbBKdeskRel7QO4JpMrr8I4pr2JGAChy68MOQoNbguatus5
         gy4mY9W+vS0jjHdli03t5QRWOz9pzsL4ekeymK2L2qUe3IXwYPd4XQx33jzCl/J+B23I
         5s/MFWYObdenVWqhQAOK+BxGWe/hoEuX8GoBGQ63bz+J4DtC2kX3X9DQlR69OJn2ZXkM
         +XsbPSYQ1C+rh9s8eq60eurLJL/LtgyMA77kxD1n+zZY/dvni3jIH4qOQfNd/4u+4dUX
         gX3w==
X-Received: by 10.107.12.27 with SMTP id w27mr4364269ioi.10.1433801483202;
        Mon, 08 Jun 2015 15:11:23 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:498e:2bf8:6933:5b2b])
        by mx.google.com with ESMTPSA id g23sm2640531iod.37.2015.06.08.15.11.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 15:11:22 -0700 (PDT)
In-Reply-To: <1433775308-5451-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	("Guillaume =?utf-8?Q?Pag=C3=A8s=22's?= message of "Mon, 8 Jun 2015
 16:55:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271139>

Guillaume Pag=C3=A8s  <guillaume.pages@ensimag.grenoble-inp.fr> writes:

> git status gives more information during rebase -i, about the list of
> command that are done during the rebase. It displays the two last
> commands executed and the two next lines to be executed. It also give=
s
> hints to find the whole files in .git directory.
> ---

Without 1/4 and 2/4 in the same thread, it is hard to guess what you
wanted to do with these two patches.  Remember, reviewers review not
just your patches but those from many others.

I would in the meantime assume these are replacement patches for the
ones in

  http://thread.gmane.org/gmane.comp.version-control.git/270743/focus=3D=
270744

> diff --git a/wt-status.c b/wt-status.c
> index c83eca5..7f88470 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1026,12 +1026,73 @@ static int split_commit_in_progress(struct wt=
_status *s)
>  	return split_in_progress;
>  }
> =20
> +static void show_rebase_information(struct wt_status *s,
> +				    struct wt_status_state *state,
> +				    const char *color)
> +{
> +	if (state->rebase_interactive_in_progress) {
> +		int i, begin;
> +		int lines_to_show_nr =3D 2;

"lines_to_show =3D 2" or "nr_lines_to_show =3D 2" would be easier to re=
ad.

> +
> +		struct strbuf buf =3D STRBUF_INIT;
> +		struct string_list have_done =3D STRING_LIST_INIT_DUP;
> +		struct string_list yet_to_do =3D STRING_LIST_INIT_DUP;
> +
> +		strbuf_read_file(&buf, git_path("rebase-merge/done"), 0);
> +		stripspace(&buf, 1);
> +		have_done.nr =3D string_list_split(&have_done, buf.buf, '\n', -1);
> +		string_list_remove_empty_items(&have_done, 1);
> +		strbuf_release(&buf);
> +
> +		strbuf_read_file(&buf, git_path("rebase-merge/git-rebase-todo"), 0=
);
> +		stripspace(&buf, 1);
> +		string_list_split(&yet_to_do, buf.buf, '\n', -1);
> +		string_list_remove_empty_items(&yet_to_do, 1);
> +		strbuf_release(&buf);
> +
> +		if (have_done.nr =3D=3D 0)
> +			status_printf_ln(s, color, _("No commands done."));

Do the users even need to be told that, I wonder?

> +		else{

Style:	"else {"

> +			status_printf_ln(s, color,
> +				Q_("Last command done (%d command done):",
> +					"Last commands done (%d commands done):",
> +					have_done.nr),
> +				have_done.nr);
> +			begin =3D (have_done.nr > lines_to_show_nr) ? have_done.nr-lines_=
to_show_nr : 0;
> +			for (i =3D begin; i < have_done.nr; i++) {
> +				status_printf_ln(s, color, "   %s", have_done.items[i].string);
> +			}

Hmm, perhaps fold lines like this (and you do not need "begin")?

			for (i =3D (lines_to_show_nr < have_done.nr)
                             ? have_done.nr - lines_to_show_nr : 0;
                             i < have_done.nr;
                             i++)
				status_printf_ln(...);

> +			if (have_done.nr > lines_to_show_nr && s->hints)
> +			   status_printf_ln(s, color,
> +				_("  (see more in file %s)"), git_path("rebase-merge/done"));

That's a nice touch ;-)

> +		}
> +		if (yet_to_do.nr =3D=3D 0)
> +			status_printf_ln(s, color,
> +					 _("No commands remaining."));

This I can see why we may want to say it.

> +		else{
> +
> +			status_printf_ln(s, color,
> +				Q_("Next command to do (%d remaining command):",
> +					"Next commands to do (%d remaining commands):",
> +					yet_to_do.nr),
> +				yet_to_do.nr);
> +			for (i =3D 0; i < lines_to_show_nr && i < yet_to_do.nr; i++) {
> +				status_printf_ln(s, color, "   %s", yet_to_do.items[i].string);
> +			}
> +			if (s->hints)
> +			   status_printf_ln(s, color,
> +				_("  (use \"git rebase --edit-todo\" to view and edit)"));
> +		}

Make sure you do not leak memory used by two string lists here...

> +	}
> +}
> +
>  static void show_rebase_in_progress(struct wt_status *s,
>  				struct wt_status_state *state,
>  				const char *color)
>  {
>  	struct stat st;
> =20
> +	show_rebase_information(s, state, color);
>  	if (has_unmerged(s) || state->rebase_in_progress || !stat(git_path(=
"MERGE_MSG"), &st)) {
>  		if (state->branch)
>  			status_printf_ln(s, color,
