From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add compat/setenv.c, use in git.c.
Date: Tue, 06 Dec 2005 13:41:48 -0800
Message-ID: <7vwtih299f.fsf@assigned-by-dhcp.cox.net>
References: <7vslt67v9o.fsf@assigned-by-dhcp.cox.net>
	<14331.1133899163@lotus.CS.Berkeley.EDU>
	<118833cc0512061310r6398f812ia47a84d3cfad1564@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 22:44:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjkZN-0004yT-Is
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 22:41:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbVLFVlu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 16:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932643AbVLFVlu
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 16:41:50 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:41623 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932642AbVLFVlu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 16:41:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051206214036.RCWU17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Dec 2005 16:40:36 -0500
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <118833cc0512061310r6398f812ia47a84d3cfad1564@mail.gmail.com>
	(Morten Welinder's message of "Tue, 6 Dec 2005 16:10:56 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13294>

Morten Welinder <mwelinder@gmail.com> writes:

> The code looks wrong.  It assumes that pointers are no larger than ints.
> If pointers are larger than ints, the code does not necessarily compute
> a consistent ordering and qsort is allowed to do whatever it wants.
>
> Morten
>
>
>
> static int compare_object_pointers(const void *a, const void *b)
> {
> 	const struct object * const *pa = a;
> 	const struct object * const *pb = b;
> 	return *pa - *pb;
> }

Are you suggesting it to be done like this?

---
git diff
diff --git a/object.c b/object.c
index 427e14c..dac5c92 100644
--- a/object.c
+++ b/object.c
@@ -82,7 +82,12 @@ static int compare_object_pointers(const
 {
 	const struct object * const *pa = a;
 	const struct object * const *pb = b;
-	return *pa - *pb;
+	if (*pa == *pb)
+		return 0;
+	else if (*pa < *pb)
+		return -1;
+	else
+		return 1;
 }
 
 void set_object_refs(struct object *obj, struct object_refs *refs)
