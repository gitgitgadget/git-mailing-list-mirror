From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH 3/4] test-lib: provide lazy TIME_COMMAND prereq
Date: Tue, 16 Oct 2012 17:06:49 +0200
Message-ID: <507D7809.6040904@drmicha.warpmail.net>
References: <k5gq60$q8c$1@ger.gmane.org> <0140f3f2f2f4bded6868f4082bef0c36e9a8560e.1350387132.git.git@drmicha.warpmail.net> <007001cdaba8$5afc6c00$10f54400$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, 'Junio C Hamano' <gitster@pobox.com>
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Tue Oct 16 17:07:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO8jX-0008W0-Qo
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 17:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754838Ab2JPPGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 11:06:53 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36897 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754598Ab2JPPGw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2012 11:06:52 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 6E06920B30;
	Tue, 16 Oct 2012 11:06:51 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Tue, 16 Oct 2012 11:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=YNcAhnSZRXav3rRpTKEnw0
	MVdWQ=; b=bxJelb2xS+p1t4RFbV5XztvU/JK3ffyWfWBWtqLUY5g2MM8HpnthPi
	xxHDNAdC1cnHinTknaG3L92RqXNt2A4N8byOYzLzyUDTSIZY3qSR8wTbS3Z3VL/c
	/LJZYDVpMELEJU9XTYGdGWvuhCxccv68H/rPhqZ/lsVkT8U/dQmaY=
X-Sasl-enc: AnyfI/idLGOgRB34Q/mjkFZbiJGxDLgYWQ45cwEui3pV 1350400011
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id CFDD14827EE;
	Tue, 16 Oct 2012 11:06:50 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
In-Reply-To: <007001cdaba8$5afc6c00$10f54400$@schmitz-digital.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207833>

Joachim Schmitz venit, vidit, dixit 16.10.2012 16:13:
>> From: Michael J Gruber [mailto:git@drmicha.warpmail.net]
>> Sent: Tuesday, October 16, 2012 1:40 PM
>> To: git@vger.kernel.org
>> Cc: Joachim Schmitz; Junio C Hamano
>> Subject: [RFC/PATCH 3/4] test-lib: provide lazy TIME_COMMAND prereq
>>
>> Some test want to use the time command (not the shell builtin) and test
>> for its availability at /usr/bin/time.
>>
>> Provide a lazy prereq TIME_COMMAND which tests for /usr/bin/time and
>> /bin/time. If any is found, set TEST_COMMAND_PATH to the first match.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>> Rather than iterating over 2 or more hardcoded paths, one could use
>> "test -P time" or allow a make variable TIME_COMMAND_PATH whose
> 
> test -P time won't work for me:
> test -P: unary operator expected
> 
> I do have another one in /usr/local/bin, maybe that could get added too?

Yikes.

If we introduce a make variable TIME_COMMAND_PATH we can even get rid of
2/4 (but have to change Makefile or t/Makefile).

>> executability is checked by the prereq. I really don't know what's best.
>>
>>  t/test-lib.sh | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 489bc80..7977c15 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -738,6 +738,13 @@ test_lazy_prereq UTF8_NFD_TO_NFC '
>>  	esac
>>  '
>>
>> +test_lazy_prereq TIME_COMMAND '
>> +	for command in /usr/bin/time /bin/time
>> +	do
>> +		test -x "$command" && break
>> +	done && TIME_COMMAND_PATH="$command"
>> +'
>> +
>>  # When the tests are run as root, permission tests will report that
>>  # things are writable when they shouldn't be.
>>  test -w / || test_set_prereq SANITY
>> --
>> 1.8.0.rc2.304.g9f3ac5c
> 
