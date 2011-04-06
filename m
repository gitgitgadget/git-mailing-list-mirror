From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] config: support values longer than 1024 bytes
Date: Wed, 6 Apr 2011 18:16:50 +0200
Message-ID: <BANLkTikuzfZrv+N0Qm7utfYF6fsYQn7Zcg@mail.gmail.com>
References: <1302046203-4408-1-git-send-email-kusmabite@gmail.com>
 <20110406005223.GA10374@sigill.intra.peff.net> <BANLkTim0N0kM+OX5Tztz-Kh+eRRsNixX0A@mail.gmail.com>
 <20110406153509.GA1864@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jwa@urbancode.com, drew.northup@maine.edu
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 06 18:17:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7VPx-0006v7-Ds
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 18:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818Ab1DFQRM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2011 12:17:12 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60351 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab1DFQRL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Apr 2011 12:17:11 -0400
Received: by fxm17 with SMTP id 17so1105348fxm.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 09:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=NuzPSNJdh7v0TRuQe2J+jfNyiFlmMcsV8b20UAkyFMg=;
        b=lMHhfMPOD19V9bgRIZj/Mgccu/rRiEZtAFYeQNhTVEIw77MLuCitR4GJ53II3WVIuI
         bgTQK70YX969or2yjBUey9sio9AN9oo2k7GEae6ra0cSfCUouyoFwUGbILpFrCRrM27F
         01LT5XtsFzoaSatNtTXFS4/p+Zl6QuDUgYIEA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=ShntlHsxhJCoTBrhv882js5WafXcGr/dJbRWxBGtj09HIecaVDswFNHvZtQOlB52T6
         DTuU+0pUKH+sawn1IHo6t4E9qmwHiFlTNgnhMacaO/cgrKNbRUmXsxEUfKIaV48/Yw5A
         tQFj7F7BytfbjKw5gwELOuCly4Pq+RBfKXHT4=
Received: by 10.204.22.9 with SMTP id l9mr1065071bkb.66.1302106630186; Wed, 06
 Apr 2011 09:17:10 -0700 (PDT)
Received: by 10.204.172.130 with HTTP; Wed, 6 Apr 2011 09:16:50 -0700 (PDT)
In-Reply-To: <20110406153509.GA1864@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170988>

On Wed, Apr 6, 2011 at 5:35 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Apr 06, 2011 at 11:10:42AM +0200, Erik Faye-Lund wrote:
>
>> > But for the other, one of the invariants of strbuf is that the str=
ing is
>> > always NUL-terminated. So I would expect strbuf_init to properly
>> > NUL-terminate after growing based on the hint.
>>
>> I agree. An unterminated yet non-NULL return from strbuf_detach is
>> just dangerous behavior. Something like this should probably be
>> applied:
>>
>> ---8<---
>> diff --git a/strbuf.c b/strbuf.c
>> index 77444a9..538035a 100644
>> --- a/strbuf.c
>> +++ b/strbuf.c
>> @@ -24,14 +24,16 @@ int suffixcmp(const char *str, const char *suffi=
x)
>> =A0 * buf is non NULL and ->buf is NUL terminated even for a freshly
>> =A0 * initialized strbuf.
>> =A0 */
>> -char strbuf_slopbuf[1];
>> +char strbuf_slopbuf[1] =3D { '\0' };
>
> This hunk is redundant. slopbuf will already be initialized to 0.

Right, silly me. I somehow thought that implicit zero-initialization
only applied to static variables, but K&R tells me I was wrong. Thanks
for pointing it out :)

>
>> =A0void strbuf_init(struct strbuf *sb, size_t hint)
>> =A0{
>> =A0 =A0 =A0 sb->alloc =3D sb->len =3D 0;
>> =A0 =A0 =A0 sb->buf =3D strbuf_slopbuf;
>> - =A0 =A0 if (hint)
>> + =A0 =A0 if (hint) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_grow(sb, hint);
>> + =A0 =A0 =A0 =A0 =A0 =A0 sb->buf[0] =3D '\0';
>> + =A0 =A0 }
>> =A0}
>
> But this one is the right fix.
>

OK, I'll turn this into a two-patch series, then.

>> that. But this brings a new issue: leaving potentially huge blocks o=
f
>> memory (especially since this patch is about long lines) allocated
>> inside a function can be a bit nasty. But it's probably not a big de=
al
>
> Yeah. It's just one block, though, and in the normal case it is proba=
bly
> only about 80 characters. So it is more efficient than what's there n=
ow. :)
>
> Somebody could have some gigantic value, though, and yes, we'll grow =
to
> the biggest one and never free that memory. You could also have
> parse_value take a strbuf parameter to output into, and then free it
> after config reading is done.
>
>> In other words: I think you're right, it's a much better approach.
>> Less allocations, less penalty on the start-up time for every little
>> git-command.
>
> I doubt the efficiency increase is measurable. We end up xstrdup'ing
> quite a few of the values in the config callbacks anyway. I would do
> whatever seems most natural for reading/writing the code.
>

I think I'll just leave the single leak in. Since it would allocate
the buffer lazily, it would really only "waste" more memory than the
existing implementation when the old implementation would fail. So my
conscience is clear ;)

>> > I do wonder, though, if we could be reusing the unquote_c_style()
>> > function in quote.c. They are obviously similar, but I haven't che=
cked
>> > if there is more going on in the config code.
>>
>> Hmm, this is an interesting suggestion. It would be a part of a bigg=
er
>> change though: unquote_c_style requires it's input to be in memory,
>> while parse_value uses a function called get_next_char to feed the
>> parser. So we'd either have to read the entire file into memory, or
>> find some way to read the file line-by-line while handling \n-escapi=
ng
>> correctly.
>>
>> It also seems like there's differences in what kind of escaping and
>> normalization the two functions handle; unquote_c_style handles more
>> escaped character sequences, while parse_value normalize all
>> non-escaped space-characters ('\t' et. al) into SP. This might not b=
e
>> such a big problem in reality.
>
> This was just a random thought that I had, and I didn't investigate i=
t
> how hard it would be. =A0If it turns out to be too much trouble, just
> forget it.
>

Yeah. I think I'll skip it, since it isn't dead obvious.

Thanks for the input, I'll cook up a new version soon.
