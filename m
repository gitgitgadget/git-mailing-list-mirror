From: demerphq <demerphq@gmail.com>
Subject: Re: XDL_FAST_HASH can be very slow
Date: Tue, 23 Dec 2014 03:51:05 +0100
Message-ID: <CANgJU+X1XvM7zMiBV5Auo+bi2Dup8z7GohGY=SJwWNDxMzB+zg@mail.gmail.com>
References: <20141222041944.GA441@peff.net>
	<CAJrMUs_fM8+=2j1e5hYiaRjQq1QF87X6qOLN847q-B7Nu-wniw@mail.gmail.com>
	<87r3vsrmdc.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Patrick Reynolds <piki@github.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Tue Dec 23 03:51:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3FZ2-0001dn-9D
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 03:51:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871AbaLWCvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 21:51:07 -0500
Received: from mail-qc0-f177.google.com ([209.85.216.177]:54496 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbaLWCvG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 21:51:06 -0500
Received: by mail-qc0-f177.google.com with SMTP id x3so4077996qcv.8
        for <git@vger.kernel.org>; Mon, 22 Dec 2014 18:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Or5O3g/2LcrmN9bWxERX/p6zO2Ln1mF7/q32OntS5ps=;
        b=XDckK0QgXjJBzrp+Z+LO9eBKTaNXoeEEiKxx0gOMzg/tHpB2kyuWbNFzbkS0zWzgo2
         gcRcOtMpgKylJlfxvHrkeOIPRVryOBt2bCwoyFpWzMbA7IyqslsgiyENgZTUF51VjLUL
         wQB6wuaoRh5SLB8zjdPIJEuUWzrvFkmT68Wh5siDhlt9D25Ykgt0PqX5F07dEBIGEceb
         I5tV041l1n6/B/cCd13wtEoHh47pFDxMZzUOmbefMkdfB7Lw2R3JGbmNkb9bK9Ov4UjX
         WxXNS1afFd5DzWpoIEBZxqT4FV+2OX8E8/Xa2Uynk9ScwejZ0RtpHm4zOerThodqd6yG
         L25A==
X-Received: by 10.224.95.67 with SMTP id c3mr41416136qan.3.1419303065306; Mon,
 22 Dec 2014 18:51:05 -0800 (PST)
Received: by 10.140.91.195 with HTTP; Mon, 22 Dec 2014 18:51:05 -0800 (PST)
In-Reply-To: <87r3vsrmdc.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261711>

(sorry for the repost, I use gmail and it send html mails by default).
On 22 December 2014 at 11:48, Thomas Rast <tr@thomasrast.ch> wrote:
>
> 1. hash function throughput
> 2. quality of the hash values
> 3. avoiding collision attacks
>
> XDL_FAST_HASH was strictly an attempt to improve throughput, and fairly
> successful at that (6942efc (xdiff: load full words in the inner loop of
> xdl_hash_record, 2012-04-06) quotes an 8% improvement on 'git log -p').
>
> You are now addressing quality.
>
> I have no idea how you ran into this, but if you are reworking things
> already, I think it would be good to also randomize whatever hash you
> put in so as to give some measure of protection against collision
> attacks.

I assume you mean DJB2 when you say DJB, and if so I will just note
that it is a pretty terrible hash function for arbitrary data. (I
understand it does better with raw text.) It does not pass either
strict-avalanche-criteria[1], nor does it pass the
bit-independence-criteria[2]. I have images which show how badly DJB2
fails these tests if anyone is interested.

Murmur3 is better, in that it does pass SAC and BIC, but before you
decide to use Murmur3 you should review https://131002.net/siphash/and
related resources which demonstrate multi-collision attacks on Murmur3
which are independent of the seed chosen. The paper also introduces a
new hash function with good performance properties, and claims that it
has cyptographic strength. (I say claims because I am not qualified to
judge if it is or not.) Eg:
https://131002.net/siphash/murmur3collisions-20120827.tar.gz

I think if you want performance and robustness against collision
attacks Siphash is a good candidate, as is perhaps the AES derived
hash used by the Go folks, but the performance of that algorithm is
strongly dependent on the CPU supporting AES primitives.

Anyway, the point is that simply adding a random seed to a hash
function like DJB2 or Murmur3 is not sufficient to prevent collision
attacks.

Yves
[1] A change in a single bit of the seed or the key should result in
50% of the output bits of the hash changing.
[2] output bits j and k should change independently when any single
input bit i is inverted, for all i, j and k.
