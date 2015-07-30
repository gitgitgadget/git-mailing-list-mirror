From: David Turner <dturner@twopensource.com>
Subject: Re: Confused about sparse vs untracked-cache
Date: Thu, 30 Jul 2015 19:30:08 -0400
Organization: Twitter
Message-ID: <1438299008.18134.59.camel@twopensource.com>
References: <1438223527.18134.53.camel@twopensource.com>
	 <CACsJy8C_PUq4htCSF=qUJ0HNWf-E4RGXJ2FuzbRhSRhLN2vrRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 01:30:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKxHH-0001JC-GI
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 01:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbbG3XaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 19:30:12 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:36093 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbbG3XaL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 19:30:11 -0400
Received: by qgeh16 with SMTP id h16so35294152qge.3
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 16:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=f/gF3K1o7GbrYRf5ONZq1fIiJax1tlOR695JzPLa70M=;
        b=dUSvsusmCAcnAufpaCLELxY/0Em9aoUT6mwoAyoK5SLEQrPVX5N6HaPpuLBeffhnIM
         1baAr6qQzV++AMCKRX/S+q7Kdf3sRTbICh8N9ym4fPu5RJeeyvrOHRKXf1U1YKz5JPik
         gylhdAU0tXKeWsqh1g2xUpEtQu7K1m4Uxf3Sj+tPBY5BBqSmKUthkY5HQ+Y6cPR5hXo7
         MriFUpf9FjWdHoq6/+ztmWG9Uh7Ch5wA48nl6ZeJlSzftYLZ8d+6ymtgRQf/8xxBcDuy
         JNnibYZLEAMLX/6gaE9bityu44eygSGoYiUkKQVo1W7SkhWwDhw6P5hHfIVbX12neqsr
         2kXQ==
X-Gm-Message-State: ALoCoQmWDxldl6YbAYHLMH0XoCebkLKJuVFg3CYcMzP+iK7A69EMCGpaLewgAx/ukwy6008d/3Lz
X-Received: by 10.141.28.6 with SMTP id f6mr10190633qhe.64.1438299010659;
        Thu, 30 Jul 2015 16:30:10 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 77sm1266930qhd.40.2015.07.30.16.30.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jul 2015 16:30:09 -0700 (PDT)
In-Reply-To: <CACsJy8C_PUq4htCSF=qUJ0HNWf-E4RGXJ2FuzbRhSRhLN2vrRg@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275031>

On Thu, 2015-07-30 at 21:09 +0700, Duy Nguyen wrote:
> On Thu, Jul 30, 2015 at 9:32 AM, David Turner <dturner@twopensource.com> wrote:
> > I'm looking at dir.c, and there's a bit I'm confused about:
> >
> > prep_exclude() says:
> >                      /*
> >                       * .. and .gitignore does not exist before
> >                       * (i.e. null exclude_sha1 and skip_worktree is
> >                       * not set). Then we can skip loading .gitignore,
> >                       * which would result in ENOENT anyway.
> >                       * skip_worktree is taken care in read_directory()
> >                       */
> >                      !is_null_sha1(untracked->exclude_sha1))) {
> >
> > That "skip_worktree is taken care in read_directory()" appears to be
> > referring to this bit of validate_untracked_cache():
> >         /*
> >          * An optimization in prep_exclude() does not play well with
> >          * CE_SKIP_WORKTREE. It's a rare case anyway, if a single
> >          * entry has that bit set, disable the whole untracked cache.
> >          */
> >         for (i = 0; i < active_nr; i++)
> >                 if (ce_skip_worktree(active_cache[i]))
> >                         return NULL;
> > ------------
> > I'm confused about why skip_worktree needs to be unset.  When I comment
> > out the second snippet, all the tests still pass.  What was the reason
> > behind that condition?  Is it really necessary?
> 
> This code is added in 27b099a (untracked cache: don't open
> non-existent .gitignore - 2015-03-08) so it's about non-existent
> .gitignore files. We have two cases: .gitignore does not exist, which
> we want to avoid opening it, and .gitignore does not exist, but it's
> in the index and is skip-worktree'd. We would want to call
> add_excludes() anyway in the second case.
> 
> I think I followed that train of thought when I wrote this and to
> avoid trouble, I just left skip-worktree case of out. But that
> ce_skip_worktree() check in read_directory() is probably too strong.
> All we need is disable the cache only when there's an .gitignore file
> being skip-worktree'd. If we do that and make sure all .gitignore
> files are not skip-worktree'd, the two can work toghether.
> 
> Back to the problem. The question is, is
> is_null_sha1(untracked->exclude_sha1) enough to satisfy both cases? If
> so, we don't have to disable the cache in the presence of
> skip-worktree. I haven't stared at this code again long enough to be
> confident, but I think we may be alright. exclude_sha1 should reflect
> the true, effective .gitignore content, wherever it's from. So in
> skip-worktree case, is_null_sha1(exclude_sha1) should only be true
> when the entry does not exist in both worktree and index. There will
> be an unnecessary open() in this case before the index version is
> used, but that's probably ok.
> 
> No I don't think the tests cover skip-worktree + untracked cache
> combination, so yeah it would pass.

I went to add some tests for this, but I ran into what appears to be an
independent bug in the untracked cache code. 

The call to lookup_untracked in treat_directory() passes dirname, but
dirname is the full name of the directory.  lookup_untracked is looking
for the base name -- that is, the code needs to subtract out the length
of not just the parent dir, but all ancestor directories.  So it ends up
creating an entry named e.g. foo/bar inside foo (instead of just finding
an existing 'bar', or adding one called 'bar')

I wasn't really sure what the right way to fix this is, as I just
started looking into this code, but I thought I should report it.

My test case for this was having two levels of subdirectory e.g.
foo/bar/some-file.  

Let me know if you need more details.
