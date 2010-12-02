From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 2/2] Use the new functions to get the current cword.
Date: Thu, 2 Dec 2010 01:45:04 -0600
Message-ID: <20101202074504.GA1771@burratino>
References: <1291236582-28603-1-git-send-email-peter@avirtualhome.com>
 <1291236582-28603-3-git-send-email-peter@avirtualhome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Peter van der Does <peter@avirtualhome.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 08:45:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO3r3-00043Q-0u
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 08:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614Ab0LBHpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 02:45:18 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33826 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab0LBHpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 02:45:16 -0500
Received: by gwj20 with SMTP id 20so3934563gwj.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 23:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=POwykGpY1BmOLipnpP5oGNDcPz0B30c+aJ/lJU3D2PA=;
        b=kejgCBD8dMNzHsMx9BpPS8vPIgcaQkSsWEkUvpo5isIN7d9Meqy9o0peF3HfC8aXQA
         QOOfzn7XCdfB0Fd6aAwXDmt16tLZtsL3EvXDPGTqkpCUeHy00uaolZ8mdY8ThPTzfJCt
         0n0QNWO9MTAlI2lA+fn5yL0jGGSXyWCa4Ehkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=aFivu5Tp+izQRSjGY4DFYgDUQQOFCj0JeqLHLRfBeRZK3Z5bzELfezYimPWmNwHvwB
         QLcGQNwBIHH6iO5DC4C6lPcOiK5URL+YshvVXoV2WB/7+qtJMIlSCDR286Qa/64izsb3
         Lo0UeQ4RbE5RFKe0g+/6bV1g0pgd0FNgA7T9U=
Received: by 10.151.109.4 with SMTP id l4mr868816ybm.293.1291275916068;
        Wed, 01 Dec 2010 23:45:16 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id v9sm2284002ybe.9.2010.12.01.23.45.13
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 23:45:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291236582-28603-3-git-send-email-peter@avirtualhome.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162681>

Hi Peter,

Peter van der Does wrote:

> Change the completion functions to use the newly introduced functions to
> get the current and/or previous cword and to reassemble the COMP_CWORDS,
> making sure the options are correctly split.

Some comments.  Please don't reroll until discussion has quieted down
(though thoughts and incremental patches would always be welcome, of
course).

> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -554,7 +554,8 @@ __gitcomp_1 ()
>  # generates completion reply with compgen
>  __gitcomp ()
>  {
> -	local cur="${COMP_WORDS[COMP_CWORD]}"
> +	local cur
> +	_get_comp_words_by_ref -n "=" cur

To save the reader some time: this excludes '=' from word-breaking
characters, so $cur will include an = when appropriate.  IIUC that is
precisely the behavior that bash 4 changed.

Perhaps that is worth explaining in the commit message in the next
round?

> @@ -615,7 +616,8 @@ __git_tags ()
>  __git_refs ()
>  {
>  	local i is_hash=y dir="$(__gitdir "${1-}")" track="${2-}"
> -	local cur="${COMP_WORDS[COMP_CWORD]}" format refs
> +	local cur format refs
> +	_get_comp_words_by_ref cur

This does not exclude '=' from word-breaking characters.  Would that
break completion of

	git update-ref refs/topics/foo=bar HEAD
	git checkout refs/topics/foo=<tab><tab>

?

> @@ -729,7 +731,8 @@ __git_compute_merge_strategies ()
>  
>  __git_complete_file ()
>  {
> -	local pfx ls ref cur="${COMP_WORDS[COMP_CWORD]}"
> +	local pfx ls ref cur
> +	_get_comp_words_by_ref -n ":" cur

This treats '=' as a word-breaking character but not ':'.  Is that
the right behavior?

> @@ -777,7 +780,8 @@ __git_complete_file ()
>  
>  __git_complete_revlist ()
>  {
> -	local pfx cur="${COMP_WORDS[COMP_CWORD]}"
> +	local pfx cur
> +	_get_comp_words_by_ref cur

'=' and ':' are word-breakers.

> @@ -797,11 +801,13 @@ __git_complete_revlist ()
>  
>  __git_complete_remote_or_refspec ()
>  {
> -	local cmd="${COMP_WORDS[1]}"
> -	local cur="${COMP_WORDS[COMP_CWORD]}"
> +	local cur words cword
> +	_get_comp_words_by_ref -n ":" cur words cword
> +	local cmd="${words[1]}"

'=' is a word-breaker, ':' not.

> @@ -869,13 +875,15 @@ __git_complete_remote_or_refspec ()
>  
>  __git_complete_strategy ()
>  {
> +	local cur prev
> +	_get_comp_words_by_ref -n "=" cur prev

'=' is not a wordbreaker, so --strategy= can be completed correctly.

> @@ -1048,10 +1056,11 @@ __git_aliased_command ()
>  # __git_find_on_cmdline requires 1 argument
>  __git_find_on_cmdline ()
>  {
> -	local word subcommand c=1
> +	local word subcommand c=1 words cword
>  
> -	while [ $c -lt $COMP_CWORD ]; do
> -		word="${COMP_WORDS[c]}"
> +	_get_comp_words_by_ref words cword

':' and '=' are word-breakers when completing subcommand names.

> @@ -1064,9 +1073,10 @@ __git_find_on_cmdline ()
>  
>  __git_has_doubledash ()
>  {
> -	local c=1
> -	while [ $c -lt $COMP_CWORD ]; do
> -		if [ "--" = "${COMP_WORDS[c]}" ]; then
> +	local c=1, words cword

Extra comma.

> +	_get_comp_words_by_ref words cword

':' and '=' are word-breakers when looking for "--".

[etc]

So in general, it seems that : and = are treated as word-breakers
after this change much more often than git itself would treat them
as such.  Is that intentional?  What rule is used to choose -n
arguments?
