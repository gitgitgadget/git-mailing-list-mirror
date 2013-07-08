From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 05/22] read-cache: add index reading api
Date: Mon, 8 Jul 2013 19:45:39 +0700
Message-ID: <CACsJy8CtOWjpxKuNhQXYjPAv8MU0U6yTBEuQeqm0kxqVne6NjQ@mail.gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
 <1373184720-29767-6-git-send-email-t.gummerer@gmail.com> <CACsJy8C0F+v3g+gPon6Y8+z7ObN1Jv8Ln==RNrVsRp7aya74hw@mail.gmail.com>
 <87pputqowr.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 14:46:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwApb-0000TS-AO
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 14:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409Ab3GHMqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 08:46:11 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:49576 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab3GHMqK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 08:46:10 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so5357485obq.7
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 05:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lrUVCEVUKxPSUcorURzCD9IYPh7wXwHNaZEB7/Xn7rg=;
        b=kDZKSAHU7HfPpGntlPe6w6L2c2Iq+rx/hOHHYbll+5ygjSApkLNJ1J6ZPogHJIXi0P
         3nc50UpnfFGnZgS5Dx6LXKgDE8TXDPID+MGJFKevma3k/iV5r0SwBU5UeppU3EVlf2lM
         BtsUrJCXQFeX0Nj4ufL9YpWK344orVF+yHjlmDXkr9sLee5rxJdZG9To4zt6Hz2EGfDK
         vJFdYWEXMZXv66CNSXTzhkKUzjKRo+RgYXqe5Y7bsEz7rKyMAAjXZ6WwiXwsuwJ68I+6
         /e5k1jkYkjt9TarWV0IWZO7gO+ysq48JmNoCRgg1V3Q0tpFIFZ6wTIW4V/fe3wP/oCp0
         uWAw==
X-Received: by 10.60.47.41 with SMTP id a9mr19836771oen.78.1373287569355; Mon,
 08 Jul 2013 05:46:09 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Mon, 8 Jul 2013 05:45:39 -0700 (PDT)
In-Reply-To: <87pputqowr.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229844>

On Mon, Jul 8, 2013 at 6:20 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>> Putting filter_opts in index_state feels like a bad design. Iterator
>> information should be separated from the iterated object, so that two
>> callers can walk through the same index without stepping on each other
>> (I'm not talking about multithreading, a caller may walk a bit, then
>> the other caller starts walking, then the former caller resumes
>> walking again in a call chain).
>
> Yes, you're right.  We need the filter_opts to see what part of the
> index has been loaded [1] and which part has been skipped, but it
> shouldn't be used for filtering in the for_each_index_entry function.
>
> I think there should be two versions of the for_each_index_entry
> function then, where the for_each_index_entry function would behave the
> same way as the for_each_index_entry_filtered function with the
> filter_opts parameter set to NULL:
> for_each_index_entry_filtered(struct index_state *, each_cache_entry_fn, void *cb_data, struct filter_opts *)
> for_each_index_entry(struct index_state *, each_cache_entry_fn, void *cb_data)
>
> Both of them then should call index_change_filter_opts to make sure all
> the entries that are needed are loaded in the in-memory format.
>
> Does that make sense?

Hmm.. I was confused actually (documentation on the api would help
greatly). If you already filter at load time, I don't think you need
to match again. The caller asked for filter and it should know what's
in there so for_each_index_entry just goes through all entries without
extra match_pathspec. Or is that what next_index_entry for?
match_pathspec function could be expensive when glob is involved. If
the caller wants extra matching, it could do inside the callback
function.

It seems you could change the filter with index_change_filter_opts. In
v5 the index will be reloaded. What happens when some index entries
area already modified? Do we start to have read-only index "views" and
one read-write view? If partial views are always read-only, perhaps we
just allow the user to create a new index_state (or view) with new
filter and destroy the old one. We don't have to care about changing
or separating filter in that case because the view is the iterator.

I wanted to have a tree-based iterator api, but that seems
incompatible with pre-v5 (or at least adds some overhead on pre-v5 to
rebuild the tree structure). It looks like using pathspec to build a
list of entries, as you did, is a good way to take advantage of
tree-based v5 while maintaining code compatibility with pre-v5. By the
way with tree structure, you could use tree_entry_interesting in
read_index_filtered_v5. I think it's more efficient than
match_pathspec.

I'm still studying the code. Some of what I wrote here may be totally
wrong due to my lack of understanding. I'll get back to you later if I
find something else.

> [1] That is only important for the new index-v5 file format, which can
>     be loaded partially.  The filter_opts could always be set to NULL,
>     as the whole index is always loaded anyway.
--
Duy
