From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [BUG] format-patch does not wrap From-field after author name
Date: Thu, 14 Apr 2011 23:19:09 +0200
Message-ID: <BANLkTin+K46_RSDsYWHso3v7Gpe_k+0m8Q@mail.gmail.com>
References: <BANLkTimruwojkq_HNMZeCDBV6K8_aFc_XQ@mail.gmail.com>
 <7v39lkiwoj.fsf@alter.siamese.dyndns.org> <20110414175034.GA23342@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 23:19:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QATx1-0005ke-7c
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 23:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340Ab1DNVTd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Apr 2011 17:19:33 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58825 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106Ab1DNVT3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2011 17:19:29 -0400
Received: by pzk9 with SMTP id 9so643760pzk.19
        for <git@vger.kernel.org>; Thu, 14 Apr 2011 14:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=i4OR09+GEoo62y2bSrRO8s6y4YExsNKBfGcoNInOv0Q=;
        b=sZCi3PWE8X9CwzEeL+oB7EY7KqHaO4q0vy4VJNPfSLhXGOpM+nfE0CECjA1MdG9mx1
         3Uj28KeoJKFKgTTGwFjEZg/XzeqeNY4xgnh1WaL6wAn7NCDSZzTXiXQ7igDQ5ZsUIAEq
         NDthmi/X6tO1TkB91fhHN7BSjTIxn2NzMGqNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=ExK+osPBLgKButSQhKwrwc14qriNLRE7tgeM0ptIQ9ibfn/eZvl5JrZ9db9YEGkuhZ
         qvRur3rjTg24+ZGKsR0wcYxVRXKFjGEdptqYaG85BA72Uge4Nr03lbOAoOD5MzEnY8rY
         3a9bkvjSo8NxexBUMBmdWVMxNF4S8VcqXRj1g=
Received: by 10.68.29.69 with SMTP id i5mr851049pbh.62.1302815969114; Thu, 14
 Apr 2011 14:19:29 -0700 (PDT)
Received: by 10.68.56.105 with HTTP; Thu, 14 Apr 2011 14:19:09 -0700 (PDT)
In-Reply-To: <20110414175034.GA23342@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171558>

On Thu, Apr 14, 2011 at 7:50 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 14, 2011 at 10:12:44AM -0700, Junio C Hamano wrote:
>
>> Erik Faye-Lund <kusmabite@gmail.com> writes:
>>
>> > With certain combinations of author name and email lengths, git
>> > format-patch does not correctly wrap the From line to be below 78
>> > characters, violating rfc2047.
>>
>> Didn't we have this fixed quite a while ago with the series that end=
s at
>> c22e7de (format-patch: rfc2047-encode newlines in headers, 2011-02-2=
3)?
>>
>> What version of git do you use?

I believe it was straight from todays master, but I'm not still at that=
 machine.

> No, that doesn't fix it. The problem is a short name and a long email
> address. We rfc2047-encode and wrap the name, but then tack the email
> onto the end without caring about line length.
>
> According to rfc2047, we are specifically forbidden to use an
> encoded-word in an addr-spec. So it would not make sense to assemble =
the
> header first and then feed the whole thing to add_rfc2047.
>
> Fortunately, this is an easy thing to wrap, since we can't actually
> break the addr-spec across lines. We can just check if the line is lo=
ng,
> and if so, wrap the whole address to the next line, which is the best=
 we
> can do (and presumably nobody has an address portion over 78
> characters). That patch looks something like:
>
> diff --git a/pretty.c b/pretty.c
> index e1d8a8f..63a7c2f 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -287,6 +287,7 @@ void pp_user_info(const char *what, enum cmit_fmt=
 fmt, struct strbuf *sb,
> =A0 =A0 =A0 =A0if (fmt =3D=3D CMIT_FMT_EMAIL) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0char *name_tail =3D strchr(line, '<');
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int display_name_length;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int final_line;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!name_tail)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while (line < name_tail && isspace(nam=
e_tail[-1]))
> @@ -294,6 +295,11 @@ void pp_user_info(const char *what, enum cmit_fm=
t fmt, struct strbuf *sb,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0display_name_length =3D name_tail - li=
ne;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strbuf_addstr(sb, "From: ");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0add_rfc2047(sb, line, display_name_len=
gth, encoding);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (final_line =3D 0; final_line < sb-=
>len; final_line++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sb->buf[sb->len - f=
inal_line - 1] =3D=3D '\n')
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (namelen - display_name_length + fin=
al_line > 78)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_addch(sb, '\n');
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strbuf_add(sb, name_tail, namelen - di=
splay_name_length);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strbuf_addch(sb, '\n');
> =A0 =A0 =A0 =A0} else {
>

Yes, this is the reasonable fix. Basically copying the wrapping logic
from add_rfc2047...

> Note that it relies on the commit header having a space before the "<=
",
> which forms the continuation whitespace for the header. This is proba=
bly
> reasonable, but we could double-check if we want to handle malformed
> commit headers better.

I think that's a reasonable assumption; this field comes straight from
the commit. It should already be well-formed, no?

> Or we could just ignore it. AFAICS, this doesn't actually violate
> rfc2047, nor rfc5322. The 78-character limit is simply a SHOULD, and
> we have up to 998 for MUST. For a single-address header[1], this seem=
s
> kind of unlikely to me.

True. But since the fix is as simple as it is, perhaps it's worth it
just for the clean conscience?

Don't get me wrong, this was just something I stumbled over. I don't
have any real-world case where it breaks.

> [1] For multi-address headers like "format-patch --cc=3Dfoo --cc=3Dba=
r", it
> looks like we already break them across lines.

Yes, but this is even worse: these fields don't get encoded at all!

> No idea if "send-email"
> is sensible in this area or not.

=2E..but luckily send-email is sensible. The first thing it does is to
unfold each header line. Addresses are rfc2047-decoded and recoded (if
needed, utf-8 is assumed as the encoding if none is found), and To/Cc
headers are laid out one address per line.

This still produce invalid To/Cc headers if send-email isn't used, thou=
gh.
