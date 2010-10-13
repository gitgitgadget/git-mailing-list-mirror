From: Pat Notz <patnotz@gmail.com>
Subject: Re: [PATCHv5 4/8] pretty.c: teach format_commit_message() to reencode
 the output
Date: Wed, 13 Oct 2010 16:44:14 -0600
Message-ID: <AANLkTi=+eBn86WBmcnASyhfDot1_5Cqkzvcn-Y_-cvrX@mail.gmail.com>
References: <1286478657-61581-1-git-send-email-patnotz@gmail.com>
 <1286478657-61581-5-git-send-email-patnotz@gmail.com> <7vd3rdiwjh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 00:44:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6A3w-0003Kw-Ft
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 00:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469Ab0JMWoh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Oct 2010 18:44:37 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48847 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512Ab0JMWog convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Oct 2010 18:44:36 -0400
Received: by fxm4 with SMTP id 4so2048903fxm.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 15:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=LKwFpgQCLxDp2gNRRx6z9Eo7JvYrEkTZAlk3MYCDyBI=;
        b=Q+9vNMDZFwbC3P5sn+cZd85kh/8T7ERjiEq1+eOQBIx8qwAzf/tc4x0LihknsjGSLg
         YYBIS7IxanQZtEjWV6OJyTzt6oHICabjjWVzu/MJdu5g04fA9exS0kCjdteIsmKCPvy3
         6cFm7wgbZ8TQBPFb/q+l+F10QZD3O4onH54l0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=cR1mB5M2erdcyUGUQJabIlM2ddVWKwp7NOjAfZmMSxC40bHNbn899sjAnwVq85GVDe
         fTzf9RZBfgqdNTcCa/+zHjwsCCkOCCAt9hIW/4G2bVveZKgyF6GAsbwjrsjKXIij+3TX
         fFa8keA9UXUayAU7aJlbS65j4+X/czyWO8dXg=
Received: by 10.239.140.5 with SMTP id v5mr592829hbv.120.1287009874154; Wed,
 13 Oct 2010 15:44:34 -0700 (PDT)
Received: by 10.239.185.65 with HTTP; Wed, 13 Oct 2010 15:44:14 -0700 (PDT)
In-Reply-To: <7vd3rdiwjh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158997>

On Wed, Oct 13, 2010 at 3:59 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> "Pat Notz" <patnotz@gmail.com> writes:
>
>> diff --git a/pretty.c b/pretty.c
>> index a607fd6..e5ce7fb 100644
>> --- a/pretty.c
>> +++ b/pretty.c
>> @@ -1009,16 +1009,47 @@ void userformat_find_requirements(const char=
 *fmt, struct userformat_want *w)
>>
>> =A0void format_commit_message(const struct commit *commit,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *forma=
t, struct strbuf *sb,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct pretty=
_print_context *pretty_ctx)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct pretty=
_print_context *pretty_ctx,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *output_=
encoding)
>> =A0{
>> =A0 =A0 =A0 struct format_commit_context context;
>> + =A0 =A0 static char utf8[] =3D "UTF-8";
>> + =A0 =A0 char *enc;
>> + =A0 =A0 char *buffer;
>> + =A0 =A0 char *enc_buffer;
>> + =A0 =A0 struct strbuf scratch_sb =3D STRBUF_INIT;
>> + =A0 =A0 struct strbuf *sb_ptr;
>> +
>> + =A0 =A0 enc =3D get_header(commit, "encoding");
>> + =A0 =A0 enc =3D enc ? enc : utf8;
>> + =A0 =A0 if(output_encoding && strcmp(enc,output_encoding)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 sb_ptr =3D &scratch_sb;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 sb_ptr =3D sb;
>> + =A0 =A0 }
>
> Style...
>
>> =A0 =A0 =A0 memset(&context, 0, sizeof(context));
>> =A0 =A0 =A0 context.commit =3D commit;
>> =A0 =A0 =A0 context.pretty_ctx =3D pretty_ctx;
>> =A0 =A0 =A0 context.wrap_start =3D sb->len;
>> - =A0 =A0 strbuf_expand(sb, format, format_commit_item, &context);
>> - =A0 =A0 rewrap_message_tail(sb, &context, 0, 0, 0);
>> + =A0 =A0 strbuf_expand(sb_ptr, format, format_commit_item, &context=
);
>> + =A0 =A0 rewrap_message_tail(sb_ptr, &context, 0, 0, 0);
>> +
>> + =A0 =A0 if(sb_ptr !=3D sb) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* if re-encoding fails, take the content =
byte-for-byte */
>> + =A0 =A0 =A0 =A0 =A0 =A0 buffer =3D strbuf_detach(sb_ptr, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 enc_buffer =3D reencode_string(buffer, out=
put_encoding, enc);
>> + =A0 =A0 =A0 =A0 =A0 =A0 enc_buffer =3D enc_buffer ? enc_buffer : b=
uffer;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 strbuf_addstr(sb,enc_buffer);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if(enc_buffer !=3D buffer)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free(enc_buffer);
>> + =A0 =A0 =A0 =A0 =A0 =A0 free(buffer);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if(enc !=3D utf8)
>> + =A0 =A0 =A0 =A0 =A0 =A0 free(enc);
>> =A0}
>
> You are expanding and wrapping commit->buf before re-encoding, but I =
am
> not sure it is the right thing to do. =A0Wouldn't it become much simp=
ler and
> more consistent if you re-encode first and then give the result to la=
ter
> expansion and wrapping process? =A0format_commit_one() would need to =
take
> "msg" not from c->commit->buffer but from a new field to hold reencod=
ed
> result you will add in your patch to the structure, if you do so, of
> course.
>
> Besides, I am a bit lost as to what this patch has to do with the sta=
ted
> goal of the series, "Add commit message options for rebase --autosqua=
sh".

Thank you for the reviews; I'll digest your comments shortly. In
response to your final comment, this patch was in response to your
earlier suggestion[1] to teach format_commit_message() to deal with
potentially different encodings.  I went for your option #3 there but
perhaps it's overkill.  I still think that's the right thing to do
despite my implementation.  Otherwise, this routine is just adding
bits to the buffer without regard for consistent encoding.  My goal
was to introduce this separately from any new features.

Again, thanks for all your comments -- I'll try to improve the series.

[1] http://thread.gmane.org/gmane.comp.version-control.git/156883/focus=
=3D156891
