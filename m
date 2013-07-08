From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 05/22] read-cache: add index reading api
Date: Mon, 08 Jul 2013 15:37:17 +0200
Message-ID: <87d2qtqik2.fsf@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com> <1373184720-29767-6-git-send-email-t.gummerer@gmail.com> <CACsJy8C0F+v3g+gPon6Y8+z7ObN1Jv8Ln==RNrVsRp7aya74hw@mail.gmail.com> <87pputqowr.fsf@gmail.com> <CACsJy8CtOWjpxKuNhQXYjPAv8MU0U6yTBEuQeqm0kxqVne6NjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 15:37:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwBdC-0007gJ-3q
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 15:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899Ab3GHNhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 09:37:23 -0400
Received: from mail-ea0-f174.google.com ([209.85.215.174]:34011 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442Ab3GHNhW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 09:37:22 -0400
Received: by mail-ea0-f174.google.com with SMTP id o10so2901753eaj.19
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 06:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=3CE1bVrqxzhEEM2trpvvU4wSveBhu3TFLVpyCa0jOcM=;
        b=uvj2AQhuZEQlM8KuPDBHa7egw7MTHttyX4em5J/pmvKdNmP7y6uu/vwTnhz9bMIqkB
         kqmXErqP+zn+V4jJDktioM2jWfTHzp4fp/vHZvWES2E+srLxrw28S4YKEBvtFKGoSYx1
         OL6KkWrkTq47b5cGDv90OfSngWCyswcbNvw4GGTFuINoTVxcwlsxTUhQkixd4+Ov9OAA
         97f99z3mGA8jZoxzDhKFm7YVrqis+NzBmY2DhoR/sT5Yj4wAXzqKbhpm07UGzPPuFAf9
         0EYmXlphyToDL+OMYnpMkOcWwVhrMlhcCvoMflVDB4hmtv8sxM4x1O7C3q6xFFWwbXgU
         nT8w==
X-Received: by 10.14.4.70 with SMTP id 46mr24389971eei.42.1373290641079;
        Mon, 08 Jul 2013 06:37:21 -0700 (PDT)
Received: from localhost (nat5.unibz.it. [46.18.27.5])
        by mx.google.com with ESMTPSA id m1sm42163036eex.17.2013.07.08.06.37.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jul 2013 06:37:19 -0700 (PDT)
In-Reply-To: <CACsJy8CtOWjpxKuNhQXYjPAv8MU0U6yTBEuQeqm0kxqVne6NjQ@mail.gmail.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229852>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Jul 8, 2013 at 6:20 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>> Putting filter_opts in index_state feels like a bad design. Iterator
>>> information should be separated from the iterated object, so that two
>>> callers can walk through the same index without stepping on each other
>>> (I'm not talking about multithreading, a caller may walk a bit, then
>>> the other caller starts walking, then the former caller resumes
>>> walking again in a call chain).
>>
>> Yes, you're right.  We need the filter_opts to see what part of the
>> index has been loaded [1] and which part has been skipped, but it
>> shouldn't be used for filtering in the for_each_index_entry function.
>>
>> I think there should be two versions of the for_each_index_entry
>> function then, where the for_each_index_entry function would behave the
>> same way as the for_each_index_entry_filtered function with the
>> filter_opts parameter set to NULL:
>> for_each_index_entry_filtered(struct index_state *, each_cache_entry_fn, void *cb_data, struct filter_opts *)
>> for_each_index_entry(struct index_state *, each_cache_entry_fn, void *cb_data)
>>
>> Both of them then should call index_change_filter_opts to make sure all
>> the entries that are needed are loaded in the in-memory format.
>>
>> Does that make sense?
>
> Hmm.. I was confused actually (documentation on the api would help
> greatly). If you already filter at load time, I don't think you need
> to match again. The caller asked for filter and it should know what's
> in there so for_each_index_entry just goes through all entries without
> extra match_pathspec. Or is that what next_index_entry for?
> match_pathspec function could be expensive when glob is involved. If
> the caller wants extra matching, it could do inside the callback
> function.

Yes, a documentation would be good.  I'll try to write something better
later today, when I have some more time.  In the meantime I'll just
outline what the functions do here shortly:

read_index_filtered(opts): This method behaves differently for index-v2
  and index-v5.
  For index-v2 it simply reads the whole index as read_cache() does, so
  we are sure we don't have to reload anything if the user wants a
  different filter.
  For index-v5 it creates an adjusted pathspec to and reads all
  directories that are matched by them.

get_index_entry_by_name(name, namelen, &ce): Returns a cache_entry
  matched by name via the &ce parameter.  If a cache_entry is matched
  exactly 1 is returned.
  Name may also be a path, in which case it returns 0 and the first
  cache_entry in that path. e.g. we have:
      ...
      path/file1
      ....
    in the index and name is "path", than it returns 0 and the path/file1
    cache_entry.  If name is "path/file1" on the other hand it returns 1
    and the path/file1 cache_entry.

for_each_index_entry(fn, cb_data):  Iterates over all cache_entries in
  the index filtered by filter_opts in the index_state, and executes fn
  for each of them with the cb_data as callback data.

next_index_entry(ce): Returns the cache_entry that follows after ce

index_change_filter_opts(opts): For index-v2 it simply changes the
  filter_opts, so for_each_index_entry uses the changed index_opts.
  For index-v5 it refreshes the index if the filter_opts have changed.
  This has some optimization potential, in the case that the opts get
  stricter (less of the index should be read) it doesn't have to reload
  anything.

I'm not sure what's in the cache, because the whole index is in the
cache if the on-disk format is index-v2 and the index is filtered by the
adjusted_pathspec if the on-disk format is index-v5.  That's what I need
the extra match_pathspec for. But yes, that could also be left to the
caller.

Hope that makes it a little clearer.

> It seems you could change the filter with index_change_filter_opts. In
> v5 the index will be reloaded. What happens when some index entries
> area already modified? Do we start to have read-only index "views" and
> one read-write view? If partial views are always read-only, perhaps we
> just allow the user to create a new index_state (or view) with new
> filter and destroy the old one. We don't have to care about changing
> or separating filter in that case because the view is the iterator.

The read-write part is mostly covered by the next patch (6/22).  Before
changing the index, the filter_opts always have to be set to NULL, using
index_change_filter_opts and therefore use the whole index.  This is
currently hard to improve, because we always need the whole index when
we write it.  Changing this only makes sense once we have partial
writing too.

So in principle the index_change_filter_opts function implements those
views.

Even with partial writing we have to distinguish if a cache_entry has
been added/removed, in which case a full rewrite is necessary or if a
cache_entry has simply been modified (it's content changed), in which
case we could replace it in place.

> I wanted to have a tree-based iterator api, but that seems
> incompatible with pre-v5 (or at least adds some overhead on pre-v5 to
> rebuild the tree structure). It looks like using pathspec to build a
> list of entries, as you did, is a good way to take advantage of
> tree-based v5 while maintaining code compatibility with pre-v5. By the
> way with tree structure, you could use tree_entry_interesting in
> read_index_filtered_v5. I think it's more efficient than
> match_pathspec.

Yes, that's why I decided to keep the current in-memory format for now.
Once an api is in place I think it will be easier to explore the
tree-based format, without having to change the format all over the
place.

Thanks, I will take a look at tree_entry_interesting later.

> I'm still studying the code. Some of what I wrote here may be totally
> wrong due to my lack of understanding. I'll get back to you later if I
> find something else.
>
>> [1] That is only important for the new index-v5 file format, which can
>>     be loaded partially.  The filter_opts could always be set to NULL,
>>     as the whole index is always loaded anyway.
> --
> Duy
