From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH 2/2] mergetool: fix running mergetool in sub-directories
Date: Mon, 02 Feb 2009 23:19:04 +0000
Message-ID: <49877F68.30509@hashpling.org>
References: <1233357611-31820-1-git-send-email-charles@hashpling.org> <1233357611-31820-2-git-send-email-charles@hashpling.org> <7v63jv0wn6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?Jonas_Flod=E9n?= <jonas.floden@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 00:20:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU85y-00007L-Mg
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 00:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753833AbZBBXTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 18:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753543AbZBBXTW
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 18:19:22 -0500
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:21644 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753271AbZBBXTV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Feb 2009 18:19:21 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAKsOh0nUnw4R/2dsb2JhbADNGIQUBg
Received: from pih-relay04.plus.net ([212.159.14.17])
  by relay.ptn-ipout02.plus.net with ESMTP; 02 Feb 2009 23:19:10 +0000
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay04.plus.net with esmtp (Exim) id 1LU84M-0007gN-Gd; Mon, 02 Feb 2009 23:19:10 +0000
Received: from [192.168.76.29] (heisenberg2.hashpling.org [192.168.76.29])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n12NJ4Kg013723;
	Mon, 2 Feb 2009 23:19:04 GMT
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <7v63jv0wn6.fsf@gitster.siamese.dyndns.org>
X-Plusnet-Relay: 1d077c308bb438462d2f122fa3fc2d8a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108134>

Junio C Hamano wrote:
> Charles Bailey <charles@hashpling.org> writes:
> 
>> diff --git a/git-mergetool.sh b/git-mergetool.sh
>> index aefdca7..87fa88a 100755
>> --- a/git-mergetool.sh
>> +++ b/git-mergetool.sh
>> @@ -13,7 +13,6 @@ SUBDIRECTORY_OK=Yes
>>  OPTIONS_SPEC=
>>  . git-sh-setup
>>  require_work_tree
>> -prefix=$(git rev-parse --show-prefix)
>>  
>>  # Returns true if the mode reflects a symlink
>>  is_symlink () {
>> @@ -131,7 +130,7 @@ checkout_staged_file () {
>>      tmpfile=$(expr "$(git checkout-index --temp --stage="$1" "$2")" : '\([^	]*\)	')
>>  
>>      if test $? -eq 0 -a -n "$tmpfile" ; then
>> -	mv -- "$tmpfile" "$3"
>> +	mv -- "$(git rev-parse --show-cdup)$tmpfile" "$3"
>>      fi
>>  }
> 
> Looking at the above change together with this disabled patch in the previous,
> 
>> +# We can't merge files from parent directories when running mergetool
>> +# from a subdir. Is this a bug?
>> +#
> 
> I wonder if it would be cleaner to keep $prefix and instead cd_to_toplevel
> at the beginning.
> 
> There are two ways for Porcelain scripts to work from inside a
> subdirectory of a project.
> 
>  * Stay in the original subdirectory and use show-cdup to convert a path
>    that is relative to the repository root to a path relative to your
>    current subdirectory.
> 
>  * Go up to the root of the work tree, use prefix to convert a path that
>    is relative to the original subdirectory to a path relative to the root
>    of the work tree.
> 
> The former way is probably the clunkier one between the two.  I think the
> latter is how most of the Porcelain scripts work when they need to worry
> about the Plumbing commands that return/accept repository relative paths.
> Also, all the plumbing commands work in the latter way.

Possibly, and I certainly wouldn't object if mergetool moved to the
latter mode of operation in the medium term.

In general, though, mergetool is pretty happy running from the users
directory and there may be cases in which users expect the merge tool to
be running from the directory that they started in (saving extra files
during the merge process?).

At the moment it is really a 'bugette' in the eyes of mergetool that
checkout-index echoes the name of the temporary file relative to the
repository root even if you called it from somewhere else. Without this,
mergetool doesn't require any prefix wizardry at all.

When I said 'is this a bug?', the counter argument is that it might be
considered a more useful feature that cd'ing into a subdirectory and
running mergetool restricts the files merged to an expected subset.

I meant to put in a cover note about the test changes. The reason that I
commented out the test_expect_failure was that I thought it not
completely obvious that it even counted as a failure rather than a
feature - certainly not one worth adding one to git's overall 'broken'
count - but that there might be some alternative opinions.

The pu patch is certainly necessary on top of the cat-file ->
checkout-index change in next and it is better tested now. It's
certainly not the last word on mergetool.

Charles.
