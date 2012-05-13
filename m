From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: git-diff-tree does not use alternate objects for submodules
Date: Sun, 13 May 2012 19:23:25 +0200
Message-ID: <20120513172301.GA58961@book.hvoigt.net>
References: <CAGHpTBLfbMU1WevW6XnY_N2BnfwPZ0_6jJDf45rCkVjWGwA9xg@mail.gmail.com> <7v1umuznuj.fsf@alter.siamese.dyndns.org> <20120509215815.GC74366@book.hvoigt.net> <7v1umtq9pm.fsf@alter.siamese.dyndns.org> <7vwr4lotjl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Orgad and Raizel Shaneh <orgads@gmail.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 13 19:23:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STcW5-00071d-OJ
	for gcvg-git-2@plane.gmane.org; Sun, 13 May 2012 19:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685Ab2EMRX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 May 2012 13:23:28 -0400
Received: from t2784.greatnet.de ([83.133.105.219]:40202 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750904Ab2EMRX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2012 13:23:27 -0400
Received: (qmail 32715 invoked from network); 13 May 2012 17:23:25 -0000
Received: from localhost (127.0.0.1)
  by darksea.de with SMTP; 13 May 2012 17:23:25 -0000
Content-Disposition: inline
In-Reply-To: <7vwr4lotjl.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197749>

Hi,

On Wed, May 09, 2012 at 03:53:34PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Heiko Voigt <hvoigt@hvoigt.net> writes:
> > ...
> >> I will have a look if I can come up with something that reads the
> >> submodules alternate config and uses it. Do you have other config
> >> related things in mind that might be missing?
> >
> > No, I do not, and that is exactly the point.
> >
> > Making the process that works in the top-level superproject to imitate
> > what would happen if the processing happened inside the submodule is what
> > invited a bug like this.  Who knows what other discrepancies remain there.
> >
> > If we forked a separate process,...
> 
> Having said all that, we seem to have come too far and it is probably too
> painful to revert the approach to contaminate the obj_hash (in object.c),
> the set of refs (in refs.c) and the like in the top-level superproject
> process with data borrowed from submodules repository [*1*].  So not only
> I do not mind seeing you try solving it inside the superproject process, I
> would appreciate and encourage the attempt.  One thing to be careful about
> is relative paths stored in the objects/info/alternates; they are relative
> to the object database of the repository the "alternates" is specified,
> not relative to the superproject that happens to contain the submodule.
> 
> Thanks.

Here is the simplest approach I could think of (not sure if its maybe
too simple). On first sight it seems to work (even if I exchange the
absolute path in alternates with a relative one.

Please see below.

Cheers Heiko

I used the following setup to test:

mkdir sub_alt &&
(cd sub_alt &&
git init &&
echo a >a &&
git add a &&
git commit -m a) &&
mkdir super &&
(cd super &&
git clone -s ../sub_alt sub &&
git init &&
git add sub &&
git commit -m "sub a") &&
(cd sub_alt &&
echo b >b &&
git add b &&
git commit -m b) &&
(cd super &&
	(cd sub &&
	 git fetch &&
	 git checkout origin/master) &&
 git diff --submodule
)


-8<--
From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] teach add_submodule_odb() to look for alternates

Since we allow to link other object databases when loading a submodules
database we should also load possible alternates.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 cache.h     | 1 +
 sha1_file.c | 3 +--
 submodule.c | 3 +++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index e14ffcd..cc5048c 100644
--- a/cache.h
+++ b/cache.h
@@ -947,6 +947,7 @@ extern struct alternate_object_database {
 	char base[FLEX_ARRAY]; /* more */
 } *alt_odb_list;
 extern void prepare_alt_odb(void);
+extern void read_info_alternates(const char * relative_base, int depth);
 extern void add_to_alternates_file(const char *reference);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
 extern void foreach_alt_odb(alt_odb_fn, void*);
diff --git a/sha1_file.c b/sha1_file.c
index 3c4f165..4ccaf7a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -229,7 +229,6 @@ char *sha1_pack_index_name(const unsigned char *sha1)
 struct alternate_object_database *alt_odb_list;
 static struct alternate_object_database **alt_odb_tail;
 
-static void read_info_alternates(const char * alternates, int depth);
 static int git_open_noatime(const char *name);
 
 /*
@@ -354,7 +353,7 @@ static void link_alt_odb_entries(const char *alt, const char *ep, int sep,
 	}
 }
 
-static void read_info_alternates(const char * relative_base, int depth)
+void read_info_alternates(const char * relative_base, int depth)
 {
 	char *map;
 	size_t mapsz;
diff --git a/submodule.c b/submodule.c
index 784b580..959d349 100644
--- a/submodule.c
+++ b/submodule.c
@@ -63,6 +63,9 @@ static int add_submodule_odb(const char *path)
 	alt_odb->name[40] = '\0';
 	alt_odb->name[41] = '\0';
 	alt_odb_list = alt_odb;
+
+	/* add possible alternates from the submodule */
+	read_info_alternates(objects_directory.buf, 0);
 	prepare_alt_odb();
 done:
 	strbuf_release(&objects_directory);
-- 
1.7.10.1.491.gc66153e
