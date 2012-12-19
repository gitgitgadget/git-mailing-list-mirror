From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH v3] git-completion.bash: add support for path completion
Date: Wed, 19 Dec 2012 22:54:05 +0100
Message-ID: <50D2377D.90100@gmail.com>
References: <1355943496-5533-1-git-send-email-manlio.perillo@gmail.com> <7vzk1995mx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 22:59:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlRgC-0002S8-DI
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 22:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175Ab2LSV7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 16:59:39 -0500
Received: from mail-we0-f173.google.com ([74.125.82.173]:43142 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017Ab2LSV7i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 16:59:38 -0500
X-Greylist: delayed 313 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Dec 2012 16:59:37 EST
Received: by mail-we0-f173.google.com with SMTP id z2so1184526wey.4
        for <git@vger.kernel.org>; Wed, 19 Dec 2012 13:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=3NY8JaQTlO+S8MxxNQwWoywLMjOVRauCTYcy4ovHNZc=;
        b=Ce9esrBcme9H0Im7HCY5PTQpgB3iDXZUI/3CWviScXWVgre7iE84ONgKtAOwt1yyWh
         hb5iBZ42kqFlWTBScoku4+q3lk0r8hgOond+qSLE+x0/FxnpFeCs0YpbTyp0QJ7aXken
         ZIUiU8JK0sWKJti5c6MxjvzPGrMJZvF0OJkntr8Aq9PTtViRDTq700Us1ZmaY6kHOMTk
         AE01fmDXice7YYNqxhD7TgY58RD7p+jbEWRrVfLOOT09WsTRnMVxAJcPhRE+LIzZqcnw
         INu0h5dldtIHXPvuA8FCOuKcmXd3DJZzo7X1mgknuRMDdzPH2KHqAFZ8f5LG0+wZPMOD
         O8OA==
X-Received: by 10.194.71.244 with SMTP id y20mr5617049wju.19.1355954063080;
        Wed, 19 Dec 2012 13:54:23 -0800 (PST)
Received: from [192.168.0.3] ([151.70.213.162])
        by mx.google.com with ESMTPS id i6sm22428520wix.5.2012.12.19.13.54.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 19 Dec 2012 13:54:22 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <7vzk1995mx.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211854>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 19/12/2012 20:57, Junio C Hamano ha scritto:
> [jch: again, adding area experts to Cc]
> 
> Manlio Perillo <manlio.perillo@gmail.com> writes:
> 
>> Changes from version 2:
>>
>> 	* Perl is no more used.
>> 	* Fixed some coding style issues.
>> 	* Refactorized code, to improve future path completion support for
>> 	  the "git reset" command.
> 
> Thanks.  Will replace what was queued on 'pu'.
> 
>> +# Process path list returned by "ls-files" and "diff-index --name-only"
>> +# commands, in order to list only file names relative to a specified
>> +# directory, and append a slash to directory names.
>> +# It accepts 1 optional argument: a directory path.  The path must have
>> +# a trailing slash.
> 
> The callsites that call this function, and the way the argument is
> used, do not make it look like it is an optional argument to me.
> 
> After reading later parts of the patch, I think the callers are
> wrong (see below) and you did intend to make "$1" optional.
> 

Thanks for the corrections.
As you can see, I'm not very expert in bash programming.
I will review the code to use proper escaping and correct optional
parameters handling, based on your review.

In this case, I incorrectly assumed that bash expands ${1} to an empty
string, in case no arguments are passed to the function.

>> +__git_index_file_list_filter ()
>> +{
>> +	local path
>> +
>> +	while read -r path; do
>> +		path=${path#$1}
> 
> This will work correctly only if $1 does not have any shell
> metacharacter that removes prefix of $path that matches $1 as a
> pathname expansion pattern.  As this file is for bash completion,
> using string-oriented Bash-isms like ${#1} (to get the length of the
> prefix) and ${path:$offset} (to get substring) are perfectly fine
> way to correct it.
> 

Ok.

> Also, as $1 is optional, won't this barf if it is run under "set -u"?
>

Ok.
Here I should use ${1-}.

>> +# __git_index_files accepts 1 or 2 arguments:
>> +# 1: A string for file index status mode ("c", "m", "d", "o"), as
>> +#    supported by git ls-files command.
>> +# 2: A directory path (optional).
>> +#    If provided, only files within the specified directory are listed.
>> +#    Sub directories are never recursed.  Path must have a trailing
>> +#    slash.
>> +__git_index_files ()
>> +{
>> +	local dir="$(__gitdir)"
>> +
>> +	if [ -d "$dir" ]; then
>> +		git --git-dir="$dir" ls-files --exclude-standard "-${1}" "${2}" |
>> +			__git_index_file_list_filter ${2} | uniq
> 
> Even though everywhere else you seem to quote the variables with dq,
> but this ${2} is not written as "${2}", which looks odd.  Deliberate?
> 

No, I simply missed it.

> If you wanted to call __git_index_file_list_filter without parameter
> when the caller did not give you the optional $2, then the above is
> not the way to write it.  It would be ${2+"$2"}.

Yes, this seems the better solution.

> [...]

>> +# __git_diff_index_files accepts 1 or 2 arguments:
>> +# 1) The id of a tree object.
>> +# 2) A directory path (optional).
>> +#    If provided, only files within the specified directory are listed.
>> +#    Sub directories are never recursed.  Path must have a trailing
>> +#    slash.
>> +__git_diff_index_files ()
>> +{
>> +	local dir="$(__gitdir)"
>> +
>> +	if [ -d "$dir" ]; then
>> +		git --git-dir="$dir" diff-index --name-only "${1}" |
>> +			__git_index_file_list_filter "${2}" | uniq
> 
> This one, when the optional $2 is absent, will call __git_index_file_list_filter
> with an empty string in its "$1".  Intended, or is it also ${2+"$2"}?

No, it was not intended. But here it should probably be ${2-}.

One possible rule is:
    * ${n+"$n"} should be used by the _git_complete_xxx_file function;
    * ${n-} should be used by the _git_xxx_file functions

The alternative is for each function to use ${n-}, or {n+"$n"}.

But I'm not sure.  What is the best practice in bash for optional
parameters "propagation"?


> 
>> +# __git_complete_index_file requires 1 argument: the file index
>> +# status mode
>> +__git_complete_index_file ()
>> +{
>> +	local pfx cur_="$cur"
>> +
>> +	case "$cur_" in
>> +		?*/*)
>> +			pfx="${cur_%/*}"
>> +			cur_="${cur_##*/}"
>> +			pfx="${pfx}/"
>> +
>> +			__gitcomp_nl "$(__git_index_files ${1} ${pfx})" "$pfx" "$cur_" ""
>> +			;;
>> +		*)
>> +			__gitcomp_nl "$(__git_index_files ${1})" "" "$cur_" ""
>> +			;;
>> +	esac
> 
> Please dedent the case arms by one level, i.e.
>

I missed it.
Vim do not intent correctly this, and I forgot to dedent.


> [...]
>> +# __git_complete_diff_index_file requires 1 argument: the id of a tree
>> +# object
>> +__git_complete_diff_index_file ()
>> +{
>> +	local pfx cur_="$cur"
>> +
>> +	case "$cur_" in
>> +		?*/*)
>> +			pfx="${cur_%/*}"
>> +			cur_="${cur_##*/}"
>> +			pfx="${pfx}/"
>> +
>> +			__gitcomp_nl "$(__git_diff_index_files ${1} ${pfx})" "$pfx" "$cur_" ""
>> +			;;
>> +		*)
>> +			__gitcomp_nl "$(__git_diff_index_files ${1})" "" "$cur_" ""
>> +			;;
> 
> Unquoted $1 looks fishy, even if the only caller of this function
> always gives "HEAD" to it (in which case you can do without making
> it a parameter in the first place).
> 

Currently it is always "HEAD", but in future it may contain an arbitrary
tree-ish (for my planned "git reset" path completion support).
This is the reason why in version 3 of the patch I added this new
__git_complete_diff_index_file function.

Better to quote it.

> Unquoted ${pfx} given to __git_diff_index_files also looks fishy.

I missed it.


Thanks   Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDSN30ACgkQscQJ24LbaUQPRQCgkQaDyBeXjk5gMJsufGoe9FCe
yDkAn2M4d1xRYSkF6P0lQQmENlbYiCb8
=iml7
-----END PGP SIGNATURE-----
