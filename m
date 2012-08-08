From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH/RFC v3 01/13] Move index v2 specific functions to their
 own file
Date: Wed, 8 Aug 2012 21:21:16 +0200
Message-ID: <20120808192041.GA25671@tommy-fedora.surfnet.iacbox>
References: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
 <1344424681-31469-2-git-send-email-t.gummerer@gmail.com>
 <CACsJy8CY--Z_BfscRCG8+Om1Z8JsFgj0BkjNyMJnwsbmyGRLXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 21:21:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzBos-0004fe-N5
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 21:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030557Ab2HHTVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 15:21:21 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:36242 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab2HHTVU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 15:21:20 -0400
Received: by weyx8 with SMTP id x8so696485wey.19
        for <git@vger.kernel.org>; Wed, 08 Aug 2012 12:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=x0eHXxMhIm3X/IO62++zzjw/0dBsQij35Apg7B08ipg=;
        b=K/XNTypfLtkEoNJPhOww5bO/LfPbPGgHU2g5uaFVtKdTitYa3Mw3rk5QOSjHoi9IY0
         0BM3FMzfijN0efYjkk1S+/9s/7nzm9mMeox3lITx4YVr2PlhwlRItWEG9dHrnp88zZKb
         AEJ2lQoN2tAesJ/0AetzSRZjKgwMhXRpsnvBqGoZTcVun8R0VvdFvMo1W2iICGAV7mIa
         r9JHcaFkVGJM+0GJwtrJG+YgCDug1ze57v+AFHd9TR/blgkSLk9zDluL8CSOaHab/T2o
         WAyQvLOM2Xt7IyYwwv8qUjkTR3udJIZCRycl48PrHflgkHidNNHl8mFcGm8CujphF+Me
         kq+Q==
Received: by 10.180.93.68 with SMTP id cs4mr143097wib.14.1344453678625;
        Wed, 08 Aug 2012 12:21:18 -0700 (PDT)
Received: from localhost ([95.171.54.129])
        by mx.google.com with ESMTPS id b7sm9856887wiz.9.2012.08.08.12.21.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Aug 2012 12:21:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8CY--Z_BfscRCG8+Om1Z8JsFgj0BkjNyMJnwsbmyGRLXQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203116>



On 08/08, Nguyen Thai Ngoc Duy wrote:
> On Wed, Aug 8, 2012 at 6:17 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > Move index version 2 specific functions to their own file,
> > to prepare for the addition of a new index file format. With
> > the split into two files we have the non-index specific
> > functions in read-cache.c and the index-v2 specific functions
> > in read-cache-v2.c
> 
> You still mix code changes and code move in one patch, but we can skip
> it for now.
> 
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -267,6 +259,7 @@ struct index_state {
> >         unsigned name_hash_initialized : 1,
> >                  initialized : 1;
> >         struct hash_table name_hash;
> > +       struct index_ops *ops;
> >  };
> 
> Do we really need to modify "ops" content? If not make it "const
> struct index_ops *ops;" which makes..
> 
> > @@ -471,8 +464,8 @@ extern int index_name_is_other(const struct index_state *, const char *, int);
> >  #define CE_MATCH_RACY_IS_DIRTY         02
> >  /* do stat comparison even if CE_SKIP_WORKTREE is true */
> >  #define CE_MATCH_IGNORE_SKIP_WORKTREE  04
> > -extern int ie_match_stat(const struct index_state *, struct cache_entry *, struct stat *, unsigned int);
> > -extern int ie_modified(const struct index_state *, struct cache_entry *, struct stat *, unsigned int);
> > +extern int ie_match_stat(struct index_state *, struct cache_entry *, struct stat *, unsigned int);
> > +extern int ie_modified(struct index_state *, struct cache_entry *, struct stat *, unsigned int);
> 
> ..this hunk go away

Unfortunately I think we need to modify it, because in some cases
when ie_modified/ie_match_stat is called, index->ops is not set yet
(happens when the index is empty and thus not read first). Therefore
we have to set it in ce_match_stat_basic to have access to the
format specific match_stat_basic.

We could also call match_stat_basic directly from the v[25]_ops
struct, but I do not think that would be the cleaner solution, or
is there any other way to do it, which I can't see?
