From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH v4 05/18] Parse the -L options
Date: Tue, 10 Aug 2010 23:40:39 +0800
Message-ID: <AANLkTi=pzsPpC=gM3UEBAaMq7PGJYafW8SKHunVzrOyP@mail.gmail.com>
References: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
	<1281024717-7855-6-git-send-email-struggleyb.nku@gmail.com>
	<7v39ur8r56.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, trast@student.ethz.ch, Jens.Lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 17:40:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiqwX-0005FQ-SC
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 17:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178Ab0HJPkl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 11:40:41 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57589 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932157Ab0HJPkk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Aug 2010 11:40:40 -0400
Received: by qwh6 with SMTP id 6so8331431qwh.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 08:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JIyK0PUET8fNx+I/evFHoW6v/8y/iAHXrMsYtmUxF+E=;
        b=Yl8XAF3vXjdFVnsmHxiEGTRKIhJVRgPzPf0MP8nlU9SfDWeni4PHVLIQVF0xMCAkAR
         fKmxLf+5ObLg0S2uwi/jhopBUBltt7yup84/vlak+Ssh3oJ2ldj8FRuOAG9+jvgCyXjM
         mfOuicMXiF951O6uqh/ezBsFI09zWyAxExBgM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PYSfswIcd+qytbz2PbRzHokTwtm4DkrGrXBYw2RYlasTjRupEBYalGS10GJENzzHJI
         1eAJMLtAuAzMgBDdP7NxQz73qhfQqWoLuuGbV4qANXzYjXPZxeesKCGgzv8FMBAYd2FY
         HHO83jLEBDfcWA/pYkHGy0RWOKa9TEVXYPLEQ=
Received: by 10.229.215.208 with SMTP id hf16mr8511635qcb.79.1281454839176; 
	Tue, 10 Aug 2010 08:40:39 -0700 (PDT)
Received: by 10.229.231.21 with HTTP; Tue, 10 Aug 2010 08:40:39 -0700 (PDT)
In-Reply-To: <7v39ur8r56.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153120>

Hi Junio,

On Sat, Aug 7, 2010 at 3:42 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Bo Yang <struggleyb.nku@gmail.com> writes:
>
>> =A0static void cmd_log_init(int argc, const char **argv, const char =
*prefix,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct rev_info *rev,=
 struct setup_revision_opt *opt)
>> =A0{
>> =A0 =A0 =A0 int i;
>> =A0 =A0 =A0 int decoration_given =3D 0;
>> =A0 =A0 =A0 struct userformat_want w;
>> + =A0 =A0 const char *path =3D NULL, *pathspec =3D NULL;
>> + =A0 =A0 static struct diff_line_range *range =3D NULL, *r =3D NULL=
;
>> + =A0 =A0 static struct parse_opt_ctx_t ctx;
>> + =A0 =A0 static struct line_opt_callback_data line_cb =3D {&range, =
&ctx, NULL};
>
> Do these have to be static? =A0cmd_log_init() may be near the top of =
the
> call chain and has less reason to be reentrant, but it feels somewhat
> wrong if we are placing something that should live on stack in BSS.
>
>> + =A0 =A0 static const struct option options[] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 OPT_CALLBACK('L', NULL, &line_cb, "n,m", "=
Process only line range n,m, counting from 1", log_line_range_callback)=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 OPT_END()
>> + =A0 =A0 };
>> + ...
>> + =A0 =A0 parse_options_start(&ctx, argc, argv, prefix, PARSE_OPT_KE=
EP_DASHDASH |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARSE_OPT_KEEP_ARGV0 | PAR=
SE_OPT_STOP_AT_NON_OPTION);
>> + =A0 =A0 for (;;) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 switch (parse_options_step(&ctx, options, =
log_opt_usage)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 case PARSE_OPT_HELP:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit(129);
>> + =A0 =A0 =A0 =A0 =A0 =A0 case PARSE_OPT_DONE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto parse_done;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case PARSE_OPT_NON_OPTION:
>> + ... do the extra path thing ...
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pathspec =3D prefix_path(p=
refix, prefix ? strlen(prefix) : 0, path);
>
> Please do not call it "pathspec", as this is a specific path in a com=
mit.
> "pathspec" is a pattern to be matched to zero or more paths.
>
>> ...
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 parse_options_next(&ctx, 1=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case PARSE_OPT_UNKNOWN:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 parse_options_next(&ctx, 1=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 parse_revision_opt(rev, &ctx, options, log=
_opt_usage);
>> + =A0 =A0 }
>
> Hmm, so the strategy is that you first run the command line through a=
 pass
> of parse-options that is aware only of "-L" syntax, eat whatever it
> recognizes, and give remainder to the setup_revisions().
>
> While I agree with that strategy in general, I think this implementat=
ion
> is ugly. =A0It may be even wrong. =A0For example, can a user specify =
a path
> that begins with a dash with this parser?
>
> My gut feeling is that the capturing of the (optional) second argumen=
t
> given to -L is better done inside your callback.
>
> Now, the current callback interface does not give you access to ctx s=
o you
> may need to invent a new type of "more powerful callback API" that gi=
ves
> you access to the ctx as well, but if you did so, you should be able =
to do
> something like:
>
> =A0 =A0static int log_line_range_callback(...)
> =A0 =A0{
> =A0 =A0 =A0 =A0arg =3D parse_options_current(ctx);
> =A0 =A0 =A0 =A0... make sure it is a line range, e.g. "10,20"
> =A0 =A0 =A0 =A0parse_options_next(ctx); /* consume it */
> =A0 =A0 =A0 =A0path =3D parse_options_current(ctx); /* peek the secon=
d position */
> =A0 =A0 =A0 =A0if (does it look like a path?) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0... associate path with the range in a=
rg
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0parse_options_next(ctx); /* consume it=
 */
> =A0 =A0 =A0 =A0} else if (have we already got another range earlier?)=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0... use the previous path with the ran=
ge in arg
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("-L range not followed by path");
> =A0 =A0 =A0 =A0}
> =A0 =A0}
>
> no? =A0In the above illustration, I am assuming that the "more powerf=
ul" one
> allows the callback to control even parsing of the first argument,
> i.e. parse-options does not call get_arg() before calling you back.
>
> And "does it look like a path?" logic could say something like "If it=
 is
> in the index, it is a path, even if it begins with a dash", or "If it=
 is
> prefixed with ./, then it is always a path but we strip that dot-slas=
h
> out", and somesuch, to make the heuristic of "do we have the optional
> second parameter?" better than "we do not allow a path that begins wi=
th a
> dash". =A0After all, the callback for -L knows better than the generi=
c
> "parse-options" infrastructure what to expect for the optional argume=
nt at
> the second position.
>
> And if you do that, I suspect that you also can lose the "clear up th=
e
> last range" hack after the loop is done, no?

Yes, I think so. And if I change the logic to what you suggest, it
will also make the later 'move/copy detect' related argument parsing
easy. Because in move/copy detect, I should remove the 'remain path'
before feed it to setup_revisions. So, I hope I can make this change
along with the 'move/copy detect' change together, I hope this is
acceptable. :)

--=20
Regards!
Bo
----------------------------
My blog: http://blog.morebits.org
Why Git: http://www.whygitisbetterthanx.com/
