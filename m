From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] merge: default to @{upstream}
Date: Fri, 28 Jan 2011 11:56:10 -0600
Message-ID: <20110128175609.GA27118@burratino>
References: <1296231457-18780-1-git-send-email-felipe.contreras@gmail.com>
 <1296233099.12855.14.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Fri Jan 28 18:56:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PisZ3-0006S3-O4
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 18:56:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755323Ab1A1R4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jan 2011 12:56:48 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60032 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754961Ab1A1R4s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 12:56:48 -0500
Received: by fxm20 with SMTP id 20so3602685fxm.19
        for <git@vger.kernel.org>; Fri, 28 Jan 2011 09:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=/GtW7EFp41TtNtxfiPPpuHBnEsOqZjn66pR0p7Ix9VY=;
        b=wWD4TI9Oo+IbVjhJmsXCubTM2LxMnSmkVHNyVzYK9bG38SRZcYr0R5mlkptg/PIg0Q
         Aqr3/1X1ZMBMIUq7OJTYGNmiX1rJux7ZqpnfPVc12NmF0oDG8gy1Dk7yKg45Z0VHr7z9
         GgPdvn/TOTIlRULmmiHrmD4aclWlaTdX0I8G8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EisgNkCU/kIzXVzXflbDrL67S8F9Nv1dsl71OgwEiJdqMXHmQn8NtcSFiP9HtclGPc
         T+KSifUgj8tffx4cWdpSzbvUtzY3RNaoObtg6ZhqLvPUJ35Un6dfXobVQ4uPnNkYpR2G
         4OVTxnppOM7kOlFPL/P+nqANqgDmjOCTYfI/E=
Received: by 10.223.72.207 with SMTP id n15mr2652235faj.49.1296237381564;
        Fri, 28 Jan 2011 09:56:21 -0800 (PST)
Received: from burratino (adsl-69-209-75-28.dsl.chcgil.ameritech.net [69.209.75.28])
        by mx.google.com with ESMTPS id n7sm6539084fam.11.2011.01.28.09.56.19
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 28 Jan 2011 09:56:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1296233099.12855.14.camel@drew-northup.unet.maine.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165630>

Drew Northup wrote:
> On Fri, 2011-01-28 at 18:17 +0200, Felipe Contreras wrote:

>> So 'git merge' is 'git merge @{upstream}' instead of 'git merge -h';
>> it's better to do something useful.
[...]
>> --- a/builtin/merge.c
>> +++ b/builtin/merge.c
>> @@ -983,9 +983,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>>  	if (!allow_fast_forward && fast_forward_only)
>>  		die("You cannot combine --no-ff with --ff-only.");
>>  
>> -	if (!argc)
>> -		usage_with_options(builtin_merge_usage,
>> -			builtin_merge_options);
>> +	if (!argc) {
>> +		/* argv[argc] should be NULL, so we can hijack it */
>> +		argv[0] = "@{u}";
[...]
> Honestly, I'd prefer that this NOT be merged in. When I mess up the
> command line I am typing I don't want some sort of hidden magic to kick
> in--I want it to tell me that I did something stupid by printing out the
> help message.

I generally have some sympathy for that point of view (especially
given the "because we can" commit message).  In this case, can you
think of an example where one would type "git merge" without a
branchname argument and expect it to do something else?

 - Never used "git merge" before, trying it for the first time.
   In this case, I think merging from upstream is a good behavior,
   relatively consistent with "git pull".

 - In a script trying to do an octopus, in the special case of no
   extra parents.  Rough plumbing equivalent:

	set --
	git merge-recursive HEAD -- HEAD "$@"
	tree=$(git write-tree)
	git fetch . "$@" 2>/dev/null
	git fmt-merge-msg <.git/FETCH_HEAD |
	git commit-tree $tree \
		$(git merge-base --independent HEAD "$@" | sed 's/^/-p ')

   The porcelain "git fetch" is used to populate .git/FETCH_HEAD (the
   fmt-merge-msg manual doesn't explain any other way).  Maybe it
   would be better to write the log message by hand.  In any case, the
   porcelain "git fetch" defeats us --- "git fetch ." means to fetch
   the default refspec instead of no branches.

   It might be nice to have a better way to format merge messages
   (like "git fmt-merge-msg --refspec "$@"?) so we can give better
   advice to the author of the script that uses "git merge $@" and
   already breaks in the no-heads case.

 - Started typing a "git merge" command with lots of switches and
   forgot to type the branch name.  It might help to print some output
   'defaulting to branch <foo>' so the operator can notice the
   mistake.

Other nits: documentation?  tests?  The rest of cmd_merge does not
rely on argv[argc] being NULL, but it might make sense to set argv[1]
to NULL anyway for futureproofing.

Thanks.
Jonathan
