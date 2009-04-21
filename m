From: Allan Caffee <allan.caffee@gmail.com>
Subject: [PATCH] graph API: fix extra space during pre_commit_line state
Date: Tue, 21 Apr 2009 14:34:12 -0400
Message-ID: <20090421183412.GA8499@linux.vnet>
References: <87zlea9lit.fsf_-_@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Tue Apr 21 20:36:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwKpG-0008W5-Li
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 20:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755620AbZDUSeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 14:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbZDUSeV
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 14:34:21 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:9537 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbZDUSeV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 14:34:21 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2545585rvb.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2009 11:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=40mZsdUZcYURQW8Up9yurkMXdyV7aBPW0jpIJesTxPQ=;
        b=QAld9cPPjE1TWAJHmF7LryOvs8IC9xucOdmvxS7tbZriKJNdYuKsrbfTXA1gupafMQ
         KKHxNiOlkpLB9rREl7MSzaGEpaCnVrBacPXvoUgYLBmcCyMqf42a9Zae1V/musskIpmQ
         m/PVLUkDG/sWeMkZsyWhT6LcimzpeLmsRz5WI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=SG33t3md789EPrRmVxTjNs3Za73hKoYAkmIpbcmTrBvQkofhZcPWC35zdtDv9sSWgB
         z3OCZUDOXapr0Gv0gE6OloivM9gOXa8P3vTry5yLv6xAVzh1d4Cze/1jtdLpfr5oBi8K
         XMbsI9qDIAYIRCsJWknukSM11cMsK2UdYMDlM=
Received: by 10.142.217.17 with SMTP id p17mr1398148wfg.161.1240338859843;
        Tue, 21 Apr 2009 11:34:19 -0700 (PDT)
Received: from linux.vnet (n1-13-232.dhcp.drexel.edu [129.25.13.232])
        by mx.google.com with ESMTPS id 22sm2958898wfg.23.2009.04.21.11.34.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Apr 2009 11:34:17 -0700 (PDT)
Mail-Followup-To: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <87zlea9lit.fsf_-_@iki.fi>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117147>

An extra space is being inserted between the "commit" column and all of
the successive edges.  Remove this space.  This regression was
introduced by 427fc5b.

Signed-off-by: Allan Caffee <allan.caffee@gmail.com>
---
 graph.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

On Tue, 21 Apr 2009, Teemu Likonen wrote:
> The colored log graph implementation (commit 427fc5b) introduces an
> alignment bug which looks like this:
> 
> | | * | edf2e37 git-apply: work from subdirectory.
> | | * | 4ca0660 working from subdirectory: preparation
> | |  | |        
> | |   \ \       
> | |    \ \      
> | |     \ \     
> | |      \ \    
> | |       \ \   
> | *-----. \ \   5401f30 Merge branches 'jc/apply', 'lt/ls-tree', [...]
> | |\ \ \ \ \ \  
> | | | | | * | | 0501c24 Tutorial: adjust merge example to recursive [...]
> 
> 
> In other words, the diagonal lines after this octopus merge are aligned
> wrong. To see it yourself type
> 
>     git log --graph --oneline a957207
> 
> in the Git repository and scroll the output down a bit. Note that the
> bug exists with both --color _and_ --no-color.

It's actually the lines before the merge that are shifted to the right
by one.  This patch should fix that.

This issue exposes a gap in the existing test coverage, which doesn't
exercise the pre_commit_line code.  Maybe another patch is in order to
extend t4202-log to cover pre-commit lines and octopus merges.

diff --git a/graph.c b/graph.c
index d4571cf..31e09eb 100644
--- a/graph.c
+++ b/graph.c
@@ -727,8 +727,8 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 		if (col->commit == graph->commit) {
 			seen_this = 1;
 			strbuf_write_column(sb, col, '|');
-			strbuf_addf(sb, " %*s", graph->expansion_row, "");
-			chars_written += 2 + graph->expansion_row;
+			strbuf_addf(sb, "%*s", graph->expansion_row, "");
+			chars_written += 1 + graph->expansion_row;
 		} else if (seen_this && (graph->expansion_row == 0)) {
 			/*
 			 * This is the first line of the pre-commit output.
-- 
1.5.6.3
