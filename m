From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Parametrize asciidoc and add --unsafe
Date: Wed, 25 Jan 2006 01:52:22 -0500
Message-ID: <1138171942.27366.104.camel@dv>
References: <1138140946.19065.2.camel@dv>
	 <7vzmll2h5h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 25 07:52:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1eWO-0004W6-93
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 07:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWAYGw3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 01:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWAYGw3
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 01:52:29 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:28564 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750722AbWAYGw2
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2006 01:52:28 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1F1eVs-0006Nv-DG
	for git@vger.kernel.org; Wed, 25 Jan 2006 01:52:16 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1F1eVy-0000zA-Ez; Wed, 25 Jan 2006 01:52:22 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmll2h5h.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.5.4 (2.5.4-10) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15120>

On Tue, 2006-01-24 at 18:08 -0800, Junio C Hamano wrote:
> Pavel Roskin <proski@gnu.org> writes:
> 
> > Including files from the parent directory is considered unsafe by
> > asciidoc 7.1.0.  This is used in git.txt, which includes ../README.
> 
> Is copying/linking README down when we build documentation a
> more conservative option, I wonder?

I considered this possibility.  I don't have a strong preference.  The
argument in favor of "--unsafe" is that adding a make target is more
intrusive that adding a switch.  Besides, we may want to include more
files from other directories.

> Does asciidoc prior to 7.1.0 do sensible thing given an --unsafe
> option?  If not, how does one override ASCIIDOC from the command
> line to the toplevel "make"?

Good question.  I misunderstood the asciidoc changelog.  Older versions
(before 7.0.4) understand "--safe", but not "--unsafe".  Since version
7.0.4 is less than 2 months old, it would be reasonable not to go ahead
with my patch right now.

Let's make a copy for now.  Symbolic linking doesn't work - asciidoc
recognizes and rejects symlinks.

---
[PATCH] Don't include ../README in git.txt - make a local copy

asciidoc 7.0.4 and newer considers such includes from parent directory
unsafe.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 Documentation/.gitignore |    1 +
 Documentation/Makefile   |    9 ++++++---
 Documentation/git.txt    |    2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index 9fef490..c87c61a 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -4,3 +4,4 @@
 *.7
 howto-index.txt
 doc.dep
+README
diff --git a/Documentation/Makefile b/Documentation/Makefile
index a65fb1b..a3bca86 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -62,11 +62,14 @@ doc.dep : $(wildcard *.txt) build-docdep
 
 -include doc.dep
 
-git.7: ../README
+git.7: README
+
+README: ../README
+	cp $< $@
 
 
 clean:
-	rm -f *.xml *.html *.1 *.7 howto-index.txt howto/*.html doc.dep
+	rm -f *.xml *.html *.1 *.7 howto-index.txt howto/*.html doc.dep README
 
 %.html : %.txt
 	asciidoc -b xhtml11 -d manpage -f asciidoc.conf $<
@@ -77,7 +80,7 @@ clean:
 %.xml : %.txt
 	asciidoc -b docbook -d manpage -f asciidoc.conf $<
 
-git.html: git.txt ../README
+git.html: git.txt README
 
 glossary.html : glossary.txt sort_glossary.pl
 	cat $< | \
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 25bcb84..e8ef3ef 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -586,7 +586,7 @@ git Diffs
 
 Discussion[[Discussion]]
 ------------------------
-include::../README[]
+include::README[]
 
 Authors
 -------


-- 
Regards,
Pavel Roskin
