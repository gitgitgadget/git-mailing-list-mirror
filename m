From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH 1/3] git-submodule - Follow top-level remote on init/update/clone
Date: Mon, 11 Feb 2008 20:00:18 -0500
Message-ID: <47B0EFA2.9070903@gmail.com>
References: <1202576245-284-1-git-send-email-mlevedahl@gmail.com> <alpine.LSU.1.00.0802112152050.3870@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 12 02:01:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOjWL-0003Tu-B9
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 02:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbYBLBA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 20:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbYBLBA0
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 20:00:26 -0500
Received: from wr-out-0506.google.com ([64.233.184.239]:7074 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835AbYBLBAX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 20:00:23 -0500
Received: by wr-out-0506.google.com with SMTP id c48so4297673wra.23
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 17:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=5CHOb6Z34h7fMeyhx6fvut853sb/8I8TtyjP4RvI3yc=;
        b=m2dzdcx3qjBd2MMd9qbvgFgNy6TWbOyfg1+0nvOwFCrlcl8k0FSfPQXQ6XpWPuefyGVI4hfphajt1uewmHSGZwX/LPUNDudWeLmgDI4Ht0HBNPv5UnnizMaWcGEFCDAlpPgXPwq2PKv2C1j+YQvvka7zlt40yaK/gWoGDzJYN4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=n81iLHWjGN8yAQtW8g2manSy2whCtzZuDNls5coEC0Z3ldXoWJQE8rR2UTBtD7GwH45l6B7Rm91crgQl03xi65oNxAwWgCudUyqOWZ/TeXVC2022CXkxqAa1eQeBxctM/VzraMfUWMTOKKUB0Y8O1uJUQ74rIGitF73EC7S78JM=
Received: by 10.142.216.9 with SMTP id o9mr559515wfg.173.1202778021517;
        Mon, 11 Feb 2008 17:00:21 -0800 (PST)
Received: from ?192.168.1.117? ( [71.163.29.241])
        by mx.google.com with ESMTPS id i38sm2530704wxd.16.2008.02.11.17.00.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 Feb 2008 17:00:20 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <alpine.LSU.1.00.0802112152050.3870@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73615>

Johannes Schindelin wrote:
>> @@ -40,11 +42,13 @@ get_repo_base() {
>>  # Resolve relative url by appending to parent's url
>>  resolve_relative_url ()
>>  {
>> -	branch="$(git symbolic-ref HEAD 2>/dev/null)"
>> -	remote="$(git config branch.${branch#refs/heads/}.remote)"
>> -	remote="${remote:-origin}"
>> -	remoteurl="$(git config remote.$remote.url)" ||
>> -		die "remote ($remote) does not have a url in .git/config"
>>     
>
> I did not really look at this code before, but does that not mean that 
> git-submodule does already what you want?
>
> Because usually, you clone the superproject from the URL that you actually 
> want to use, and in that case, the initial branch's default remote will 
> have exactly that URL.
>
> So I have to admit that I do not see the reason why you remove that code, 
> replace it with another (that I think does the same), and claim that you 
> introduce that behaviour.
>
>   
There were three changes:
1) Eliminate die() in a subshell - it doesn't work. Instead, must have a 
return code and pass that up to top-level shell before exit can be done.
2) Eliminated duplication of get_default_remote(), instead using the 
definition in git-parse-remote.
Suggestions? (Separate patches, don't do 2)?
3) Use the user specified $remote if given.

>> @@ -107,7 +112,7 @@ module_clone()
>>  	test -e "$path" &&
>>  	die "A file already exist at path '$path'"
>>  
>> -	git-clone -n "$url" "$path" ||
>> +	git-clone -n -o "$remote" "$url" "$path" ||
>>  	die "Clone of '$url' into submodule path '$path' failed"
>>  }
>>  
>>     
>
> If you do _that_, you will _force_ the submodule to have no "origin" 
> remote.  As discussed _at length_, this is not what you should do.  The 
> only reason to use "-o <other-nick-name>" is if you plan _not_ to use the 
> same URL for the default remote.
>   
This *must* define the remote using the same name as flowed down from 
top-level, whatever that name is. Otherwise, subsequent fetch / update 
following top-level just won't work. Consider if top-level 
branch.<name>.remote = frotz and we define not frotz but origin in the 
submodule. Later, on different branch, top-level branch.<name>.remote  = 
origin. The submodule has origin defined but it points to a server 
different than top-level's origin. Now what?

The same holds true if user gave -r frotz: ignoring that and defining 
origin instead is an outright bug.

>
> Why do you need the "realremote" here?  Why is "$remote" not enough?
>   
Good catch - there was a reason in an earlier version of this, no longer 
relevant.
>   
>> @@ -235,7 +259,7 @@ cmd_init()
>>  		# Possibly a url relative to parent
>>  		case "$url" in
>>  		./*|../*)
>> -			url="$(resolve_relative_url "$url")"
>> +			url=$(resolve_relative_url "$url") || exit 1
>>     
>
> Yes for the "|| exit 1".  No for the removal of the quotes: keep in mind: 
> you are possibly getting a url from the _config_, which is supposed to be 
> user-editable.
>   
Works fine as is (You need the quotes when using the variable, not when 
defining it):

git>git config foo.name "some string
 > with cr"
git>z=$(git config foo.name)
git>echo "$z"
some string
with cr

As written, the old code had the perverse effect of *not* quoting $url, 
and that was the part that needed to be quoted.

>> @@ -274,6 +308,7 @@ cmd_update()
>>  		shift
>>  	done
>>  
>> +	remote=${remote:-$(get_default_remote)}
>>     
>
> You have this paradigm so often, but AFAICS you only use it for the call 
> to module_clone.  Why not let module_clone figure it out, if $remote is 
> empty?
>
>   
Will do.
>> @@ -298,9 +333,24 @@ cmd_update()
>>  			die "Unable to find current revision in submodule path '$path'"
>>     
> Wasn't the whole _point_ of having a two-stage init/update that you could 
> _change_ the remote in the config?
>
> Now you override those settings if .gitmodules says that the path is 
> relative?  Shouldn't you respect the setting in the config (which the user 
> can change freely), rather than .gitmodules (which the user cannot change 
> without either committing it or having a permanently dirty working 
> directory)?
>   
Ok, I was trying to avoid defining another config variable. The 
"relativeness" of a submodule is not knowable from  submodule.<path>.url 
as that is always absolute (if relative in .gitmodules, it is resolved 
into an absolute url during git init). I see two choices:
    1) define variable  submodule.<path>.isrelative during init, and use 
that instead. The user would have to modify that and the url to override.
    2) always resolve the relative url from .gitmodules, compare with 
submodule.<path>.url and decide it was relative if those two agree. More 
overhead, enough complexity that I fear for strange failure modes later on.

Any preferences or other suggestions?

Mark
