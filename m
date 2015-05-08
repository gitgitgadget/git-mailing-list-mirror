From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 1/3] tree-walk: learn get_tree_enty_follow_symlinks
Date: Fri, 08 May 2015 16:02:31 -0400
Organization: Twitter
Message-ID: <1431115351.9179.7.camel@ubuntu>
References: <1431108819-6831-1-git-send-email-dturner@twopensource.com>
	 <xmqqd22alvk6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 22:02:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqoU0-0005nq-Ny
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 22:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbbEHUCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 16:02:47 -0400
Received: from mail-qc0-f173.google.com ([209.85.216.173]:33254 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932172AbbEHUCe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 16:02:34 -0400
Received: by qcvo8 with SMTP id o8so18722425qcv.0
        for <git@vger.kernel.org>; Fri, 08 May 2015 13:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=h66+CMIn5btviZBx02RlgNfM96OvrAKUKDhW6jF/Bh4=;
        b=bv1iJon8uAU27FtLvH2vCY3IZI6GMQgF1w6HKVCKXZYvqGpUX3ILtxqK13RJ3dkLS3
         Sa/jcfN5xKnF/hSKusasDW6urwm0S96fQndmO6x5fYKH+uStRLFBykkAPKr3MyFGp3S5
         cbuISr7wlrt1TpQ6luGyoNvOSvbrNOBmsnz9UKggwI1Oyp1LCSkBZJ2Ml3PTXBMThPws
         10pDr3S94TJcIuNrvrfHOLNoVbHXkFv3MKS5IVR2lYyhZRQIJEXQAnnLiM8o9nsa3j6I
         H08bNGaTUk2M8eIgjNeQFsLH/02CkR//3ffGG9uqESqNfm9Y1B/YqHuoVPqJY5q0ppH8
         hn3A==
X-Gm-Message-State: ALoCoQmeTojT+b/bmxqFhYxkbmtB7eupTiYs5rVGcsLL/YbA1FVn6LG2t5t5XXCDqpMinYZw23xS
X-Received: by 10.55.20.207 with SMTP id 76mr11882046qku.46.1431115354051;
        Fri, 08 May 2015 13:02:34 -0700 (PDT)
Received: from [172.22.38.222] ([192.133.79.147])
        by mx.google.com with ESMTPSA id 75sm4286403qhw.41.2015.05.08.13.02.32
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2015 13:02:33 -0700 (PDT)
In-Reply-To: <xmqqd22alvk6.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268655>

On Fri, 2015-05-08 at 12:26 -0700, Junio C Hamano wrote:
> > +static int find_tree_entry_nonrecursive(struct tree_desc *t, char *name, unsigned char *result, unsigned *mode) {
> > +	int namelen = strlen(name);
> > +
> > +	while (t->size) {
> 
> Why do you need an almost duplicate of existing find_tree_entry()
> here?  The argument "name" above is not const, so isn't that just
> the matter of the caller to temporarily replace '/' in name[] before
> calling find_tree_entry() if all you wanted to avoid was to prevent
> it from falling into get_tree_entry() codepath?  Or are there more
> to this function?

Oh, right, actually, we already replaced the '/'!  So I can just use the
existing one.  That was silly.  

> > +#define GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS 40
> 
> Is 40 just a randomly chosen number?
> 
> I do not think 40 is particularly unreasonable, but so is 5 (which I
> think is also reasonable and is already used as MAXDEPTH in refs.c
> to follow symrefs), and am curious where that number came from.

http://lxr.linux.no/linux+v3.6.4/fs/namei.c#L783

I'll add a comment to that effect.

> > +/**
> > + * Find a tree entry by following symlinks in tree_sha (which is
> > + * assumed to be the root of the repository).  In the event that a
> > + * symlink points outside the repository (e.g. a link to /foo or a
> > + * root-level link to ../foo), the portion of the link which is
> > + * outside the repository will be copied into result_path (which is
> > + * assumed to hold at least PATH_MAX bytes), and *mode will be set to
> > + * 0.
> 
> As the API to this new function is not constrained by existing
> callers, you might want to consider using strbuf for result_path,
> which would make it easier for both the callers and this function.

The API is sort-of constrained, because the caller has a fixed-size
buffer to fill in (see the 2nd patch in this series).  

> It is customary to name variables to control an ALLOC_GROW()-managed
> array 'foo' as foo_nr and foo_alloc.  Deviating from the convention
> makes the patch harder to read by people who are familiar with it
> without any benefit, and those who are familiar with the existing
> code are the people you want your patch reviewed by.

Will fix.

> I am context-switching now; will review the remainder some other
> time.

Thanks for the review.
