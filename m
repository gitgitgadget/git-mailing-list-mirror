From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] merge: fix cache_entry use-after-free
Date: Mon, 19 Oct 2015 19:13:51 -0700
Message-ID: <xmqqh9lm9ti8.fsf@gitster.mtv.corp.google.com>
References: <1444860424-8361-1-git-send-email-dturner@twopensource.com>
	<561F1EE5.5070300@web.de> <1444935764.20887.1.camel@twopensource.com>
	<xmqqfv1bhn2t.fsf@gitster.mtv.corp.google.com>
	<1444979140.20887.19.camel@twopensource.com>
	<xmqq1tcuhkb2.fsf@gitster.mtv.corp.google.com>
	<1445293649.3418.16.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
	Keith McGuigan <kmcguigan@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 04:14:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoMR6-00017v-4V
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 04:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbbJTCN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 22:13:56 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34224 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbbJTCNz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 22:13:55 -0400
Received: by padhk11 with SMTP id hk11so4789371pad.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 19:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=i8ljCKu+0jmU4aHkU2QHtWJ+jFA/K+141FkoHEoPaxU=;
        b=netW71qaEJLkTUY0UjbUdwk2qfRJCxDiIjA4K3u5F9VKAFZL3575oNA6KeSC81IrTs
         L0SVfipT2X/kLvlMuH4vaZgOIzCG6w099GJVoCVqWzZp8CP48nOH/zbKicsNHyyRjHWw
         UrFsbLUFq4RNTnpMUIHkNH0VQJt/xrHwwyRPZ0QVJ1zGfQ3yxnj8o63dLZ+TTXMQjWyc
         Y28AB+wP4m2OG/e/puKsynBeZbIZhEVp7YtzyzgUyrJpOc6DkDn4/t3jbm+HK0pxO93y
         G0bg3/YDVpbNFz3jLjt9nEE1XXeDPOZUZFr/L/6Jg3p3jA69pEFWJNbASUWQiXUb57q1
         6hYA==
X-Received: by 10.68.195.3 with SMTP id ia3mr833320pbc.106.1445307234688;
        Mon, 19 Oct 2015 19:13:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:e1b1:e6e0:dc10:8032])
        by smtp.gmail.com with ESMTPSA id d2sm484388pat.24.2015.10.19.19.13.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Oct 2015 19:13:52 -0700 (PDT)
In-Reply-To: <1445293649.3418.16.camel@twopensource.com> (David Turner's
	message of "Mon, 19 Oct 2015 18:27:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279899>

David Turner <dturner@twopensource.com> writes:

> The problem is not the name_hash, but with the dir_hash.  The dir_hash
> is only even populated on case-insensitive filesystems (which is why you
> and Linus don't see this bug).  The dir_hash is not designed to catch
> d/f conflicts, but rather case conflicts (one side of a merge has
> foo/bar; the other has FOO/bar).  For each directory, it maintains a
> pointer to a cache_entry.  Then add_to_index uses that cache_entry to 
> rewrite incoming entries' parent directories to the expected case.
> Weirdly, that part of add_to_index is, so far as I can tell, never
> called during a merge.  So where's are we using the freed value?
> Probably in dir_entry_cmp, while adding another entry to the hashmap;
> that's where our crash seems to have happened.  And our failure depended
> on the details of the hash function as well; if a certain collision did
> not happen, we would not see it.
>
> There is, I think, another way to handle this: we could *copy* the path
> into the struct dir_entry instead of pointing to a cache_entry.  But
> this seems like a bunch of extra work; the refcounting is simpler.  

This codepath is a mess.  Whoever wrote hash_dir_entry() seems to
have already known that the code is buggy by leaving this comment
there:

 * Note that the cache_entry stored with the dir_entry merely
 * supplies the name of the directory (up to dir_entry.namelen). We
 * track the number of 'active' files in a directory in dir_entry.nr,
 * so we can tell if the directory is still relevant, e.g. for git
 * status. However, if cache_entries are removed, we cannot pinpoint
 * an exact cache_entry that's still active. It is very possible that
 * multiple dir_entries point to the same cache_entry.

If you add "a/frotz" to the index, the code will somehow create a
dir_entry to represent that the canonical case for directory "a/" is
such, so that when you later try to add "A/nitfol", the code can
grab the canonical path "a/" from dir_entry hash and turn it into
"a/nitfol".  That is what happens in add_to_index in read-cache.c

But what happens if, after adding "a/frotz" and "a/nitfol" to the
index like that, you remove "a/frotz"?  I do not see any code that
notices the poitner to "a/frotz" will become stale and replace it
with a pointer to "a/nitfol" that is still in the system.  The next
time you try to add "a/xyzzy", find_dir_entry() will try to see if
there is an existing entry that matches "a/xyzzy"'s directory, and
one of the dir_entries has a stale pointer to ce for "a/frotz" that
is already gone.

I think the root cause of the bug is the external interface to the
index_dir_exists() function.  For the above processing, there is no
reason for dir_entry() to hold a pointer to ce for "a/frotz" or
"a/nitfol".  All it needs to have is an embedded string in the
structure itself, i.e.

        struct dir_entry {
                struct hashmap_entry ent;
                struct dir_entry *parent;
                int nr;
                unsigned int namelen;
                char name[FLEX_ARRAY];
        };

The caller of index_dir_exists() in add_to_index() can be adjusted
to work with a new function in name-hash.c that does this part:

	const char *startPtr = ce->name;
	const char *ptr = startPtr;
	while (*ptr) {
		while (*ptr && *ptr != '/')
			++ptr;
		if (*ptr == '/') {
			struct cache_entry *foundce;
			++ptr;
			foundce = index_dir_exists(istate, ce->name, ptr - ce->name - 1);
			if (foundce) {
				memcpy((void *)startPtr, foundce->name + (startPtr - ce->name), ptr - startPtr);
				startPtr = ptr;
			}
		}
	}

Perhaps name it "adjust_dirname_case(istate, ce->name)" and have it
do the whole while loop above, all inside name-hash.c.  That would
make this caller a lot easier to read and understand what is going
on.

The other one, directory_exists_in_index_icase() in dir.c, expects
that a ce is returned, but the way it uses the returned value does
not really require the function to return a ce.  It does look at the
ce->ce_mode but that is only because the way index_dir_exists()
tells its caller if there is a directory (hence some files inside
it) or if there is a submodule (hence there is nothing below it) by
making a fallback call internally to index_file_exists() and returns
the ce for gitlink only when (1) there is no directory in dir_hash
and (2) file_hash as a submodule in that path.

A more cleaner helper function to give what this caller really wants
to know that name-hash.c can provide would be a function that takes
pathname and len and returns an enum: "there is nothing there",
"there is a directory", or "there is a submodule".  For completeness
of the API, even though this sole caller does not need it, we could
throw in "there is a regular file" there, too, if we wanted to.

If I were to clean this up, I would probably use the above updated
definition of struct dir_entry and:

 * drop the fallback "return gitlink if there is one" from
   index_dir_exists(), and make index_dir_exists() return 0 (false)
   or 1 (true).

 * have directory_exists_in_index() first call the updated
   index_dir_exists() via the cache_dir_exists() convenience macro.
   If it returned true, it should return index_direcgtory.  If it
   returned false, make a call to cache_file_exists() to see if
   there is a gitlink and rturn index_gitdir when that is the case.
   When all of the above fails, return index_nonexistent.

That way, we do not have to worry about "this ce no longer exists in
the main index but we need to keep it around", saving 8-bytes from
each ce and refcounting mess in the code.
