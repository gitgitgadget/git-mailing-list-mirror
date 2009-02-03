From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] t3411: Fix test 1 for case-insensitive file systems
Date: Tue, 3 Feb 2009 12:43:06 -0500
Message-ID: <5FE034E8-422F-4692-AD37-5633C91A4B98@silverinsanity.com>
References: <1233244816-67565-1-git-send-email-benji@silverinsanity.com> <7vocxqf2sf.fsf@gitster.siamese.dyndns.org> <673CE949-5DF9-4970-A739-AA09FCD26D24@silverinsanity.com> <1E104E1B-BFCC-4CFC-9D53-CE89299C9600@silverinsanity.com> <alpine.DEB.1.00.0902031752230.6573@intel-tinevez-2-302> <2D4586A6-ADAC-4B6E-8B42-2CBD76E0304C@silverinsanity.com> <alpine.DEB.1.00.0902031817260.6573@intel-tinevez-2-302>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 03 18:45:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUPKQ-00026u-RF
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 18:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682AbZBCRnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 12:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753080AbZBCRnP
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 12:43:15 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:56562 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240AbZBCRnO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 12:43:14 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 5DEDC1FFC27F; Tue,  3 Feb 2009 17:43:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=4.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.7-deb3
Received: from [192.168.5.44] (nmd.sbx07360.rocheny.wayport.net [98.98.50.102])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id F1AE51FFC271;
	Tue,  3 Feb 2009 17:43:02 +0000 (UTC)
In-Reply-To: <alpine.DEB.1.00.0902031817260.6573@intel-tinevez-2-302>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108224>


On Feb 3, 2009, at 12:18 PM, Johannes Schindelin wrote:

> On Tue, 3 Feb 2009, Brian Gernhardt wrote:
>
>> On Feb 3, 2009, at 11:53 AM, Johannes Schindelin wrote:
>>
>>> Besides, I think that my latest comment still stands there:  
>>> testing is not
>>> good enough, code inspection is required if something expects the  
>>> file
>>> names as they used to be.
>>
>> As far as I can tell, no test relies on the auto-generated name of  
>> the test
>> file.  In fact, only t3411 uses that feature at all and it only  
>> performs
>> operations on commits.  All other uses of test_commit give a  
>> filename (even
>> though many of them don't appear to use the file).
>
> You did not look far.

If there's something I missed, could you perhaps say what it is  
instead of being cryptic?  I have a day job and am attempting to  
squeeze in searching for this between tasks.  This fix (or similar)  
needs to make it into master so that the tests can run on case- 
insensitive file systems.

I used git grep to find uses of test_commit in next, and the only uses  
that did not provide a file name argument were in t3411.  I read  
through every test in the file, and the only operations I saw were  
test_commit, test_merge, checkout -b, reset without filenames, rebase,  
and rev-parse.  All operations on commits, not files.

The tests all run properly, and I've run t3411 individually (since  
it's apparently the only one using this feature) using -v to ensure  
that it was actually performing work and it seems to be.

So, based on the above, every usage of test_commit either provides a  
file name or does not care about the names of the files.  Unless you  
have something that says it isn't, I'd like to see the fix Junio gave  
applied (repeated here as a reminder):

On Jan 29, 2009, at 12:19 PM, Junio C Hamano wrote:

> diff --git c/t/test-lib.sh w/t/test-lib.sh
> index c1839f7..8066c25 100644
> --- c/t/test-lib.sh
> +++ w/t/test-lib.sh
> @@ -201,7 +201,7 @@ test_tick () {
> # Both <file> and <contents> default to <message>.
>
> test_commit () {
> -	file=${2:-$(echo "$1" | tr 'A-Z' 'a-z')}
> +	file=${2:-$(echo "$1" | tr 'A-Z' 'a-z').t}
> 	echo "${3-$1}" > "$file" &&
> 	git add "$file" &&
> 	test_tick &&
