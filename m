From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH v3] Prevent megablobs from gunking up git packs
Date: Sat, 26 May 2007 16:48:18 -0700
Message-ID: <56b7f5510705261648g7d3dc2f6lb68b3a6a8dd10012@mail.gmail.com>
References: <465887AB.1010001@gmail.com>
	 <7vwsyvgpvf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 27 01:48:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs600-0006WZ-4u
	for gcvg-git@gmane.org; Sun, 27 May 2007 01:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbXEZXsU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 19:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752829AbXEZXsU
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 19:48:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:4239 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbXEZXsT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 19:48:19 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1384621ugf
        for <git@vger.kernel.org>; Sat, 26 May 2007 16:48:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h4B/4PABFmfuE0lIsNv5A1ASd1ygYjC3sN8eNzWDRxPQxUz5BrEjANSnJ069BYtbSCH3OWFzmPTK5vob7Hn9eVT6w0N/JxCumRE7aUZglKnlvS/tDzqPlsh8ocu305R0Y85cbmQ7DVGLLCu4CuFihJQNt7Db7uhNw70IMVnKNPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YrEAk1+kVWJVCyo3B63MyYKrN4FqepM8/UmAxqSShumUEaYvCaKmW8Xx+bo+JSolo0X+vP5urjOJJlWpDXwANK5mgLbk1pyqI36AMFwa336BwTDVCxIgnuEme5OEukHDXrKPbby58JVjAtq3iMsAXRuVyUmhxxIxSHMvMcqxz5k=
Received: by 10.78.162.4 with SMTP id k4mr1306318hue.1180223298092;
        Sat, 26 May 2007 16:48:18 -0700 (PDT)
Received: by 10.78.129.3 with HTTP; Sat, 26 May 2007 16:48:18 -0700 (PDT)
In-Reply-To: <7vwsyvgpvf.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48508>

On 5/26/07, Junio C Hamano <junkio@cox.net> wrote:
> Dana How <danahow@gmail.com> writes:
> > diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> > @@ -371,8 +372,6 @@ static unsigned long write_object(struct sha1file *f,
> >                               /* no if no delta */
> >       int usable_delta =      !entry->delta ? 0 :
> > -                             /* yes if unlimited packfile */
> > -                             !pack_size_limit ? 1 :
> >                               /* no if base written to previous pack */
> >                               entry->delta->offset == (off_t)-1 ? 0 :
> >                               /* otherwise double-check written to this
> > @@ -408,7 +407,7 @@ static unsigned long write_object(struct sha1file *f,
> >               buf = read_sha1_file(entry->sha1, &type, &size);
> >               if (!buf)
> >                       die("unable to read %s", sha1_to_hex(entry->sha1));
> > -             if (size != entry->size)
> > +             if (size != entry->size && type == obj_type)
> >                       die("object %s size inconsistency (%lu vs %lu)",
> >                           sha1_to_hex(entry->sha1), size, entry->size);
>
> I do not quite get how these two hunks relate to the topic of
> this patch.  Care to enlighten?

No problem.

When the code decides that a blob should not be written to the output file,
then I must make sure it is not used as a delta base.  A large blob
that triggered the size test and _was_ a delta base could be the result
of maxblobsize decreasing or being newly specified,
both without -f/--no-object-reuse,
and we need to tolerate the user forgetting the option.

To make sure that it is not so used,  I re-use the trick from maxpacksize
which ensures that a delta base is not in the previous split pack:
I set the offset field to -1.  Unfortunately,  I only checked for this magic
value when computing usable_delta if pack_size_limit was set.  It turns
out the test doesn't need to be conditional on pack_size_limit,  it works
for all cases;  so since I need to do the test when maxblobsize was specified
and maxpacksize wasn't, I deleted the pack_size_limit test.

Now for the second hunk.  The facts above mean we could have marked
this entry as a re-used delta, but we are unable to re-use the delta
because its delta base is not being written to this pack.  So we fall into
the !to_reuse case even though the size field in the object_entry is the
size of the delta,  not the object.  We can detect this by the type coming
from read_sha1_file being unequal to the type set from the pack (which is
one of OBJ_{REF,OFS}_DELTA).  So I disable the size matching
test in this case.

> > @@ -564,6 +563,17 @@ static off_t write_one(struct sha1file *f,
> > +     /* refuse to include as many megablobs as possible */
> > +     if (max_blob_size && e->size >= max_blob_size) {
> > +             struct stat st;
> > +             /* skip if unpacked, remotely packed, or loose anywhere */
> > +             if (!e->in_pack || !e->in_pack->pack_local || find_sha1_file(e->sha1, &st)) {
> > +                     e->offset = (off_t)-1;  /* might drop reused delta base if mbs less */
> > +                     written++;
> > +                     return offset;
> > +             }
> > +     }
> > +
>
> I thought that you are simply ignoring the "naughty blobs"---why
> should it be done this late in the call sequence?  I haven't
> followed the existing code nor your patch closely, but I wonder
> why the filtering is simply done inside (or by the caller of)
> add_object_entry().  You would need to do sha1_object_info()
> much earlier than the current code does, though.

Recently Nicolas Pitre improved the code as follows:
(1) tree-walking etc. which calls add_object_entry.
    We learn sha1, type, name(path), pack&offset, no_try_delta
    during this step.
(2) NEW: sort a table of pointers to these objects by pack_offset.
(3) Now call check_object on each object, but in the order
     determined in (2).  We learn each object's size during
     this step.  This requires us to inspect each object's header
     in the pack(s).

The result is that we smoothly scan through the pack(s),
instead of jumping all over the place.

If I move sha1_object_info earlier,  before (2),  then I undo
his optimization.  This fact ultimately justifies the first two
hunks that you commented on,  since it means we want
the objects to appear in the object list _before_ we can
decide not to write them,  and thus we need to handle
objects not written and all their consequences
(which didn't seem too strange to me,
since you already have preferred bases).

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
