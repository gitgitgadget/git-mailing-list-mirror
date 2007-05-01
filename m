From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 8/8] git-repack --max-pack-size: add option parsing to enable feature
Date: Mon, 30 Apr 2007 23:15:09 -0700
Message-ID: <56b7f5510704302315v3d985dcfodb48fcd0bf49853f@mail.gmail.com>
References: <46367ADC.2090704@gmail.com> <20070501054528.GC5942@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 01 08:15:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hile4-00075Y-Ls
	for gcvg-git@gmane.org; Tue, 01 May 2007 08:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946600AbXEAGPO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 02:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946599AbXEAGPN
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 02:15:13 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:40580 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946600AbXEAGPK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 02:15:10 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1821011wra
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 23:15:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cdrS0DbDAY6AKuA6JDC9Z+rVrdevMpD4nkHwjK31ZeoXzijnCVzTfjxw3ZqT8ajObyEdHZHwSKOUgMn715VxhFawKeHGe2Rswetqj0Y4+BAnOlDVk7F9sy4D+jCGPQP70LL3RjAwOZ8QfCQuAIHObqjSJrpeKx2aCCRS+FmnHNU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XE3s/MQIhMpS3qQ89+hL35FsVkI24iRI0yXSW5J5dCd7htYuwVtaqPQr0GAjREe8GcA0xxvzVUSkoe01swFxTLNYEN0QwR+Vn6sy/A46cqy+pu9MLpmcuvEmxb41ABVsFLeAoi8wd5B3NAJvMR6V8EJ4IrMgz9y0uYVbcGE1qMc=
Received: by 10.114.183.1 with SMTP id g1mr2283032waf.1178000109209;
        Mon, 30 Apr 2007 23:15:09 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Mon, 30 Apr 2007 23:15:09 -0700 (PDT)
In-Reply-To: <20070501054528.GC5942@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45923>

On 4/30/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Dana How <danahow@gmail.com> wrote:
> > diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> ...
> > +             if (!prefixcmp(arg, "--max-pack-size=")) {
> > +                     char *end;
> > +                     pack_size_limit = strtoul(arg+16, &end, 0) * 1024 * 1024;
> > +                     if (!arg[16] || *end)
> > +                             usage(pack_usage);
> > +                     no_reuse_delta = 1;
>
> Wow, are you serious?  This entire change is about making repack
> automatically split large projects into multiple packfiles.  If
> that happens are you intending that the caller will mark all of
> those packfiles with .keep files immediately after repacking them?
> If you want users to create .keep files, can git-repack.sh do that
> for them when more than one packfile was output?
>
> Because otherwise a "quick" git-gc will not be quick because the
> reuse delta feature (which is a massive performance improvement for
> repack/gc) will always be disabled.  But odds are a future repack
> of the same project will generally keep things that are in the
> same packfile already in the same packfile again, so delta reuse is
> actually possible for most objects.  I think you should find a way
> to make this change work without needing to force no_reuse_delta
> just because this limit was added.
In a previous version of this patchset I explained that I had turned
on no_reuse_delta because I hadn't yet verified all the combinations
in the reuse codepath(s).  I guess I'll be reinspecting them sooner
rather than later.

> > diff --git a/git-repack.sh b/git-repack.sh
> ...
> > +names=$(git-pack-objects --non-empty --all --reflog $args </dev/null "$PACKTMP") ||
> >       exit 1
> > -if [ -z "$name" ]; then
> > +if [ -z "$names" ]; then
> >       echo Nothing new to pack.
> > -else
> > +fi
> > +for name in $names ; do
>
> I think this particular change needs to either preceed the prior
> commit, or be part of it.  If someone tries to bisect this patch
> series with a large enough project that multiple packfiles are being
> produced then you run into some ugly problems in this repack script.
Sorry, you lost me.  git is being bisected, or a project managed by git?
My intent was that the pack splitting wouldn't be available until
_all_ patches were applied (active).  Bisecting git _within_ this patchset
would still be useful -- it could be used to isolate where some of
this new code broke some pre-existing feature.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
