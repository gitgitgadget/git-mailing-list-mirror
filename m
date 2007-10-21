From: david@lang.hm
Subject: Re: .gittattributes handling has deficiencies
Date: Sun, 21 Oct 2007 02:19:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0710210204580.4818@asgard>
References: <1192956535617-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Oct 21 11:13:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjWse-00083X-TW
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 11:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbXJUJNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 05:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbXJUJNp
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 05:13:45 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:59309
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbXJUJNo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 05:13:44 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l9L9Di3Z030746;
	Sun, 21 Oct 2007 02:13:44 -0700
X-X-Sender: dlang@asgard
In-Reply-To: <1192956535617-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61891>

On Sun, 21 Oct 2007, Steffen Prohaska wrote:

> If a .gitattributes is in the work tree and we checkout a
> different head, the .gitattributes of the head we are switching
> to must have precedence. Files are expected to be converted as
> configured in the .gitattributes that is available in the head
> we're switching to.
>
> This adds a test case revealing deficiencies of the current
> handling of .gitattributes.
>
> At a first glance, I saw two possible resolutions:
> 1) .gitattributes from the index has precedence. It's unclear
>   how merging can be handled appropriately.
> 2) .gitattributes are handled as a special file. Checkout is a
>   two pass process. In the first pass only the special file
>   .gitattributes is checked out. In th second pass the remaining
>   files are added. Maybe this gives a perspective how to handle
>   merges.
>
> But actually the issue is much harder to solve.
>
> Here is what needs to be done: Whenever the attributes of a file
> change the file must be freshly checked out according to the
> attributes of the head we switch to.

this is the same problem that we would have with the extended file 
attributes, in the discussion for those it was suggested that I refrence 
the file from the index rather then from the file system to avoid needing 
to do two passes.

> The file itself does not
> necessarily change between the two commits. A fresh checkout is
> already needed if only .gitattributes change.
>
> But this is really hard to solve. We would need to compare
> attributes before and after for _all_ files that have attributes
> in one of the two commits and check if they changed. If so, we
> need to do a fresh checkout according to the new attributes.

if you know that you will get the new .gitattributes if it changes, setup 
a post-checkout hook to checkout everything if it has changed. it's far 
from ideal, but it should be a good, safe, first approximation.

you shouldn't need to check all files of all attributes, only on any that 
match the lines that get changed. the hook for this is exactly the type of 
thing that I was talking about in the metastore thread.

> Maybe the gitattributes of a file should be part of the per-file
> flags in the index. Thus we could verify if the flags changed and
> if so, adjust the work tree accordig to the new flags.  I'm
> lacking a deeper insight into the git internals.  Therefore, I
> can't really say if the index is the right place.  But it looks
> to me as if changing an attribute should be treated similar to a
> changing sha1, as far as the work tree is concerned.

the problem with this is that each attribute ends up needing it's own 
flag, which severely limits extending things (see the discussions on file 
permissions for examples). it's also much harder to manipulate them then 
in a file.

David Lang

> So, I need some help.
>    Steffen
>
> ---
> t/t0020-crlf.sh |   23 +++++++++++++++++++++++
> 1 files changed, 23 insertions(+), 0 deletions(-)
>
> diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
> index 62bc4bb..5d7e033 100755
> --- a/t/t0020-crlf.sh
> +++ b/t/t0020-crlf.sh
> @@ -371,6 +371,29 @@ test_expect_success 'in-tree .gitattributes (4)' '
> 	}
> '
>
> +test_expect_success 'in-tree .gitattributes (5)' '
> +
> +	git reset --hard master &&
> +	echo >.gitattributes &&
> +	git add .gitattributes &&
> +	git commit -m "empty .gitattributes" &&
> +	rm -rf tmp one dir .gitattributes patch.file three &&
> +	git reset --hard master &&
> +	git checkout master^ &&
> +
> +	if remove_cr one >/dev/null
> +	then
> +		echo "Eh? one should not have CRLF"
> +		false
> +	else
> +		: happy
> +	fi &&
> +	remove_cr three >/dev/null || {
> +		echo "Eh? three should still have CRLF"
> +		false
> +	}
> +'
> +
> test_expect_success 'invalid .gitattributes (must not crash)' '
>
> 	echo "three +crlf" >>.gitattributes &&
>
