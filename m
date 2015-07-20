From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2] unpack-trees: don't update files with CE_WT_REMOVE
 set
Date: Mon, 20 Jul 2015 13:40:48 -0400
Organization: Twitter
Message-ID: <1437414048.30911.10.camel@twopensource.com>
References: <xmqqk2ty1reo.fsf@gitster.dls.corp.google.com>
	 <1437167967-5933-1-git-send-email-dturner@twopensource.com>
	 <20150718083719.GA19676@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Anatole Shaw <git-devel@omni.poc.net>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 19:40:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHF3e-0006ln-1Z
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 19:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755993AbbGTRkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 13:40:49 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:33783 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755329AbbGTRks (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 13:40:48 -0400
Received: by qged69 with SMTP id d69so46706618qge.0
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 10:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=8DKxr5/qdN5+AzmJJMmKDqnw4P63TeQdiKOiV/ryjFQ=;
        b=BL3pphNp5VUvePVMN7b5aVkenBFDPLGyUArGyrhSu8spiPEa1vq2JA0tqhuoi0Afuf
         W/q9VfXB0KPBtxO4TDTuxb6q9HsuO6+sVzTxN1IvF2L6cPCSoA7LZtFArEM87JKK3ASa
         uxdD3HJT3A+PizbKfi4w6dGHkJ55RgsyskyFeCYIGjHHiaaLuEzHPgzJEERWJuKPIKvi
         7bb8ae2KVwTi1YzihEsZs2SMY0ed4UAw2iFJzrBkZfTp6WB5mlSTh2mLQ3V8GbCeIaqO
         h7JPXloG496cspbanNIe/r6hKsLOqTh5eQJO3VLDjwB7p7FJAQnlDDqvreaZAp34FwZU
         znZA==
X-Gm-Message-State: ALoCoQmKLUWvvT67zAwJ0KOHE9QZKTigDXIA/5romnDQALkfDzxYXJ4sNEij3xLHQWs3Hu6+cjuz
X-Received: by 10.140.233.22 with SMTP id e22mr41458310qhc.67.1437414047661;
        Mon, 20 Jul 2015 10:40:47 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 89sm11307468qkw.13.2015.07.20.10.40.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2015 10:40:46 -0700 (PDT)
In-Reply-To: <20150718083719.GA19676@lanh>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274334>

Anatole tells me that this works for us.  Thanks.

On Sat, 2015-07-18 at 15:37 +0700, Duy Nguyen wrote:
> On Fri, Jul 17, 2015 at 05:19:27PM -0400, David Turner wrote:
> > Don't update files in the worktree from cache entries which are
> > flagged with CE_WT_REMOVE.
> > 
> > When a user does a sparse checkout, git removes files that are marked
> > with CE_WT_REMOVE (because they are out-of-scope for the sparse
> > checkout). If those files are also marked CE_UPDATE (for instance,
> > because they differ in the branch that is being checked out and the
> > outgoing branch), git would previously recreate them.  This patch
> > prevents them from being recreated.
> > 
> > These erroneously-created files would also interfere with merges,
> > causing pre-merge revisions of out-of-scope files to appear in the
> > worktree.
> 
> Thank you both for catching this. Just a small suggestion. Perhaps we
> should do this instead. apply_sparse_checkout() is the function where
> all "action" manipulation (add, delete, update files..) for sparse
> checkout occurs and it should not ask to delete and update both at the
> same time.
> 
> -- 8< --
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 2927660..d6cf849 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -224,6 +224,9 @@ static int check_updates(struct unpack_trees_options *o)
>  		struct cache_entry *ce = index->cache[i];
>  
>  		if (ce->ce_flags & CE_UPDATE) {
> +			if (ce->ce_flags & CE_WT_REMOVE)
> +				die("BUG: both update and delete flags are set on %s",
> +				    ce->name);
>  			display_progress(progress, ++cnt);
>  			ce->ce_flags &= ~CE_UPDATE;
>  			if (o->update && !o->dry_run) {
> @@ -293,6 +296,7 @@ static int apply_sparse_checkout(struct index_state *istate,
>  		if (!(ce->ce_flags & CE_UPDATE) && verify_uptodate_sparse(ce, o))
>  			return -1;
>  		ce->ce_flags |= CE_WT_REMOVE;
> +		ce->ce_flags &= ~CE_UPDATE;
>  	}
>  	if (was_skip_worktree && !ce_skip_worktree(ce)) {
>  		if (verify_absent_sparse(ce, ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o))
> -- 8< --
> 
> --
> Duy
