From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC/PATCH 1/2] for-each-ref: add new format 'refbasename'
Date: Fri, 29 Aug 2008 07:34:48 -0700
Message-ID: <20080829143448.GC7403@spearce.org>
References: <0329f1ab2642e1dab701b5fc6517bfb1b4ea2d46.1220004755.git.szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: SZEDER GGGbor <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Aug 29 16:37:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ55W-0002iQ-O2
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 16:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178AbYH2Oev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 10:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbYH2Oev
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 10:34:51 -0400
Received: from george.spearce.org ([209.20.77.23]:59646 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbYH2Oeu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 10:34:50 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id F0E4D38375; Fri, 29 Aug 2008 14:34:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <0329f1ab2642e1dab701b5fc6517bfb1b4ea2d46.1220004755.git.szeder@ira.uka.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94293>

SZEDER GGGbor <szeder@ira.uka.de> wrote:
> Therefore, we introduce a new for-each-ref format called 'refbasename',
> which strips everything before and including the second '/' in the ref's
> name from the output.
> 
>   I assumed that refs always look like 'refs/{heads,tags,whatever}/foo',
>   hence this patch breaks if a ref might look like 'refs/foo' or just
>   'foo'.  But can I really rely on that?
> 
> diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
> index 21e92bb..1993ff4 100644
> --- a/builtin-for-each-ref.c
> +++ b/builtin-for-each-ref.c
> @@ -577,6 +578,10 @@ static void populate_value(struct refinfo *ref)
>  			char *s = xmalloc(len + 4);
>  			sprintf(s, "%s^{}", ref->refname);
>  			v->s = s;
> +		} else if (!strcmp(name, "refbasename")) {
> +			char * p = strchr(ref->refname, '/');
> +			p = strchr(p+1, '/');
> +			v->s = p+1;

Please be careful here and check for !p.  A refname may be missing
one or two '/' in which case you will cause the process to segfault.

I don't think its a good idea to assume you'll always have to '/'
in the name.  "refs/foo" can be created by git-update-ref.  Or if
we ever started to report on HEAD this output tag would crash.

Also, as a style nit, its "p + 1" not "p+1".

Test cases?

On the other hand, I like where this is going.  Given that it
has such a nice effect on the bash completion for larger repos
I'd like to see it in Git.

-- 
Shawn.
