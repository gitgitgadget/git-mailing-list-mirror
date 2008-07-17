From: Lars Noschinski <lars@public.noschinski.de>
Subject: Re: [PATCH] cvsserver: Add support for packed refs
Date: Thu, 17 Jul 2008 14:40:35 +0200
Message-ID: <20080717124034.GA10589@lars.home.noschinski.de>
References: <1216288877-12140-1-git-send-email-lars@public.noschinski.de> <1216288877-12140-2-git-send-email-lars@public.noschinski.de> <1216288877-12140-3-git-send-email-lars@public.noschinski.de> <alpine.LSU.1.00.0807171346560.3486@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org, fabian.emmes@rwth-aachen.de
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 17 14:47:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJStc-00079V-Ql
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 14:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724AbYGQMqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 08:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755424AbYGQMqq
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 08:46:46 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:37369 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755337AbYGQMqp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 08:46:45 -0400
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Jul 2008 08:46:45 EDT
Received: from [87.78.67.122] (helo=vertikal.home.noschinski.de)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lars@public.noschinski.de>)
	id 1KJSmm-0002y2-Nt; Thu, 17 Jul 2008 14:40:40 +0200
Received: from lars by vertikal.home.noschinski.de with local (Exim 4.69)
	(envelope-from <lars@public.noschinski.de>)
	id 1KJSmm-0002rV-2i; Thu, 17 Jul 2008 14:40:40 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0807171346560.3486@wbgn129.biozentrum.uni-wuerzburg.de>
User-Agent: mutt-ng/devel-r804 (Linux)
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88843>

Hello!

* Johannes Schindelin <Johannes.Schindelin@gmx.de> [08-07-17 14:31]:
>On Thu, 17 Jul 2008, Lars Noschinski wrote:
>
>> req_update still parses /refs/heads manually. Replace this by
>> a call to show-ref.
>> 
>> Signed-off-by: Lars Noschinski <lars@public.noschinski.de>
>> ---
>>  git-cvsserver.perl |   25 +++++++++----------------
>>  1 files changed, 9 insertions(+), 16 deletions(-)
>> 
>> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
>> index b00d1c2..0e4f5f9 100755
>> --- a/git-cvsserver.perl
>> +++ b/git-cvsserver.perl
>> @@ -947,24 +947,17 @@ sub req_update
>>      # projects (heads in this case) to checkout.
>>      #
>>      if ($state->{module} eq '') {
>> -	my $heads_dir = $state->{CVSROOT} . '/refs/heads';
>> -	if (!opendir HEADS, $heads_dir) {
>> -	    print "E [server aborted]: Failed to open directory, "
>> -	      . "$heads_dir: $!\nerror\n";
>> -	    return 0;
>> -	}
>> -        print "E cvs update: Updating .\n";
>> -	while (my $head = readdir(HEADS)) {
>> -	    if (-f $state->{CVSROOT} . '/refs/heads/' . $head) {
>> -	        print "E cvs update: New directory `$head'\n";
>> -	    }
>> -	}
>> -	closedir HEADS;
>> -	print "ok\n";
>> -	return 1;
>> +        my $showref = `git show-ref --heads`;
>> +        for my $line (split '\n', $showref) {
>> +            if ( $line =~ m% refs/heads/(.*)$% ) {
>> +                print "M $1\t$1\n";
>
>In the removed part, I see that this changes behaviour from "E cvs update: 
>..." to "M ...".

Good catch, this part is indeed somewhat busted. The tested clients did
not care, but this should be changed nevertheless to be the same as the
old behaviour.

>I do not know the CVS protocol well enough to know if that is still 
>correct.
>
>BTW from the removed part, it seems that the indentation was done with 
>tabs formerly, and with spaces now; please use tabs instead.

Actually, the old indetation was wrong. The biggest part of the file
(and the surrounding code) is indented by spaces.
