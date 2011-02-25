From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCH] commit notes workflow
Date: Fri, 25 Feb 2011 16:58:22 +0100
Message-ID: <201102251658.22678.johan@herland.net>
References: <20110225133056.GA1026@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 25 16:58:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt03v-0002xj-5d
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 16:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565Ab1BYP63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 10:58:29 -0500
Received: from smtp.opera.com ([213.236.208.81]:48910 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932411Ab1BYP63 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 10:58:29 -0500
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p1PFwMao004677
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 25 Feb 2011 15:58:23 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <20110225133056.GA1026@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167913>

On Friday 25 February 2011, Jeff King wrote:
> So my solution was that "git commit" should be able to embed and
> extract notes from the commit message itself. The patch below
> implements "git commit --notes", which does two things:
>
>   1. If we are amending, it populates the commit message not just
> with the existing message, but also with a "---" divider and any
> notes on the commit.
>
>   2. After editing the commit message, it looks for the "---" divider
>      and puts everything after it into a commit note (whether or not
> it put in a divider in step (1), so you can add new notes, too).
>
> So your commit template looks like:
>
>   subject
>
>   commit message body
>   ---
>   notes data
>
>   # usual template stuff
>
> I'm curious what people think. Do others find this useful? Does it
> seem harmful?

I _really_ like the idea. :)

> It's yet another magic format to worry about when writing a commit
> message. But you don't need to care unless you use "--notes" (and I
> would probably add a config option, since I would always want this on
> personally). And "---" is already something to be aware of, since
> "am" treats it specially (technically, I could just drop "notes"
> entirely and use "---" in my commit message; so perhaps this is just
> overengineering).

Maybe we should use a slightly more verbose separator (i.e. more 
unlikely to trigger false positives). As you say, we already have to 
watch out for "---" because of "am", but that only applies to projects 
that _use_ "am" (i.e. mailing-list-centric projects like git.git and 
the Linux kernel). Other projects (e.g. github-centric projects or most 
centralized "$dayjob-style" projects) seldom or never use "am" at all, 
so I wouldn't expect those developers think of "---" as "special" in 
any way.

What about using something like "--- Notes ---" instead?

> How should this interact with --cleanup? Right now it splits
> everything after the "---" into the notes part, including any "#"
> lines. Which should be fine, I think, because they get pulled out by
> stripspace in either case. If you were using --cleanup=verbatim, then
> you'd have gotten rid of them manually anyway. And if you really want
> a literal "---", you would use "git commit" (or "git commit
> --no-notes" once there is a config option). So I think the behavior
> in this patch is sane.

What if you combine --notes with --verbose (i.e. including the 
diff-to-be-committed in the commit message template)?

AFAICS, stripspace() doesn't know how to remove the diff (there's a 
separate section in cmd_commit() discarding everything 
following "\ndiff --git ").

> I only turn on --edit when we launch an editor. It seems somehow more
> confusing to me that "git commit -F file" should split notes out (or
> worse, "git commit -m"). If you are doing things non-interactively,
> it's probably not a big deal to just call "git notes add" separately.
> And I expect "-F" is used by porcelains, or people wanting to do
> verbatim stuff.

Agreed.

> How should this interact with the commit-msg hook? In my
> implementation, it sees the whole thing, message and notes. Should we
> be picking apart the two bits after the editor and rewriting the
> COMMIT_EDITMSG before the hook sees it?

I'm not sure about this, but I suspect we should follow the same 
behaviour as --verbose (i.e. does the commit-msg hook see the entire 
diff inline in the commit message?).

A short look at builtin/commit.c indicates that we should leave 
everything in there for the commit-msg hook (AFAICS, the commit-msg 
hook is invoked from prepare_to_commit(), which is invoked from 
cmd_commit() _before_ the verbose diff part is removed.)

> How should this interact with the post-rewrite hook? I obviously need
> to set that up for my workflow, too, but I haven't yet. This patch
> does nothing, but I'm pretty sure it should turn of "git commit
> --amend" calling the rewrite hook if we are using --notes (since the
> user has already seen and edited the notes, and we've written them
> out).

I don't see what this has to do with the post-rewrite hook. Currently, 
the post-rewrite documentation ("git help hooks") states that it is run 
_after_ the automatic notes copying. AFAICS, your --notes simply 
replaces the usual automatic notes copying with a 
semi-automatic "edit-and-copy" instead. But this all happens before the 
port-rewrite hook is called, and thus shouldn't affect it.

> @@ -730,6 +780,9 @@ static int prepare_to_commit(const char
> *index_file, const char *prefix, strbuf_release(&sob);
>  	}
>
> +	if (edit_notes && amend)
> +		add_notes_from_commit(&sb, "HEAD");

I haven't read the sources closely enough to figure out when/where the 
commit diff is added to the commit message (in case of --verbose), but 
I trust that it happens _after_ the above lines (so that the notes part 
doesn't end up after the diff)

Otherwise, this looks good to me from a precursory review.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
