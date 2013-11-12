From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6 00/10] transport-helper: updates
Date: Tue, 12 Nov 2013 14:55:42 -0600
Message-ID: <528295cecbb0b_3b98795e7895@nysa.notmuch>
References: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
 <1384210507-26561-2-git-send-email-felipe.contreras@gmail.com>
 <5281C8EA.8030002@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 22:03:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgL7N-0006EB-Aj
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 22:03:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165Ab3KLVDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 16:03:21 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:33209 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134Ab3KLVDO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 16:03:14 -0500
Received: by mail-ob0-f177.google.com with SMTP id wp4so4514495obc.22
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 13:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=8rFaScDtsENxBdAGLVQSqRli0IxnJqdMddkHHCUn4h8=;
        b=g8JMvNEeD1ePYYZ14Yo8R2FSfzLhRQWql6w52/CQifEcSDqkZttsNXOkiBybXcUiUB
         GafaUPFpKcFtA+7fNxrh0eJ5jJVLjPPKy2rDkHdKaIN1NVHA54rWz4oqHGC3eKHpSfcK
         p2ZmUC/Cgf8SywLHx0oJnz4ucdYo7EW1jeuZpr1rtfos7oKdzp5efLTPZDF9cN/MZZSh
         5iW2FSyu5ScsF5YwM6AZbIiRSnuQYwo848yVRkT99tRfvfZb4v/l/LZ4SHIRmet13trL
         7wg5MLgJJckwQDO6IaZ3UJbg6Z3Am14ts+7im05rSCJcYadeZC55rsyna2bNd0AsSOz2
         pySA==
X-Received: by 10.60.149.169 with SMTP id ub9mr25781330oeb.39.1384290192941;
        Tue, 12 Nov 2013 13:03:12 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r6sm20080775obi.14.2013.11.12.13.03.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2013 13:03:11 -0800 (PST)
In-Reply-To: <5281C8EA.8030002@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237737>

Richard Hansen wrote:
> On 2013-11-11 17:54, Felipe Contreras wrote:
> > Hi,
> > 
> > Here are the patches that allow transport helpers to be completely transparent;
> > renaming branches, deleting them, custom refspecs, --force, --dry-run,
> > reporting forced update, everything works.
> > 
> > Small changes since v5:
> > 
> > diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> > index 8ed41b4..4b76222 100644
> > --- a/builtin/fast-export.c
> > +++ b/builtin/fast-export.c
> > @@ -736,9 +736,10 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
> >  		usage_with_options (fast_export_usage, options);
> >  
> >  	if (refspecs_list.nr) {
> > -		const char *refspecs_str[refspecs_list.nr];
> > +		const char **refspecs_str;
> >  		int i;
> >  
> > +		refspecs_str = xmalloc(sizeof(*refspecs_str) * refspecs_list.nr);
> >  		for (i = 0; i < refspecs_list.nr; i++)
> >  			refspecs_str[i] = refspecs_list.items[i].string;
> >  
> > @@ -746,6 +747,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
> >  		refspecs = parse_fetch_refspec(refspecs_nr, refspecs_str);
> >  
> >  		string_list_clear(&refspecs_list, 1);
> > +		free(refspecs_str);
> >  	}
> >  
> >  	if (use_done_feature)
> > diff --git a/git-remote-testgit.sh b/git-remote-testgit.sh
> > index 716aa4c..1c006a0 100755
> > --- a/git-remote-testgit.sh
> > +++ b/git-remote-testgit.sh
> > @@ -15,6 +15,8 @@ test -z "$refspec" && prefix="refs"
> >  
> >  export GIT_DIR="$url/.git"
> >  
> > +force=
> > +
> >  mkdir -p "$dir"
> >  
> >  if test -z "$GIT_REMOTE_TESTGIT_NO_MARKS"
> 
> What about changing those two test-hg.sh tests to test_expect_success?
> 
>   http://article.gmane.org/gmane.comp.version-control.git/237606

I can do that.

> Should those changes be squashed into the "transport-helper: don't
> update refs in dry-run" and "transport-helper: add 'force' to 'export'
> helpers" commits?  Or are those commits not really the appropriate place?

I think it should be a separate commit, since it's not part of the core, but
contrib area.

-- 
Felipe Contreras
