From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/5] t/t7004-tag: test handling of rfc1991 signatures
Date: Tue, 09 Nov 2010 18:23:39 +0100
Message-ID: <4CD9839B.6060406@drmicha.warpmail.net>
References: <4CAB90EC.1080302@drmicha.warpmail.net> <cover.1289041051.git.git@drmicha.warpmail.net> <c20fb62cefcd42533e47f6f1bf5817712e5ebf9a.1289041051.git.git@drmicha.warpmail.net> <7vwrommn6j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stephan Hugel <urschrei@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 18:25:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFrwu-0000Co-Cv
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 18:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587Ab0KIRZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 12:25:30 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:35932 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752122Ab0KIRZa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Nov 2010 12:25:30 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6BE928CA;
	Tue,  9 Nov 2010 12:25:29 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 09 Nov 2010 12:25:29 -0500
X-Sasl-enc: nPyo3+9DPDb4nywrB461nh67ecpl7BfHq9YiVPqb5fFE 1289323529
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C8E6B404CF0;
	Tue,  9 Nov 2010 12:25:28 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Fedora/3.1.6-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <7vwrommn6j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161062>

Junio C Hamano venit, vidit, dixit 09.11.2010 18:17:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Currently, git expects "-----BEGIN PGP SIGNATURE-----" at the beginning of a
>> signature. But gpg uses "MESSAGE" instead of "SIGNATURE" when used with
>> the "rfc1991" option. This leads to git's failing to verify it's own
>> signed tags, among other problems.
>>
>> Add tests for all code paths (tag -v, tag -l -n largenumber, tag -f
>> without -m) where signature detection matters.
>>
>> Reported-by: Stephan Hugel <urschrei@gmail.com>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>>  t/t7004-tag.sh |   43 +++++++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 43 insertions(+), 0 deletions(-)
>>
>> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
>> index ac943f5..22dcc45 100755
>> --- a/t/t7004-tag.sh
>> +++ b/t/t7004-tag.sh
>> @@ -1030,6 +1030,49 @@ test_expect_success GPG \
>>  	test_cmp expect actual
>>  '
>>  
>> +# usage with rfc1991 signatures
>> +echo "rfc1991" > gpghome/gpg.conf
>> +get_tag_header rfc1991-signed-tag $commit commit $time >expect
>> +echo "RFC1991 signed tag" >>expect
>> +echo '-----BEGIN PGP MESSAGE-----' >>expect
>> +test_expect_success GPG \
>> +	'creating a signed tag with rfc1991' '
>> +	git tag -s -m "RFC1991 signed tag" rfc1991-signed-tag $commit &&
>> +	get_tag_msg rfc1991-signed-tag >actual &&
>> +	test_cmp expect actual
>> +'
>> +
>> +cat >fakeeditor <<'EOF'
>> +#!/bin/sh
>> +cp "$1" actual
>> +EOF
>> +chmod +x fakeeditor
>> +
>> +test_expect_failure GPG \
>> +...
>> +'
>> +
>> +rm -f gpghome/gpg.conf
> 
> Shouldn't this line be placed much earlier in the sequence, to make sure
> that people without --rfc1991 can grok new style signatures?  Better yet,
> shouldn't the script test rfc1991-signed tags both with and without the
> rfc1991 configuration?

The --rfc1991 option matters for the creation of signatures only, not
for the verification (and neither for display/listing with git, of course).

Michael
