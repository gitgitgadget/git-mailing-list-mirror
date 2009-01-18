From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision walker: include a detached HEAD in --all
Date: Sat, 17 Jan 2009 22:36:09 -0800
Message-ID: <7v3afh15pi.fsf@gitster.siamese.dyndns.org>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch>
 <496EE559.3060901@viscovery.net>
 <alpine.DEB.1.00.0901151413250.3586@pacific.mpi-cbg.de>
 <200901151500.01876.trast@student.ethz.ch>
 <alpine.DEB.1.00.0901151508540.3586@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0901151517190.3586@pacific.mpi-cbg.de>
 <7vhc40s50t.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901161351460.3586@pacific.mpi-cbg.de>
 <7v8wp917c3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 18 07:38:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LORIU-0001SB-KW
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 07:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755402AbZARGgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 01:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755189AbZARGgV
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 01:36:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62184 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754707AbZARGgT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 01:36:19 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C00E81CC24;
	Sun, 18 Jan 2009 01:36:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0EE2A1CC14; Sun,
 18 Jan 2009 01:36:11 -0500 (EST)
In-Reply-To: <7v8wp917c3.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 17 Jan 2009 22:01:00 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5030B666-E52A-11DD-8778-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106143>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> ...
>> Note that this affects creating bundles with --all; I contend that it
>> is a good change to add the HEAD, so that cloning from such a bundle
>> will give you a current branch.  However, I had to fix t5701 as it
>> assumed that --all does not imply HEAD.
>
> Sorry, but I do not understand.
>
>> diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
>> index 8dfaaa4..14413f8 100755
>> --- a/t/t5701-clone-local.sh
>> +++ b/t/t5701-clone-local.sh
>> @@ -11,8 +11,8 @@ test_expect_success 'preparing origin repository' '
>>  	git clone --bare . x &&
>>  	test "$(GIT_CONFIG=a.git/config git config --bool core.bare)" = true &&
>>  	test "$(GIT_CONFIG=x/config git config --bool core.bare)" = true
>> -	git bundle create b1.bundle --all HEAD &&
>> -	git bundle create b2.bundle --all &&
>> +	git bundle create b1.bundle master HEAD &&
>> +	git bundle create b2.bundle master &&
>
> Because --all did not imply HEAD, "--all HEAD" used to be the way to say
> "everything and HEAD".  Now --all does imply HEAD, but it should still be
> a valid way to say "everything, by the way, do not forget HEAD".
>
> Does the first one need to be changed to "master HEAD"?  If "--all HEAD"
> makes the rest of the test unhappy because HEAD is listed twice, perhaps
> that is an independent bug that needs to be fixed?
>
> For that matter, what does "git bundle create x HEAD HEAD" do?  Does it
> list HEAD twice?

With a patch like this, I think b1.bundle can be created with "--all HEAD"
as before.

Of course, to advertise that --all now includes HEAD and it is a _good_
thing, we may want to even say "git bundle create b1.bundle --all" in the
above test sequence.

Creation of b2.bundle should say "master" explicitly as in your patch,
because the point of that bundle is to test a use of such HEAD-less bundle
in the later parts of the script.

-- >8 --
Subject: [PATCH] bundle: allow the same ref to be given more than once

"git bundle create x master master" used to create a bundle that lists
the same branch (master) twice.  Cloning from such a bundle resulted in
a needless warning "warning: Duplicated ref: refs/remotes/origin/master".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 bundle.c |    2 ++
 object.c |   19 +++++++++++++++++++
 object.h |    1 +
 3 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/bundle.c b/bundle.c
index daecd8e..b20f210 100644
--- a/bundle.c
+++ b/bundle.c
@@ -240,6 +240,8 @@ int create_bundle(struct bundle_header *header, const char *path,
 		return error("unrecognized argument: %s'", argv[i]);
 	}
 
+	object_array_remove_duplicates(&revs.pending);
+
 	for (i = 0; i < revs.pending.nr; i++) {
 		struct object_array_entry *e = revs.pending.objects + i;
 		unsigned char sha1[20];
diff --git a/object.c b/object.c
index 50b6528..7e6a92c 100644
--- a/object.c
+++ b/object.c
@@ -268,3 +268,22 @@ void add_object_array_with_mode(struct object *obj, const char *name, struct obj
 	objects[nr].mode = mode;
 	array->nr = ++nr;
 }
+
+void object_array_remove_duplicates(struct object_array *array)
+{
+	int ref, src, dst;
+	struct object_array_entry *objects = array->objects;
+
+	for (ref = 0; ref < array->nr - 1; ref++) {
+		for (src = ref + 1, dst = src;
+		     src < array->nr;
+		     src++) {
+			if (!strcmp(objects[ref].name, objects[src].name))
+				continue;
+			if (src != dst)
+				objects[dst] = objects[src];
+			dst++;
+		}
+		array->nr = dst;
+	}
+}
diff --git a/object.h b/object.h
index 036bd66..3193916 100644
--- a/object.h
+++ b/object.h
@@ -71,5 +71,6 @@ int object_list_contains(struct object_list *list, struct object *obj);
 /* Object array handling .. */
 void add_object_array(struct object *obj, const char *name, struct object_array *array);
 void add_object_array_with_mode(struct object *obj, const char *name, struct object_array *array, unsigned mode);
+void object_array_remove_duplicates(struct object_array *);
 
 #endif /* OBJECT_H */
-- 
1.6.1.208.g58df
