Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857B7C19F2B
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 08:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239298AbiHDI2N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 04:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiHDI2K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 04:28:10 -0400
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D89E31275E
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 01:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Mime-Version:Subject:From:Date:Message-Id; bh=YLN0m
        1dw5dvyMS5RtLBPW4KEiYmXLQLRQSRurha/ssU=; b=i/ljZ72kCCdW0M8A6Bd6M
        LRDyXWxxr1b8H77nK2MWTKm8snUKe2DTJT09AG1PnxOHuj/CufJCnoVCqYfDJtTM
        ZWsYuX2cTQB9BHmJ9TDZZMMK5rwEkTWtXyY8HHSbERka5za7vkH8mQByRjsvy533
        UnwB8d5Yfzz/wiunKXLZe8=
Received: from smtpclient.apple (unknown [119.3.119.20])
        by smtp10 (Coremail) with SMTP id DsCowAAXBhMCg+tiPuZ_Rg--.41488S3;
        Thu, 04 Aug 2022 16:27:48 +0800 (CST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 0/3] refs-advertise: add hook to filter advertised refs
From:   =?utf-8?B?5a2Z6LaF?= <16657101987@163.com>
In-Reply-To: <xmqq35ed9iof.fsf@gitster.g>
Date:   Thu, 4 Aug 2022 16:27:44 +0800
Cc:     Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Sun Chao <16657101987@163.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FEAF81E9-61C7-4A41-9882-D05895340003@163.com>
References: <pull.1301.git.git.1659543457.gitgitgadget@gmail.com>
 <xmqq35ed9iof.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-CM-TRANSID: DsCowAAXBhMCg+tiPuZ_Rg--.41488S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr43trW7ArWrKw1kJFW8WFg_yoW5Xry5pF
        13KFy2k34vvF4rAw4kZ3WkW3W0vFyavry3A395t34UZrsxXr1IgFW8JFy5Ka1xCryfK3yY
        yrn0v39rAw4vv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR04ENUUUUU=
X-Originating-IP: [119.3.119.20]
X-CM-SenderInfo: rprwlkyxrqimiyx6il2tof0z/1tbiFQRTgl5mMD6GqQAAsZ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On Aug 4, 2022, at 04:27, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>> Gerrit is implemented by JGit and is known as a centralized workflow =
system
>> which supports reference-level access control for repository. If we =
choose
>> to work in centralized workflow like what Gerrit provided, =
reference-level
>> access control is needed and is possible if we add a reference =
advertise
>> filter hook just like what Gerrit did.
>=20
> It may be one starting point, but is it sufficient to call it
> "possible"?  The server side needs to tighten "fetch by object name"
> to refuse to serve objects that are not reachable from any of the
> refs advertised to the client requesting them.  IIRC, fetch protocol
> v2 is wide open and does not limit the requests to those that are
> only reachable from the advertised refs.
>=20
>=20
Hi Junio, thanks for you reply.

I agree with you that the server need to refuse the fetch requests that =
want to
steal objects not reachable from the advertised refs. So I have tried to =
understand
the source codes of of `ls-refs.c` and `upload-pack.c` (maybe I lost =
some important
files), and I put a new function `filter_advertise_object` to call =
`refs-advertise`
hook checks the `want` objects.

```diff
@@ -1118,7 +1119,7 @@ static void receive_needs(struct upload_pack_data =
*data,
               }

               o =3D parse_object(the_repository, &oid_buf);
-               if (!o) {
+               if ((!o) || (filter_advertise_object(&oid_buf))) {
                       packet_writer_error(&data->writer,
                                           "upload-pack: not our ref =
%s",
                                           oid_to_hex(&oid_buf));

...

@@ -1421,7 +1445,7 @@ static int parse_want(struct packet_writer =
*writer, const char *line,
               else
                       o =3D parse_object(the_repository, &oid);

-               if (!o) {
+               if ((!o) || (filter_advertise_object(&oid))) {
                       packet_writer_error(writer,
                                           "upload-pack: not our ref =
%s",
                                           oid_to_hex(&oid));
```

The `filter_advertise_object` will exchange messages with the hook by =
pkt-line
messages, eg:

       # Send commit filter request to hook
       G: PKT-LINE(obj <oid>)
       G: flush-pkt

       # Receive result from the hook.
       # Case 1: this object is valid
       H: PKT-LINE(ok obj <oid>)
       H: flush-pkt
       # Case 2: this object is filtered out
       H: PKT-LINE(ng obj <oid>)
       H: flush-pkt

the hook can check if the `oid` is valid for the client and returns `ng` =
message if not,
so git server will hide the objects to the client. And I added some test =
cases for
upload-pack V1 and V2 and looks like it works, but maybe I lost some =
important points and
I'm still trying to understand other codes for upload-pack and =
receive-pack because
currently I only implements the filter process for upload-pack and =
receive-pack.

Thanks for your reply again.=

