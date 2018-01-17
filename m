Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE3951F406
	for <e@80x24.org>; Wed, 17 Jan 2018 19:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753988AbeAQThg (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 14:37:36 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:53909 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752588AbeAQThd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 14:37:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ift2L3OXm9wUYJYLcS/nvfvuywA2f8JQ2yyZkoXPAU4=; b=bst1tPMpdQO5MLqSUN3zQ/uuj
        EqpTUCGwSkB3e/yfRz/d7odER4Z10B8Hsvdy9WXe1HWIdWv2LwPKW1x/C4YCTZwirfbjH19NkTEeZ
        d9qCWWGdZQ8OtIRQRcenPcsuY1bUMWLwAEWalJPbhtZXURfjW7u8PZtx2pEs8Z1p9q6/iX0gs+hOf
        wKA3BDemHcsPJ65vzw3RFo0pCMKu+AJg6fnDH6IZcjpPU03mEUrJZtpQAokEpeShxe9lr/gz6ecgp
        xxa6zcIA9r0sTJU/jhR7JmiF1p7nrKVvM+4jX92N7mPzF9N3wAQeX7fd2Lvjoa5OLtQ6RV8zDDnks
        UuOoOyO+w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.89 #1 (Red Hat Linux))
        id 1ebtWd-0008Es-JR; Wed, 17 Jan 2018 19:37:31 +0000
Date:   Wed, 17 Jan 2018 11:37:31 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christoph Hellwig <hch@lst.de>, git@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] enable core.fsyncObjectFiles by default
Message-ID: <20180117193731.GC25862@bombadil.infradead.org>
References: <20180117184828.31816-1-hch@lst.de>
 <xmqqd128s3wf.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd128s3wf.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 17, 2018 at 11:04:32AM -0800, Junio C Hamano wrote:
> Christoph Hellwig <hch@lst.de> writes:
> > @@ -866,10 +866,8 @@ core.whitespace::
> >  core.fsyncObjectFiles::
> >  	This boolean will enable 'fsync()' when writing object files.
> >  +
> > -This is a total waste of time and effort on a filesystem that orders
> > -data writes properly, but can be useful for filesystems that do not use
> > -journalling (traditional UNIX filesystems) or that only journal metadata
> > -and not file contents (OS X's HFS+, or Linux ext3 with "data=writeback").
> > +This option is enabled by default and ensures actual data integrity
> > +by calling fsync after writing object files.
> 
> I am somewhat sympathetic to the desire to flip the default to
> "safe" and allow those who know they are already safe to tweak the
> knob for performance, and it also makes sense to document that the
> default is "true" here.  But I do not see the point of removing the
> four lines from this paragraph; the sole effect of the removal is to
> rob information from readers that they can use to decide if they
> want to disable the configuration, no?

How about this instead?

This option is enabled by default and ensures data integrity by calling
fsync after writing object files.  It is not necessary on filesystems
which journal data writes, but is still necessary on filesystems which
do not use journalling (ext2), or that only journal metadata writes
(OS X's HFS+, or Linux's ext4 with "data=writeback").  Turning this
option off will increase performance at the possible risk of data loss.

