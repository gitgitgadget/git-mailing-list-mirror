From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cvsimport: strip question marks from tags
Date: Tue, 04 Sep 2012 20:19:40 -0700
Message-ID: <7vsjax6trn.fsf@alter.siamese.dyndns.org>
References: <1346813618-20279-1-git-send-email-ktdreyer@ktdreyer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ken Dreyer <ktdreyer@ktdreyer.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 05:19:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T969f-0000QV-SU
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 05:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242Ab2IEDTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 23:19:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34899 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751863Ab2IEDTn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 23:19:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FCD19E40;
	Tue,  4 Sep 2012 23:19:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m9ssw1IrbSXR7ULw6EcBY2aW8M4=; b=PrMp2u
	ml1Wnk15wtK36XVX2HFo8p541eT39CWLAxNpicQEMOjuavoxeSNJnm61Jvj5yS5h
	jG3CG5CAnQ1jrBP39Xe7GeUpm31p3qlfSCi+WwW92wfi8i+S5rX95Jmc6j0BaYuB
	hcXyQ8cUuleERvcUgjCcERuTSRv/SnaNzfCjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pdrl4MrOjTvQEBAjXUIirHSnbDutQgzG
	TW/mRVGmdbn/0e8am/pZlnyyFPYS2eFArOJGUffpng7fsIAxewFb56hKJfLxhB6i
	aLAe5VEmZGZHaCbG6y0GVuN9oT7hfT8JVGyqyFmfGhAKCB2owbEU84q+t/lOVn6v
	B4ouUlRZNC8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E54C9E3F;
	Tue,  4 Sep 2012 23:19:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84A479E3E; Tue,  4 Sep 2012
 23:19:41 -0400 (EDT)
In-Reply-To: <1346813618-20279-1-git-send-email-ktdreyer@ktdreyer.com> (Ken
 Dreyer's message of "Tue, 4 Sep 2012 20:53:38 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 883FBCDE-F708-11E1-B607-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204796>

Ken Dreyer <ktdreyer@ktdreyer.com> writes:

> The "?" character can be present in a CVS tag name, but git's
> bad_ref_char does not allow question marks in git tags. If
> git-cvsimport encounters a CVS tag with a question mark, it will error
> and refuse to continue the import beyond that point.
>
> When importing CVS tags, strip "?" characters from the tag names as we
> translate them to git tag names.
>
> Signed-off-by: Ken Dreyer <ktdreyer@ktdreyer.com>
> ---
>  git-cvsimport.perl | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/git-cvsimport.perl b/git-cvsimport.perl
> index 8d41610..36f59fe 100755
> --- a/git-cvsimport.perl
> +++ b/git-cvsimport.perl
> @@ -890,6 +890,7 @@ sub commit {
>  		$xtag =~ tr/_/\./ if ( $opt_u );
>  		$xtag =~ s/[\/]/$opt_s/g;
>  		$xtag =~ s/\[//g;
> +		$xtag =~ s/\?//g;

I do not think this is a right and sustainable approach.  The next
patch would probably be to strip "~" and then another patch that
strips "^", and yet another that squashes ".." into one would surely
follow.

How about extending the s/\[//g we can see in the context to cover
everything that are unacceptable (see refs.c:bad_ref_char()) once
and for all?  The result needs to be further massaged to avoid
component that has two or more dots in a row, a dot at the beginning
or at the end (see the comment at the beginning of refs.c, and also
refs.c:check_refname_component()).

>  		system('git' , 'tag', '-f', $xtag, $cid) == 0
>  			or die "Cannot create tag $xtag: $!\n";
