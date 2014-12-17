From: Peter Wu <peter@lekensteyn.nl>
Subject: Re: [PATCH v3] remote: add --fetch and --both options to set-url
Date: Wed, 17 Dec 2014 15:20:58 +0100
Message-ID: <5257945.aZPNBJ6Uhr@al>
References: <1416916106-19892-1-git-send-email-peter@lekensteyn.nl> <54915607.9020304@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Torsten =?ISO-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Dec 17 15:21:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1FTP-0002v3-Oj
	for gcvg-git-2@plane.gmane.org; Wed, 17 Dec 2014 15:21:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbaLQOVD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Dec 2014 09:21:03 -0500
Received: from lekensteyn.nl ([178.21.112.251]:55062 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750995AbaLQOVB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Dec 2014 09:21:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2014-q3;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From; bh=4O2/LucK9WahGiL8p9ishwGAWuO3/aVD400PLqblbho=;
	b=Xwd+vTt92oAY0NjwJuUOXz2goiRCaaNtDW/6h5w+EswBDLHGsExi1jML/owMOGu+fC6E+LNcUHZff282iHixkEi0GRAGmNnmlhM7hea+uRia0Y3Ah/rxZq+euCC4Kj9Va7Mqt9JHFcLTNcU4rwHPliQ6+U+Ebv6nB/cT/ksrBY8hLXsdDG6vIUOI7KXr9A3d1Lo6N7v/52vKEdrjoucjES4bT2l1gWojPxmlofQOB7yCLZZA0vbUNj4HOD5oBlxUkkakz7Bejsxs8iNSR5Y3wL7Qpp+G6RmJrEFKSD1aNrGGdwvqP/CTkazBJd2sveQ7kdcOqgb+MnyKgzOlfsEdCg==;
Received: by lekensteyn.nl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <peter@lekensteyn.nl>)
	id 1Y1FTH-0005zT-Uk; Wed, 17 Dec 2014 15:21:00 +0100
User-Agent: KMail/4.14.3 (Linux/3.17.0-rc4-custom-00168-g7ec62d4; KDE/4.14.3; x86_64; ; )
In-Reply-To: <54915607.9020304@web.de>
X-Spam-Score: 0.0 (/)
X-Spam-Status: No, hits=0.0 required=5.0 tests=NO_RELAYS=-0.001,URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261484>

On Wednesday 17 December 2014 11:08:07 Torsten B=F6gershausen wrote:
> On 11/25/2014 12:48 PM, Peter Wu wrote:
> > git remote set-url knew about the '--push' option to update just th=
e
> > pushurl, but it does not have a similar option for "update fetch UR=
L and
> > leave whatever was in place for the push URL".
> >
> > This patch adds support for a '--fetch' option which implements tha=
t use
> > case in a backwards compatible way: if no --both, --push or --fetch
> > options are given, then the push URL is modified too if it was not =
set
> > before. This is the case since the push URL is implicitly based on =
the
> > fetch URL.
> >
> > A '--both' option is added to make the command independent of previ=
ous
> > pushurl settings. For the --add and --delete set operations, it wil=
l
> > always set the push and/ or the fetch URLs. For the primary mode of
> > operation (without --add or --delete), it will drop pushurl as the
> > implicit push URL is the (fetch) URL.
> >
> > The documentation has also been updated and a missing '--push' opti=
on
> > is added to the 'git remote -h' command.
> >
> > Tests are also added to verify the documented behavior.
> >
> > Signed-off-by: Peter Wu <peter@lekensteyn.nl>
> > ---
> >
> >   v2: fixed test case
> >   v3: added --both option, changed --fetch --push behavior, added m=
ore tests for
> >       --add/--delete cases, refactored to reduce duplication (not s=
pecial-casing
> >       add_mode without oldurl, just skip initially setting oldurl).
> >
> > Translators note: the help text gained more translatable strings an=
d some
> > strings got additional options.
> > ---
> >   Documentation/git-remote.txt |  17 ++++--
> >   builtin/remote.c             | 140 +++++++++++++++++++++++++++---=
-------------
> >   t/t5505-remote.sh            | 125 ++++++++++++++++++++++++++++++=
++++++++
> >   3 files changed, 228 insertions(+), 54 deletions(-)
> >
> > diff --git a/Documentation/git-remote.txt b/Documentation/git-remot=
e.txt
> > index cb103c8..bdd0305 100644
> > --- a/Documentation/git-remote.txt
> > +++ b/Documentation/git-remote.txt
> > @@ -15,9 +15,9 @@ SYNOPSIS
> >   'git remote remove' <name>
> >   'git remote set-head' <name> (-a | --auto | -d | --delete | <bran=
ch>)
> >   'git remote set-branches' [--add] <name> <branch>...
> > -'git remote set-url' [--push] <name> <newurl> [<oldurl>]
> > -'git remote set-url --add' [--push] <name> <newurl>
> > -'git remote set-url --delete' [--push] <name> <url>
> > +'git remote set-url' [--both | --fetch | --push] <name> <newurl> [=
<oldurl>]
> > +'git remote set-url' [--both | --fetch | --push] '--add' <name> <n=
ewurl>
> > +'git remote set-url' [--both | --fetch | --push] '--delete' <name>=
 <url>
> >   'git remote' [-v | --verbose] 'show' [-n] <name>...
> >   'git remote prune' [-n | --dry-run] <name>...
> >   'git remote' [-v | --verbose] 'update' [-p | --prune] [(<group> |=
 <remote>)...]
> > @@ -134,7 +134,16 @@ Changes URL remote points to. Sets first URL r=
emote points to matching
> >   regex <oldurl> (first URL if no <oldurl> is given) to <newurl>. I=
f
> >   <oldurl> doesn't match any URL, error occurs and nothing is chang=
ed.
> >   +
> > -With '--push', push URLs are manipulated instead of fetch URLs.
> > +With '--both', both the fetch and push URLs are manipulated.
> > ++
> > +With '--fetch', only fetch URLs are manipulated.
> > ++
> > +With '--push', only push URLs are manipulated.
> > ++
> > +If none of the '--both', '--fetch' or --push' options are given, t=
hen
> > +'--both' applies only if no push URL was set before. Otherwise '--=
fetch'
> > +is assumed for historical reasons. This default may change in the
> > +future to '--both' to avoid surprises depending on the configurati=
on.
> >   +
> >   With '--add', instead of changing some URL, new URL is added.
> >   +
> > diff --git a/builtin/remote.c b/builtin/remote.c
> > index 7f28f92..a250b23 100644
> > --- a/builtin/remote.c
> > +++ b/builtin/remote.c
> > @@ -18,9 +18,9 @@ static const char * const builtin_remote_usage[] =
=3D {
> >   	N_("git remote prune [-n | --dry-run] <name>"),
> >   	N_("git remote [-v | --verbose] update [-p | --prune] [(<group> =
| <remote>)...]"),
> >   	N_("git remote set-branches [--add] <name> <branch>..."),
> > -	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]"),
> > -	N_("git remote set-url --add <name> <newurl>"),
> > -	N_("git remote set-url --delete <name> <url>"),
> > +	N_("git remote set-url [--both | --fetch | --push] <name> <newurl=
> [<oldurl>]"),
> > +	N_("git remote set-url [--both | --fetch | --push] --add <name> <=
newurl>"),
> > +	N_("git remote set-url [--both | --fetch | --push] --delete <name=
> <url>"),
> >   	NULL
> >   };
> >  =20
> > @@ -66,9 +66,9 @@ static const char * const builtin_remote_update_u=
sage[] =3D {
> >   };
> >  =20
> >   static const char * const builtin_remote_seturl_usage[] =3D {
> > -	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]"),
> > -	N_("git remote set-url --add <name> <newurl>"),
> > -	N_("git remote set-url --delete <name> <url>"),
> > +	N_("git remote set-url [--both | --fetch | --push] <name> <newurl=
> [<oldurl>]"),
> > +	N_("git remote set-url [--both | --fetch | --push] --add <name> <=
newurl>"),
> > +	N_("git remote set-url [--both | --fetch | --push] --delete <name=
> <url>"),
> >   	NULL
> >   };
> >  =20
> > @@ -1503,21 +1503,35 @@ static int set_branches(int argc, const cha=
r **argv)
> >   	return set_remote_branches(argv[0], argv + 1, add_mode);
> >   }
> >  =20
> > +#define MODIFY_TYPE_FETCH       (1 << 0)
> > +#define MODIFY_TYPE_PUSH        (1 << 1)
> > +#define MODIFY_TYPE_BOTH        (MODIFY_TYPE_FETCH | MODIFY_TYPE_P=
USH)
> > +#define MODIFY_TYPE_HISTORIC    (MODIFY_TYPE_FETCH | (1 << 2))
> > +
> >   static int set_url(int argc, const char **argv)
> >   {
> > -	int i, push_mode =3D 0, add_mode =3D 0, delete_mode =3D 0;
> > +	int i, add_mode =3D 0, delete_mode =3D 0;
> > +	int modify_type =3D MODIFY_TYPE_HISTORIC;
> >   	int matches =3D 0, negative_matches =3D 0;
> >   	const char *remotename =3D NULL;
> >   	const char *newurl =3D NULL;
> >   	const char *oldurl =3D NULL;
> >   	struct remote *remote;
> >   	regex_t old_regex;
> > -	const char **urlset;
> > -	int urlset_nr;
> > -	struct strbuf name_buf =3D STRBUF_INIT;
> > +	struct strbuf name_buf_fetch =3D STRBUF_INIT;
> > +	struct strbuf name_buf_push =3D STRBUF_INIT;
> >   	struct option options[] =3D {
> > -		OPT_BOOL('\0', "push", &push_mode,
> > -			 N_("manipulate push URLs")),
> > +		OPT_GROUP(""),
> > +		OPT_SET_INT('\0', "fetch", &modify_type,
> > +			N_("manipulate just fetch URLs"),
> > +			MODIFY_TYPE_FETCH),
> > +		OPT_SET_INT('\0', "push", &modify_type,
> > +			N_("manipulate just push URLs"),
> > +			MODIFY_TYPE_PUSH),
> > +		OPT_SET_INT('\0', "both", &modify_type,
> > +			N_("manipulate both push and fetch URLs"),
> > +			MODIFY_TYPE_BOTH),
> > +		OPT_GROUP(""),
> >   		OPT_BOOL('\0', "add", &add_mode,
> >   			 N_("add URL")),
> >   		OPT_BOOL('\0', "delete", &delete_mode,
> > @@ -1535,7 +1549,8 @@ static int set_url(int argc, const char **arg=
v)
> >  =20
> >   	remotename =3D argv[1];
> >   	newurl =3D argv[2];
> > -	if (argc > 3)
> > +	/* The old URL is only meaningful for the primary non-set operati=
on. */
> > +	if (argc > 3 && !add_mode && !delete_mode)
> >   		oldurl =3D argv[3];
> >  =20
> >   	if (delete_mode)
> > @@ -1545,47 +1560,72 @@ static int set_url(int argc, const char **a=
rgv)
> >   		die(_("No such remote '%s'"), remotename);
> >   	remote =3D remote_get(remotename);
> >  =20
> > -	if (push_mode) {
> > -		strbuf_addf(&name_buf, "remote.%s.pushurl", remotename);
> > -		urlset =3D remote->pushurl;
> > -		urlset_nr =3D remote->pushurl_nr;
> > -	} else {
> > -		strbuf_addf(&name_buf, "remote.%s.url", remotename);
> > -		urlset =3D remote->url;
> > -		urlset_nr =3D remote->url_nr;
> > +	strbuf_addf(&name_buf_fetch, "remote.%s.url", remotename);
> > +	strbuf_addf(&name_buf_push, "remote.%s.pushurl", remotename);
> > +
> > +	if (oldurl && !add_mode) {
> > +		/* Old URL specified, or deletion. Demand that one matches. */
> > +		if (regcomp(&old_regex, oldurl, REG_EXTENDED))
> > +			die(_("Invalid old URL pattern: %s"), oldurl);
> > +
> > +		if (modify_type & MODIFY_TYPE_FETCH)
> > +			for (i =3D 0; i < remote->url_nr; i++)
> > +				if (!regexec(&old_regex, remote->url[i], 0, NULL, 0))
> > +					matches++;
> > +				else
> > +					negative_matches++;
> > +		if (delete_mode && !negative_matches && modify_type & MODIFY_TYP=
E_FETCH)
> > +			die(_("Will not delete all non-push URLs"));
> > +		if (modify_type & MODIFY_TYPE_PUSH)
> > +			for (i =3D 0; i < remote->pushurl_nr; i++)
> > +				if (!regexec(&old_regex, remote->pushurl[i], 0, NULL, 0))
> > +					matches++;
> > +				else
> > +					negative_matches++;
> There are 2 warning  "dangling else", line 1570 and 1578
> I think we should use:
>=20
> 			for (i =3D 0; i < remote->pushurl_nr; i++) {
> 				if (!regexec(&old_regex, remote->pushurl[i], 0, NULL, 0))
> 					matches++;
> 				else
> 					negative_matches++;
> 			}
>=20

Good catch, strange enough I did not get any warnings from my compiler
or Clang's static analyzer. I have submitted a new patch which treats
the accumulated comments.
--=20
Kind regards,
Peter
https://lekensteyn.nl
