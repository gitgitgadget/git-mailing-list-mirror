From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] shell portability: Use sed instead of non-portable variable
 expansion
Date: Mon, 05 Sep 2011 10:16:06 +0200
Message-ID: <4E648546.8060303@viscovery.net>
References: <8762l73758.fsf@elisp.net> <4E647442.9000005@viscovery.net> <7v7h5nxxwf.fsf@alter.siamese.dyndns.org> <4E647BD5.8060609@viscovery.net> <7v39gbxwi6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Naohiro Aota <naota@elisp.net>, git@vger.kernel.org,
	tarmigan+git@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 05 10:16:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0ULr-000697-4i
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 10:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347Ab1IEIQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 04:16:15 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:22579 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751167Ab1IEIQN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 04:16:13 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1R0ULe-0007Ts-SL; Mon, 05 Sep 2011 10:16:07 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 986201660F;
	Mon,  5 Sep 2011 10:16:06 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.21) Gecko/20110830 Thunderbird/3.1.13
In-Reply-To: <7v39gbxwi6.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180727>

Am 9/5/2011 9:45, schrieb Junio C Hamano:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> Actually, it's the opposite: Within double-quotes, a backslash is only
>> removed when the next character has a special meaning (essentially $, `,
>> ", \), otherwise, it remains and loses its quoting ability. This means,
>> that the backslash would remain as a literal character in our patterns on
>> the right of % or #, and they would not work anymore as intended.
> 
> That's strange...
> 
> I thought that VAR=<any string without $IFS character in it> would behave
> identically to VAR="<the same string as above>". You seem to be saying
> that they should act differently.

They are not the same.

First of all, the value of $IFS is irrelevant whether or not you need
double-quotes on the RHS of an assignment, because it is purely a
syntactic matter; $IFS plays no role during syntax analysis. It is only
the presence of white-space that sometimes[*] requires quoting of some form.

The most visible difference is a backslash that is followed by a character
that is not special:

$ foo="a\xb" env | grep foo; foo=a\xb env | grep foo
foo=a\xb
foo=axb

But it is the same elsewhere in a command:

$ echo "a\xb"; echo a\xb
a\xb
axb

The reason is that a backslash inside double-quotes remains as a literal
character when it is not followed by a special character, whereas outside
double-quotes an unquoted backslash is always removed.

[*] No quoting is required in cases like this: VAR=$(echo foo)

>> [?] instead of \? is certainly also worth a try.
> 
> I obviously agree. Besides, [?] would sidestep the tricky backslash vs
> double quote issue entirely, so it would be a more robust solution to
> leave it around than "sometimes you need to avoid double-quote and some
> other times you would need double-quote" for other people to mimic writing
> tests later.

Good point, and I shall prefer this solution as well.

-- Hannes
