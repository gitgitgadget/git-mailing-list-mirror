From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git-pack-refs --prune
Date: Thu, 21 Sep 2006 21:57:54 -0700
Message-ID: <7vzmcs5wh9.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0609111158390.3960@g5.osdl.org>
	<Pine.LNX.4.64.0609111632050.27779@g5.osdl.org>
	<7vy7shr5zw.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609180934360.4388@g5.osdl.org>
	<7v64fhd7ns.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609210815100.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 22 06:58:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQd7D-0003J2-Ha
	for gcvg-git@gmane.org; Fri, 22 Sep 2006 06:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWIVE56 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 00:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWIVE55
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 00:57:57 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:6805 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932270AbWIVE5z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Sep 2006 00:57:55 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060922045755.NJFB12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Fri, 22 Sep 2006 00:57:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id RGxw1V00i1kojtg0000000
	Fri, 22 Sep 2006 00:57:57 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27519>

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 21 Sep 2006, Junio C Hamano wrote:
>> 
>> Ok, so I did these and the result is a 4-patch series.
>
> Looks good to me. I would have combined 2/3, since the bulk of them is the 
> calling conversion change, and they both add a new argument to the same 
> function, so combining them would make just one patch that isn't even 
> noticeably larger than either of the two originals, but that's just a 
> small nitpick.

Actually I did these two as a single change and then later split
them.  Unfortunately cherry-picking only 3 without 2 would not
have worked anyway in this particular case with git, but an
ideal SCM would have done a better job.  It's just taste and
principle and splitting them into two would not have any
practical advantage in the real world.

Side note to interested bystanders.

Patch 2 changes function signature of for_each_ref() and
friends and adds one parameter, void *cbdata, to them and the
called-back functions.  Typical changes looked like these:

+typedef int each_ref_fn(const char *refname, const unsigned char *sha1, void *cb_data);
-static int name_ref(const char *path, const unsigned char *sha1)
+static int name_ref(const char *path, const unsigned char *sha1, void *cb_data)
-	for_each_ref(name_ref);
+	for_each_ref(name_ref, &tags_only);

Then patch 3 adds another parameter, int flags, to the same functions involved:

-typedef int each_ref_fn(const char *refname, const unsigned char *sha1, void *cb_data);
+#define REF_ISSYMREF 01
+#define REF_ISPACKED 02
+typedef int each_ref_fn(const char *refname, const unsigned char *sha1, int flags, void *cb_data);
-static int name_ref(const char *path, const unsigned char *sha1, void *cb_data)
+static int name_ref(const char *path, const unsigned char *sha1, int flags, void *cb_data)

An ideal SCM should help the user who wants to cherry pick patch
3 without patch 2, effectively applying a patch like this:

* Type definition of for_each_ref() callback function (with
  flags but without callback data):

+#define REF_ISSYMREF 01
+#define REF_ISPACKED 02
+typedef int each_ref_fn(const char *refname, const unsigned char *sha1, int flags);

* An actual callback function:

-static int name_ref(const char *path, const unsigned char *sha1)
+static int name_ref(const char *path, const unsigned char *sha1, int flags)

* The call-site of for_each_ref (note patch2 and patch2+patch3
  have the same effect):

-	for_each_ref(name_ref);
+	for_each_ref(name_ref, &tags_only);
