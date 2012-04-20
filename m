From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v7 4/4] git-rebase: add keep_empty flag
Date: Fri, 20 Apr 2012 06:35:03 -0400
Message-ID: <20120420103503.GA15966@hmsreliant.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334776680-23460-1-git-send-email-nhorman@tuxdriver.com>
 <1334776680-23460-5-git-send-email-nhorman@tuxdriver.com>
 <4F8FE2CD.3070300@in.waw.pl>
 <873980q6vm.fsf@thomas.inf.ethz.ch>
 <xmqqty0fv97w.fsf@junio.mtv.corp.google.com>
 <xmqqpqb3v8x7.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org, Clemens Buchacher <drizzd@aon.at>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <jch@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 12:35:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLBBb-0003aQ-I7
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 12:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754420Ab2DTKfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 06:35:25 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:37910 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670Ab2DTKfY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 06:35:24 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SLBBA-00010o-4f; Fri, 20 Apr 2012 06:35:06 -0400
Content-Disposition: inline
In-Reply-To: <xmqqpqb3v8x7.fsf@junio.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195985>

On Thu, Apr 19, 2012 at 12:05:56PM -0700, Junio C Hamano wrote:
> Junio C Hamano <jch@google.com> writes:
> 
> > Thomas Rast <trast@student.ethz.ch> writes:
> >
> >> Either way, it should simply be spelled as
> >>
> >> is_empty_commit() {
> >> 	tree=$(git rev-parse "$1"^{tree})
> >> 	ptree=$(git rev-parse "$1"^^{tree})
> >> 	test "$tree" = "$ptree"
> >> }
> >
> > Thanks; will squash in something like this:
> > ...
> 
> Ehh, not like that.  But something like this, as we need to be able to
> pick "root" (t3412 insists on it).
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 82042b1..de71543 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -168,9 +168,11 @@ has_action () {
>  }
>  
>  is_empty_commit() {
> -	tree=$(git rev-parse "$1"^{tree})
> -	ptree=$(git rev-parse "$1"^^{tree})
> -	return $(test "$tree" = "$ptree")
> +	tree=$(git rev-parse "$1"^{tree} 2>/dev/null) ||
> +		die "$1: not a commit that can be picked"
> +	ptree=$(git rev-parse "$1"^^{tree} 2>/dev/null) ||
> +		ptree=4b825dc642cb6eb9a060e54bf8d69288fbee4904
> +	test "$tree" = "$ptree"
>  }
>  
>  # Run command with GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
> 

What about this?
is_empty_commit() {
        tree=$(git rev-parse -q --verify "$1"^{tree})
        ptree=$(git rev-parse -q --verify "$1"^^{tree})

        # Note that if either rev-parse commands fail, the output 
        # of that command will be an empty string.  If that happens
        # We should just return 0, to indicate the commit is non-empty
        # and let the rest of the git rebase logic handle it.
        if test  -z "$tree"  -o  -z "$ptree"
        then
                return 0
        fi

        return test "$tree" = "$ptree"
}
