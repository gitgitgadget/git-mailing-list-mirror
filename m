From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH RFC] parse_object: pass on the original sha1, not the replaced one
Date: Fri, 13 Aug 2010 05:59:33 +0200
Message-ID: <201008130559.33640.chriscool@tuxfamily.org>
References: <1280579802-8606-1-git-send-email-pclouds@gmail.com> <201008051341.08632.chriscool@tuxfamily.org> <AANLkTim9vMiEuBJJdCdGqjTOz8cs-nH+LyJF-rPGOTvS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 05:59:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjlQu-0002jZ-51
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 05:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583Ab0HMD7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 23:59:42 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:58383 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751617Ab0HMD7m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 23:59:42 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 3309581802F;
	Fri, 13 Aug 2010 05:59:35 +0200 (CEST)
User-Agent: KMail/1.13.2 (Linux/2.6.32-24-generic; KDE/4.4.2; x86_64; ; )
In-Reply-To: <AANLkTim9vMiEuBJJdCdGqjTOz8cs-nH+LyJF-rPGOTvS@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153460>

On Saturday 07 August 2010 06:03:05 Nguyen Thai Ngoc Duy wrote:
> On Thu, Aug 5, 2010 at 9:41 PM, Christian Couder
> 
> <chriscool@tuxfamily.org> wrote:
> > It looks like parse_commit() is buggy regarding replaced objects. But I
> > am not sure how it should be fixed.
> 
> It could be fixed the same way you did with parse_object(): replace
> read_sha1_file() with read_sha1_file_repl(). You would also need to
> fix parse_tree() and parse_tag(). But..
> 
> > Anyway if you use parse_object(), then you don't need parse_commit(). So
> > if possible you should use parse_object() instead of both
> > lookup_commit() and parse_commit().
> 
> That's how those functions are used. For example, in
> traverse_commit_list(), lookup_*() may be called and uninteresting
> objects marked UNINTERESTING. Later on in process_{tree,blob,tag},
> parse_* may be called if their content is interesting.
> 
> To me, the fix above will leave a gap when object->sha1 is the
> original sha1, until parse_*() is called. It just does not sound good.

What do you think about adding a parse_commit_repl() function like the patch 
below and then using it instead of parse_commit()?

------- >8 ---------------------------------------------------

diff --git a/commit.c b/commit.c
index 652c1ba..183a735 100644
--- a/commit.c
+++ b/commit.c
@@ -316,6 +316,50 @@ int parse_commit(struct commit *item)
        return ret;
 }
 
+int parse_commit_repl(struct commit **commit)
+{
+       enum object_type type;
+       void *buffer;
+       unsigned long size;
+       int ret;
+       const unsigned char *repl;
+       struct commit *item = *commit;
+
+       if (!item)
+               return -1;
+       if (item->object.parsed)
+               return 0;
+       buffer = read_sha1_file_repl(item->object.sha1, &type, &size, &repl);
+       if (!buffer)
+               return error("Could not read %s",
+                            sha1_to_hex(item->object.sha1));
+
+       if (item->object.sha1 != repl) {
+               struct commit *repl_item = lookup_commit(repl);
+               if (!repl_item) {
+                       free(buffer);
+                       return error("Bad replacement %s for commit %s",
+                                    sha1_to_hex(repl),
+                                    sha1_to_hex(item->object.sha1));
+               }
+               repl_item->object.flags = item->object.flags;
+               *commit = item = repl_item;
+       }
+
+       if (type != OBJ_COMMIT) {
+               free(buffer);
+               return error("Object %s not a commit",
+                            sha1_to_hex(item->object.sha1));
+       }
+       ret = parse_commit_buffer(item, buffer, size);
+       if (save_commit_buffer && !ret) {
+               item->buffer = buffer;
+               return 0;
+       }
+       free(buffer);
+       return ret;
+}
+
 int find_commit_subject(const char *commit_buffer, const char **subject)
 {
        const char *eol;

-------- 8< --------------------------------------------------

Thanks,
Christian.
