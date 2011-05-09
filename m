From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] t1507: change quoting in test_did_you_mean to a more
 general one
Date: Mon, 09 May 2011 08:39:56 +0200
Message-ID: <4DC78C3C.6060004@viscovery.net>
References: <20110505191027.GA3242@camk.edu.pl> <7vsjss6hmf.fsf@alter.siamese.dyndns.org> <4DC3A685.4080300@drmicha.warpmail.net> <4DC3CBEF.6080303@viscovery.net> <7voc3cqyfp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kacper Kornet <draenog@pld-linux.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 09 08:40:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJK8Z-0006vH-Ph
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 08:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203Ab1EIGkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 02:40:04 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:55167 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959Ab1EIGkD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 02:40:03 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QJK8L-00035p-1L; Mon, 09 May 2011 08:39:57 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id BDEA71660F;
	Mon,  9 May 2011 08:39:56 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <7voc3cqyfp.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173196>

Am 5/9/2011 6:40, schrieb Junio C Hamano:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> - The behavior of quoting at the right of :- when the ${...:-...} exansion
>> appears in double-quotes was debated recently at length at the Austin
>> group (which revises the POSIX standard). You better move the expansions
>> to assignments of temporary variables,...
> 
> What alternative semantics do Austin folks have in mind, by the way?  Just
> declare this undefined?

Most of the debate centered around how to quote a closing brace: the
problem is that usually the backslash within double-quotes is only special
when followed by $, `, or \, therefore, it should not be possible to quote
a closing brace using \}. It turned out that different shells handled this
particular case differently. IIRC, there were also discrepancies whether
whitespace generated on the RHS of :- (or other operators) was retained or
discarded. The conclusion for us as application developers is not to
depend on too many subtle details in such a variable expansions because
the specification is too vague, shells implement it differently, and some
even get it outright wrong (as the case discovered by Kascper).

> -	printf "fatal: Path '$2$3' $4, but not ${5:-'$3'}.\n" >expected &&
> -	printf "Did you mean '$1:$2$3'${2:+ aka '$1:./$3'}?\n" >>expected &&
> +	sq="'"

This cuts the && chain.

> +	cat >expected <<-EOF &&
> +	fatal: Path '$2$3' $4, but not ${5:-$sq$3$sq}.
> +	Did you mean '$1:$2$3'${2:+ aka $sq$1:./$3$sq}?
> +	EOF

Looks good otherwise; I tested this with various shells, and there were no
surprises.

-- Hannes
