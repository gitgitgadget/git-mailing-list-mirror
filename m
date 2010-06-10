From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Leaving large binaries out of the packfile
Date: Thu, 10 Jun 2010 00:25:26 -0600
Message-ID: <4C108556.8040102@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 10 08:25:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMbD6-0006Sk-6G
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 08:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440Ab0FJGZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 02:25:46 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:44923 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224Ab0FJGZp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 02:25:45 -0400
Received: (qmail 21670 invoked by uid 399); 10 Jun 2010 00:25:44 -0600
Received: from unknown (HELO ?192.168.1.107?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 10 Jun 2010 00:25:44 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.4) Gecko/20100526 Lightning/1.0b1 Thunderbird/3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148832>

  Hi.

I've been dealing with a Subversion repository that contains a lot of 
large binaries.  Git generally seems to handle them reasonably enough, 
although it chokes under the pressure of a 'git gc' with this git-svn 
repository.  The repository packs total 2.7 gigabytes.  As it turns out, 
the 250 individual blob revisions worth of large binaries are about 2.4 
gigabytes of that.

Sometimes, 'git gc' runs out of memory.  I have to discover which file 
is causing the problem, so I can add it to .gitattributes with a 
'-delta' flag.  Mostly, though, the repacking takes forever, and I dread 
running the operation.

As an experiment, I added a '-pack' flag to .gitattributes.  This flag 
will leave the file type specified by the .gitattributes entry loose in 
the repository.  During a 'git gc', instead of recopying gigabytes of 
data each time, the loose objects are used.  The 'git gc' process runs 
very quick with this change.

The only issue I've found is in too_many_loose_objects().  gitk is 
always telling me the repository needs to be packed, obviously because 
of all the loose objects.

I haven't yet come up with a good idea for handling this.  I thought 
about putting the forced loose objects in a separate directory.  (This 
idea goes along with another that I want to build on top of this 
functionality, the ability to commit and have -pack binaries go to an 
alternates location.)  I have also thought about writing out a file with 
the count of forced loose objects and using that to drive the 
guesstimate made by too_many_loose_objects() down.

Does anyone have any thoughts?

Thanks!

Josh

---
  builtin/pack-objects.c |   25 +++++++++++++++++++++++++
  1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 214d7ef..f33a7fb 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -644,6 +644,28 @@ static int no_try_delta(const char *path)
      return 0;
  }

+static void setup_pack_attr_check(struct git_attr_check *check)
+{
+    static struct git_attr *attr_pack;
+
+    if (!attr_pack)
+        attr_pack = git_attr("pack");
+
+    check[0].attr = attr_pack;
+}
+
+static int must_pack(const char *path)
+{
+    struct git_attr_check check[1];
+
+    setup_pack_attr_check(check);
+    if (git_checkattr(path, ARRAY_SIZE(check), check))
+        return 1;
+    if (ATTR_FALSE(check->value))
+        return 0;
+    return 1;
+}
+
  static int add_object_entry(const unsigned char *sha1, enum 
object_type type,
                  const char *name, int exclude)
  {
@@ -667,6 +689,9 @@ static int add_object_entry(const unsigned char 
*sha1, enum object_type type,
      if (!exclude && local && has_loose_object_nonlocal(sha1))
          return 0;

+    if (name && !must_pack(name))
+        return 0;
+
      for (p = packed_git; p; p = p->next) {
          off_t offset = find_pack_entry_one(sha1, p);
          if (offset) {
--
1.7.1.msysgit.3.1.g108b5.dirty
