From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: breakage in revision traversal with pathspec
Date: Wed, 11 Sep 2013 11:24:44 -0700
Message-ID: <20130911182444.GD4326@google.com>
References: <xmqqy574y4pz.fsf@gitster.dls.corp.google.com>
 <522F8ED2.9000408@bracey.fi>
 <xmqq38pcwc21.fsf@gitster.dls.corp.google.com>
 <5230AD23.2050009@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Wed Sep 11 20:25:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJp62-0004g9-EZ
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 20:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755261Ab3IKSYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 14:24:54 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:50190 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911Ab3IKSYx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 14:24:53 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so9619520pdi.27
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 11:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=X6BVKTgLTMxNldryQwWEteFIc229fn2It1KZOCfuX6U=;
        b=0fkmuop8UP4jMKTESdMl9nF/g5I8hhmnf52V51J2TB8+eGAVeHq1Hm8LyHFyPlmwCK
         FO6bL3jceael/PA+XKzAaX2g7D00/VZcaHZ8dsEWqgj7CzyiqSXYEp4EW3M5GLeLq4Ah
         gVTBX82eK+KvXJwl9pid6uPoIjEQN0ieUufiMSGEbuJhT6m74ons8QdHbejE6rOIEQLB
         L9L0rkIHNdZNMH3hlWiazGItAD7+K1B58I+ikcMYFz7vynxAzrSCyd9dHrbGNKFw+9WP
         D+Ft79JrxhmWQ9/HGO9hSORZNkWA0SIc8EVNLFmAAvCVIVyLPOlD5T41aZJWh9HfjCvF
         zSxA==
X-Received: by 10.68.130.1 with SMTP id oa1mr3346964pbb.35.1378923893145;
        Wed, 11 Sep 2013 11:24:53 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id fa4sm5126082pab.17.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 11 Sep 2013 11:24:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5230AD23.2050009@bracey.fi>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234592>

Kevin Bracey wrote:

> On reflection I'm not sure what we should for the "simple history"
> view of v1.8.3.1..v1.8.4. We're not rewriting parents, so we don't
> get a chance to reconsider the merge as being zero-parent, and we do
> have this little section of graph to traverse at the bottom:
>
>           1.8.3
>             o----x----x----x----x---x---     (x = included, o = excluded, *=!treesame)
>                 /
>                /*
>   o--x--x--x--x
[...]
> 1) if identical to any on-graph parent, follow that one, and rewrite
> the merge as a non-merge. We currently do not follow to an identical
> off-graph parent. This long-standing comment in try_to_simplify_commit
> applies: "Even if a merge with an uninteresting side branch brought
> the entire change we are interested in, we do not want to lose the
> other branches of this merge, so we just keep going."
[...]
> 2) If rule 1 doesn't activate, and it remains as a merge, hide it if
> treesame to all on-graph parents. Previously this rule was "hide if
> treesame to any parent", and so that would have hidden the merge.
>
> Now, when I changed rule 2, I did not think this would affect the
> default log. See my commit message:
[...]
> I currently feel instinctively more disposed to dropping the older
> "don't follow off-graph identical parents" rule. Let the default
> history go straight to v1.8.3 even though it goes off the graph,
> stopping us traversing the topic branch.

Thanks for this analysis.  Interesting.

The rule (1) comes from v1.3.0-rc1~13^2~6:

	commit f3219fbbba32b5100430c17468524b776eb869d6
	Author: Junio C Hamano <junkio@cox.net>
	Date:   Fri Mar 10 21:59:37 2006 -0800

	    try_to_simplify_commit(): do not skip inspecting tree change at boundary.
	    
	    When git-rev-list (and git-log) collapsed ancestry chain to
	    commits that touch specified paths, we failed to inspect and
	    notice tree changes when we are about to hit uninteresting
	    parent.  This resulted in "git rev-list since.. -- file" to
	    always show the child commit after the lower bound, even if it
	    does not touch the file.  This commit fixes it.
	    
	    Thanks for Catalin for reporting this.
	    
	    See also:
		461cf59f8924f174d7a0dcc3d77f576d93ed29a4
	    
	    Signed-off-by: Junio C Hamano <junkio@cox.net>

I think you're right that dropping the "don't follow off-graph
treesame parents" rule would be a sensible change.  The usual point of
the "follow the treesame parent" rule is to avoid drawing undue
attention to merges of ancient history where some of the parents are
side-branches with an old version of the files being tracked and did
not actually change those files.  That rationale applies just as much
for a merge on top of an UNINTERESTING rev as any other merge.

Thanks,
Jonathan
