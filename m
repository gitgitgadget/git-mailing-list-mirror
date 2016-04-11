From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [PATCH v2 4/7] i18n: builtin/pull.c: mark strings for translation
Date: Mon, 11 Apr 2016 10:43:25 +0000
Message-ID: <570B7FCD.5050809@sapo.pt>
References: <1460234324-13506-1-git-send-email-vascomalmeida@sapo.pt>
 <1460234324-13506-4-git-send-email-vascomalmeida@sapo.pt>
 <xmqqinzptkaw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 12:43:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apZJt-0007vL-U0
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 12:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbcDKKnp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Apr 2016 06:43:45 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:47340 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750881AbcDKKno (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 06:43:44 -0400
Received: (qmail 30051 invoked from network); 11 Apr 2016 10:43:41 -0000
Received: (qmail 4027 invoked from network); 11 Apr 2016 10:43:41 -0000
Received: from unknown (HELO [192.168.64.10]) (vascomalmeida@sapo.pt@[147.203.126.221])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPSA
          for <worldhello.net@gmail.com>; 11 Apr 2016 10:43:35 -0000
X-PTMail-RemoteIP: 147.203.126.221
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <xmqqinzptkaw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291209>

=C0s 18:01 de 10-04-2016, Junio C Hamano escreveu:
> Vasco Almeida <vascomalmeida@sapo.pt> writes:
>=20
>> Some translations might also translate "<remote>" and "<branch>".
>=20
> This offers an interesting observation that I didn't think of while
> reviewing the first round of this series.
>=20
> Do translations want to translate "remote" and "branch" without the
> "<bra" and "ket>"?  Or is it better to allow translations to adjust
> the "quote around a placeholder" in a locale dependent way?
>=20
I think they want to translate without brackets.
=46rom what I can see, translator are using the same quoting.
The use of this kind of placeholders should be a new thing to languages=
,
and might be limited to some backgrounds or situations. So, translator
might adopt the English way, since there are no better or equivalent wa=
y
in their languages. Or I may be be assuming to much?

>> @@ -458,13 +458,13 @@ static void NORETURN die_no_merge_candidates(c=
onst char *repo, const char **refs
>>  			fprintf_ln(stderr, _("Please specify which branch you want to me=
rge with."));
>>  		fprintf_ln(stderr, _("See git-pull(1) for details."));
>>  		fprintf(stderr, "\n");
>> -		fprintf_ln(stderr, "    git pull <remote> <branch>");
>> +		fprintf_ln(stderr, "    git pull <%s> <%s>", _("remote"), _("bran=
ch"));
>=20
> I know this hunk follows I suggested, i.e. "quotes around a
> placeholder is universal and locale independent".  However, ...
>=20
>>  		fprintf(stderr, "\n");
>>  	} else if (!curr_branch->merge_nr) {
>>  		const char *remote_name =3D NULL;
>> =20
>>  		if (for_each_remote(get_only_remote, &remote_name) || !remote_nam=
e)
>> -			remote_name =3D "<remote>";
>> +			remote_name =3D _("<remote>");
>> =20
> ... this does not.  It allows to translate the "quote around a
> placeholder".  And where this phony "remote_name" string is used,
> there is also this reference to <branch>:
>=20
>     fprintf_ln(stderr, _("If you wish to set tracking information for=
 ..."
>                     "\n"
>                     "    git branch --set-upstream-to=3D%s/<branch> %=
s\n"),
>                     remote_name, curr_branch->name);
>=20
> which also does.
>=20
> Perhaps the first hunk at around ll.458 would want to do
>=20
>> +	fprintf_ln(stderr, "    git pull %s %s", _("<remote>"), _("<branch=
>"));
>=20
> to be consistent and more flexible for the translator's needs?  The
> quoting convention may be locale dependent after all.
>
If we think placeholders quoting is important for localization, we coul=
d
mark them for translation in usage_argh() function in parse-options.c:

s =3D literal ? " %s" : _(" <%s>");

and do the same for other cases of <%s> in that function. Plus, add a
comment for translator, perhaps.

Otherwise, something like the following just to be consistent:

diff --git a/builtin/pull.c b/builtin/pull.c
index 617893c..317c3ce 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -463,8 +463,7 @@ static void NORETURN die_no_merge_candidates(const =
char *repo, const char **refs
        } else if (!curr_branch->merge_nr) {
                const char *remote_name =3D NULL;
=20
-               if (for_each_remote(get_only_remote, &remote_name) || !=
remote_name)
-                       remote_name =3D _("<remote>");
+               for_each_remote(get_only_remote, &remote_name);
=20
                fprintf_ln(stderr, _("There is no tracking information =
for the current branch."));
                if (opt_rebase)
@@ -477,8 +476,11 @@ static void NORETURN die_no_merge_candidates(const=
 char *repo, const char **refs
                fprintf(stderr, "\n");
                fprintf_ln(stderr, _("If you wish to set tracking infor=
mation for this branch you can do so with:"));
                fprintf(stderr, "\n");
-               fprintf_ln(stderr, "    git branch --set-upstream-to=3D=
%s/<%s> %s\n",
-                               remote_name, _("branch"), curr_branch->=
name);
+               fprintf_ln(stderr, remote_name
+                                  ? "    git branch --set-upstream-to=3D=
%s/<%s> %s\n"
+                                  : "    git branch --set-upstream-to=3D=
<%s>/<%s> %s\n",
+                               remote_name ? remote_name : _("remote")=
,
+                               _("branch"), curr_branch->name);
        } else
                fprintf_ln(stderr, _("Your configuration specifies to m=
erge with the ref '%s'\n"
                        "from the remote, but no such ref was fetched."=
),

I think there is no need to internationalize the bracket. If we did so,
they would end up just in the way without adding much value for
translators.
What do you think?
