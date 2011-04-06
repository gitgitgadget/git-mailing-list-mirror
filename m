From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] config: support values longer than 1024 bytes
Date: Wed, 6 Apr 2011 11:10:42 +0200
Message-ID: <BANLkTim0N0kM+OX5Tztz-Kh+eRRsNixX0A@mail.gmail.com>
References: <1302046203-4408-1-git-send-email-kusmabite@gmail.com> <20110406005223.GA10374@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jwa@urbancode.com, drew.northup@maine.edu
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 06 11:11:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Olc-0002zH-Kw
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 11:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754430Ab1DFJLG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2011 05:11:06 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42330 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975Ab1DFJLE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Apr 2011 05:11:04 -0400
Received: by bwz15 with SMTP id 15so965667bwz.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 02:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=tRyyLt0itXF1tjHi0Bsd28uINykoELgIaGHzJFJOxFQ=;
        b=wuBgiegwSezeu3bwtE/IwCX0inriO+WafOQIOy6iMRBXkYfTkQRfvJ3r07bTOlqLPn
         RyopSqWRxuAsimGdWyxPXaOJUko8C1gVY5lGSnibLpETL8rEeo4TTCOgciDcK+BvoZzR
         sOf+CFX/rFYnVRjgSRaYAV3PLO0Xiq6/OIiiM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=etN5zetdAM9mK/1vmLYsYyWKd/LAM/7V2xPxe5fn1VNjFmHYl/2NvDPge09GGvjtXM
         qEl5O1Y841ps4uUmnnVCU9nIppJII91yHh07APuN6RwbMyS8A5qJUo5toclHkSZwSu5/
         xnssWbr275Yv1RJbVrbTlUjpRe+FrdOE2ULHI=
Received: by 10.204.84.137 with SMTP id j9mr573126bkl.120.1302081062664; Wed,
 06 Apr 2011 02:11:02 -0700 (PDT)
Received: by 10.204.172.130 with HTTP; Wed, 6 Apr 2011 02:10:42 -0700 (PDT)
In-Reply-To: <20110406005223.GA10374@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170956>

On Wed, Apr 6, 2011 at 2:52 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Apr 06, 2011 at 01:30:03AM +0200, Erik Faye-Lund wrote:
>
>> The rather awkward return statement with strdup("") is because
>> strbuf_detach returns NULL when there's nothing allocated. Even
>> worse, it returns an uninitialized string if the string has been
>> initialized with a non-zero 'hint'.
>
> That seems like two bugs in the strbuf code.
>
> I would expect strbuf_detach to _always_ return an allocated buffer,
> even if it is xstrdup(""). Though the code in strbuf_detach is explic=
it
> about returning NULL rather than slopbuf, so perhaps there is a case
> where it is useful.

Yeah, this is why I didn't just go for it. Looking through history, it
seems that the reason why it explicitly returns NULL when there's
nothing allocated is that it used to do so "by artifact" before
b315c5c ("strbuf change: be sure ->buf is never ever NULL."), and it
looks like the author didn't want to change the semantics. Fair
enough, changing this takes a lot of code-reading to verify that there
isn't any call-sites that depend on this behavior.

>
> But for the other, one of the invariants of strbuf is that the string=
 is
> always NUL-terminated. So I would expect strbuf_init to properly
> NUL-terminate after growing based on the hint.

I agree. An unterminated yet non-NULL return from strbuf_detach is
just dangerous behavior. Something like this should probably be
applied:

---8<---
diff --git a/strbuf.c b/strbuf.c
index 77444a9..538035a 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -24,14 +24,16 @@ int suffixcmp(const char *str, const char *suffix)
  * buf is non NULL and ->buf is NUL terminated even for a freshly
  * initialized strbuf.
  */
-char strbuf_slopbuf[1];
+char strbuf_slopbuf[1] =3D { '\0' };

 void strbuf_init(struct strbuf *sb, size_t hint)
 {
 	sb->alloc =3D sb->len =3D 0;
 	sb->buf =3D strbuf_slopbuf;
-	if (hint)
+	if (hint) {
 		strbuf_grow(sb, hint);
+		sb->buf[0] =3D '\0';
+	}
 }

 void strbuf_release(struct strbuf *sb)
---8<---

>
>> =A0static char *parse_value(void)
>> =A0{
>> - =A0 =A0 static char value[1024];
>> - =A0 =A0 int quote =3D 0, comment =3D 0, len =3D 0, space =3D 0;
>> + =A0 =A0 struct strbuf value =3D STRBUF_INIT;
>> + =A0 =A0 int quote =3D 0, comment =3D 0, space =3D 0;
>
> One thing you could about the strbuf_detach thing is to just use a
> single static strbuf instead of the static array, and just reset its
> length back to zero on each call. So:
>
> =A0static struct strbuf value =3D STRBUF_INIT;
> =A0...
> =A0strbuf_reset(&value);
>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 value[len] =3D 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return value;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return value.len ?
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_detach(&val=
ue, NULL) :
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strdup("");
>
> Then this just becomes:
>
> =A0return value.buf;
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_rel=
ease(&value);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return N=
ULL;
>
> And you can drop the release.
>
>> @@ -226,7 +226,9 @@ static int get_value(config_fn_t fn, void *data,=
 char *name, unsigned int len)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!value)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> =A0 =A0 =A0 }
>> - =A0 =A0 return fn(name, value, data);
>> + =A0 =A0 ret =3D fn(name, value, data);
>> + =A0 =A0 free(value);
>> + =A0 =A0 return ret;
>
> And drop this hunk, since callers no longer need to free.
>

Yeah, and this was what I tried first.

I dropped that approach because I misread the code of strbuf_setlen so
I thought it ended up freeing the buffer (which would have lost the
gain we get from making it static). This is wrong, it does not do
that. But this brings a new issue: leaving potentially huge blocks of
memory (especially since this patch is about long lines) allocated
inside a function can be a bit nasty. But it's probably not a big deal
here, the blocks are probably small enough to "leak" without worries,
unless you have a downright evil config file (which I suspect could
only happen due to disk-corruption, in which case you're going to have
much much bigger problems). And that problem can also be fixed by
giving the buffer file-local scope, and adding a cleanup-function that
gets called when config-parsing is finished. But it's probably not
even worth the hassle.

I guess it's my background from handheld/low-power device development
that makes me worry too much about problems like these :P

In other words: I think you're right, it's a much better approach.
Less allocations, less penalty on the start-up time for every little
git-command.

> I do wonder, though, if we could be reusing the unquote_c_style()
> function in quote.c. They are obviously similar, but I haven't checke=
d
> if there is more going on in the config code.

Hmm, this is an interesting suggestion. It would be a part of a bigger
change though: unquote_c_style requires it's input to be in memory,
while parse_value uses a function called get_next_char to feed the
parser. So we'd either have to read the entire file into memory, or
find some way to read the file line-by-line while handling \n-escaping
correctly.

It also seems like there's differences in what kind of escaping and
normalization the two functions handle; unquote_c_style handles more
escaped character sequences, while parse_value normalize all
non-escaped space-characters ('\t' et. al) into SP. This might not be
such a big problem in reality.
