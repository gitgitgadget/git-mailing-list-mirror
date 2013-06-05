From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: fix problem causing erroneous project list
Date: Wed, 05 Jun 2013 12:17:12 -0700
Message-ID: <7vd2s01i6f.fsf@alter.siamese.dyndns.org>
References: <20130605043524.GA2453@compy.Home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Charles McGarvey <chazmcgarvey@brokenzipper.com>
X-From: git-owner@vger.kernel.org Wed Jun 05 21:17:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkJCy-00029q-B3
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 21:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756783Ab3FETRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 15:17:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49826 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755354Ab3FETRP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 15:17:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8459825CF0;
	Wed,  5 Jun 2013 19:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+hA5HWAA0sma8Jcy/4JZkmgup8I=; b=oayGMV
	mwxm+YEasw09yMKDoA2cUM/yfEqGOp7cCB5o57Ecb7DZF40ZHXeRJYv9Qwio8D/D
	eWnWIEDHvwbJX5S00D2vn2vn8sV7EZ2seckKR9Oe/Tlb+jbupOG6JTJxINVzXeM4
	efxgY2b/trKMcuF4DV7cNu+Z8z7hfAWidLYEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wme589/z8dp50ycilpZTEOY1te1mR/B+
	gXcSbQcX+VKr2s8jd/mmDYPE9XzJ7xIwCWEajgbx0CzO+pbnK5l2L1ov2nCrePAX
	aIwEp+EXZwpBYrulSmOSsUi82B8cnqu7Gi5ZzQbQ89IiWBc2NPMVjK5u8nHp8yGB
	KmigzZnxmxA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78C8F25CEE;
	Wed,  5 Jun 2013 19:17:14 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88ABE25CED;
	Wed,  5 Jun 2013 19:17:13 +0000 (UTC)
In-Reply-To: <20130605043524.GA2453@compy.Home> (Charles McGarvey's message of
	"Tue, 4 Jun 2013 22:44:28 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8717F27A-CE14-11E2-B125-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226464>

Charles McGarvey <chazmcgarvey@brokenzipper.com> writes:

> The bug is manifest when running gitweb in a persistent process (e.g.
> FastCGI, PSGI), and it's easy to reproduce.  If a gitweb request
> includes the searchtext parameter (i.e. s), subsequent requests using
> the project_list action--which is the default action--and without
> a searchtext parameter will be filtered by the searchtext value of the
> first request.  This is because the value of the $search_regexp global
> (the value of which is based on the searchtext parameter) is currently
> being persisted between requests.
>
> Instead, clear $search_regexp before dispatching each request.
>
> Signed-off-by: Charles McGarvey <chazmcgarvey@brokenzipper.com>
> ---
> I don't think there are currently any persistent-process gitweb tests to
> copy from, so writing a test for this seems to be non-trivial.

The problem description makes sense to me, and clearing with "undef"
is in line with the case where the CGI is run for the first time, so
I think this patch is correct.

Will wait for a while to give Jakub some time to comment on (like:
Ack ;-) and then apply.  Thanks.

By the way, I looked at how $search_regexp is used in the code:

 * esc_html_match_hl and esc_html_match_hl__chopped (called from
   git_project_list_rows, for example) want to have "undef"; an
   empty string will not do.

 * search_projects_list (called from git_project_list_body)

 x git_search_files and git_search_grep_body assume that
   $search_regexp can be interpolated in m//, which is not very
   nice.  They want an empty string.

So as an independent fix, the two subs may want to be fixed if we
want to be undef clean.  Or am I missing something?  Jakub, isn't
this kind of "undef" reference t9500 was designed to catch?

>  gitweb/gitweb.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 80950c0..8d69ada 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1086,7 +1086,7 @@ sub evaluate_and_validate_params {
>  	our $search_use_regexp = $input_params{'search_use_regexp'};
>  
>  	our $searchtext = $input_params{'searchtext'};
> -	our $search_regexp;
> +	our $search_regexp = undef;
>  	if (defined $searchtext) {
>  		if (length($searchtext) < 2) {
>  			die_error(403, "At least two characters are required for search parameter");
