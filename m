From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: Re: [PATCH 1/3] git-branch: add --track and --no-track options
Date: Mon, 05 Mar 2007 16:22:26 +0100
Message-ID: <45EC35B2.2070808@lu.unisi.ch>
References: <esgm1m$33f$1@sea.gmane.org> <Pine.LNX.4.63.0703051520340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 05 16:22:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOF1T-0008G3-8X
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 16:22:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbXCEPWb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 10:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbXCEPWb
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 10:22:31 -0500
Received: from server.usilu.net ([195.176.178.200]:32212 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932453AbXCEPWa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 10:22:30 -0500
Received: from [192.168.68.211] ([192.168.68.211] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 5 Mar 2007 16:22:25 +0100
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <Pine.LNX.4.63.0703051520340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-OriginalArrivalTime: 05 Mar 2007 15:22:25.0789 (UTC) FILETIME=[145F72D0:01C75F3A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41450>


>> +	/* Try an exact match first.  */
>> +	sscanf(value, "refs/%*[^:]:%n", &len_first);
> 
> This is the first time I saw that sscanf format type. How portable is it?

It is.  At the very least it is in OpenGroup.

>> +		/* Truncate the value before the colon.  */
>> +		asprintf(&config_repo, "%.*s", len_first - 1, value);
> 
> asprintf() is a GNU extension. I guess it is better to just
> 
> 	config_repo = xstrdup(value);
> 	config_repo[p - value] = '\0';

git has nfvasprintf -- I'll just use that one.

> FWIW I don't think .trackIntoLocalBranches" is needed. Opinions?

That's because I'd like to make it the default for me...  Also, look at patch 3/3.

>> @@ -333,7 +424,9 @@ static void create_branch(const char *name, const char *start_name,
>>  	if (start_sha1)
>>  		/* detached HEAD */
>>  		hashcpy(sha1, start_sha1);
>> -	else if (get_sha1(start_name, sha1))
>> +	else if (dwim_ref(start_name, strlen(start_name), sha1, &real_ref) > 1)
>> +		die("Ambiguous object name: '%s'.", start_name);
> 
> I know, I should have said that earlier, but I just found out myself: We 
> have a config variable core.warnambiguousrefs, and maybe we should _not_ 
> complain and set the defaults when the global variable warn_ambiguous_refs 
> is 0.

If warn_ambiguous_ref == 0, dwim_ref is never going to answer anything > 1...

Paolo
