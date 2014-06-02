From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] Makefile: don't hardcode HEAD in dist target
Date: Mon, 2 Jun 2014 21:34:20 +0200
Message-ID: <20140602193419.GA10198@spirit>
References: <20140531202507.GA9101@spirit>
 <xmqq4n035ej3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 21:34:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrY06-000062-TX
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 21:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbaFBTe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 15:34:26 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:40358 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577AbaFBTeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 15:34:25 -0400
Received: by mail-wi0-f180.google.com with SMTP id hi2so5243811wib.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2014 12:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=uYddh76FDQTrzHSaxYaggqHfcZJSf83Pauo4pTcqvf0=;
        b=GAHgLW8T72RsUUSnVsVDhy9xknNQ8KKu0pzgOABSTFfFw7AQIJ5ha4QIVlwSkdras/
         skJOH6TTq7H4xMudx8i65i5alDKUPgc7cJ/DC/ce68yir1364ZQjV1ZpRhEIW02JK+0f
         qdKLM4qUnn8NKPDpIWNYe8JGE3QL2YorNg8vxqehxtju/a3czwT26vuSoqgkUgd/UjL9
         gxrgbEIYIKkTzoARCc0fR+Ue6jxIgPwJgDlqTlCIerEYiYNRdNpOfloc9T4Xd/j9SdIP
         MgOedvIu1uDCt2RtKE6FQI+l1Yoarl1QxYDtpJidbYCuulP1+8sieirCXGs5FlDhAEL4
         ruUQ==
X-Gm-Message-State: ALoCoQl1EfXzBC5EsIZ2LshtrVB7UjlRtu8j1txYEaNSCXqon9fv0yUgJ6x9PxXkYpCw/8dzKzo1
X-Received: by 10.194.82.9 with SMTP id e9mr51317834wjy.45.1401737664327;
        Mon, 02 Jun 2014 12:34:24 -0700 (PDT)
Received: from spirit (195-240-45-142.ip.telfort.nl. [195.240.45.142])
        by mx.google.com with ESMTPSA id m2sm37739404wjf.42.2014.06.02.12.34.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 02 Jun 2014 12:34:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqq4n035ej3.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250586>

On Mon, Jun 02, 2014 at 11:53:36AM -0700, Junio C Hamano wrote:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> 
> > Instead of calling git-archive HEAD^{tree}, use $(GIT_VERSION)^{tree}.
> > This makes sure the archive name and contents are consistent, if HEAD
> > has moved, but GIT-VERSION-FILE hasn't been regenerated yet.
> >
> > Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
> > ---
> > I have a somewhat odd setup in which I share a .git between multiple
> > checkouts for automated builds. To minimize locking time for parallel
> > builds with different options, there's only a lock around checkout and
> > running git describe $commit > version, the builds themselves run in
> > parallel.
> >
> > This works just fine except during 'make dist', which is hardcoded to
> > package up HEAD, but that's not always the commit that is actually
> > checked out, another process may have checked out something else.
> >
> > I realize this setup is somewhat strange, but the only change necessary
> > to make this work is this one-line patch, so I hope that's acceptable.
> 
> The "dist" target happens to do a clean checkout to a temporary
> directory with "git archive" and then muck with its contents before
> tarring up the result, so moving HEAD around may appear to work for
> this particular target, but htmldocs/manpages targets use what is in
> the current checkout of Documentation/ area.  Turning the HEAD^{tree}
> into $(GIT_VERSION)^{tree} would make the inconsistency between the
> two worse, wouldn't it?

I'd say it would make the consistency better, because now both look at
what is checked out instead of at HEAD. I agree that it's a game of
whack-a-mole though and it's really easy to add another dependency on
HEAD and GIT-VERSION-FILE agreeing with each other.

> If we were to change the "dist" rules, we may want to go in the
> opposite direction.  Instead of using "git archive" to make a
> temporary copy of a directory from a commit, make such a temporary
> copy from the contents of the current working tree (or the index).
> And then tar-up a result after adding configure, version etc. to it.
> That would mean what will be in the tarball can be different from
> even HEAD, which is more consistent with the way how documentation
> tarballs are made.
> 
> Alternatively, you can update the dist-doc rules to make a temporary
> copy of documentation area and generate the documentation tarballs
> out of a pristine source of a known version---which would also make
> these two consistent.  I am not sure which one is more preferrable,
> though.
> 
> Why are you sharing the .git/HEAD across multiple checkouts in the
> first place?  If they are to build all different versions, surely
> these working trees are derived from different commits, no?

I'm sharing all of .git using explicit GIT_DIR and GIT_WORK_TREE
environment variables, sharing .git/HEAD comes with that. What I'm
actually doing is a continuos integration setup that can run many
actions at once in freshly checked-out work trees, but sharing .git to
save space. 

What it specifically doing is running 'make test' for master, next and
pu, and make dist for next. As long as I protect the 'git checkout
$sha1' with a lock, that all works just fine.

> Have you considered using contrib/workdir/git-new-workdir, perhaps?

I have not, thanks for the pointer. That approach is definitely cleaner
than what I am currently doing.

> I dunno.

With the hint above, I actually don't need this patch anymore. And if
you're not convinced it's a good idea, it's probably better to drop it :)

> >  Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index a53f3a8..63d9bac 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2433,7 +2433,7 @@ git.spec: git.spec.in GIT-VERSION-FILE
> >  GIT_TARNAME = git-$(GIT_VERSION)
> >  dist: git.spec git-archive$(X) configure
> >  	./git-archive --format=tar \
> > -		--prefix=$(GIT_TARNAME)/ HEAD^{tree} > $(GIT_TARNAME).tar
> > +		--prefix=$(GIT_TARNAME)/ $(GIT_VERSION)^{tree} > $(GIT_TARNAME).tar
> >  	@mkdir -p $(GIT_TARNAME)
> >  	@cp git.spec configure $(GIT_TARNAME)
> >  	@echo $(GIT_VERSION) > $(GIT_TARNAME)/version

-- 
Dennis Kaarsemaker <dennis@kaarsemaker.net>
http://twitter.com/seveas
