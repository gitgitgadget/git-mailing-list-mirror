From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fw: git-core: SIGSEGV during {peek,ls}-remote on HTTP remotes.
Date: Sun, 01 Nov 2009 12:15:55 -0800
Message-ID: <7vljiqxapw.fsf@alter.siamese.dyndns.org>
References: <20091101.010702.527849118592864646._deepfire@feelingofgreen.ru>
 <7v8weq50pm.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0911011348190.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Samium Gromoff <_deepfire@feelingofgreen.ru>,
	git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>,
	Mike Hommey <mh@glandium.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Nov 01 21:16:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4gqa-0006mG-Ms
	for gcvg-git-2@lo.gmane.org; Sun, 01 Nov 2009 21:16:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343AbZKAUQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2009 15:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753323AbZKAUQI
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 15:16:08 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55334 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbZKAUQH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2009 15:16:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1983C6F4D2;
	Sun,  1 Nov 2009 15:16:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tWZS4bsZwXSYyhL8WdJ/1pTu0j8=; b=fUzPCs
	avTuu9BXEQQN2MaUAx/VtD+OtAFEUY9BYPxH1RFVCwcQduRN+OE81zrG0xcXMUu0
	QdQh9MOka3mADEVp0E5UczW580MMyqX5DZQ3r9YjOZ/gaMDa/jrg0IHpmy1d/vRQ
	2cD0zj2IrkWqoV/IuDJwNClRJ2mSmKfkA9RZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lu3H+iJSJdIzBTCYsE2LoL7/kpu8OIAi
	7h6ysowHwVqyZNa5YINW71hgwRF8gOKUdO9Xqjh72syz61Hii0CtBxocqzxD7mZX
	0lNdl5eEHZmVkwhdatFxyIuYl5ReJWmepkVJR0VxFwxxX4IXO+LsVvBAOvQLcEvd
	+Jr/4X908pA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B20796F4CE;
	Sun,  1 Nov 2009 15:16:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 538856F4C8; Sun,  1 Nov
 2009 15:15:56 -0500 (EST)
In-Reply-To: <alpine.LNX.2.00.0911011348190.14365@iabervon.org> (Daniel
 Barkalow's message of "Sun\, 1 Nov 2009 14\:43\:34 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 62703D7A-C723-11DE-9290-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131876>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Sat, 31 Oct 2009, Junio C Hamano wrote:
> ...
>> Attached is a minimum fix/work around, but this is done without being very
>> familiar with the current assumptions in the codepaths involved.
>> 
>> Issues I want area experts to consider before coming up with the final fix
>> are:
>> ... 
> I think there's no benefit to allowing NULL for the remote; I think you 
> can always get a struct remote for what you want to access. So it's 
> probably just as well to require it, particularly because, as in the case 
> of cmd_ls_remote() below, you'd need a special case to not get a struct 
> remote.
>
> Is there any way in which the intended semantics of "transport_get(NULL, 
> url)" is not the same as "transport_get(remote_get(url), url)"?
> (And, in the extended series, I make "transport_get(remote_get(url), 
> NULL)" also mean the same thing as above, while "transport_get(NULL, 
> NULL)" is obviously underspecified.)

That was really my question to people who are involved in the transport
layer code.  I didn't know how transport->url and transport->remote->url
are intended to relate to each other, for example, and that was why you
were on Cc list.  In other words, you are the area expert, you tell me ;-)

Sverre seemed to think slightly differently; perhaps having worked on the
foreign vcs interface he has some other input.

>>  - When helping to handle ls-remote request, there is no need for the
>>    helper to know anything about the local state.  We probably shouldn't
>>    even run setup_git_directory_gently() at all in this case.  But when
>>    helping other kinds of request, the helper does need to know where our
>>    repository is.
>> 
>>    In general, what should the initial environment for helpers be?  Should
>>    they assume that they have to figure out where the git repository is
>>    themselves (in other words, should they assume they cannot rely on
>>    anything the caller does before they are called?  Would the caller
>>    generally have done the usual repo discovery (including chdir() to the
>>    toplevel), and there are some set of assumptions they can make?  If so
>>    what are they?
>
> Probably, the helper should be run with a predicable initial environment, 
> simply because operations that use remote repositories are most often run 
> from the toplevel of a repo, so people will fail to notice their bugs 
> which trigger on running from subdirectories....
> Perhaps we should actively tell the helper if there is no git repository 
> (or, if any git repository we happen to be in is merely coincidental and 
> shouldn't affect the helper)? Helpers involving importing will probably 
> want to know they don't have a private refs namespace, private state 
> directory, etc. even for implementing "list" for ls-remote, and it would 
> probably be best to require helper authors to report that they've 
> considered this possibility before trying to use it.

I think that is a sane approach.

>> diff --git a/builtin-ls-remote.c b/builtin-ls-remote.c
>> index 78a88f7..a8d5613 100644
>> --- a/builtin-ls-remote.c
>> +++ b/builtin-ls-remote.c
>> @@ -86,7 +86,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>>  			pattern[j - i] = p;
>>  		}
>>  	}
>> -	remote = nongit ? NULL : remote_get(dest);
>> +	remote = remote_get(dest);
>>  	if (remote && !remote->url_nr)
>>  		die("remote %s has no configured URL", dest);
>>  	transport = transport_get(remote, remote ? remote->url[0] : dest);
>
> You can also drop the two checks for remote being non-NULL here, since 
> it's now always non-NULL...

You are probably right; I didn't even look when I did the above.

>> diff --git a/remote-curl.c b/remote-curl.c
>> index ad6a163..7c83f77 100644
>> --- a/remote-curl.c
>> +++ b/remote-curl.c
>> @@ -81,8 +81,9 @@ int main(int argc, const char **argv)
>>  	struct strbuf buf = STRBUF_INIT;
>>  	const char *url;
>>  	struct walker *walker = NULL;
>> +	int nongit = 0;
>>  
>> -	setup_git_directory();
>> +	setup_git_directory_gently(&nongit);
>>  	if (argc < 2) {
>>  		fprintf(stderr, "Remote needed\n");
>>  		return 1;
>
> Do things like git_path() fail cleanly if there was no git directory?  If
> not, there should probably be tests of nongit on paths that actually need 
> a git directory,...

I don't know.  Again, you tell me ;-)

It probably makes sesne as you outlined in the earlier part of your
response for the caller to give a bit more clue to the helper to help
making such a decision.
