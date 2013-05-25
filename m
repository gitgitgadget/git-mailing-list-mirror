From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 00/25] Remove assumptions about each_ref_fn arg lifetimes
Date: Sat, 25 May 2013 11:07:59 +0200
Message-ID: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johan Herland <johan@herland.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 25 11:09:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgATJ-0004wz-BT
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 11:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306Ab3EYJIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 05:08:52 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:52887 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751664Ab3EYJIu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 05:08:50 -0400
X-AuditID: 1207440d-b7fd06d000000905-5d-51a07fa1e127
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 9C.12.02309.1AF70A15; Sat, 25 May 2013 05:08:49 -0400 (EDT)
Received: from michael.fritz.box (p4FDD49F3.dip0.t-ipconnect.de [79.221.73.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4P98gua000489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 May 2013 05:08:46 -0400
X-Mailer: git-send-email 1.8.2.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsUixO6iqLuwfkGgwcRjJhZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLe5eXsXuwObx9/0HJo9LL7+zedx+PZ/Z41nvHkaPi5eUPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgznh93r5gtVzFzKlb2BoY+yS6GDk4JARMJM488eti5AQyxSQu3FvP
	1sXIxSEkcJlRYkvjbCYI5wKTxLq2HiaQKjYBXYlFPc1gtoiAo8SJB9dZQYqYBXoZJR4++g6W
	EBbwkXjbt5QZxGYRUJVYP/EGI4jNK+Ai8eXXKxaIdQoSl2etYZ7AyL2AkWEVo1xiTmmubm5i
	Zk5xarJucXJiXl5qka6RXm5miV5qSukmRkjY8O5g/L9O5hCjAAejEg/vjpL5gUKsiWXFlbmH
	GCU5mJREeflrFwQK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuFlSAHK8aYkVlalFuXDpKQ5WJTE
	edWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeD3qgBoFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JS
	ixJLSzLiQYEeXwwMdZAUD9DeQJB23uKCxFygKETrKUZdjs3nJ79jFGLJy89LlRLnnQhSJABS
	lFGaB7cCliReMYoDfSzMmwJSxQNMMHCTXgEtYQJacjN3PsiSkkSElFQDI9sGt1KHZknXzYId
	TbZ3cu/l2E5qXVM2+WHJNtfkNJkv7SWTV2/9mVp7OmqbOde8/w8zNAxWlt3LW7e7SEauw3TG
	jMn/0/4/KspIyl3w2u/E+pM3Z2S1v5y+4tfd3jNnOVm0ZVQqtDM3vfglxcWS9XPJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225493>

This is version two of the patch series.  Aside from addressing
Junio's comments about the first version, it goes significantly
further than v1:

I did a manual audit of the 50 (!) functions that are used as an
each_ref_fn callback to the for_each_ref()-style functions.  (I hope I
haven't missed any.)  I checked that they do not make the assumption
that the lifetimes of the refname and sha1 arguments extend past the
duration of the callback invocation.  There were a number of callers
that got this wrong; I believe I have fixed them all.

I also changed how object_array_entry manages its name field.  Like
the RFC in the first version of this patch series, I change
add_object_array_with_mode() to make a copy of the name before storing
it in its field.  But (at Peff's suggestion) I also make an
optimization like that of strbuf of not copying the name if it is the
empty string, but rather using a pointer to a static empty string.

After this patch series, the test suite runs without errors under
valgrind even when I change refs.c:do_one_ref() to pass temporary
copies of refname and sha1 to the callback functions then free them
immediately.  (Before this patch series, such a test failed in many
places.)  But it is still not enough to make Peff's
jk/packed-refs-race series work correctly under the "hyperactive
repository" stress-test in which the packed-refs file is made to
always look stale,

    refs.c:get_packed_refs():
    -	if (refs->packed &&
    -	    !stat_validity_check(&refs->packed_validity, packed_refs_file))
    +	if (refs->packed /* &&
    +	    !stat_validity_check(&refs->packed_validity, packed_refs_file) */)


Michael Haggerty (25):
  describe: make own copy of refname
  fetch: make own copies of refnames
  add_rev_cmdline(): make a copy of the name argument
  builtin_diff_tree(): make it obvious that function wants two entries
  cmd_diff(): use an object_array for holding trees
  cmd_diff(): rename local variable "list" -> "entry"
  cmd_diff(): make it obvious which cases are exclusive of each other
  revision: split some overly-long lines
  object_array: add function object_array_filter()
  revision: use object_array_filter() in implementation of gc_boundary()
  object_array_remove_duplicates(): rewrite to reduce copying
  fsck: don't put a void*-shaped peg in a char*-shaped hole
  find_first_merges(): initialize merges variable using initializer
  find_first_merges(): remove unnecessary code
  object_array_entry: fix memory handling of the name field
  do_fetch(): reduce scope of peer_item
  do_fetch(): clean up existing_refs before exiting
  add_existing(): do not retain a reference to sha1
  show_head_ref(): do not shadow name of argument
  show_head_ref(): rename first parameter to "refname"
  string_list_add_one_ref(): rename first parameter to "refname"
  string_list_add_refs_by_glob(): add a comment about memory management
  exclude_existing(): set existing_refs.strdup_strings
  register_ref(): make a copy of the bad reference SHA-1
  refs: document the lifetime of the args passed to each_ref_fn

 bisect.c           |  5 ++--
 builtin/describe.c |  6 +++--
 builtin/diff.c     | 69 ++++++++++++++++++++++++++---------------------------
 builtin/fetch.c    | 29 ++++++++++++----------
 builtin/fsck.c     |  2 +-
 builtin/show-ref.c |  2 +-
 bundle.c           |  2 +-
 http-backend.c     |  6 ++---
 notes.c            |  9 ++++---
 object.c           | 70 ++++++++++++++++++++++++++++++++++++++++++++----------
 object.h           | 25 +++++++++++++++++--
 refs.h             | 22 ++++++++++++-----
 revision.c         | 64 +++++++++++++++++++++++++++++--------------------
 revision.h         | 32 ++++++++++++++++---------
 submodule.c        |  6 ++---
 15 files changed, 228 insertions(+), 121 deletions(-)

-- 
1.8.2.3
