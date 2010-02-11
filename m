From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 3/4] git-imap-send: Implement CRAM-MD5 auth method
Date: Thu, 11 Feb 2010 15:59:25 +0100
Message-ID: <40aa078e1002110659y9493052l3752c7e0afb6eb3c@mail.gmail.com>
References: <7vaavj8h1k.fsf@alter.siamese.dyndns.org>
	 <1265717345-2118-4-git-send-email-mitake@dcl.info.waseda.ac.jp>
	 <40aa078e1002090622vb65027xa53acff95557a183@mail.gmail.com>
	 <4B741A44.7060003@dcl.info.waseda.ac.jp>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org,
	Jeremy White <jwhite@codeweavers.com>,
	Robert Shearman <robertshearman@gmail.com>
To: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
X-From: git-owner@vger.kernel.org Thu Feb 11 15:59:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfaVy-00087O-D0
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 15:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756058Ab0BKO73 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2010 09:59:29 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:46795 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755837Ab0BKO72 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Feb 2010 09:59:28 -0500
Received: by ewy28 with SMTP id 28so1570760ewy.28
        for <git@vger.kernel.org>; Thu, 11 Feb 2010 06:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7fHiAr7bmS3KKUBqey6x2lmel5K/h199TqxSvbZKqLU=;
        b=I7WT2Oh+ima2AoKgwJjNmBIRyHUF7LrU6d0nHExra7rsiK0nMNPKLpfaAzUe0FG2st
         fsW6XBk3F4el+3iEIib6IiXBGCNNPv0AekBCCyqJ//MuD+/TplOsUZvn6sQQaCbkjCMX
         h+QqzsL5nCWDPgUQnBcjCrzwdfBbfIccMPvKs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=xGAI47Bh50eEonBNkd5OgafYaWi7+quu7C8PCY4BA0pOBmuwJBki/cgtO5+GWArJ3t
         Tfpipkr9Bgveql6u5hPfL/ZCqaC1NZZgYLA17EYfnQIKFJAfOPCzXfb8h1jJPodc4Zk5
         Zro52+LfzivCOCewR+/21R3+AYk4VsEn/YgvA=
Received: by 10.216.86.66 with SMTP id v44mr1075824wee.163.1265900365907; Thu, 
	11 Feb 2010 06:59:25 -0800 (PST)
In-Reply-To: <4B741A44.7060003@dcl.info.waseda.ac.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139602>

On Thu, Feb 11, 2010 at 3:55 PM, Hitoshi Mitake
<mitake@dcl.info.waseda.ac.jp> wrote:
> (2010=E5=B9=B402=E6=9C=8809=E6=97=A5 23:22), Erik Faye-Lund wrote:
>>
>> On Tue, Feb 9, 2010 at 1:09 PM, Hitoshi Mitake
>> <mitake@dcl.info.waseda.ac.jp> =C2=A0wrote:
>>>
>>> +static int auth_cram_md5(struct imap_store *ctx, struct imap_cmd *=
cmd,
>>> const char *prompt)
>>> +{
>>> + =C2=A0 =C2=A0 =C2=A0 int ret;
>>> + =C2=A0 =C2=A0 =C2=A0 char digest[DIGEST_HEX_LEN];
>>> + =C2=A0 =C2=A0 =C2=A0 char buf[256], base64_out[256];
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 memset(buf, 0, 256);
>>> + =C2=A0 =C2=A0 =C2=A0 base64_decode(buf, prompt, strlen(prompt));
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 memset(digest, 0, DIGEST_HEX_LEN);
>>> + =C2=A0 =C2=A0 =C2=A0 md5_hex_hmac(digest, (const unsigned char *)=
buf, strlen(buf),
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(const unsigned char *)server.pass,
>>> strlen(server.pass));
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 memset(buf, 0, 256);
>>> + =C2=A0 =C2=A0 =C2=A0 strcpy(buf, server.user);
>>> + =C2=A0 =C2=A0 =C2=A0 strcpy(buf + strlen(buf), " ");
>>> + =C2=A0 =C2=A0 =C2=A0 strcpy(buf + strlen(buf), digest);
>>> + =C2=A0 =C2=A0 =C2=A0 memset(base64_out, 0, 256);
>>> + =C2=A0 =C2=A0 =C2=A0 base64_encode(base64_out, buf, strlen(buf));
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 ret =3D socket_write(&ctx->imap->buf.sock, b=
ase64_out,
>>> strlen(base64_out));
>>
>> Since this is the only location in this function that accesses
>> anything inside ctx, how about just passing the imap_socket itself t=
o
>> the function? That'd make it a bit simpler if, say, I was rewriting
>> send-email in C and wanted to add CRAM-MD5 AUTH support (given that
>> I'd done the work to use imap_socket first)...
>>
>
> Do you mean that
> =C2=A0auth_cram_md5(struct imap_store *ctx, struct imap_cmd *cmd, con=
st char
> *prompt)
> should be,
> =C2=A0auth_cram_md5(struct imap_socket *socket, struct imap_cmd *cmd,=
 const char
> *prompt)
> =C2=A0?
>
> If this improves portability of cram-md5 auth, of course I agree.
> But struct imap_socket is defined in imap-send.c yet.
>

Yes, it's what I meant. It's only a minor nit-pick, as some
refactoring would have to be done anyway. But I think it'd be a good
change to only pull in the state needed, but that's my personal
opinion.

> If you want to separate imap-send.c and cram-md5 auth for git-send-em=
ail,
> I'll cooperate :)
>

Not at this point, if ever. I'm fine with you not doing anything about
my comment. I was merely thinking out loud... ;)

--=20
Erik "kusma" Faye-Lund
