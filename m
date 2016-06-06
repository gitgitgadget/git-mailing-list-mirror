From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [BUG?] trailer command with multiple keys
Date: Mon, 6 Jun 2016 14:27:52 +0200
Message-ID: <b94e1666-2f89-619b-112c-023f72002d9d@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 14:28:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9te3-0003bZ-8c
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 14:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422AbcFFM2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 08:28:34 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:50683 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751569AbcFFM17 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 08:27:59 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id A4CD421C3A;
	Mon,  6 Jun 2016 08:27:53 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Mon, 06 Jun 2016 08:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=OPc
	RWKsijc+M2Wi6HDxR0TU0FcA=; b=gz3+4nP7nRTCDXRpSBymLIhgK3rDojkts2C
	I1CcTGRRhZ9ZH3nqT8ILA8JnwqQ6mhfCGo8EK2WGzsMpj6l1a7sSkxZX6Lr6lbhc
	66EVujCQ8v7wXQ/Hl59kOReX2tK/93nmgXIIa9H3mDkSkHxzYVvhRXFnxObeF3iw
	3tpOYKDo=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=OPcRWKsijc+M2Wi6HDxR0TU0FcA=; b=sJABq
	H4r2208Ig0wLGDVa75sUqCMXFxfCh0FAwjtfKARsXYrgNpiPTabgLtu4A/OOuDnq
	XF1pZHqyQsFtdSmk8Df5nGV09hoOl855q1hbfdk2xBN4vajOrcQpmMOf2uDxxUCs
	k42kROnMyc253gONzOx/Wkr+tiSJiVtaJtqZaY=
X-Sasl-enc: 3cHj8K/WD/vaAeQs6+XzeM93pZBZ9Os28ieBlBjpeqiE 1465216073
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 2B6E4F29F4;
	Mon,  6 Jun 2016 08:27:53 -0400 (EDT)
X-Mozilla-News-Host: news://news.gmane.org:119
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296503>

The command

printf "body\n\ntest: foo\ntest: froz\n" | git -c
trailer.test.key=tested -c trailer.test.command="echo by \$ARG"
interpret-trailers

gives:

body

tested: foo
tested: froz
tested: by froz

I expected the command to be run on each "test" key, resulting in the
output:

body:

tested: by foo
tested: by froz

(In a real life scenario, I would use ifexists replace.)[*]

Maybe my expectation is wrong? The code breaks out of the loop after the
first matching in_tok, apparently intentionally so. But I'm not sure -
the key is replaced for both instances.

Simply replacing that "return 1" by a "ret = 1" etc. runs into problems
with the way the freeing of in_tok and arg_tok is arranged there :|

Basically, I expected the trailer command to work "grep/sed-like" on all
key value pairs that have matching keys, passing the value to the
command, and using the (each) command's output as the new value for each
of these pairs.

Michael

[*] My prime use case: fill in reported-by etc. with short author names,
completed the same way we complete --author=jun using a trailer command
(interpret-trailers in the commit-msg hook):

$ git help author
`git author' is aliased to `!f() { a=$(git log -1 --all -i --format="%aN
<%aE>" --author "$1"); echo ${a:-$1}; }; f'

$ cat .git/hooks/commit-msg
#!/bin/sh
git interpret-trailers --in-place "$1"

$ git config --get-regexp trailer
trailer.report.key Reported-by
trailer.report.command git author '$ARG'
trailer.report.ifexists replace
trailer.report.ifmissing doNothing
