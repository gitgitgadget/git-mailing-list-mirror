From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] rebase -i: commit when continuing after "edit"
Date: Tue, 25 Sep 2007 15:26:45 +0200
Message-ID: <46F90C95.5060903@viscovery.net>
References: <20070923224502.GB7249@potapov> <Pine.LNX.4.64.0709240121080.28395@racer.site> <7vlkav71bv.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709251249450.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 25 15:27:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaARG-0004Ae-Ne
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 15:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbXIYN0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 09:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbXIYN0u
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 09:26:50 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:49058 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbXIYN0t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 09:26:49 -0400
X-Greylist: delayed 1275 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Sep 2007 09:26:49 EDT
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IaAR4-00005T-Oe; Tue, 25 Sep 2007 15:26:47 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1BD19546; Tue, 25 Sep 2007 15:26:46 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0709251249450.28395@racer.site>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59119>

Johannes Schindelin schrieb:
> On Mon, 24 Sep 2007, Junio C Hamano wrote:
>>>  do_next () {
>>>  	test -f "$DOTEST"/message && rm "$DOTEST"/message
>>>  	test -f "$DOTEST"/author-script && rm "$DOTEST"/author-script
>>> +	test -f "$DOTEST"/amend && rm "$DOTEST"/amend
>> As you do not check the error from "rm", how are these different from rm 
>> -f "$DOTEST/frotz"?
> 
> The difference: the user will not see many irritating error messages.
> 
> I changed this code to use a newly written function "remove_if_exists", 
> which die()s if the file exists and could not be removed.

Why? rm -f does nothing if the file does not exist, and fails if it cannot 
remove an existing file. It all boils down to:

	rm -f "$DOTEST"/message "$DOTEST"/author-script \
		"$DOTEST"/amend || exit

>>>  			# This is like --amend, but with a different message
>>>  			eval "$author_script"
>>>  			export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
>>>  			$USE_OUTPUT git commit -F "$MSG" $EDIT_COMMIT
>>>  			;;
>> The "export" here makes me somewhat nervous -- no chance these
>> leak into the next round?
> 
> I am somewhat wary: I get quoting wrong all the time.  Would
> 
> 	$USE_OUTPUT $author_script git commit -F "$MSG" $EDIT_COMMIT
> 
> work?  I have the slight suspicion that it would not, since
> 
> 	eval "$author_script"
> 
> needs extra quoting in $author_script, no?

How about:

	eval "$author_script"
	GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
	GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
	GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
	$USE_OUTPUT git commit -F "$MSG" $EDIT_COMMIT

and if you dislike that, put the two questionable lines in parenthesis.

-- Hannes
