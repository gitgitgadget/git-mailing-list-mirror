From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 1/2] rebase -i: optimize the creation of the todo file
Date: Thu, 8 Mar 2012 11:48:39 +0100
Message-ID: <87boo7pdvc.fsf@thomas.inf.ethz.ch>
References: <1331203358-28277-1-git-send-email-domq@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <gitster@pobox.com>, <git@vger.kernel.org>
To: Dominique Quatravaux <domq@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 11:48:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5atr-0002jZ-V9
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 11:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298Ab2CHKsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 05:48:42 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:57492 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082Ab2CHKsl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 05:48:41 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 8 Mar
 2012 11:48:39 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 8 Mar
 2012 11:48:39 +0100
In-Reply-To: <1331203358-28277-1-git-send-email-domq@google.com> (Dominique
	Quatravaux's message of "Thu, 8 Mar 2012 11:42:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192559>

Dominique Quatravaux <domq@google.com> writes:

> Instead of obtaining short SHA1's from "git rev-list" and hitting the repository
> once more with "git rev-parse" for the full-size SHA1's, obtain long SHA1's from
> "git rev-list" and truncate them with "cut".

That doesn't work if there are 7-digit SHA1 collisions in the repo.
Even my git.git has a bunch of them, as checked with

  git rev-list --objects --all | cut -c1-7 | sort | uniq -d

and I expect a bigger project would have collisions beyond the 9th
digit.

What you can, however, do:

> -git rev-list $merges_option --pretty=oneline --abbrev-commit \
> -	--abbrev=7 --reverse --left-right --topo-order \
> +git rev-list $merges_option --pretty=oneline --no-abbrev-commit \
> +	--reverse --left-right --topo-order \
>  	$revisions | \

rev-list can give you *both* the abbreviated and full SHA1s if you say

  git rev-list $merges_option --format="%>%h %H %s" <...etc...>

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
