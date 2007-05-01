From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 6/8] git-repack --max-pack-size: write_one() implements limits
Date: Mon, 30 Apr 2007 23:00:40 -0700
Message-ID: <56b7f5510704302300i6c44760dn111729f669493766@mail.gmail.com>
References: <46367A68.4010008@gmail.com> <20070501052517.GA5942@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 01 08:00:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HilPu-0002lr-R7
	for gcvg-git@gmane.org; Tue, 01 May 2007 08:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423819AbXEAGAr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 02:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423816AbXEAGAq
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 02:00:46 -0400
Received: from nz-out-0506.google.com ([64.233.162.224]:59491 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946606AbXEAGAl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 02:00:41 -0400
Received: by nz-out-0506.google.com with SMTP id o1so2146122nzf
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 23:00:40 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s6IGCJ7Rgl6f4V4WDcXj7VIAlP7oVWJiRR/WBMfgY3kuw50ov6z7oKzkiRhQqZKlMhyDFM3BxuQGrncbqdXJNx+Tk91eoZwdYlH4BbW28iFRR2kz1vNRBtA4x0jtsP55PI4ZmJfK36GHheYsi6X409a+j6Lte5Qi8Jk1jcZ/mok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=txFHhUd06BYgACB844lAuaviVurQ6HIsvvF6A0kFOPjTdFR0r/l+M5wEs69p5In4gtOYCNgq5fA+vLrR7MBB2UrWCwFROWIRBbc1pHla5w/3QhZMU/4xzQOho9TODoN5ErCVvERIl9UyXkmI9J4MN0sCPnhcqZPBjWzuYnRzxq4=
Received: by 10.114.180.1 with SMTP id c1mr2257014waf.1177999240327;
        Mon, 30 Apr 2007 23:00:40 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Mon, 30 Apr 2007 23:00:40 -0700 (PDT)
In-Reply-To: <20070501052517.GA5942@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45919>

On 4/30/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Dana How <danahow@gmail.com> wrote:
> >       /* if we are deltified, write out base object first. */
> > -     if (e->delta)
> > +     if (e->delta) {
> >               offset = write_one(f, e->delta, offset);
> > +             if (!offset)
> > +                     return 0;
> > +     }
>
> So offset == 0 means we didn't write this object into this packfile?
> Did I read your changes right?
Yes.  write_object()/write_one() return 0 to indicate
that the write was "refused" due to pack size limits.

Note that entry->offset has *2* special values now:
0 to indicate not yet written (any "real" offset is >= 12), and
(off_t)-1 to indicate written but to previous pack.
In my previous patchsets, the latter condition was indicated
by a new field in object_entry, but since Nicolas Pitre just
optimized its space usage I figured I wouldn't immediately undo his work...

> >       e->offset = offset;
> > -     size = write_object(f, e, 0);
> > +     /* pass in write limit if limited packsize and not first object */
> > +     size = write_object(f, e, pack_size_limit && nr_written ? pack_size_limit - offset : 0);
>
> Why wasn't this in the prior patch?  You had almost everything in
> place, but hardcoded the option to 0, to then just change it here
> in this patch to non-zero under some conditions?
I broke up the patches by function changed.  The goal
was to change 1 function per patch,  plus whatever minor
stuff (e.g. ,0 above) was needed to make it compile.
That was followed too rigidly: the write_object() and write_one()
changes should have been together in 1 patch.

> I'd also like to see that line <80 characters, but that's just me
> and my own style preferences.
The 3rd arg should be on its own line.
Funny I didn't do that.

> But isn't that argument actually kind of silly here?  None of
> the values that are used to compute that 3rd boolean argument to
> write_objet depend on things that are local to write_one - they
> are all global values.  Can't we spare the poor register-starved
> x86 platform and just let write_object compute that value itself?
That all makes sense.  I left it this way out of laziness and
because Junio suggested putting a limit into sha1write_compressed(),
so I left the new argument to write_object() as a limit,
thinking (unclearly?) I might follow his suggestion later.

> > +     if (!size)
> > +             return e->offset = 0;
>
> Ugh.  I don't really like to see assignment in the middle of an
> evaluation of an rvalue, and especially here in a return.  Burn the
> couple of lines to segment it out:
>
>         if (!size) {
>                 e->offset = 0;
>                 return 0;
>         }
>
> or something.  Because its a lot more clear and doesn't look like
> you missed an = to make "return e->offset == 0".
Hmm,  I only worry about the =/== issue when the context
expects a condition, and this function was _not_ declared boolean.
However, it's just as easy to do what you suggest.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
