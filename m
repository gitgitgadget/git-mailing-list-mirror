From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix "unpack-objects --strict"
Date: Fri, 14 Aug 2009 00:41:31 -0700
Message-ID: <7vhbwasuz8.fsf@alter.siamese.dyndns.org>
References: <20090813103231.GY14475@mail-vs.djpig.de>
 <20090813111933.GZ14475@mail-vs.djpig.de>
 <7vd46zbjae.fsf@alter.siamese.dyndns.org>
 <20090814060307.GA31721@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Fri Aug 14 09:41:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbrQ1-0001w4-Ae
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 09:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756107AbZHNHlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 03:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754826AbZHNHlh
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 03:41:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43489 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754781AbZHNHlh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 03:41:37 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DD4A993DB;
	Fri, 14 Aug 2009 03:41:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C21193DA; Fri, 14 Aug
 2009 03:41:33 -0400 (EDT)
In-Reply-To: <20090814060307.GA31721@auto.tuwien.ac.at> (Martin Koegler's
 message of "Fri\, 14 Aug 2009 08\:03\:07 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E617286C-88A5-11DE-9D79-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125915>

Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:

> What about this check:
>> @@ -184,7 +184,7 @@ static int check_object(struct object *obj, int type, void *data)
>>       if (!obj)
>>  		return 0;
>
> This is neccessary to skip already written objects (eg. blobs,
> obj_list[i].obj == NULL).

You can fix that issue by teaching write_rest() to check what it feeds
check_object(), can't you?

> I'm not sure, if fsck_walk can call check_object with obj == NULL
> under some (rare) conditions. If yes, the return code should be
> changed to 1.

I think that is a sensible change to signal an error regardless.  For
example, fsck_walk_tree() will make a callback to you (meaning, walk()
function pointer points at your check_object() function) like this:

	while (tree_entry(&desc, &entry)) {
		int result;

		if (S_ISGITLINK(entry.mode))
			continue;
		if (S_ISDIR(entry.mode))
			result = walk(&lookup_tree(entry.sha1)->object, OBJ_TREE, data);

so while you are checking a tree object you received, upon hitting a
subtree of that tree, it will lookup_tree() it, and if that tree is
missing, you will be called with NULL.

On top of the previous patch, a fix would look like this, I think, but
please double check.

Thanks.

 builtin-unpack-objects.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 2522c2d..bae00ea 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -181,7 +181,7 @@ static void write_cached_object(struct object *obj)
 static int check_object(struct object *obj, int type, void *data)
 {
 	if (!obj)
-		return 0;
+		return 1;
 
 	if (obj->flags & FLAG_WRITTEN)
 		return 0;
@@ -209,8 +209,10 @@ static int check_object(struct object *obj, int type, void *data)
 static void write_rest(void)
 {
 	unsigned i;
-	for (i = 0; i < nr_objects; i++)
-		check_object(obj_list[i].obj, OBJ_ANY, 0);
+	for (i = 0; i < nr_objects; i++) {
+		if (obj_list[i].obj)
+			check_object(obj_list[i].obj, OBJ_ANY, 0);
+	}
 }
 
 static void added_object(unsigned nr, enum object_type type,
