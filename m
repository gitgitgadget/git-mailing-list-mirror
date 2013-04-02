From: Jeff King <peff@peff.net>
Subject: Re: check-attr doesn't respect recursive definitions
Date: Tue, 2 Apr 2013 10:48:14 -0400
Message-ID: <20130402144814.GD23828@sigill.intra.peff.net>
References: <slrnkldd3g.1l4.jan@majutsushi.net>
 <20130402143130.GC23828@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jan Larres <jan@majutsushi.net>
X-From: git-owner@vger.kernel.org Tue Apr 02 16:48:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN2Vz-0000aW-Qi
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 16:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305Ab3DBOsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 10:48:19 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52180 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759790Ab3DBOsS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 10:48:18 -0400
Received: (qmail 10007 invoked by uid 107); 2 Apr 2013 14:50:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Apr 2013 10:50:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Apr 2013 10:48:14 -0400
Content-Disposition: inline
In-Reply-To: <20130402143130.GC23828@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219777>

On Tue, Apr 02, 2013 at 10:31:30AM -0400, Jeff King wrote:

> On Sat, Mar 30, 2013 at 09:45:51AM +0000, Jan Larres wrote:
> 
> > I am trying to write a custom archiving script that checks the
> > export-ignore attribute to know which files from an ls-files output it
> > should skip. Through this I noticed that for files in directories for
> > which the export-ignore (or any other) attribute is set, check-attr
> > still reports 'unspecified'. More precisely:
> > 
> > $ git init test
> > Initialized empty Git repository in /home/jan/test/.git/
> > $ cd test
> > $ mkdir foo
> > $ touch foo/bar
> > $ echo "foo export-ignore" > .gitattributes
> > $ git check-attr export-ignore foo
> > foo: export-ignore: set
> > $ git check-attr export-ignore foo/bar
> > foo/bar: export-ignore: unspecified
> > 
> > I would expect the last command to also report 'set'. I've also tried
> > other patterns like 'foo/' and 'foo*', but it didn't make any
> > difference. Is this expected behaviour? It does make checking the
> > attributes of single files somewhat more difficult.
> 
> Yes, it is the expected behavior, though I cannot offhand think of
> anything that would break if we did apply it recursively.

Naively, such a patch might look something like this:

diff --git a/attr.c b/attr.c
index de170ff..ac04188 100644
--- a/attr.c
+++ b/attr.c
@@ -791,8 +791,18 @@ static void collect_all_attrs(const char *path)
 		check_all_attr[i].value = ATTR__UNKNOWN;
 
 	rem = attr_nr;
-	for (stk = attr_stack; 0 < rem && stk; stk = stk->prev)
+	for (stk = attr_stack; 0 < rem && stk; stk = stk->prev) {
+		last_slash = path;
+		for (cp = path; *cp; cp++) {
+			if (*cp == '/') {
+				rem = fill(path, cp - path + 1,
+					   last_slash - path,
+					   stk, rem);
+				last_slash = cp;
+			}
+		}
 		rem = fill(path, pathlen, basename_offset, stk, rem);
+	}
 }
 
 int git_check_attr(const char *path, int num, struct git_attr_check *check)

which is based on current "next" (because it has some other related
fixes for handling directories). It seems to work for me, but I suspect
we could do it more optimally. If you have N files in "foo/", this will
check "foo/" against the attribute stack N times, and we should be able
to amortize that work.

Hmm. Actually, thinking on it more, I'm not sure this is even going to
give the right answer anyway, as it will check "foo" against the
"foo/.gitattributes", which is not right. I think we'd need to collect
attributes as we walk the stack in prepare_attr_stack.

So take this as a "this is not how to do it" patch. :)

-Peff
