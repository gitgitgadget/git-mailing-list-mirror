From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: A look at some alternative PACK file encodings
Date: Thu, 7 Sep 2006 10:19:03 -0400
Message-ID: <9e4733910609070719g42ff7d9buf4b798a9c6b3a7ee@mail.gmail.com>
References: <9e4733910609070557jd8cfc57nd4f7a8973b69f6ed@mail.gmail.com>
	 <20060907133456.24226.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Thu Sep 07 16:19:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLKik-00026C-1d
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 16:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWIGOTG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 10:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWIGOTG
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 10:19:06 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:62932 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932217AbWIGOTE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 10:19:04 -0400
Received: by py-out-1112.google.com with SMTP id x66so333390pye
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 07:19:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gTYyyewL3ucFFJQpZuj5zpueGMdCa74KcIRzlAwpCq9lzo6IW4uUfuU5c7xC05UxUok9PJ/ugzFut/EhiJpLnt8ngtDb8auAk1AtliK2vDw1DmiDlnu15+fLsJG7hYCoRMaVlu+VeGR68qNv24yCfKW1SxAnAQ23QuFUagOq44o=
Received: by 10.35.72.1 with SMTP id z1mr774479pyk;
        Thu, 07 Sep 2006 07:19:03 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Thu, 7 Sep 2006 07:19:03 -0700 (PDT)
To: "linux@horizon.com" <linux@horizon.com>
In-Reply-To: <20060907133456.24226.qmail@science.horizon.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26639>

On 7 Sep 2006 09:34:56 -0400, linux@horizon.com <linux@horizon.com> wrote:
> >> An alternative would be to create a small "placeholder" object that
> >> just gives an ID, then refer to it by offset.
> >>
> >> That would avoid the need for an id/offset bit with every offset,
> >> and possibly save more space if the same object was referenced
> >> multiple times.
> >>
> >> And it just seems simpler.
>
> > There are 2 million objects in the Mozilla pack. This table would take:
> > 2M *  (20b (sha)  + 10b(object index/overhead) = 60MB
> > This 60MB is pretty much incompressible and increases download time.
> >
> > Much better if storage of the sha1s can be totally eliminated and
> > replaced by something smaller. Alternatively this map could be
> > stripped for transmission and rebuilt locally.
>
> Um, I think I wasn't clear.  Objects in a "thin" pack (for network
> updating of a different pack) that are referred to but not included
> would have stand-ins containing just the object ID.  Objects that *are*
> present would simply be present and referred to by offset as usual.

Yes I missed the thin pack context. Has anyone tried building a thin
pack? Having thin packs would address major concerns with the download
time of the initial Mozilla checkout. Right now you have to download
450MB of data that 99% of the people are never going to look at.

Thin packs would also set an 'archival' bit as discussed earlier. The
'archival' bit tells the local tools to leave these packs alone. You
don't want to accidentally trigger a 450MB down just because you did a
git-repack. Of course git would need to developer error messages
indicating that you asked for something in the archive that isn't
present.

I'm not sure I would mix these external references in with other
objects. Instead I would make a pair of packs, one only contains
external reference stubs and is tiny. The second is the full version
of the same data. That makes getting the old data easy, it just
replaces the stub pack. The stub pack doesn't need to contain stubs
for all the objects, only the ones referenced upstream.

I haven't tried doing this, does the current git code support having
multiple pack files covering difference pieces of the project? Can we
have an archive pack and a local current pack that get merged
together?

> Imagine you have a "thin" pack containing a delta to an object that the
> recipient has, so isn't in the pack.  The delta has to specify the
> base object somehow.  If the base object is in the pack, you can
> specify it by offset.  If it's not, you can either:
>
> - Generalize the base object pointer to allow an object ID option, or
> - Provide a pointer to a magic kind of "external reference" pointer
>   object.
>
> I was proposing the latter.
>
> For regular packs, such objects wouldn't even be present, because
> all base objects are in the pack itself.
>
> And, of course, you'd only create such objects if you needed to,
> if there was at least one pointer to them.
>
> Compared to putting the object ID directly in the pointer, it has
> Cost:   An extra offset pointer and object header.
>         Extra time follwoing the indirection resolving the pointer.
> Benefit: Non-indirect object pointers are a bit smaller.
>         The code is simpler.
>         Second and later references to the same external object are
>         another offset, not another 20 bytes.
>


-- 
Jon Smirl
jonsmirl@gmail.com
