From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Disable useless check_for_new_submodule_commits() by
 default
Date: Fri, 09 Sep 2011 18:29:21 +0200
Message-ID: <4E6A3EE1.9080103@web.de>
References: <7vy5xyv5p3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 18:30:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R23xu-0003Yz-Fd
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 18:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759433Ab1IIQ3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 12:29:38 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:49771 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758537Ab1IIQ3h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 12:29:37 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate02.web.de (Postfix) with ESMTP id 3CFC71AAA8677;
	Fri,  9 Sep 2011 18:29:22 +0200 (CEST)
Received: from [79.247.248.31] (helo=[192.168.178.43])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #2)
	id 1R23xC-0000Ok-00; Fri, 09 Sep 2011 18:29:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <7vy5xyv5p3.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18frnL8PIxAwcYHg4ys6W3u3rXBRYY9h0Vuhjz/
	vWGuOo5+JjQ0I1ti+Lv09DAiq5vtIDX+5Uvyo0iV4ZM7mYw+mu
	x68g1jOzxssKru86gM5Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181092>

Am 09.09.2011 03:56, schrieb Junio C Hamano:
> Imagine a project with 20k paths with a history 250k commits deep, without
> any submodule.
> 
> Imagine another project with the same depth of history but with 1k paths,
> among which there are 200 submodules.
> 
> Further, imagine fetching from one of the above repositories into a
> repository that is very behind, and updating many remote tracking
> branches.  Now, think about what check_for_new_submodule_commits() in
> submodule.c that is called from update_local_ref() in builtin/fetch.c
> would do.
> 
> For each updated remote tracking branch (or anything that is not a tag),
> the problem function will run the equivalent of:
> 
> 	git log --raw $new --not --all
> 
> which would mean 250k rounds of diff-tree to enumerate the submodules that
> may have been updated, and it does it for each and every refs outside the
> refs/tags hierarchy.
>
> Presumably, this is so that it only has to actually fetch in the submodule
> "on demand", but even if in a project _with_ submodules (i.e. the latter
> example above), this is simply not acceptable.

Definitely.

> You could just enumerate
> those 200 submodules at the tip that _might_ matter and that would be
> million times cheaper.

But that trick won't do it. I thought about that too when I implemented this
feature, but we need to look in all new commits (e.g. a submodule is not
present anymore in the new tip but is changed in the preceding but not yet
fetched commits, then it still has to be checked if it has the necessary
commits locally and they need to be fetched if that is not the case).

> To add insult to injury, this "on demand" behaviour
> is on by default, which hurts projects without any submodules (i.e. the
> former example above) a lot.

Right, I'll post a patch disabling that check completely when a project has
no submodules.

> In short, if "on demand" check is million times more expensive than
> actually doing it, the check does not have any value.
> 
> In the longer term, people who want to have the on-demand behaviour need
> to come up with a cheaper way to determine if it is necessary to recurse
> into submodules by fixing check_for_new_submodule_commits(), but until
> that happens, we should disable submodule recursion by default unless the
> user explicitly asks for it from the command line or from the configuration.

Ok, I'll see if I can come up with a solution for the performance regression.
