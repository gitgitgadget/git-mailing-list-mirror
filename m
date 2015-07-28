From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] cache-tree: populate cache-tree on successful merge
Date: Tue, 28 Jul 2015 17:18:47 -0400
Organization: Twitter
Message-ID: <1438118327.18134.42.camel@twopensource.com>
References: <1438111840-6403-1-git-send-email-dturner@twopensource.com>
	 <xmqqsi88c8m9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Brian Degenhardt <bmd@bmdhacks.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 23:18:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKCGz-00022R-Rc
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 23:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362AbbG1VSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 17:18:49 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33891 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109AbbG1VSt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 17:18:49 -0400
Received: by qkfc129 with SMTP id c129so57398500qkf.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 14:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=kdpiqh8vqRRQUPD0K8Kt6QDfXWT4HQ9h7AZZ6ymCLmk=;
        b=QeafrmVpCGyRFytRCJt1LA9T+N0HvYryfAap5RKm3cFKBfnyLtvvll0KdXwj8Amz+i
         PVNF81xPrt0FEVcBAR15to/kDkW4r73IVfXexyQ/jB1AkLwmu+kRTJAuF9bt/YuGd/pl
         hTFaR0GO/y4dOlFDTVa8D/dYv52BdIlKacTe80gYwclqUE9KNDJ6ICxOXNoo2u0HKfBM
         KhLTTxaTKl/bA2iavnIfpRXOG5rsf7HkmXtdr4/kJQHSsAivXfEY1hk92CPgwXC0uDNC
         9I4iRTcjVhRAHsIzL8qJeQW2JfY3lMOy469pXTV24s3RUWASCWBHT99bGwGdcYzXNqO1
         8o5g==
X-Gm-Message-State: ALoCoQnnXIKz+XwbsqUF7OU4uKF/iWZlSaKFScG2HHAVk0DdI83kxSW8gGR/UiLnqSs2WayHSW9e
X-Received: by 10.55.40.135 with SMTP id o7mr53281496qko.106.1438118328389;
        Tue, 28 Jul 2015 14:18:48 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id g92sm12047196qgf.20.2015.07.28.14.18.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2015 14:18:47 -0700 (PDT)
In-Reply-To: <xmqqsi88c8m9.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274851>

On Tue, 2015-07-28 at 13:47 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > When we unpack trees into an existing index, we discard the old index
> > and replace it with the new, merged index.  Ensure that this index has
> > its cache-tree populated.  This will make subsequent git status and
> > commit commands faster.
> >
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > Signed-off-by: Brian Degenhardt <bmd@bmdhacks.com>
> > ---
> >
> > This patch is by my colleague, Brian Degenhardt (as part of his work
> > on git at Twitter).  I'm sending it with his and Twitter's approval.
> 
> I'd need to tweak the From:/Author: line then, and flip the order of
> the sign-off, as Brian wrote and signed off then David relayed (as
> attached).

Where do I put an Author: line? In the commit message above the
signoffs?  As an email header?  I didn't see an option to git send-email
that would do this.  I don't want to use the From: header because I want
to be the point-of-contact for these patches.

> > diff --git a/unpack-trees.c b/unpack-trees.c
> > index 2927660..befc247 100644
> > --- a/unpack-trees.c
> > +++ b/unpack-trees.c
> > @@ -1156,6 +1156,13 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
> >  	o->src_index = NULL;
> >  	ret = check_updates(o) ? (-2) : 0;
> >  	if (o->dst_index) {
> > +		if (!o->result.cache_tree)
> > +			o->result.cache_tree = cache_tree();
> > +
> > +		if (!cache_tree_fully_valid(o->result.cache_tree)) {
> > +			cache_tree_update(&o->result, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
> > +		}
> 
> This does the cache-tree thing unconditionally, not "on successful
> merge".  cache_tree_update() would refuse when it sees an unmerged
> entry, but somehow the discrepancy between the title and the code
> bothers me.
> 
> By the way, I wonder if we can lose/revert aecf567c (cache-tree:
> create/update cache-tree on checkout, 2014-07-05), now the
> underlying unpack_trees() does the necessary cache_tree_update()
> when a branch is checked out.

Well, the tests still pass, so I guess so. That is, we still need the
WRITE_TREE_REPAIR bit, but not the update check.

Will re-roll once I hear back on the author line.
