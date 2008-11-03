From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: add git_commit_non_empty_tree and
 --prune-empty.
Date: Sun, 02 Nov 2008 20:58:44 -0800
Message-ID: <7viqr5wgl7.fsf@gitster.siamese.dyndns.org>
References: <20081030132623.GC24098@artemis.corp>
 <1225445204-28000-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pasky@suse.cz, srabbelier@gmail.com
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Nov 03 06:00:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwrY8-0007RP-Bu
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 06:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754552AbYKCE7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 23:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754543AbYKCE7G
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 23:59:06 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62901 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754529AbYKCE7F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 23:59:05 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 85D6378B44;
	Sun,  2 Nov 2008 23:59:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5508A78B40; Sun,  2 Nov 2008 23:58:51 -0500 (EST)
In-Reply-To: <1225445204-28000-1-git-send-email-madcoder@debian.org> (Pierre
 Habouzit's message of "Fri, 31 Oct 2008 10:26:44 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 22206C46-A964-11DD-9B95-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99898>

Pierre Habouzit <madcoder@debian.org> writes:

> +case "$prune_empty,$filter_commit" in
> +',')
> +	filter_commit='git commit-tree "$@"';;
> +'t,')
> +	filter_commit="$functions;"' git_commit_non_empty_tree "$@"';;
> +','*)
> +	;;
> +*)
> +	die "Cannot set --prune-empty and --filter-commit at the same time"
> +esac

This is only style issue, but I find the above extremely difficult to
read.  If it were either:

	case ... in
        ,) do "neither set case" ;;
        t,) do "prune but not filter case" ;;
        *) do "both set case" ;;
        esac

or (rather amateurish but conveys what it wants to do more clearly):
        
	case ... in
        '','') do "neither set case" ;;
        t,'') do "prune but not filter case" ;;
        t,t) do "both set case" ;;
        esac

I wouldn't have to wonder which sq pairs with which one.

> diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
> index b0a9d7d..352b56b 100755
> --- a/t/t7003-filter-branch.sh
> +++ b/t/t7003-filter-branch.sh
> @@ -262,4 +262,12 @@ test_expect_success 'Tag name filtering allows slashes in tag names' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'Prune empty commits' '
> +	make_commit to_remove &&
> +	(git rev-list HEAD | grep -v $(git rev-parse HEAD)) > expect &&

I am not sure what this one is doing.

 - Isn't this the same as "git rev-list HEAD^"?
 - Do you need a subshell?
