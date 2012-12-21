From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH v4] git-completion.bash: add support for path completion
Date: Fri, 21 Dec 2012 20:02:21 +0100
Message-ID: <50D4B23D.2030507@gmail.com>
References: <1356108872-5881-1-git-send-email-manlio.perillo@gmail.com> <7vmwx71e2y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, szeder@ira.uka.de, felipe.contreras@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 20:02:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm7rp-0007Ff-Kr
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 20:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095Ab2LUTC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 14:02:28 -0500
Received: from mail-ee0-f41.google.com ([74.125.83.41]:53696 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008Ab2LUTC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 14:02:26 -0500
Received: by mail-ee0-f41.google.com with SMTP id d41so2672634eek.0
        for <git@vger.kernel.org>; Fri, 21 Dec 2012 11:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=SyeQz1soEgUSHavmDMtwus6jv2RZ0BixCwzlIoLsV8M=;
        b=ZomsxAuqL+lKr4khpnZsyXmKo1K++awirCx1ZfJiHtaMLZj8pVJRn49bEsHMPxOWea
         5qWaN1tznNnGw3UWK2CLiAlfll/tonpxkSOmdg+UEldQeBqdJX53UTlWW9EMcGdBbnk1
         NK+TCzgNdA3vJZ4bgaxqmYqMPmgRN7flTjd7pbXc5ckISgi8TMBxuS6nGN7bmnQXyVQA
         uYG3ethQUCTxwq1huvUvVHIVYn78FzpgbceDCzlcOhtaehcuyiyPFM76NdFfZOT5JlE8
         UgQI6hRfxqlsmrTfBYh025uw9EuI9hY+0+SRT0JuRDR32+dY0rCbGmXpv/YC8MTPpDZQ
         t7VA==
X-Received: by 10.14.194.4 with SMTP id l4mr33942813een.42.1356116544745;
        Fri, 21 Dec 2012 11:02:24 -0800 (PST)
Received: from [192.168.0.3] ([151.70.200.154])
        by mx.google.com with ESMTPS id 6sm23313260eea.3.2012.12.21.11.02.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Dec 2012 11:02:24 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <7vmwx71e2y.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212003>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 21/12/2012 18:59, Junio C Hamano ha scritto:
> Manlio Perillo <manlio.perillo@gmail.com> writes:
> 
>> +		case "$path" in
>> +		?*/*) echo "${path%%/*}/" ;;
>> +		*) echo $path ;;
> 
> $path unquoted???
> 

Missed again, thanks.
I hope this is really the last one!

> [...]
>> +__git_index_files ()
>> +{
>> +	local dir="$(__gitdir)"
>> +
>> +	if [ -d "$dir" ]; then
>> +		# NOTE: $1 is not quoted in order to support multiple options
> 
> Good thinking to document this.  Thanks.
> 
> I take it that $1 never comes from the end user and it is known that
> it is correct to split them at $IFS?  That is the way I read callers
> of this function in this patch, but I am just double-checking.
> 

Yes, $1 is always set internally (but I will check again)
Probably there are better solutions.


>> @@ -998,7 +1093,13 @@ _git_commit ()
>>  			"
>>  		return
>>  	esac
>> -	COMPREPLY=()
>> +
>> +	if git rev-parse --verify --quiet HEAD 1>/dev/null; then
> 
> s/1>/>/;
> 

What is the reason?
Coding style?

>> +		__git_complete_diff_index_file "HEAD"
> 
> As this runs "git diff-index" without --cached, 
> 
> The completion will give only for paths that have difference between
> the working tree and the HEAD.  If the user has a bogus contents
> that was "git add"ed earlier, (i.e. the index is different from
> HEAD), then realizes the mistake and fixes it in the working tree
> with his editor to match "HEAD" (i.e. the working tree is the same
> as HEAD):
> 
> 	git commit the-prefix-to-that-file<TAB>
> 
> to complete the filename will not give that file.  I do not think it
> is a show-stopper, but it may puzzle the users when they encounter
> the situation.
> 

Umh, I just checked this case.

  0) git init test
  1) Added a README file with "Hello World.", and committed.
  2) Modified the README file with "Hello World!" and executed
     git add README
  3) Modified the README file with "Hello World." (the original content)
  4) $ git diff HEAD:README README
     $ git diff-index --name-only HEAD
     README

     git commit <TAB> shows the README file.

If I understand correctly the documentation of diff-index, it will
always compare the content of the index with HEAD.
If --cached is specified, it will ignore the stat state of the file on disk.


> I am wondering if reading from "git status --porcelain" might be a
> better alternative, or if it is too much trouble and slow things
> down to cover such a corner case.
> 

It have considered it.

The problem is that the output of "git status --porcelain" is not
trivial to parse.


>> @@ -1362,7 +1464,14 @@ _git_mv ()
>>  		return
>>  		;;
>>  	esac
>> -	COMPREPLY=()
>> +
>> +	if [ $cword -gt 2 ]; then
>> +		# We need to show both cached and untracked files (including
>> +		# empty directories) since this may not be the last argument.
>> +		__git_complete_index_file "--cached --others --directory"
>> +	else
>> +		__git_complete_index_file "--cached"
>> +	fi
> 
> Is $cword affected by the presense of "-f" in "git mv [-f] foo bar"?
> Just being curious.
> 

Yes, it is affected; I missed it, thanks.
It should count only non-option arguments.


> Other than that, I do not see anything majorly wrong from the coding
> and semantics point of view in the patch.  As to the interaction
> with the rest of the completion machinery, I'll leave the review to
> the area experts CC'ed and wait for their comments.
> 
> Thanks.
> 

Thanks for your review.


Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDUsjwACgkQscQJ24LbaUSGuwCffon7/VGFo98CCBsZlmOdNYYE
91oAn3X8fbr5jtzMUOZkMp9CuGWCa7Cf
=Qzsv
-----END PGP SIGNATURE-----
