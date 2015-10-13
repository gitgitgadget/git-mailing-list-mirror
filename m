From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2] merge: fix cache_entry use-after-free
Date: Tue, 13 Oct 2015 15:22:47 -0400
Organization: Twitter
Message-ID: <1444764167.7234.14.camel@twopensource.com>
References: <1444687413-928-1-git-send-email-dturner@twitter.com>
	 <xmqqio6bbu2w.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Keith McGuigan <kmcguigan@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 21:23:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm5A1-0000xz-Te
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 21:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374AbbJMTWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 15:22:53 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:35682 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752197AbbJMTWu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 15:22:50 -0400
Received: by qgt47 with SMTP id 47so23871034qgt.2
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 12:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=AZhI20JLUo9sjw+vXjXu1nbU5qpoarJNEadpScXYjWU=;
        b=Y37RFpVVAaZB5A2Xq/jdzp//KvnNtKfsygX/uuLfRyz4aceYa0BSP7XxZIyjjb1hLh
         H2sCqmgVA0IgvWQ64At0EqzjEMzo7lXjQMBJ1s9xOG8pwIfwB+0nGG1NFEYZqLeWDFqC
         8LNT6TJVDRyFqlXydYG82g6gyrbQ0aNl2nGDJzrIVYJbpVZ5x3r6SzP6FKngLMvJ8zck
         q7gBi9dVdcXoCfISBxjRG39FQUrEdckj+2Zx/XD2fdraFFyPymWsO/NCHUg2y3zRRhPe
         GlmqznEc4s3QrcQthTQrVSKZIK2O14EVy5cOfHmaHRBULHiretJuQEOwHLa40rWOYGeQ
         VA3A==
X-Gm-Message-State: ALoCoQnXJ+yO36uu8vALVGyVcDLTN+lyJyLgMEE4n1iX8wSpnGQ6WxkFSdpRO5v87LLpbol8ErwS
X-Received: by 10.140.104.113 with SMTP id z104mr11983726qge.21.1444764169485;
        Tue, 13 Oct 2015 12:22:49 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 99sm1781009qkv.38.2015.10.13.12.22.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2015 12:22:48 -0700 (PDT)
In-Reply-To: <xmqqio6bbu2w.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279516>

On Mon, 2015-10-12 at 15:28 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > From: Keith McGuigan <kmcguigan@twitter.com>
> >
> > During merges, we would previously free entries that we no longer need
> > in the destination index.  But those entries might also be stored in
> > the dir_entry cache, and when a later call to add_to_index found them,
> > they would be used after being freed.
> >
> > To prevent this, add a ref count for struct cache_entry.  Whenever
> > a cache entry is added to a data structure, the ref count is incremented;
> > when it is removed from the data structure, it is decremented.  When
> > it hits zero, the cache_entry is freed.
> >
> > Signed-off-by: Keith McGuigan <kmcguigan@twitter.com>
> > ---
> 
> I'll forge your "messenger's sign-off" here ;-)

Thanks.

> > diff --git a/unpack-trees.c b/unpack-trees.c
> > index f932e80..1a0a637 100644
> > --- a/unpack-trees.c
> > +++ b/unpack-trees.c
> > @@ -606,8 +606,10 @@ static int unpack_nondirectories(int n, unsigned long mask,
> >  					o);
> >  		for (i = 0; i < n; i++) {
> >  			struct cache_entry *ce = src[i + o->merge];
> > -			if (ce != o->df_conflict_entry)
> > -				free(ce);
> > +			if (ce != o->df_conflict_entry) {
> > +				drop_ce_ref(ce);
> > +				src[i + o->merge] = NULL;
> > +			}
> 
> This one smelled iffy.  I think it is safe because the caller does
> not look at src[] other than src[0] after this function returns, and
> this setting to NULL happens only when o->merge is set to 1, so I do
> not think this is buggy, but at the same time I do not think setting
> to NULL is necessary.
> 
> Other than that, looks nice.  Thanks.

I like to set a pointer to NULL after I free the thing pointed to by it,
because it helps make use-after-free bugs easier to detect.  
