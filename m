Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B9121F45A
	for <e@80x24.org>; Sun, 11 Aug 2019 23:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfHKXbI (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Aug 2019 19:31:08 -0400
Received: from mail.farhan.codes ([155.138.165.43]:50488 "EHLO
        mail.farhan.codes" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfHKXbI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Aug 2019 19:31:08 -0400
Received: from mail.farhan.codes (rainloop [172.16.0.4])
        by mail.farhan.codes (Postfix) with ESMTPSA id 005851476F;
        Sun, 11 Aug 2019 19:31:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=farhan.codes; s=mail;
        t=1565566267; bh=kMoUdQcmnMCLvOTZ+mryd949E7VZ4ZRPejzs0LN+Pt8=;
        h=Date:From:Subject:To:Cc:In-Reply-To:References;
        b=SolSg21DUKy0CIGtIP01EKenL/dlwC6azY4ycbiIObIRCcr7FZ2YZf9nQA/WIUV0c
         6uovmK8/E79A33ypaWgEm2b8y/xZvylt+5TODqKlWhDPg/NmKbl4RbGPVeYa0Crchg
         5pKvd37ivAXgfnwrSwsMOxA0k2Cvix2d/AnuK1gc=
MIME-Version: 1.0
Date:   Sun, 11 Aug 2019 23:31:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.1
From:   "Farhan Khan" <farhan@farhan.codes>
Message-ID: <53515e0fb56928114a63bfe87e24c743@farhan.codes>
Subject: Re: How to determine when to stop receiving pack content
To:     "Pratyush Yadav" <me@yadavpratyush.com>
Cc:     "Git" <git@vger.kernel.org>
In-Reply-To: <20190811150450.5pvgvwcqrrvzggbo@localhost.localdomain>
References: <20190811150450.5pvgvwcqrrvzggbo@localhost.localdomain>
 <c1754835efe3aa8a5ac93ee2db4a99c5@farhan.codes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

August 11, 2019 11:04 AM, "Pratyush Yadav" <me@yadavpratyush.com> wrote:=
=0A=0A> On 10/08/19 11:47PM, Farhan Khan wrote:=0A> =0A>> Hi,=0A>> =0A>> =
I am trying to write an implementation of git clone over ssh and am a lit=
tle confused how to=0A>> determine a server response has ended. Specifica=
lly, after a client sends its requested 'want', the=0A>> server sends the=
 pack content over. However, how does the client know to stop reading dat=
a? If I=0A>> run a simple read() of the file descriptor:=0A>> =0A>> A. If=
 I use reading blocking, the client will wait until new data is available=
, potentially=0A>> forever.=0A>> B. If I use non-blocking, the client mig=
ht terminate reading for new data, when in reality new data=0A>> is in tr=
ansit.=0A>> =0A>> I do not see a mechanism to specify the size or to indi=
cate the end of the pack content. Am I=0A>> missing something?=0A> =0A> W=
ell, I am not very familiar with git-clone internals, but I did some=0A> =
digging around, and I think I know what answer to your problem is.=0A> =
=0A> Looking at Documentation/technical/protocol-v2.txt:34, the flush pac=
ket=0A> indicates the end of a message. Looking in the output section of =
the=0A> fetch command (protocol-v2.txt:342), it sends you some optional=
=0A> sections, and then the packfile and then sends a flush packet.=0A> =
=0A> So your read should stop reading data when it sees the flush packet.=
=0A> =0A> Another way would be to look at the packfile contents. Looking =
at=0A> Documentation/technical/pack-format.txt, the packfile contains the=
=0A> number of objects in the packfile, and each object entry has the obj=
ect=0A> size. So you can stop reading after you have received the last ob=
ject in=0A> the packfile (plus the 20-byte trailer).=0A> =0A> I don't kno=
w which is the better way, but the former seems like a better=0A> choice =
to me.=0A> =0A> --=0A> Regards,=0A> Pratyush Yadav=0A=0AHi Pratyush,=0A=
=0AThanks for your reply!=0A=0AUnless I am mistaken, a pack file does not=
 end in a flush_pkt. I ran some tests and did not see the stream end in "=
0000". Is there is a mistake somewhere on my end?=0A=0A---=0AFarhan Khan=
=0APGP Fingerprint: 1312 89CE 663E 1EB2 179C  1C83 C41D 2281 F8DA C0DE
