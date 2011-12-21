From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: Re* How to generate pull-request with info of signed tag
Date: Wed, 21 Dec 2011 12:00:03 +0530
Message-ID: <87liq6xwr8.fsf@linux.vnet.ibm.com>
References: <874nx1korf.fsf@linux.vnet.ibm.com> <7vbor8jw0h.fsf@alter.siamese.dyndns.org> <871us3l45o.fsf@linux.vnet.ibm.com> <7viplfdlpb.fsf@alter.siamese.dyndns.org> <87iplch79e.fsf@linux.vnet.ibm.com> <7vobv4mj4r.fsf@alter.siamese.dyndns.org> <7vk45smilc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 21 07:30:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdFgx-0006Gl-JO
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 07:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807Ab1LUGaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 01:30:14 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:56043 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751403Ab1LUGaN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 01:30:13 -0500
Received: from /spool/local
	by e3.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <git@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
	Wed, 21 Dec 2011 01:30:12 -0500
Received: from d01relay04.pok.ibm.com (9.56.227.236)
	by e3.ny.us.ibm.com (192.168.1.103) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	Wed, 21 Dec 2011 01:30:09 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id pBL6U8lI276608
	for <git@vger.kernel.org>; Wed, 21 Dec 2011 01:30:08 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id pBL6U853002128
	for <git@vger.kernel.org>; Wed, 21 Dec 2011 01:30:08 -0500
Received: from skywalker.linux.vnet.ibm.com (skywalker.in.ibm.com [9.124.35.73])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id pBL6U3GI001669;
	Wed, 21 Dec 2011 01:30:05 -0500
In-Reply-To: <7vk45smilc.fsf@alter.siamese.dyndns.org>
User-Agent: Notmuch/0.10.2+110~g3b54f44 (http://notmuchmail.org) Emacs/23.3.1 (x86_64-pc-linux-gnu)
x-cbid: 11122106-8974-0000-0000-0000047534FB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187549>

On Mon, 19 Dec 2011 12:06:55 -0800, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Come to think of it, the last patch I sent out on request pull was very
> > wrong....
> 
> And this should fix it.
> 
> -- >8 --
> Subject: [PATCH] request-pull: do not emit "tag" before the tagname
> 
> The whole point of the recent update to allow "git pull $url $tagname" is
> so that the integrator does not have to store the (signed) tag that is
> used to convey authenticity to be recorded in the resulting merge in the
> local repository's tag namespace.  Asking for a merge be made with "git
> pull $url tag $tagname" defeats it.
> 
> Note that the request can become ambiguous if the requestor has a branch
> with the same name as the tag, but that is not a new problem limited to
> pulling. I wouldn't mind if somebody wants to add disambiguation to the
> find_matching_ref logic in the script as a separate patch, though.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  git-request-pull.sh     |    4 +---
>  t/t5150-request-pull.sh |    2 +-
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/git-request-pull.sh b/git-request-pull.sh
> index 7b5c777..d7ba117 100755
> --- a/git-request-pull.sh
> +++ b/git-request-pull.sh
> @@ -63,10 +63,8 @@ die "fatal: No commits in common between $base and $head"
>  find_matching_ref='
>  	sub abbr {
>  		my $ref = shift;
> -		if ($ref =~ s|refs/heads/||) {
> +		if ($ref =~ s|refs/heads/|| || $ref =~ s|refs/tags/||) {
>  			return $ref;
> -		} elsif ($ref =~ s|refs/tags/||) {
> -			return "tag $ref";
>  		} else {
>  			return $ref;
>  		}
> diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
> index aec842f..da25bc2 100755
> --- a/t/t5150-request-pull.sh
> +++ b/t/t5150-request-pull.sh
> @@ -180,7 +180,7 @@ test_expect_success 'request names an appropriate branch' '
>  		read branch
>  	} <digest &&
>  	{
> -		test "$branch" = tag--full ||
> +		test "$branch" = full ||
>  		test "$branch" = master ||
>  		test "$branch" = for-upstream
>  	}

Also can we make .git/config remote stanza to have something like below


     fetch = +refs/tags/*:refs/tags/abc/*

so that one can do

   git fetch t-remote tag-name

and that get stored to abc/tag-name 

-aneesh
