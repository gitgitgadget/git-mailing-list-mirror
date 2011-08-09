From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 26/48] merge-recursive: Allow make_room_for_path() to
 remove D/F entries
Date: Tue, 09 Aug 2011 09:01:41 +0200
Message-ID: <4E40DB55.5020101@viscovery.net>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>	<1307518278-23814-27-git-send-email-newren@gmail.com>	<4E1D46A5.6050904@viscovery.net> <CABPp-BEBJnMCwKKL67=LkB8pea+7QkpoXih3P7rfF5AiDRQYZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 09 09:01:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqgK3-0002vi-74
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 09:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035Ab1HIHBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Aug 2011 03:01:49 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:58851 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751423Ab1HIHBr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2011 03:01:47 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QqgJq-0004Y9-FS; Tue, 09 Aug 2011 09:01:42 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 347A01660F;
	Tue,  9 Aug 2011 09:01:42 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <CABPp-BEBJnMCwKKL67=LkB8pea+7QkpoXih3P7rfF5AiDRQYZQ@mail.gmail.com>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179023>

Am 8/8/2011 22:56, schrieb Elijah Newren:
> Hi,
> 
> On Wed, Jul 13, 2011 at 1:17 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Am 6/8/2011 9:30, schrieb Elijah Newren:
>>> +static int make_room_for_path(const struct merge_options *o, const char *path)
>>>  {
>>> -     int status;
>>> +     int status, i;
>>>       const char *msg = "failed to create path '%s'%s";
>>>
>>> +     /* Unlink any D/F conflict files that are in the way */
>>> +     for (i = 0; i < o->df_conflict_file_set.nr; i++) {
>>> +             const char *df_path = o->df_conflict_file_set.items[i].string;
>>> +             size_t pathlen = strlen(path);
>>> +             size_t df_pathlen = strlen(df_path);
>>> +             if (df_pathlen < pathlen && strncmp(path, df_path, df_pathlen) == 0) {
>>> +                     unlink(df_path);
>>> +                     break;
>>> +             }
>>> +     }
>>
>> Each time this loop is entered it tries to remove the same path again,
>> even if it does not exist anymore or was morphed into a directory in the
>> meantime. I suggest to remove a path from o->df_conflict_file_set after it
>> was unlinked. Or even better: have a separate "make room" phase somewhere
>> in the merge process.
> 
> Removing it from o->df_conflict_file_set makes sense.  However, there
> appears to be no API in string_list.h for deleting entries.  Are such
> operations discouraged?  I'm not sure whether to add such API, just
> hack it directly, or wait for someone else to come along and change
> this to a better data structure (such as a hash)...
> 
> I don't think it's possible to move this "make room" phase anywhere
> earlier in the merge process.  When we have D/F conflicts, the files
> of those D/F conflicts should only be removed if at least one of the
> paths under the corresponding directory are not removed by the merge
> process.  We don't know whether those paths will need to be removed
> until we call process_entry() on each of them, and from there we go
> right to this function when we find one that needs to stick around.
> So I simply don't see how to move it any earlier.

I missed that the loop is selective: It removes only a subset of the
paths. Without a deeper understanding of the merge machinery I'll just
accept what you explain. Removing the paths from the list that were
unlinked seems to be the right approach.

Here's an attempt for a delete_item API (note: only compile-tested).
Bike-shed painters welcome: delete_item, remove_item, free_item?

Signed-off-by: Johannes Sixt <j6t@kdbg.org>

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index 3f575bd..ce24eb9 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -29,6 +29,9 @@ member (you need this if you add things later) and you should set the
 
 . Can sort an unsorted list using `sort_string_list`.
 
+. Can remove individual items of an unsorted list using
+  `unsorted_string_list_delete_item`.
+
 . Finally it should free the list using `string_list_clear`.
 
 Example:
@@ -112,6 +115,13 @@ write `string_list_insert(...)->util = ...;`.
 The above two functions need to look through all items, as opposed to their
 counterpart for sorted lists, which performs a binary search.
 
+`unsorted_string_list_delete_item`::
+
+	Remove an item from a string_list. The `string` pointer of the items
+	will be freed in case the `strdup_strings` member of the string_list
+	is set. The third parameter controls if the `util` pointer of the
+	items should be freed or not.
+
 Data structures
 ---------------
 
diff --git a/string-list.c b/string-list.c
index 5168118..d9810ab 100644
--- a/string-list.c
+++ b/string-list.c
@@ -185,3 +185,12 @@ int unsorted_string_list_has_string(struct string_list *list,
 	return unsorted_string_list_lookup(list, string) != NULL;
 }
 
+void unsorted_string_list_delete_item(struct string_list *list, int i, int free_util)
+{
+	if (list->strdup_strings)
+		free(list->items[i].string);
+	if (free_util)
+		free(list->items[i].util);
+	list->items[i] = list->items[list->nr-1];
+	list->nr--;
+}
diff --git a/string-list.h b/string-list.h
index bda6983..0684cb7 100644
--- a/string-list.h
+++ b/string-list.h
@@ -44,4 +44,5 @@ void sort_string_list(struct string_list *list);
 int unsorted_string_list_has_string(struct string_list *list, const char *string);
 struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
 						     const char *string);
+void unsorted_string_list_delete_item(struct string_list *list, int i, int free_util);
 #endif /* STRING_LIST_H */


> [...]
> 
> However, I don't see how any of this would address any failure you're
> seeing on windows.  Maybe one of my other changes, including one or
> two other bugfixes I've found will help?  I'll have to ping you when I
> submit the re-roll.

I stumbled over this only because on Windows we have an implementation of
unlink() that asks whether to retry a failed unlink attempt. I was using
an old version that asks when a directory was tried to unlink where a
retry is pointless.

-- Hannes
