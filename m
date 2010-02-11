From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Subject: Re: [PATCH 3/4] git-imap-send: Implement CRAM-MD5 auth method
Date: Fri, 12 Feb 2010 00:11:28 +0900
Message-ID: <4B741E20.3010602@dcl.info.waseda.ac.jp>
References: <7vaavj8h1k.fsf@alter.siamese.dyndns.org>	 <1265717345-2118-4-git-send-email-mitake@dcl.info.waseda.ac.jp>	 <40aa078e1002090622vb65027xa53acff95557a183@mail.gmail.com>	 <4B741A44.7060003@dcl.info.waseda.ac.jp> <40aa078e1002110659y9493052l3752c7e0afb6eb3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Faye-Lund <kusmabite@googlemail.com>, gitster@pobox.com,
	git@vger.kernel.org, Jeremy White <jwhite@codeweavers.com>,
	Robert Shearman <robertshearman@gmail.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 11 16:11:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfahc-0000n0-Qh
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 16:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756061Ab0BKPLb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2010 10:11:31 -0500
Received: from ns.dcl.info.waseda.ac.jp ([133.9.216.194]:64420 "EHLO
	ns.dcl.info.waseda.ac.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755840Ab0BKPLa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 10:11:30 -0500
Received: from localhost (localhost [127.0.0.1])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id E9DA4EAFA61;
	Fri, 12 Feb 2010 00:11:29 +0900 (JST)
X-Virus-Scanned: amavisd-new at dcl.info.waseda.ac.jp
Received: from ns.dcl.info.waseda.ac.jp ([127.0.0.1])
	by localhost (ns.dcl.info.waseda.ac.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m9KfK6PbFFTN; Fri, 12 Feb 2010 00:11:29 +0900 (JST)
Received: from [192.168.11.2] (FL1-122-130-141-251.tky.mesh.ad.jp [122.130.141.251])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 7BC46EAFA5D;
	Fri, 12 Feb 2010 00:11:29 +0900 (JST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ja; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <40aa078e1002110659y9493052l3752c7e0afb6eb3c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139606>

(2010=E5=B9=B402=E6=9C=8811=E6=97=A5 23:59), Erik Faye-Lund wrote:
> On Thu, Feb 11, 2010 at 3:55 PM, Hitoshi Mitake
> <mitake@dcl.info.waseda.ac.jp>  wrote:
>> (2010=E5=B9=B402=E6=9C=8809=E6=97=A5 23:22), Erik Faye-Lund wrote:
>>>
>>> On Tue, Feb 9, 2010 at 1:09 PM, Hitoshi Mitake
>>> <mitake@dcl.info.waseda.ac.jp>    wrote:
>>>>
>>>> +static int auth_cram_md5(struct imap_store *ctx, struct imap_cmd =
*cmd,
>>>> const char *prompt)
>>>> +{
>>>> +       int ret;
>>>> +       char digest[DIGEST_HEX_LEN];
>>>> +       char buf[256], base64_out[256];
>>>> +
>>>> +       memset(buf, 0, 256);
>>>> +       base64_decode(buf, prompt, strlen(prompt));
>>>> +
>>>> +       memset(digest, 0, DIGEST_HEX_LEN);
>>>> +       md5_hex_hmac(digest, (const unsigned char *)buf, strlen(bu=
f),
>>>> +                    (const unsigned char *)server.pass,
>>>> strlen(server.pass));
>>>> +
>>>> +       memset(buf, 0, 256);
>>>> +       strcpy(buf, server.user);
>>>> +       strcpy(buf + strlen(buf), " ");
>>>> +       strcpy(buf + strlen(buf), digest);
>>>> +       memset(base64_out, 0, 256);
>>>> +       base64_encode(base64_out, buf, strlen(buf));
>>>> +
>>>> +       ret =3D socket_write(&ctx->imap->buf.sock, base64_out,
>>>> strlen(base64_out));
>>>
>>> Since this is the only location in this function that accesses
>>> anything inside ctx, how about just passing the imap_socket itself =
to
>>> the function? That'd make it a bit simpler if, say, I was rewriting
>>> send-email in C and wanted to add CRAM-MD5 AUTH support (given that
>>> I'd done the work to use imap_socket first)...
>>>
>>
>> Do you mean that
>>   auth_cram_md5(struct imap_store *ctx, struct imap_cmd *cmd, const =
char
>> *prompt)
>> should be,
>>   auth_cram_md5(struct imap_socket *socket, struct imap_cmd *cmd, co=
nst char
>> *prompt)
>>   ?
>>
>> If this improves portability of cram-md5 auth, of course I agree.
>> But struct imap_socket is defined in imap-send.c yet.
>>
>
> Yes, it's what I meant. It's only a minor nit-pick, as some
> refactoring would have to be done anyway. But I think it'd be a good
> change to only pull in the state needed, but that's my personal
> opinion.

My latest patch doesn't change the point.
Because auth_cram_md5() is a call back, so changing type of it
needs some works...

>
>> If you want to separate imap-send.c and cram-md5 auth for git-send-e=
mail,
>> I'll cooperate :)
>>
>
> Not at this point, if ever. I'm fine with you not doing anything abou=
t
> my comment. I was merely thinking out loud... ;)
>

I'm looking forward to using your new git-send-email.
I'm also a heavy user of it :)
