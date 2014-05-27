From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] clean: add a flag to back up cleaned files
Date: Tue, 27 May 2014 20:12:52 +0200
Message-ID: <CABPQNSbo-cUHfu-uGZELntYJ6ymNUzOZjL3z2-OppK__fZ+KqQ@mail.gmail.com>
References: <1401200254-4592-1-git-send-email-kusmabite@gmail.com> <20140527163700.GB29693@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 27 20:13:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpLsX-0007VD-Jh
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 20:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbaE0SNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 14:13:33 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:47623 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbaE0SNc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 14:13:32 -0400
Received: by mail-ie0-f174.google.com with SMTP id lx4so8920133iec.5
        for <git@vger.kernel.org>; Tue, 27 May 2014 11:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=JmOa31j3DMNqncq2CiVNyNEoH5DXDgB2Lg2H4o5NvnU=;
        b=YcQSBTWKhjjyet2fpg295BioNCmaVz6MmhNI8qDUzRtYgSLN/9eSiW2JoX2Ejueo23
         /EJNm0BMSO/uWTThsimO+GlYe9K3wrRxp/FKkDYle6V1+cHzncd294qDtVgdCGAAwRRW
         Hs5lNzADk0iUO3YIK87rvVxuK6ZZx7t99f/AE4mBfCsZQkiA6W/L3XOov3FqDcDgyWhe
         i2PA1YZtrKiS/m8H6nNuYNtyLr512xFi5oSsK2HQlCYmspMzQNHFOI57ivQWOAjGPfF1
         GlWuVDqFBJmnBttHrxg6F5f4HqPGEzC7fT1KcjuMQ3cfLg7Q5nWY25CLYubYAW890klE
         r1nA==
X-Received: by 10.50.13.42 with SMTP id e10mr35323418igc.24.1401214412213;
 Tue, 27 May 2014 11:13:32 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Tue, 27 May 2014 11:12:52 -0700 (PDT)
In-Reply-To: <20140527163700.GB29693@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250181>

On Tue, May 27, 2014 at 6:37 PM, Jeff King <peff@peff.net> wrote:
> On Tue, May 27, 2014 at 04:17:34PM +0200, Erik Faye-Lund wrote:
>
>> The combination of "git clean" and fat fingers can some times cause
>> data-loss, which can be frustrating.
>>
>> So let's add a flag that imports the files to be deleted into the
>> object-database, in a way similar to what git-stash does. Maintain
>> a reflog of the previously backed up clean-runs.
>>
>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>> ---
>> I've had a similar patch laying around for quite a while, but since
>> f538a91 ("git-clean: Display more accurate delete messages"), this
>> patch is a lot less nasty than before. So here you go, perhaps
>> someone else has fat fingers and hate to lose work?
>
> I've definitely considered doing something like this before (and for
> "git reset --hard"). My biggest concern would be poor performance in
> some cases. But since it's optional, and one can presumably override it
> with --no-backup for a specific large cleanup, it would not hurt anybody
> who does not want to play with it.

I also made it opt-in rather than opt-out by default. Perhaps it
shouldn't be, though - dunno.

>> +     /* load HEAD into the index */
>> +
>> +     tree = parse_tree_indirect(sha1);
>> +     if (!tree)
>> +             die(_("Failed to unpack tree object %s"), sha1);
>> +
>> +     parse_tree(tree);
>> +     init_tree_desc(&t, tree->buffer, tree->size);
>> +
>> +     memset(&opts, 0, sizeof(opts));
>> +     opts.head_idx = -1;
>> +     opts.src_index = &the_index;
>> +     opts.dst_index = &the_index;
>> +     opts.index_only = 1;
>> +
>> +     if (unpack_trees(1, &t, &opts)) {
>> +             /* We've already reported the error, finish dying */
>> +             exit(128);
>> +     }
>
> This bit of the code surprised me. I guess you are trying to re-create
> the index state of the HEAD so that the commit you build on top of it
> contains _only_ the untracked files as changes, and not whatever
> intermediate index state you had.  That makes some sense to me, as clean
> is never touching the index state.

TBH, I didn't really think this stuff through, I basically just hacked
on this until I got it to save away superfluous files when the index
matched HEAD. So this part is more accidental than designed. I'm not
very familiar with the index-maniuplation code in Git either.

I *think* the right thing to do would be to save the tree of HEAD
*plus* those deleted files in this case. That way it only records the
destruction itself. This does *not* seem to be what currently happens.
If I have a change staged, that staged change also gets included in
the commit. That's not ideal, I think.

> Though taking a step back for a moment, I'd like to think about doing
> something similar for "reset --hard", which is the other "destructive"
> operation in git[1]. In that case, I think saving the index state is also
> useful, because it is being reset, too (and while those blobs are
> recoverable, the exact state is sometimes useful).

I agree. I guess that should essentially do a "full" git-stash.

> If we were to do that, should it be a separate ref? Or should there be a
> single backup ref for such "oops, undo that" operations? If the latter,
> what should that ref look like? I think it would look something like
> refs/stash, with the index and the working tree state stored as separate
> commits (even though in the "clean" case, the index state is not likely
> to be that interesting, it is cheap to store and makes the recovery
> tools uniform to use).

Hmm, perhaps. I do like the concept of a "git undo" of sorts, but
perhaps that'll raise the expectations even further? Or maybe raising
them a good thing, so people add missing features? :)

> And if we are going to store it like that, should we just be using "git
> stash save --keep-index --include-untracked"? I think we would just need
> to teach it a "--no-reset" option to leave the tracked files as-is.

Hm, interesting. But it does leave me with a bit of a bad feeling; git
stash is currently a shell-script, and I want us to move *away* from
depending on those rather than towards... Or perhaps I just convinced
myself to port git-stash to C? I guess the full script won't be
needed, only the heavy lifting...

> I realize that I went a few steps down the "if..." chain there to get to
> "should we just be using stash?". But it would also make the code here
> dirt-simple.

Simplicity is good, and it's always good to hear some different ideas
on how to reach a goal.

> [1] Actually, "reset --hard" may be more of an education issue, as
>     simply running "git stash" has the same effect, but keeps a backup.
>     It's just that "reset --hard" is advertised as the solution to many
>     problems.
>
>> +     if (!active_cache_tree)
>> +             active_cache_tree = cache_tree();
>> +
>> +     if (!cache_tree_fully_valid(active_cache_tree)) {
>> +             if (cache_tree_update(active_cache_tree,
>> +                 (const struct cache_entry * const *)active_cache,
>> +                 active_nr, 0) < 0)
>> +                     die("failed to update cache");
>> +     }
>
> I'd have thought you could use write_cache_as_tree, which backs "git
> write-tree", but there is currently no way to convince it not to write
> out the new cache. This is little enough code that it may not be worth
> refactoring write_cache_as_tree to handle it.
>

I think not having to maintain multiple copies might make it worth
factoring it out. Sure, it's not *that* complicated, but it *is*
pretty well-contained.

>> +     /* create a reflog, if there isn't one */
>> +     git_snpath(logfile, sizeof(logfile), "logs/%s", ref);
>> +     if (stat(logfile, &st)) {
>> +             FILE *fp = fopen(logfile, "w");
>> +             if (!fp)
>> +                     warning(_("Can not do reflog for '%s'\n"), ref);
>> +             else
>> +                     fclose(fp);
>> +     }
>
> Kind of gross that we have to do this ourselves (and somewhat contrary
> to efforts elsewhere to make the ref code more abstract), but I see that
> "git stash" does the same thing.

Hmm, it seems like log_ref_setup might be able to do the work for us,
if it wold take a flag to force O_CREAT. Perhaps that's worth the
effort?

> Should you fopen with "a" here, to avoid a race condition where another
> process creates it between the stat() and the fopen(), in which case we
> would truncate what they wrote? You could even just get rid of the
> stat(), then, like:
>
>   if ((fp = fopen(logfile, "a")))
>         fclose(fp);
>   else
>         warning(_("Can not do reflog for '%s'"), ref);
>
> Also note that your warning has an extra "\n" in it.

Good catch, thanks. Both details :)
