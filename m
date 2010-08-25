From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/2] builtin/fetch.c: ignore merge config when not fetching
 from branch's remote
Date: Wed, 25 Aug 2010 16:41:02 -0500
Message-ID: <TDHEkC5Y5b2p-yjw_5mixlQb49a7TMinj2d5CgfEHHH9Dq6lNFV7dQ@cipher.nrlssc.navy.mil>
References: <pzml8liT3RErVlMrdxbSkHmhBs1RMvwYma9UXgvG6WY@cipher.nrlssc.navy.mil> <O7UxM6KEqdDAhjJAF7ODSlo_kZavb8gBCJ6laH3QPOlG9a1q29koMQOkS7wDMj0BpyrLYfAcEh4@cipher.nrlssc.navy.mil> <20100825211641.GC2319@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, galak@kernel.crashing.org,
	Brandon Casey <drafnel@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 23:41:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoNjF-0003Zj-U5
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 23:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953Ab0HYVlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 17:41:50 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:51506 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab0HYVls (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 17:41:48 -0400
Received: by mail.nrlssc.navy.mil id o7PLf26a030987; Wed, 25 Aug 2010 16:41:02 -0500
In-Reply-To: <20100825211641.GC2319@burratino>
X-OriginalArrivalTime: 25 Aug 2010 21:41:02.0427 (UTC) FILETIME=[36C012B0:01CB449E]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154480>

On 08/25/2010 04:16 PM, Jonathan Nieder wrote:
> Brandon Casey wrote:
> 
>> If the argument to fetch does not specify a named remote, or if the name
>> supplied does not match the remote configured for the current branch, then
>> the current branch's merge configuration should not be considered.
> 
> Thanks for a fix.
> 
>> +++ b/builtin/fetch.c
>> @@ -146,7 +146,8 @@ static struct ref *get_ref_map(struct transport *transport,
>>  		struct remote *remote = transport->remote;
>>  		struct branch *branch = branch_get(NULL);
>>  		int has_merge = branch_has_merge_config(branch);
>> -		if (remote && (remote->fetch_refspec_nr || has_merge)) {
>> +		if (remote && (remote->fetch_refspec_nr || (has_merge &&
>> +				!strcmp(branch->remote_name, remote->name)))) {
> 
> What will happen with this (invalid) branch?
> 
> 	[branch "tmp"]
> 		merge = refs/heads/tmp

The same thing that would have happened before, since a few lines
further down there is this:

   if (has_merge &&
       !strcmp(branch->remote_name, remote->name))
           add_merge_config(&ref_map, remote_refs, branch, &tail);

I didn't trace branch_get() to check whether it returns an object
with remote_name initialized in all cases.  I relied on the form
of the existing code.  Perhaps it's worth investigating.  If something
needs to be fixed, then it was already broken and deserves a separate
patch anyway.

-Brandon
