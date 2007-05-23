From: "Dana How" <danahow@gmail.com>
Subject: Re: Rebase max-pack-size?
Date: Tue, 22 May 2007 23:33:27 -0700
Message-ID: <56b7f5510705222333l6e285e67l1dc327322a2ab250@mail.gmail.com>
References: <4648848B.1030304@gmail.com>
	 <7virak5cr5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 23 08:33:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqkPg-0007W3-5A
	for gcvg-git@gmane.org; Wed, 23 May 2007 08:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756713AbXEWGda (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 02:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756670AbXEWGd3
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 02:33:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:49335 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756715AbXEWGd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 02:33:28 -0400
Received: by ug-out-1314.google.com with SMTP id j3so420990ugf
        for <git@vger.kernel.org>; Tue, 22 May 2007 23:33:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ts/dozDux5ynvUOqavfkPph3XKu9pe3J675bQ5FKniGHO7YF+zcZ5mBxbqb/Z8TZY1lqTPELif6M0jemZtL3ehAB8q/s7WOGNT4UlykPd70GynNcO0supeT/kAigWU8mdLIzeeALNZonCRsffAPOtVtPLo1KBsrOM/rij6CYk+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GiBqFvCGgBteGKj25ji+6PP14fRoROMcl6R8IFqIViSTZLSF+glQ5Ti1y6Y6RYmxvUDiTVcUALPLkAEfP/cvo+BS8m9dIul803RALnAlaajIby/7iCL0cgim8eVgAM0zF6UjVJl01ImIPT95bJbB5HWEVhnKR3Ddom3oGodinoc=
Received: by 10.78.150.7 with SMTP id x7mr34364hud.1179902007176;
        Tue, 22 May 2007 23:33:27 -0700 (PDT)
Received: by 10.78.129.3 with HTTP; Tue, 22 May 2007 23:33:27 -0700 (PDT)
In-Reply-To: <7virak5cr5.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48144>

On 5/22/07, Junio C Hamano <junkio@cox.net> wrote:
> Dana How <danahow@gmail.com> writes:
> ----------------------------------------------------------------
> > Subject: [PATCH] Alter sha1close() 3rd argument to request flush only
> >
> > update=0 suppressed writing the final SHA-1 but was not used.
> > Now final=0 suppresses SHA-1 finalization, SHA-1 writing,
> > and closing -- in other words,  only flush the buffer.
>
> What it does is understandable but it somehow feels funny that
> "sha1close(file, hashresult, 0)" does _not_ close it (and does
> not hash either for obvious reasons ;-).  I would say we should
> let it pass this round, but might want to separate the first
> part out into a separate "update hash and flush" function if we
> get more callers.
OK,  see the list at the end.

> ----------------------------------------------------------------
> > Subject: [PATCH 1/4] git-repack --max-pack-size: new file statics and code restructuring
> >
> > Add "pack_size_limit", the limit specified by --max-pack-size,
> > "written_list", the list of objects written to the current pack,
> > and "nr_written", the number of objects in written_list.
> > Put "base_name" at file scope again and add forward declarations.
> > Move write_index_file() call from cnd_pack_objects() to
> > write_pack_file() since only the latter will know how
> > many times to call write_index_file().
>
> I would have split this part a bit differently.
>
> This is mostly about restructuring the code so that
> write_index_file() is called from write_pack_file(), which by
> itself is a very good change (but then we might have been better
> off passing basename as a parameter).
That would have worked too.  I made base_name file scope
b/c that's how it was before NP's immediatley previous patches.

> You are not using written_list nor limit yet but are introducing
> them in this step, which feels not quite right.  I usually compile stuff
> with -Werror, and if I ever have to bisect the series, this would bomb
> out for these unused variables.  Not nice.
Very good point -- I did not think of that.
I will make sure in the future
each patch in a patchset has no warnings.

> ----------------------------------------------------------------
> > Subject: [PATCH 2/4] git-repack --max-pack-size: write_{object,one}() respect pack limit
> >
> > With --max-pack-size,  generate the appropriate write limit
> > for each object and check against it before each group of writes.
> > Update delta usability rules to handle base being in a previously-
> > written pack.  Inline sha1write_compress() so we know the
> > exact size of the written data when it needs to be compressed.
> > Detect and return write "failure".
>
> Again, this is split somewhat wrongly, as you do not have a way
> to set max size from the caller, but more importantly, even
> though write_one and write_object knows to obey the limit
> (perhaps somebody bisecting this series later may set the limit
> under the debugger, to work around the lack of option parser),
> write_pack_file() does not notice zero return from write_one();
> I would have added a check there to do:
>
>         die("sorry, limit reached and we do not have code to split the pack yet.")
>
> which obviously can be updated in the next patch.
This makes sense to me.  In a previous version of the patchset,
I had some temporary code like you say (just some extra
arguments, not any checking or die() calls) which was
immediately changed/replaced in the next patch.
Shawn or Nicolas didn't like that,
so I migrated to the split I used here.

I didn't really intend bisecting this patchset to do
anything useful *with respect to max-pack-size functionality*,
but bisecting it would be useful to detect if these patches
had broken something else.  But I can rethink that in
the future.

> ----------------------------------------------------------------
> > Subject: [PATCH 3/4] git-repack --max-pack-size: split packs as asked by write_{object,one}()
> >
> > Rewrite write_pack_file() to break to a new packfile
> > whenever write_object/write_one request it,  and
> > correct the header's object count in the previous packfile.
> > Change write_index_file() to write an index
> > for just the objects in the most recent packfile.
> >
> > diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> > --- a/builtin-pack-objects.c
> > +++ b/builtin-pack-objects.c
> > @@ -652,7 +663,26 @@ static void write_pack_file(void)
> > +     } while (nr_remaining && i < nr_objects);
> > +
> > +     for (j = 0; i < nr_objects; i++) {
> > +             struct object_entry *e = objects + i;
> > +             j += !e->offset && !e->preferred_base;
> > +     }
> > +     if (j)
> > +             die("wrote %u objects as expected but %u unwritten", written, j);
> I am a bit confused by this loop.  Don't you have to start with i=0
> for this check to be meaningful?
The previous do-while loop whose last line is shown
could end with i < nr_objects due to nr_remaining becoming
0.  This means the objects [i ... nr_objects) have not been
inspected.  They should all be either already written
or non-writable,  which is what the two terms in the && expression
are testing.  See list at end.

> ----------------------------------------------------------------
> > Subject: [PATCH 4/4] git-repack --max-pack-size: add option parsing to enable feature
> >
> > Add --max-pack-size parsing and usage messages.
> > Upgrade git-repack.sh to handle multiple packfile names,
> > and build packfiles in GIT_OBJECT_DIRECTORY not GIT_DIR.
> > Update documentation.
> >
> > diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> > --- a/builtin-pack-objects.c
> > +++ b/builtin-pack-objects.c
> > @@ -1713,6 +1713,13 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
> > +             if (!prefixcmp(arg, "--max-pack-size=")) {
> > +                     char *end;
> > +                     pack_size_limit = strtoul(arg+16, &end, 0) * 1024 * 1024;
> > +                     if (!arg[16] || *end)
> > +                             usage(pack_usage);
> > +                     continue;
> > +             }
>
> Hmmm.  I was almost going to suggest to have this spelled in
> bytes, with suffixes like k/m/g.  However, because wanting to
> limit a pack under 1.4MB does not make much sense these days,
> and because having to spell "up to 2GB" as 2047 is not too much
> trouble, I think this is Ok.
I thought about suffixes too but I chose this way
b/c that's how git fast-import does it.

> Shouldn't we have a safety to error out when --stdout and
> --max-pack-size are both given?  Currently it silently ignores
> the limit, doesn't it?
Yes & yes.  Previously there was disagreement on this point.
One preference was to disallow the combination,
another was that it was useful and should be supported.
So I left the code in a state where a small follow-on patch
could make the decision.  The current behavior is not
to disallow the combination,  and it is well-defined
(you get a sequence of packs on stdout,  concatenated,
whose headers indicate how many objects there are
in the current pack and all following).

I do not think --stdout && --max-pack-size is currently
useful,  and a follow-on patch should complain.
See list at end.

> > diff --git a/git-repack.sh b/git-repack.sh
> > --- a/git-repack.sh
> > +++ b/git-repack.sh
> > @@ -35,7 +36,7 @@ true)
> > -PACKTMP="$GIT_DIR/.tmp-$$-pack"
> > +PACKTMP="$GIT_OBJECT_DIRECTORY/.tmp-$$-pack"
>
> Although this is a good change, this hunk does not belong to
> this.
OK.
If you decide not to keep this change here for historical clarity,
I can add it back later.

> Overall everything looks good, except some minor details noted
> above.  Separation of the commits into logical steps does not
> need to be fixed up (they are already in 'next'), but follow-up
> patches might be needed.
OK,  I will not edit and re-submit these patches.
But I will submit two follow-on patches:

Patch 1:
* Pull "sha1flush()" or similar out of sha1close() inside csum-file.c.
  This will require some edits to callers.

Patch 2:
* Add a comment to "confusing loop" to explain what it's checking.
* Complain about --stdout && --max-pack-size combination.

This will have to happen tomorrow.

> And I have to agree with Linus; responding this way was more
> cumbersome than it should have been.
Understood.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
