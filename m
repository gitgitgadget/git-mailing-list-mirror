From: Junio C Hamano <gitster@pobox.com>
Subject: Re: test-mergesort conflict with stdlib.h
Date: Tue, 17 Apr 2012 11:06:50 -0700
Message-ID: <7v8vhunsg5.fsf@alter.siamese.dyndns.org>
References: <E6D295C2-C35E-4ECF-990D-FCF8407C2429@gernhardtsoftware.com>
 <7vd376ntem.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 20:06:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKCnr-0002QY-CP
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 20:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755823Ab2DQSGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 14:06:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37763 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754597Ab2DQSGx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 14:06:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14B4979DD;
	Tue, 17 Apr 2012 14:06:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mewzhfnbVe3+CpaX6ZxG2Jzei1w=; b=TGKCMo
	cazWW4/He9dueq91o2X177LPNa7xvzaX4i6OKCDUA8aPJ/UKRA6tLuLUyhoPibiA
	gdyZN6ZsRgT6SV4APuH5Qs6MHZZUBc5d3zFbB6lsZdoyBtQVhIrLNihV1dv9bCRn
	YfDCeeO3SeKBSOqOML1wtmbjNhTFHPFVsykEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nY4sw3nrAK1D3KjL9tC4FpnmvrGw+UZA
	ShLwhkGOCFYjkOjj2UHZW5L5ze774G4sTOvpU94f5Az4PD/eY44kO7hoT0r86x30
	SmY5yhE1bK6lgs9yArk4XbbGPcSHRBMg8KutSpf2CJBNGowdrypWMCn5mzdPUQTO
	k2EghP9Xhks=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C62479DC;
	Tue, 17 Apr 2012 14:06:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4CC4579DA; Tue, 17 Apr 2012
 14:06:52 -0400 (EDT)
In-Reply-To: <7vd376ntem.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 17 Apr 2012 10:46:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C049EF4-88B8-11E1-B07F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195779>

Junio C Hamano <gitster@pobox.com> writes:

> Unfortunate.  OS X shouldn't contaminate the user namespace by adding such
> names in stdlib.h (which incidentally has qsort()), but the damage is done
> already, so I am not opposed to rename it to llist_mergesort() or something.

Something like this.  While we are touching the code, let's add some
documentation to the header.

 commit.c         |    4 ++--
 mergesort.c      |    8 ++++----
 mergesort.h      |   16 ++++++++++++----
 test-mergesort.c |    2 +-
 4 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/commit.c b/commit.c
index 0759b2c..84304c0 100644
--- a/commit.c
+++ b/commit.c
@@ -429,8 +429,8 @@ static void commit_list_set_next(void *a, void *next)
 
 void commit_list_sort_by_date(struct commit_list **list)
 {
-	*list = mergesort(*list, commit_list_get_next, commit_list_set_next,
-			  commit_list_compare_by_date);
+	*list = llist_mergesort(*list, commit_list_get_next, commit_list_set_next,
+				commit_list_compare_by_date);
 }
 
 struct commit *pop_most_recent_commit(struct commit_list **list,
diff --git a/mergesort.c b/mergesort.c
index d084c60..e5fdf2e 100644
--- a/mergesort.c
+++ b/mergesort.c
@@ -23,10 +23,10 @@ static void *pop_item(struct mergesort_sublist *l,
 	return p;
 }
 
-void *mergesort(void *list,
-		void *(*get_next_fn)(const void *),
-		void (*set_next_fn)(void *, void *),
-		int (*compare_fn)(const void *, const void *))
+void *llist_mergesort(void *list,
+		      void *(*get_next_fn)(const void *),
+		      void (*set_next_fn)(void *, void *),
+		      int (*compare_fn)(const void *, const void *))
 {
 	unsigned long l;
 
diff --git a/mergesort.h b/mergesort.h
index d6e5f4a..644cff1 100644
--- a/mergesort.h
+++ b/mergesort.h
@@ -1,9 +1,17 @@
 #ifndef MERGESORT_H
 #define MERGESORT_H
 
-void *mergesort(void *list,
-		void *(*get_next_fn)(const void *),
-		void (*set_next_fn)(void *, void *),
-		int (*compare_fn)(const void *, const void *));
+/*
+ * Sort linked list in place.
+ * - get_next_fn() returns the next element given an element of a linked list.
+ * - set_next_fn() takes two elements A and B, and makes B the "next" element
+ *   of A on the list.
+ * - compare_fn() takes two elements A and B, and returns negative, 0, positive
+ *   as the same sign as "subtracting" B from A.
+ */
+void *llist_mergesort(void *list,
+		      void *(*get_next_fn)(const void *),
+		      void (*set_next_fn)(void *, void *),
+		      int (*compare_fn)(const void *, const void *));
 
 #endif
diff --git a/test-mergesort.c b/test-mergesort.c
index 1dd82fd..3f388b4 100644
--- a/test-mergesort.c
+++ b/test-mergesort.c
@@ -42,7 +42,7 @@ int main(int argc, const char **argv)
 		p = line;
 	}
 
-	lines = mergesort(lines, get_next, set_next, compare_strings);
+	lines = llist_mergesort(lines, get_next, set_next, compare_strings);
 
 	while (lines) {
 		printf("%s", lines->text);
