From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v8 4/4] config: allow http.<url>.* any user matching
Date: Mon, 22 Jul 2013 13:24:06 -0700
Message-ID: <DF5B20F8-33C2-4F72-A78B-97EE1FB4A522@gmail.com>
References: <3c7fc982841069ce79faf227e007815@f74d39fa044aa309eaea14b9f57fe79> <7dfaadb69accede33b88ae2d9e47a48@f74d39fa044aa309eaea14b9f57fe79> <7vehaqcw66.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 22 22:24:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1MeZ-00019H-PC
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 22:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933358Ab3GVUYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 16:24:14 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:47850 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933259Ab3GVUYL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 16:24:11 -0400
Received: by mail-pb0-f50.google.com with SMTP id wz7so7524162pbc.9
        for <git@vger.kernel.org>; Mon, 22 Jul 2013 13:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mauler;
        bh=cL4SssdEoCN+7YxSu2ZtHPDrntP6qExfDnyW0qN8DfA=;
        b=D+Qt7f+CzAidtZfcwWdeb0p5STJdrkXBlqnxQeFeH8KtzLUNUMKeq2oigubrYsvf+A
         +ONL4qqvMyTatAIoY9Zjs0LWp3eoZERoFCjA6R2Z20peirrjxrManXA1utUsluZDXblz
         U1CRA2qN3VPnJMTwQEhX5ILjJuKUt/O6s6hn+JVpDf8ok2vGotou+/j5NNT+8VG4oCgM
         Bta5mH0i4F+biNrlDf09pKKaR9gk4K+cjWyaVFs/WcztLjZhEimaGYLgTD43MGHzeTdR
         V6D6nz2PsbK9LG5pt2e0g+CYqAt5Jd9BeJtSaQ5Z5oy3WYCryc+L9LVmMNiRBlYPTnrq
         vo2w==
X-Received: by 10.66.7.164 with SMTP id k4mr33355990paa.142.1374524650548;
        Mon, 22 Jul 2013 13:24:10 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id we2sm41000010pab.0.2013.07.22.13.24.08
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 22 Jul 2013 13:24:09 -0700 (PDT)
In-Reply-To: <7vehaqcw66.fsf@alter.siamese.dyndns.org>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230989>

On Jul 22, 2013, at 11:00, Junio C Hamano wrote:
> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index e461f32..c418adf 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -1517,15 +1517,26 @@ http.<url>.*::
>> 	Any of the http.* options above can be applied selectively to some  
>> urls.
>> 	For example "http.https://example.com.useragent" would set the user
>> 	agent only for https connections to example.com.  The <url> value
>> +	matches a url if it refers to the same scheme, host and port and  
>> the
>> +	path portion is an exact match or a prefix that matches at a "/"
>> +	boundary.  If <url> does not include a user name, it will match a  
>> url
>> +	with any username otherwise the user name must match as well (the
>> +	password part, if present in the url, is always ignored).  Longer  
>> <url>
>> +	path matches take precedence over shorter matches no matter what  
>> order
>> +	they occur in.  For example, if both "https://user@example.com/ 
>> path" and
>> +	"https://example.com/path/name" are used as a config <url> value  
>> and
>> +	then "https://user@example.com/path/name/here" is passed to a git
>> +	command, the settings in the "https://example.com/path/name"  
>> section
>> +	will be preferred because that <url> has a longer path length  
>> match than
>> +	"https://user@example.com/path" even though the latter did match  
>> the
>> +	user.  For same length matches, the last one wins except that a  
>> same
>> +	length <url> match that includes a user name will be preferred  
>> over a
>> +	same length <url> match that does not.  The urls are normalized  
>> before
>> +	matching so that equivalent urls that are simply spelled  
>> differently
>> +	will match properly.  Environment variable settings always  
>> override any
>> +	matches.  The urls that are matched against are those given  
>> directly to
>> +	git commands.  This means any urls visited as a result of a  
>> redirection
>> +	do not participate in matching.
>
> A solid wall of text is somewhat hard to read, so I'd queue the
> equivalent of the following "git diff -w" output on top.

Can I send out the change as a 'fixup!' patch?  Or do I need to send a  
new v9 patch series with the documentation update?

> I also was
> trying to see if we can clarify the "length comparison" only refers
> to the length of the path part, excluding the length of "user@"
> (i.e. when comparing "https://user@example.com/path" with
> "https://example.com/path", they are of the same length), which you
> can see in the first three lines below.
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index c418adf..635ed5d 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1521,9 +1521,11 @@ http.<url>.*::
> 	path portion is an exact match or a prefix that matches at a "/"
> 	boundary.  If <url> does not include a user name, it will match a url
> 	with any username otherwise the user name must match as well (the
> -	password part, if present in the url, is always ignored).  Longer  
> <url>
> -	path matches take precedence over shorter matches no matter what  
> order
> -	they occur in.  For example, if both "https://user@example.com/ 
> path" and
> +	password part, if present in the url, is always ignored).  A <url>
> +	with longer path matches take precedence over shorter matches no  
> matter
> +	what order they occur in the configuration file.
> ++
> +For example, if both "https://user@example.com/path" and
> "https://example.com/path/name" are used as a config <url> value and
> then "https://user@example.com/path/name/here" is passed to a git
> command, the settings in the "https://example.com/path/name" section

OK.

> I am not yet convinced that the precedence rule specified in this
> what we want (I do not have an example why it is *not* what we want,
> either).  Another definition could be "if user@ is present in the
> request, give lower precedence to config entries for the site
> without user@ than entries with user@", and I do not have a strong
> opinion myself which one between the two is better (and there may be
> third and other possible rule).
>
> Comments?

Consider this site:

example.com/
example.com/dir
example.com/dir/sub
example.com/dir/sub/public

Suppose I want to configure a particular key for example.com/dir/sub  
for a particular user, say "contractor".

I can configure:

[http "https://contractor@example.com/dir/sub"]
   sslkey=contractor_key

But then I want to configure a completely different key for the public  
area example.com/dir/sub/public no matter what user.  I just add this:

[http "https://example.com/dir/sub/public"]
   sslkey=public_key

But if entries with usernames take precedence it won't work.  The only  
way to do it is to list every possible user for "example.com/dir1/sub1/ 
public" in its own new section and then continue to add a new config  
section every time a new user name is encountered.

Conversely, if a special key is supposed to be used for the user  
"contractor" everywhere on the site at or below "example.com/dir/sub",  
then the above configuration doesn't work unless user matches take  
precedence.  With the current code, one additional entry would have to  
be added like so:

[http "https://contractor@example.com/dir/sub/public"]
   sslkey=contractor_key

So my thinking was that having user matches take precedence over path  
length matches can result in endless additions to the config file  
(because you have to list all the other users to override a sub area  
and that could be a large list) whereas having path length matches  
take precedence over user matches will only result in a few, finite  
additions to the config file (the number of already-configured items  
with a longer path).
