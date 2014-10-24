From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2] push: heed user.signingkey for signed pushes
Date: Fri, 24 Oct 2014 17:16:30 +0200
Message-ID: <544A6D4E.7070408@drmicha.warpmail.net>
References: <787502533676138ad113e446eba71d92dee3b4de.1413989046.git.git@drmicha.warpmail.net>	<7b3546cd125d1ad92dd62297ecbe624a78c6079b.1413989799.git.git@drmicha.warpmail.net>	<xmqq7fzru5do.fsf@gitster.dls.corp.google.com> <xmqq38afu0of.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 24 17:16:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhgbV-0000ps-Lx
	for gcvg-git-2@plane.gmane.org; Fri, 24 Oct 2014 17:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbaJXPQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2014 11:16:33 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39768 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932374AbaJXPQc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Oct 2014 11:16:32 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 2DCC220735
	for <git@vger.kernel.org>; Fri, 24 Oct 2014 11:16:32 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 24 Oct 2014 11:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=mCKbfr/dXGjV2tycbRIbGx
	bx8iI=; b=QZQLjQsJuhS+Bq9u7nxJUKcgDlyvf58J9k11kCOO+XwHuDYkexwF6Q
	4lIX2b7M0Aws3FYKm2ow3aT41GwMPIFwug/aTeBdca7r8bj8jOZo2BB37eJD/6lO
	UqVYJLDDPYudxpvDnWrMPGBAqSOSLGtyrZ5gyc4+L4+3EOwU4eewg=
X-Sasl-enc: g0t+I2OqoFTFdFQNEUVtEnrmdKujxD4c0ysA+2YR78wj 1414163791
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id AD8B4C00011;
	Fri, 24 Oct 2014 11:16:31 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <xmqq38afu0of.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano schrieb am 23.10.2014 um 01:47:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>
>>> push --signed promises to take user.signingkey as the signing key but
>>> fails to read the config.
>>>
>>> Make it do so.
>>>
>>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>>> ---
>>> Okay, I guess this is nicer. We do have the committer info in the env. Sorry.
>>>
>>>  builtin/push.c         |  13 ++++++++++++-
>>>  t/lib-gpg/trustdb.gpg  | Bin 1360 -> 1360 bytes
>>>  t/t5534-push-signed.sh |  44 ++++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 56 insertions(+), 1 deletion(-)
>>
>> Hmph, I simply forgot about that configuration, I guess.
>>
>> What is this change to trustdb about, though?  The log message does
>> not say anything about it.
> 
> This is a related tangent, but I just tried this:
> 
>     $ git clone ... git.git
>     $ cd git.git
>     $ chmod a-w t/lib-gpg/* t/lib-gpg
>     $ make test
> 
> which makes GPG related tests to fail, as running GPG with the GNUPGHOME
> set there involves writing into the files in the directory (or
> removing and recreating).
> 
> Perhaps GPG tests should create their own copy in the playpen (aka
> "trash directory") and use that as GNUPGHOME so that we do not have
> to write into the single shared directory?  I wonder if automated
> parallel tests can intermittently fail because of this...

If I do that, I get:

gpg: can't create `/home/mjg/src/git/t/trash
directory.t5534-push-signed/gpghome/random_seed': Permission denied

So I we do copy the env around. Problems arise only when the original
copy ends up ro. We can guard against that by doing:

diff --git i/t/lib-gpg.sh w/t/lib-gpg.sh
index fd499e7..972f10e 100755
--- i/t/lib-gpg.sh
+++ w/t/lib-gpg.sh
@@ -17,7 +17,7 @@ else
                # Name and email: C O Mitter <committer@example.com>
                # No password given, to enable non-interactive operation.
                cp -R "$TEST_DIRECTORY"/lib-gpg ./gpghome
-               chmod 0700 gpghome
+               chmod 0700 gpghome gpghome/*
                GNUPGHOME="$(pwd)/gpghome"
                export GNUPGHOME
                test_set_prereq GPG

That is we have partial guard in place already.

I'll resend in proper format.

Michael
