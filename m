From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 16'/16] vcs-svn: Add svn delta parser
Date: Sun, 10 Oct 2010 23:01:40 -0500
Message-ID: <20101011040140.GC5649@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
 <20100810125317.GB3921@kytes>
 <20101011023435.GA706@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 06:05:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P59df-0001rs-89
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 06:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754Ab0JKEFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 00:05:04 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35156 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040Ab0JKEFB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 00:05:01 -0400
Received: by yxm8 with SMTP id 8so62311yxm.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 21:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=8PVqUVGPdY+npigrGA0k7etQCmhG7Mqyi0lBXc44bIk=;
        b=r2QNxuByyyzWyItNfoA/VocFuaaKizufpeJ6BL7+g1OMT1Wr2U0ucuncvcIyqe3F4O
         bLhGv8V9s8cgDCp3C3bAfzxt/cHJhXOg/BFnxoF8tCsu4WNxyxkbejNreM/cnoiOduJx
         d6HzHcVxL8ljMLUr5WPohuSNa07rcWCkSoFmg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=E0WmaezJzSx5zWvRt4NT/WANAwV/GzZY3SrsFoMVA1VEldDkeUTuGPZyP0ha297U2c
         MUx6mkGIClhjPolj1e/+uFzQnrbv4UDIBPjOUMwGEDmi5UE475Bd5fWVPLc9ktlrHoLd
         0fsBB0LeVafdTe/XAb4cwuHtdZXXNbd7Jf1R8=
Received: by 10.236.103.37 with SMTP id e25mr10692780yhg.71.1286769899447;
        Sun, 10 Oct 2010 21:04:59 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id f46sm4749158yhc.17.2010.10.10.21.04.55
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 21:04:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101011023435.GA706@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158748>

Implement an svndiff 0 interpreter, for use by the dumpfilev3
importer.  It is slower than it needs to be (e.g., it does not use
fseek() on input) for simplicity.

This is based only on the spec and not Subversion's implementation of
the svndiff0 spec.

The tests come from various deltas encountered in importing the
Apache SVN repo.

The svndiff0 semantics are not completely documented, meaning that
some of this work had to be done by guesswork.  It is not complete.

This version of the patch omits the enormous Xerces.cpp test (which
is not so interesting because it passes, anyway).

Helped-by: Ramkumar Ramachandra <artagnon@gmail.com>
Helped-by: Thomas Rast <trast@student.ethz.ch>
Helped-by: David Barr <david.barr@cordelta.com>
Not-signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
[alternate ending, for those who do not like reading 3-MiB messages -
sorry about that]

Still not signed off because I haven't checked the copyright of the
tests.  I would prefer tiny deltas or deltas of some public-domain
work (e.g., drafts of foundation documents of some country).

This patch owes a great deal to David and Ram, probably more than
it owes to me.  David made lots and lots of fixes.  Ram introduced
the tests and helped with design.  Thomas provided an early sanity
check for code clarity.

Thanks for reading.

 Makefile              |    4 +-
 t/t9010-svn-fe.sh     |   14 ++
 t/t9010/newdata.diff0 |  Bin 0 -> 19392 bytes
 t/t9010/newdata.done  |  522 +++++++++++++++++++++++++++++++++++++++++++++++++
 t/t9010/src.diff0     |  Bin 0 -> 74 bytes
 t/t9010/src.done      |  522 +++++++++++++++++++++++++++++++++++++++++++++++++
 test-svn-fe.c         |   37 +++-
 vcs-svn/svndiff.c     |  265 +++++++++++++++++++++++++
 vcs-svn/svndiff.h     |    9 +
 9 files changed, 1364 insertions(+), 9 deletions(-)
 create mode 100644 t/t9010/blank.done
 create mode 100644 t/t9010/newdata.diff0
 create mode 100644 t/t9010/newdata.done
 create mode 100644 t/t9010/src.diff0
 create mode 100644 t/t9010/src.done
 create mode 100644 vcs-svn/svndiff.h

diff --git a/Makefile b/Makefile
index d99da33..966f5c7 100644
--- a/Makefile
+++ b/Makefile
@@ -1766,7 +1766,7 @@ XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
 VCSSVN_OBJS = vcs-svn/string_pool.o vcs-svn/line_buffer.o \
 	vcs-svn/repo_tree.o vcs-svn/fast_export.o vcs-svn/svndump.o \
-	vcs-svn/sliding_window.o
+	vcs-svn/sliding_window.o vcs-svn/svndiff.o
 OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS) $(VCSSVN_OBJS)
 
 dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
@@ -1893,7 +1893,7 @@ xdiff-interface.o $(XDIFF_OBJS): \
 $(VCSSVN_OBJS): \
 	vcs-svn/obj_pool.h vcs-svn/trp.h vcs-svn/string_pool.h \
 	vcs-svn/line_buffer.h vcs-svn/repo_tree.h vcs-svn/fast_export.h \
-	vcs-svn/svndump.h vcs-svn/sliding_window.h
+	vcs-svn/sliding_window.h vcs-svn/svndump.h vcs-svn/svndiff.h
 endif
 
 exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index fd851a4..9e61608 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -14,6 +14,18 @@ svn_cmd () {
 	svn "$subcommand" --config-dir "$svnconf" "$@"
 }
 
+test_delta () {
+	delta="$TEST_DIRECTORY/$1"
+	preimage="$TEST_DIRECTORY/$2"
+	expect="$TEST_DIRECTORY/$3"
+	expectation=${4:-success}
+	test_expect_$expectation "$delta" '
+		delta_len=$(wc -c <"$delta") &&
+		test-svn-fe -d "$preimage" "$delta" $delta_len >actual &&
+		test_cmp "$expect" actual
+	'
+}
+
 test_dump () {
 	label=$1
 	dump=$2
@@ -38,5 +50,7 @@ test_dump () {
 }
 
 test_dump simple t9135/svn.dump
+test_delta t9010/newdata.diff0 t9010/blank.done t9010/newdata.done
+test_delta t9010/src.diff0 t9010/newdata.done t9010/src.done failure
 
 test_done
diff --git a/t/t9010/blank.done b/t/t9010/blank.done
new file mode 100644
index 0000000..e69de29
diff --git a/t/t9010/newdata.diff0 b/t/t9010/newdata.diff0
new file mode 100644
index 0000000000000000000000000000000000000000..57813032b74ff90fae130841a2a32ea909d489cc
GIT binary patch
literal 19392
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
Sy02OE;6CKe^(VDHJNREnOC7xc

literal 0
HcmV?d00001

diff --git a/t/t9010/newdata.done b/t/t9010/newdata.done
new file mode 100644
index 0000000..f53c3bf
--- /dev/null
+++ b/t/t9010/newdata.done
@@ -0,0 +1,522 @@
+APACHE COMMONS PROJECT
+STATUS: -*-indented-text-*- Last modified at [$Date$]
+
+Background:
+    o IRC channel #apache-commons on irc.openprojects.net
+      traffic is logged to <URL:http://Source-Zone.Org/apache-irc/>
+      so that the content of interactive discussions is available
+      to everyone
+
+Project committers (as of 2002-10-27):
+    o commons:
+      aaron,coar,donaldp,jerenkrantz,fitz,geirm,gstein,jim,striker
+    o commons-site:
+      aaron,coar,donaldp,jerenkrantz,fitz,geirm,gstein,jim,striker,
+      sanders,nicolaken
+
+Release:
+    none yet; still defining mission :-)
+
+
+Resolved Issues:
+
+    o Commons is a parent of reusable code projects. These projects
+      may be used by other projects of the ASF, but it is not a
+      requirement.
+
+    o The Commons will be language-agnostic.
+
+    o Projects that are "in scope" are defined as:
+    
+      - Existing components that are, or would be, useful to multiple
+        projects
+
+      - If a component does not fit the (TBD) goals of Apache Commons,
+        then it is not considered "in scope" just because it has no
+        other home. In other words, the Apache Commons is not a place
+        of last refuge if the component does not match the Apache
+        Commons' goals.
+
+      - Reusable libraries
+        [ gstein: we should expand this definition for the mission
+          statement; examples provided were serf and regexp ]
+
+      - Components that do not fit cleanly into any other top-level
+        project, but they do fit the goals of Commons.
+
+    o Voting will follow the "standard Apache voting guidelines"
+
+      [ be nice to refer to an Incubator doc here ]
+
+    o All code donations [to the ASF, destined for Apache Commons]
+      arrive via the Incubator, unless the Incubator states they can
+      be placed directly into Commons.
+
+    o Existing Commons committers can start new components without a
+      detour to the Incubator. These new components must be approved
+      by the PMC and must meet the (TBD) goals of Apache Commons.
+
+
+Pending issues:
+    o Coming up with a set of bylaws for the project
+
+    o Enabling Reply-to on the @commons lists
+      (pmc@ will *not* use reply-to munging, but user lists
+      will be determined by user majority; this item applies
+      to lists for which the decision has not yet been made)
+      +1: aaron, coar, donaldp, geirm, acoliver, mas, bayard, sanders
+      -1: fitz, gstein, jerenkrantz, striker, jim
+
+    o The name 'Commons' has caused some heartburn with the
+      Jakarta community because of the Jakarta-Commons project.
+      Should we rename to avoid conflicts and keep the peace?
+      Conflicts would include Java namespace as well as
+      philosophical aspects.
+      +1: 
+      +0: coar (i'm willing)
+      -0: jerenkrantz, donaldp, striker, gstein, fitz
+      -1: sanders
+
+    o If we rename, to what?  What words/names describe our
+      purpose?
+      - toolbox
+        +0: gstein (I'd be +1 but for the confusion with the existing
+                    Apache Toolbox project, but *really* like this
+                    name)
+      - toolchest
+        +0.5: gstein
+      - tools
+        +0: gstein
+        -1: donaldp (tools are different to components)
+      - components
+        +0: gstein (a bit long)
+      - util
+      - library
+        +0: gstein (doesn't fit well with perl/python "modules")
+      - suite (sweet?)
+      - belt (as in bat-belt or tool-belt)
+      - mcgyver
+      - foundry or mill
+        +1: sanders (maybe too 'SourceForgeesque')
+        -0: donaldp (If reorg goes through we may have multiple
+                     foundaries or federations for different "concepts")
+      - federation
+      - share or shared
+      - stuff
+        +.3: fitz :)
+      - ?
+
+    o Style for the mailing lists:
+    
+      One community mailing list, with specific breakouts:
+        +1: fitz, jerenkrantz, sanders, coar,
+            donaldp (lets start here and evolve)
+      +0.5: mas
+        -0: aaron (too early)
+      
+      Topical mailing lists:
+        +1: gstein, scolebourne, acoliver, striker
+        -0: aaron (too early), jerenkrantz
+      -0.1: mas, sanders (too early for this), donaldp
+        -1: coar
+      
+      Per-language mailing lists:
+        -0: aaron (too early)
+      -0.1: mas
+        -1: gstein, sanders, fitz, jerenkrantz, striker, coar
+
+      Per-component mailing lists as a default (breakouts will create
+          these as a matter of course, this is about the default)
+      +0.7: mas
+        -0: aaron (too early)
+      -0.9: sanders
+        -1: gstein, fitz, jerenkrantz, striker
+
+    o A number of very valid issues have been brought up on the
+      list. We need to figure out how the Commons Project will
+      deal with each of these, in terms of new components and
+      how those components will contain code projects. This list
+      is only meant to keep record of all the issues:
+
+        - Releasable pieces
+        - Release rules
+        - Voting scope
+        - Directory structure and naming conventions
+        - Coding style
+        - Build system consistency (or inconsistency)
+        - Namespace issues (esp. w/ java)
+        - Language vs. Functional
+
+    o Default commit privileges
+    
+      - Commons-wide
+        +1:
+        -1: gstein, striker, donaldp
+      
+      - Per-component
+        +1: gstein, striker, donaldp, jerenkrantz
+        -1:
+      
+      - Per-component with self-chosen aggregation
+        +1: gstein, donaldp
+        -1:
+
+    o Granularity of CVS repositories for components (this excludes
+      commons-site)
+    
+      - Commons-wide
+        +1: gstein, donaldp, jerenkrantz
+        -1:
+      
+      - Per-topic
+        +1:
+        -0: gstein, donaldp, jerenkrantz
+        -1: 
+      
+      - Per-component
+        +1:
+        -1: gstein, donaldp, jerenkrantz
+
+
+Project Mission:
+
+What is the project's mission?  Our statement of goals/mission/vision
+should arise from the answers to the following and other questions:
+(jim notes that defining something after the fact seems very backwards
+ and broken; gstein notes that we're refining the board-provided
+ charter)
+
+    o Should commons have an sandbox component to ease infrastructure
+      burden on smaller code bases?
+      +1: coar, donaldp, jerenkrantz, gstein, sanders (non-binding)
+      +0: fitz
+      -0: striker
+      -1: jim (the PMC is about reusability, not sandbox),
+          aaron (what jim said; and go see incubator)
+
+    o What types of components would be appropriate for this project? 
+      ("in scope")
+
+      - Tools that help/promote reusability?
+        Hypothetical: ant, jlibtool, ASF-based autoconf
+        +1: jerenkrantz, gstein, striker, fitz, sanders (non-binding)
+        -0: donaldp (prefer a tools PMC for that)
+        -1: aaron (too broad, don't belong here)
+
+      - Development frameworks?
+        Hypothetical: avalon
+        +1: fitz
+        -0: donaldp (how do we determine this given we would prolly
+                     accept it if it was new?)
+        -1: gstein (the avalon components, but not the whole bugger),
+            striker, sanders (non-binding)
+
+     - Components that fit the (TBD) goals of Commons, have a more
+       "logical" home elsewhere in the ASF, but were rejected by that
+       home?
+        +1: gstein, donaldp
+         0: striker (on a case by case basis, taking reasons for rejection
+                     seriously into account. Abstain from vote until
+                     rephrased),
+            fitz (what striker said), aaron (what fitz said)
+        -1: jerenkrantz, sanders (non-binding)
+
+      FOLD BELOW VOTES INTO ABOVE? (i.e. eliminate the "donation" wording)
+      - Donations that could fit but have a more obvious (proper) home which
+        has already rejected it?
+        +1: coar, donaldp, gstein (note the "might fit" term)
+        -0:
+        -1: jerenkrantz, jim, aaron, striker, fitz
+
+      - Existing ASF components whose committers believe that they
+        are a better fit under commons and the commons PMC agrees?
+        (If this component were brought up as new, we would accept it.)
+        +1: coar, donaldp, jerenkrantz, striker, gstein, fitz
+        -1: jim (by this definition httpd could be in commons)
+                (gstein says: see the "if" part; we wouldn't accept httpd)
+                (jim says: until we better define what the PMC would or
+                 would not accept, then this seems too wishy-washy to me)
+             (gstein says: jim, you're blocking closure on this;
+              how would you refine the phrasing here; the intent
+              here is to accept components from the other Commons
+              projects or projects with reusable component),
+             aaron (we need to differenciate ourselves from other
+                    libraries first, namely APR)
+
+      - Packages being worked on by Apache developers, with a clear
+        affiliation, that can't or won't be bundled?  (E.g., an
+        httpd module)
+        +1: coar, donaldp
+        -1: jerenkrantz, striker, gstein, fitz, jim, aaron
+       CLOSE THIS? (as "not passed"; what is a good way to phrase this?)
+
+      - Should we have a minimum bar of entry for components?
+        +1:
+        -0: donaldp, gstein
+        -1:
+       
+      - Should we have a minimum set of requirements before components
+        are released?
+        +1: donaldp, gstein (mixed, see below), striker
+        -1: jerenkrantz (what is released?)
+
+      - If yes to above then which things should be part of minimum
+        requirements?
+
+        documentation: require basic overview and user docs
+        +1: donaldp
+        -0: gstein (recommend highly, but let the committers determine
+                    what is right for the component),
+            striker, jerenkrantz
+        -1:
+
+        uptodate website: require website be updated to latest release
+                          but may still host previous release docs.
+        +1: donaldp, gstein, striker
+        -0: jerenkrantz
+        -1:
+
+        unit tests: (okay so this will never get consensus but ...)
+        +1: donaldp
+        -1: gstein (unit tests should be recommended, but not
+                    mandated; I also find it unreasonable for initial
+                    development/pre-alpha releases, but it can make
+                    sense for "final" types of releases),
+            striker, jerenkrantz
+
+        versioning standard: derived from
+            http://apr.apache.org/versioning.html
+            http://jakarta.apache.org/commons/versioning.html
+        +1: donaldp, gstein, striker, jerenkrantz
+        -1:
+
+        release process: derived from
+          http://jakarta.apache.org/commons/releases.html
+          http://jakarta.apache.org/turbine/maven/development/release-process.html
+          http://cvs.apache.org/viewcvs.cgi/jakarta-ant/ReleaseInstructions?rev=1.9.2.1&content-type=text/vnd.viewcvs-markup
+        +1: donaldp
+        -1: gstein (we should provide "best practices" but allow each
+                    components' committers to define their rules),
+            striker, jerenkrantz
+
+        deprecation process: (java specific?)
+          http://jakarta.apache.org/turbine/maven/development/deprecation.html
+        +1: donaldp, gstein (I see this as part of the "versioning"
+                             process, and we can provide best
+                             practices here)
+        -0: jerenkrantz (kinda sorta versioning, but not quite)
+        -1:
+
+        CVS/Subversion branching:
+          http://jakarta.apache.org/turbine/maven/development/branches.html
+        +1: donaldp
+        -1: gstein (we should provide "best practices" but allow each
+                    components' committers to define their rules),
+            striker, jerenkrantz
+
+
+Candidate Projects:
+
+    o APR's serf project has voted itself to move into Commons.
+    
+      - Should the PMC accept it as fitting the Commons goal?
+        +1: gstein, fitz, jerenkrantz, striker, donaldp
+        -1: aaron (no such thing as "the Commons goal", how can it fit it?)
+
+      - When should it move?
+
+        Whenever it likes:
+          +1: gstein, sanders, jerenkrantz, striker
+          +0: donaldp (+1 if we use subversion, but if using CVS 
+              we should hold off until structure is decided upon)
+          -1: aaron (after we know why it fits)
+
+        Give us a while:
+          +1: fitz (what's the hurry?), aaron
+          -0: gstein (we're only talking about a small seed of a
+                codebase; it won't get in our way as we complete the
+                charter), striker
+
+      - Where should the CVS code be located?
+      
+        commons/serf   (each component under top-level)
+            +1: sanders (works well at jakarta-commons)
+                fitz (Please don't mix interface and implementation 
+                  of commons!), aaron
+            +0: jerenkrantz
+          -0.5: gstein
+            -1: donaldp (makes it difficult to update all related 
+                         projects with a single sweep)
+
+        commons/components/serf   (all components under this dir,
+            leaving the top open for other non-code items)
+          +0: gstein, striker, donaldp (is this just dev with a 
+                                        different name?
+                                        (gstein says "yes"))
+          -1: fitz, aaron, jerenkrantz
+        
+        commons/clients/serf   (topical-groups under top-level)
+          +1: gstein, jerenkrantz
+          -1: fitz, aaron, donaldp
+        
+        commons/dev/serf  (all components under "dev")
+          +1: gstein, donaldp (if we are having a single 
+                               monolithic repo for all commons)
+          -1: fitz, aaron, jerenkrantz
+        
+        commons/bootstrap/serf  (serf is very early stage, so maybe we
+            have a "bootstrap" area; this is different from Incubator
+            since the existing committers do not need "training")
+          +1: gstein, donaldp
+          -1: fitz, aaron, jerenkrantz
+
+        commons/???
+
+        commons/c/serf (separate out component based on language
+                        and then have a flat structure underneath)
+          +1: donaldp
+          -1: jerenkrantz
+
+      - What mailing list should it use for dev discussions?
+      
+        general@commons.apache.org:  (one group for all discussion;
+                                      dev and non-dev alike)
+          -0.5: gstein
+            -1: striker, aaron, jerenkrantz
+        
+        dev@commons.apache.org:  (one group for dev discussion;
+                                  general@ remains for non-dev)
+          +1: gstein, fitz, sanders, jerenkrantz, striker, donaldp
+          
+        clients-dev@commons.apache.org:
+           (this is really TOPICNAME-dev@ where I preselected
+            "clients" for TOPICNAME; this question is whether this
+            style would be appropriate)
+          +1: gstein, striker
+          -0: sanders, donaldp (maybe in the future but too early),
+              jerenkrantz
+          -1: aaron (what is "clients"? I'd probably be +1 if I knew
+                     what that was)
+
+      - Note: serf has no web site, so there isn't a need to figure
+        that out right now.
+
+
+Assets:
+    DNS:                commons.apache.org
+    
+    Mailing lists:      general@commons.apache.org
+                        announce@commons.apache.org
+                        pmc@commons.apache.org
+                        cvs@commons.apache.org
+                        
+                        [ core-cvs@commons.apache.org in case we
+                          create a commons-core CVS module ]
+
+    Web site:           http://commons.apache.org/
+    
+    Repositories:       commons        (code, info, etc)
+                        commons-site   (the web site)
+
+
+PMC Members:
+
+    Aaron Bannert <aaron@apache.org>
+    Ken Coar <coar@apache.org>
+    Peter Donald <peter@apache.org>
+    Justin Erenkrantz <jerenkrantz@apache.org>
+    Brian W. Fitzpatrick <fitz@apache.org>
+    Jim Jagielski <jim@apache.org>
+    Geir Magnusson Jr. <geirm@apache.org>
+    Greg Stein <gstein@lyra.org>
+    Sander Striker <striker@apache.org>
+
+    Note: Ken Coar is the Chair
+
+
+PMC Members, pending Board approval:
+
+    none yet
+
+    [ this may become obsolete; the Board is discussing a way for the
+      Chair to directly alter the PMC membership; until then, however,
+      we need PMC members ratified by the board, and this tracks them ]
+
+
+Committers:
+
+    none yet [still defining mission]
+
+
+Invited Committers:
+
+    none yet
+
+
+Current mission/charter as approved by the board:
+
+    'The Apache Commons PMC hereby is responsible for the creation
+    and maintenance of software related to reusable libraries and
+    components, based on software licensed to the Foundation.'
+
+The complete text of the resolution that was passed is:
+
+       WHEREAS, the Board of Directors deems it to be in the best
+       interests of the Foundation and consistent with the
+       Foundation's purpose to establish a Project Management
+       Committee charged with the creation and maintenance of
+       open-source software related to reusable libraries and
+       components, for distribution at no charge to the public.
+
+       NOW, THEREFORE, BE IT RESOLVED, that a Project Management
+       Committee (PMC), to be known as the "Apache Commons PMC", be
+       and hereby is established pursuant to Bylaws of the Foundation;
+       and be it further
+
+       RESOLVED, that the Apache Commons PMC be and hereby is
+       responsible for the creation and maintenance of software
+       related to reusable libraries and components, based on software
+       licensed to the Foundation; and be it further
+
+       RESOLVED, that the office of "Vice President, Apache Commons"
+       be and hereby is created, the person holding such office to
+       serve at the direction of the Board of Directors as the chair
+       of the Apache Commons PMC, and to have primary responsibility
+       for management of the projects within the scope of
+       responsibility of the Apache Commons PMC; and be it further
+
+       RESOLVED, that the persons listed immediately below be and
+       hereby are appointed to serve as the initial members of the
+       Apache Commons PMC:
+
+              Aaron Bannert
+              Ken Coar (chair)
+              Peter Donald
+              Justin Erenkrantz
+              Brian W. Fitzpatrick
+              Jim Jagielski
+              Geir Magnusson Jr.
+              Greg Stein
+              Sander Striker
+
+       NOW, THEREFORE, BE IT FURTHER RESOLVED, that Ken Coar be and
+       hereby is appointed to the office of Vice President, Apache
+       Commons, to serve in accordance with and subject to the
+       direction of the Board of Directors and the Bylaws of the
+       Foundation until death, resignation, retirement, removal or
+       disqualification, or until a successor is appointed; and be it
+       further
+
+       RESOLVED, that the initial Apache Commons PMC be and hereby is
+       tasked with the creation of a set of bylaws intended to
+       encourage open development and increased participation in the
+       Apache Commons Project.
+
+#
+# Local Variables:
+# mode: indented-text
+# tab-width: 4
+# indent-tabs-mode: nil
+# tab-stop-list: (4 6 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80)
+# End:
+#
diff --git a/t/t9010/src.diff0 b/t/t9010/src.diff0
new file mode 100644
index 0000000000000000000000000000000000000000..50a49fc1065a313b8592645614e3779261c981fe
GIT binary patch
literal 74
zcmWFz^J8FWobJ&$y_(yQVFD||Mux_A*9puDK#;ExT$)stT2!2wpQlisnUkZCl&Vl#
WoSLGLmS3a*lSt0bD=Es);Q|10>loAk

literal 0
HcmV?d00001

diff --git a/t/t9010/src.done b/t/t9010/src.done
new file mode 100644
index 0000000..56b2572
--- /dev/null
+++ b/t/t9010/src.done
@@ -0,0 +1,522 @@
+APACHE COMMONS PROJECT
+STATUS: -*-indented-text-*- Last modified at [$Date$]
+
+Background:
+    o IRC channel #apache-commons on irc.openprojects.net
+      traffic is logged to <URL:http://Source-Zone.Org/apache-irc/>
+      so that the content of interactive discussions is available
+      to everyone
+
+Project committers (as of 2002-10-27):
+    o commons:
+      aaron,coar,donaldp,jerenkrantz,fitz,geirm,gstein,jim,striker
+    o commons-site:
+      aaron,coar,donaldp,jerenkrantz,fitz,geirm,gstein,jim,striker,
+      sanders,nicolaken
+
+Release:
+    none yet; still defining mission :-)
+
+
+Resolved Issues:
+
+    o Commons is a parent of reusable code projects. These projects
+      may be used by other projects of the ASF, but it is not a
+      requirement.
+
+    o The Commons will be language-agnostic.
+
+    o Projects that are "in scope" are defined as:
+    
+      - Existing components that are, or would be, useful to multiple
+        projects
+
+      - If a component does not fit the (TBD) goals of Apache Commons,
+        then it is not considered "in scope" just because it has no
+        other home. In other words, the Apache Commons is not a place
+        of last refuge if the component does not match the Apache
+        Commons' goals.
+
+      - Reusable libraries
+        [ gstein: we should expand this definition for the mission
+          statement; examples provided were serf and regexp ]
+
+      - Components that do not fit cleanly into any other top-level
+        project, but they do fit the goals of Commons.
+
+    o Voting will follow the "standard Apache voting guidelines"
+
+      [ be nice to refer to an Incubator doc here ]
+
+    o All code donations [to the ASF, destined for Apache Commons]
+      arrive via the Incubator, unless the Incubator states they can
+      be placed directly into Commons.
+
+    o Existing Commons committers can start new components without a
+      detour to the Incubator. These new components must be approved
+      by the PMC and must meet the (TBD) goals of Apache Commons.
+
+
+Pending issues:
+    o Co    o Subversion will be used for version controlComing up with a set of bylaws for the project
+
+    o Enabling Reply-to on the @commons lists
+      (pmc@ will *not* use reply-to munging, but user lists
+      will be determined by user majority; this item applies
+      to lists for which the decision has not yet been made)
+      +1: aaron, coar, donaldp, geirm, acoliver, mas, bayard, sanders
+      -1: fitz, gstein, jerenkrantz, striker, jim
+
+    o The name 'Commons' has caused some heartburn with the
+      Jakarta community because of the Jakarta-Commons project.
+      Should we rename to avoid conflicts and keep the peace?
+      Conflicts would include Java namespace as well as
+      philosophical aspects.
+      +1: 
+      +0: coar (i'm willing)
+      -0: jerenkrantz, donaldp, striker, gstein, fitz
+      -1: sanders
+
+    o If we rename, to what?  What words/names describe our
+      purpose?
+      - toolbox
+        +0: gstein (I'd be +1 but for the confusion with the existing
+                    Apache Toolbox project, but *really* like this
+                    name)
+      - toolchest
+        +0.5: gstein
+      - tools
+        +0: gstein
+        -1: donaldp (tools are different to components)
+      - components
+        +0: gstein (a bit long)
+      - util
+      - library
+        +0: gstein (doesn't fit well with perl/python "modules")
+      - suite (sweet?)
+      - belt (as in bat-belt or tool-belt)
+      - mcgyver
+      - foundry or mill
+        +1: sanders (maybe too 'SourceForgeesque')
+        -0: donaldp (If reorg goes through we may have multiple
+                     foundaries or federations for different "concepts")
+      - federation
+      - share or shared
+      - stuff
+        +.3: fitz :)
+      - ?
+
+    o Style for the mailing lists:
+    
+      One community mailing list, with specific breakouts:
+        +1: fitz, jerenkrantz, sanders, coar,
+            donaldp (lets start here and evolve)
+      +0.5: mas
+        -0: aaron (too early)
+      
+      Topical mailing lists:
+        +1: gstein, scolebourne, acoliver, striker
+        -0: aaron (too early), jerenkrantz
+      -0.1: mas, sanders (too early for this), donaldp
+        -1: coar
+      
+      Per-language mailing lists:
+        -0: aaron (too early)
+      -0.1: mas
+        -1: gstein, sanders, fitz, jerenkrantz, striker, coar
+
+      Per-component mailing lists as a default (breakouts will create
+          these as a matter of course, this is about the default)
+      +0.7: mas
+        -0: aaron (too early)
+      -0.9: sanders
+        -1: gstein, fitz, jerenkrantz, striker
+
+    o A number of very valid issues have been brought up on the
+      list. We need to figure out how the Commons Project will
+      deal with each of these, in terms of new components and
+      how those components will contain code projects. This list
+      is only meant to keep record of all the issues:
+
+        - Releasable pieces
+        - Release rules
+        - Voting scope
+        - Directory structure and naming conventions
+        - Coding style
+        - Build system consistency (or inconsistency)
+        - Namespace issues (esp. w/ java)
+        - Language vs. Functional
+
+    o Default commit privileges
+    
+      - Commons-wide
+        +1:
+        -1: gstein, striker, donaldp
+      
+      - Per-component
+        +1: gstein, striker, donaldp, jerenkrantz
+        -1:
+      
+      - Per-component with self-chosen aggregation
+        +1: gstein, donaldp
+        -1:
+
+    o Granularity of CVS repositories for components (this excludes
+      commons-site)
+    
+      - Commons-wide
+        +1: gstein, donaldp, jerenkrantz
+        -1:
+      
+      - Per-topic
+        +1:
+        -0: gstein, donaldp, jerenkrantz
+        -1: 
+      
+      - Per-component
+        +1:
+        -1: gstein, donaldp, jerenkrantz
+
+
+Project Mission:
+
+What is the project's mission?  Our statement of goals/mission/vision
+should arise from the answers to the following and other questions:
+(jim notes that defining something after the fact seems very backwards
+ and broken; gstein notes that we're refining the board-provided
+ charter)
+
+    o Should commons have an sandbox component to ease infrastructure
+      burden on smaller code bases?
+      +1: coar, donaldp, jerenkrantz, gstein, sanders (non-binding)
+      +0: fitz
+      -0: striker
+      -1: jim (the PMC is about reusability, not sandbox),
+          aaron (what jim said; and go see incubator)
+
+    o What types of components would be appropriate for this project? 
+      ("in scope")
+
+      - Tools that help/promote reusability?
+        Hypothetical: ant, jlibtool, ASF-based autoconf
+        +1: jerenkrantz, gstein, striker, fitz, sanders (non-binding)
+        -0: donaldp (prefer a tools PMC for that)
+        -1: aaron (too broad, don't belong here)
+
+      - Development frameworks?
+        Hypothetical: avalon
+        +1: fitz
+        -0: donaldp (how do we determine this given we would prolly
+                     accept it if it was new?)
+        -1: gstein (the avalon components, but not the whole bugger),
+            striker, sanders (non-binding)
+
+     - Components that fit the (TBD) goals of Commons, have a more
+       "logical" home elsewhere in the ASF, but were rejected by that
+       home?
+        +1: gstein, donaldp
+         0: striker (on a case by case basis, taking reasons for rejection
+                     seriously into account. Abstain from vote until
+                     rephrased),
+            fitz (what striker said), aaron (what fitz said)
+        -1: jerenkrantz, sanders (non-binding)
+
+      FOLD BELOW VOTES INTO ABOVE? (i.e. eliminate the "donation" wording)
+      - Donations that could fit but have a more obvious (proper) home which
+        has already rejected it?
+        +1: coar, donaldp, gstein (note the "might fit" term)
+        -0:
+        -1: jerenkrantz, jim, aaron, striker, fitz
+
+      - Existing ASF components whose committers believe that they
+        are a better fit under commons and the commons PMC agrees?
+        (If this component were brought up as new, we would accept it.)
+        +1: coar, donaldp, jerenkrantz, striker, gstein, fitz
+        -1: jim (by this definition httpd could be in commons)
+                (gstein says: see the "if" part; we wouldn't accept httpd)
+                (jim says: until we better define what the PMC would or
+                 would not accept, then this seems too wishy-washy to me)
+             (gstein says: jim, you're blocking closure on this;
+              how would you refine the phrasing here; the intent
+              here is to accept components from the other Commons
+              projects or projects with reusable component),
+             aaron (we need to differenciate ourselves from other
+                    libraries first, namely APR)
+
+      - Packages being worked on by Apache developers, with a clear
+        affiliation, that can't or won't be bundled?  (E.g., an
+        httpd module)
+        +1: coar, donaldp
+        -1: jerenkrantz, striker, gstein, fitz, jim, aaron
+       CLOSE THIS? (as "not passed"; what is a good way to phrase this?)
+
+      - Should we have a minimum bar of entry for components?
+        +1:
+        -0: donaldp, gstein
+        -1:
+       
+      - Should we have a minimum set of requirements before components
+        are released?
+        +1: donaldp, gstein (mixed, see below), striker
+        -1: jerenkrantz (what is released?)
+
+      - If yes to above then which things should be part of minimum
+        requirements?
+
+        documentation: require basic overview and user docs
+        +1: donaldp
+        -0: gstein (recommend highly, but let the committers determine
+                    what is right for the component),
+            striker, jerenkrantz
+        -1:
+
+        uptodate website: require website be updated to latest release
+                          but may still host previous release docs.
+        +1: donaldp, gstein, striker
+        -0: jerenkrantz
+        -1:
+
+        unit tests: (okay so this will never get consensus but ...)
+        +1: donaldp
+        -1: gstein (unit tests should be recommended, but not
+                    mandated; I also find it unreasonable for initial
+                    development/pre-alpha releases, but it can make
+                    sense for "final" types of releases),
+            striker, jerenkrantz
+
+        versioning standard: derived from
+            http://apr.apache.org/versioning.html
+            http://jakarta.apache.org/commons/versioning.html
+        +1: donaldp, gstein, striker, jerenkrantz
+        -1:
+
+        release process: derived from
+          http://jakarta.apache.org/commons/releases.html
+          http://jakarta.apache.org/turbine/maven/development/release-process.html
+          http://cvs.apache.org/viewcvs.cgi/jakarta-ant/ReleaseInstructions?rev=1.9.2.1&content-type=text/vnd.viewcvs-markup
+        +1: donaldp
+        -1: gstein (we should provide "best practices" but allow each
+                    components' committers to define their rules),
+            striker, jerenkrantz
+
+        deprecation process: (java specific?)
+          http://jakarta.apache.org/turbine/maven/development/deprecation.html
+        +1: donaldp, gstein (I see this as part of the "versioning"
+                             process, and we can provide best
+                             practices here)
+        -0: jerenkrantz (kinda sorta versioning, but not quite)
+        -1:
+
+        CVS/Subversion branching:
+          http://jakarta.apache.org/turbine/maven/development/branches.html
+        +1: donaldp
+        -1: gstein (we should provide "best practices" but allow each
+                    components' committers to define their rules),
+            striker, jerenkrantz
+
+
+Candidate Projects:
+
+    o APR's serf project has voted itself to move into Commons.
+    
+      - Should the PMC accept it as fitting the Commons goal?
+        +1: gstein, fitz, jerenkrantz, striker, donaldp
+        -1: aaron (no such thing as "the Commons goal", how can it fit it?)
+
+      - When should it move?
+
+        Whenever it likes:
+          +1: gstein, sanders, jerenkrantz, striker
+          +0: donaldp (+1 if we use subversion, but if using CVS 
+              we should hold off until structure is decided upon)
+          -1: aaron (after we know why it fits)
+
+        Give us a while:
+          +1: fitz (what's the hurry?), aaron
+          -0: gstein (we're only talking about a small seed of a
+                codebase; it won't get in our way as we complete the
+                charter), striker
+
+      - Where should the CVS code be located?
+      
+        commons/serf   (each component under top-level)
+            +1: sanders (works well at jakarta-commons)
+                fitz (Please don't mix interface and implementation 
+                  of commons!), aaron
+            +0: jerenkrantz
+          -0.5: gstein
+            -1: donaldp (makes it difficult to update all related 
+                         projects with a single sweep)
+
+        commons/components/serf   (all components under this dir,
+            leaving the top open for other non-code items)
+          +0: gstein, striker, donaldp (is this just dev with a 
+                                        different name?
+                                        (gstein says "yes"))
+          -1: fitz, aaron, jerenkrantz
+        
+        commons/clients/serf   (topical-groups under top-level)
+          +1: gstein, jerenkrantz
+          -1: fitz, aaron, donaldp
+        
+        commons/dev/serf  (all components under "dev")
+          +1: gstein, donaldp (if we are having a single 
+                               monolithic repo for all commons)
+          -1: fitz, aaron, jerenkrantz
+        
+        commons/bootstrap/serf  (serf is very early stage, so maybe we
+            have a "bootstrap" area; this is different from Incubator
+            since the existing committers do not need "training")
+          +1: gstein, donaldp
+          -1: fitz, aaron, jerenkrantz
+
+        commons/???
+
+        commons/c/serf (separate out component based on language
+                        and then have a flat structure underneath)
+          +1: donaldp
+          -1: jerenkrantz
+
+      - What mailing list should it use for dev discussions?
+      
+        general@commons.apache.org:  (one group for all discussion;
+                                      dev and non-dev alike)
+          -0.5: gstein
+            -1: striker, aaron, jerenkrantz
+        
+        dev@commons.apache.org:  (one group for dev discussion;
+                                  general@ remains for non-dev)
+          +1: gstein, fitz, sanders, jerenkrantz, striker, donaldp
+          
+        clients-dev@commons.apache.org:
+           (this is really TOPICNAME-dev@ where I preselected
+            "clients" for TOPICNAME; this question is whether this
+            style would be appropriate)
+          +1: gstein, striker
+          -0: sanders, donaldp (maybe in the future but too early),
+              jerenkrantz
+          -1: aaron (what is "clients"? I'd probably be +1 if I knew
+                     what that was)
+
+      - Note: serf has no web site, so there isn't a need to figure
+        that out right now.
+
+
+Assets:
+    DNS:                commons.apache.org
+    
+    Mailing lists:      general@commons.apache.org
+                        announce@commons.apache.org
+                        pmc@commons.apache.org
+                        cvs@commons.apache.org
+                        
+                        [ core-cvs@commons.apache.org in case we
+                          create a commons-core CVS module ]
+
+    Web site:           http://commons.apache.org/
+    
+    Repositories:       commons        (code, info, etc)
+                        commons-site   (the web site)
+
+
+PMC Members:
+
+    Aaron Bannert <aaron@apache.org>
+    Ken Coar <coar@apache.org>
+    Peter Donald <peter@apache.org>
+    Justin Erenkrantz <jerenkrantz@apache.org>
+    Brian W. Fitzpatrick <fitz@apache.org>
+    Jim Jagielski <jim@apache.org>
+    Geir Magnusson Jr. <geirm@apache.org>
+    Greg Stein <gstein@lyra.org>
+    Sander Striker <striker@apache.org>
+
+    Note: Ken Coar is the Chair
+
+
+PMC Members, pending Board approval:
+
+    none yet
+
+    [ this may become obsolete; the Board is discussing a way for the
+      Chair to directly alter the PMC membership; until then, however,
+      we need PMC members ratified by the board, and this tracks them ]
+
+
+Committers:
+
+    none yet [still defining mission]
+
+
+Invited Committers:
+
+    none yet
+
+
+Current mission/charter as approved by the board:
+
+    'The Apache Commons PMC hereby is responsible for the creation
+    and maintenance of software related to reusable libraries and
+    components, based on software licensed to the Foundation.'
+
+The complete text of the resolution that was passed is:
+
+       WHEREAS, the Board of Directors deems it to be in the best
+       interests of the Foundation and consistent with the
+       Foundation's purpose to establish a Project Management
+       Committee charged with the creation and maintenance of
+       open-source software related to reusable libraries and
+       components, for distribution at no charge to the public.
+
+       NOW, THEREFORE, BE IT RESOLVED, that a Project Management
+       Committee (PMC), to be known as the "Apache Commons PMC", be
+       and hereby is established pursuant to Bylaws of the Foundation;
+       and be it further
+
+       RESOLVED, that the Apache Commons PMC be and hereby is
+       responsible for the creation and maintenance of software
+       related to reusable libraries and components, based on software
+       licensed to the Foundation; and be it further
+
+       RESOLVED, that the office of "Vice President, Apache Commons"
+       be and hereby is created, the person holding such office to
+       serve at the direction of the Board of Directors as the chair
+       of the Apache Commons PMC, and to have primary responsibility
+       for management of the projects within the scope of
+       responsibility of the Apache Commons PMC; and be it further
+
+       RESOLVED, that the persons listed immediately below be and
+       hereby are appointed to serve as the initial members of the
+       Apache Commons PMC:
+
+              Aaron Bannert
+              Ken Coar (chair)
+              Peter Donald
+              Justin Erenkrantz
+              Brian W. Fitzpatrick
+              Jim Jagielski
+              Geir Magnusson Jr.
+              Greg Stein
+              Sander Striker
+
+       NOW, THEREFORE, BE IT FURTHER RESOLVED, that Ken Coar be and
+       hereby is appointed to the office of Vice President, Apache
+       Commons, to serve in accordance with and subject to the
+       direction of the Board of Directors and the Bylaws of the
+       Foundation until death, resignation, retirement, removal or
+       disqualification, or until a successor is appointed; and be it
+       further
+
+       RESOLVED, that the initial Apache Commons PMC be and hereby is
+       tasked with the creation of a set of bylaws intended to
+       encourage open development and increased participation in the
+       Apache Commons Project.
+
+#
+# Local Variables:
+# mode: indented-text
+# tab-width: 4
+# indent-tabs-mode: nil
+# tab-stop-list: (4 6 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80)
+# End:
+#
diff --git a/test-svn-fe.c b/test-svn-fe.c
index 77cf78a..658c2a7 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -4,14 +4,37 @@
 
 #include "git-compat-util.h"
 #include "vcs-svn/svndump.h"
+#include "vcs-svn/svndiff.h"
+#include "vcs-svn/line_buffer.h"
 
 int main(int argc, char *argv[])
 {
-	if (argc != 2)
-		usage("test-svn-fe <file>");
-	svndump_init(argv[1]);
-	svndump_read(NULL);
-	svndump_deinit();
-	svndump_reset();
-	return 0;
+	static const char test_svnfe_usage[] =
+		"test-svn-fe (<dumpfile> | [-d] <preimage> <delta> <len>)";
+	if (argc < 2)
+		usage(test_svnfe_usage);
+	if (argc == 2) {
+		svndump_init(argv[1]);
+		svndump_read(NULL);
+		svndump_deinit();
+		svndump_reset();
+		return 0;
+	}
+	if (argc == 5 && !strcmp(argv[1], "-d")) {
+		struct line_buffer preimage = LINE_BUFFER_INIT;
+		struct line_buffer delta = LINE_BUFFER_INIT;
+		buffer_init(&preimage, argv[2]);
+		buffer_init(&delta, argv[3]);
+		if (svndiff0_apply(&delta, (off_t) strtoull(argv[4], NULL, 0),
+				   &preimage, stdout))
+			return 1;
+		if (buffer_deinit(&preimage))
+			die_errno("cannot close preimage");
+		if (buffer_deinit(&delta))
+			die_errno("cannot close delta");
+		buffer_reset(&preimage);
+		buffer_reset(&delta);
+		return 0;
+	}
+	usage(test_svnfe_usage);
 }
diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index df0b1a2..1668bf7 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -4,6 +4,7 @@
  */
 
 #include "git-compat-util.h"
+#include "sliding_window.h"
 #include "line_buffer.h"
 
 /*
@@ -12,15 +13,53 @@
  * See http://svn.apache.org/repos/asf/subversion/trunk/notes/svndiff.
  *
  * svndiff0 ::= 'SVN\0' window window*;
+ * window ::= int int int int int instructions inline_data;
+ * instructions ::= instruction*;
+ * instruction ::= view_selector int int
+ *   | copyfrom_data int
+ *   | packed_view_selector int
+ *   | packed_copyfrom_data
+ *   ;
+ * view_selector ::= copyfrom_source
+ *   | copyfrom_target
+ *   ;
+ * copyfrom_source ::= # binary 00 000000;
+ * copyfrom_target ::= # binary 01 000000;
+ * copyfrom_data ::= # binary 10 000000;
+ * packed_view_selector ::= # view_selector OR-ed with 6 bit value;
+ * packed_copyfrom_data ::= # copyfrom_data OR-ed with 6 bit value;
  * int ::= highdigit* lowdigit;
  * highdigit ::= # binary 1000 0000 OR-ed with 7 bit value;
  * lowdigit ::= # 7 bit value;
  */
 
+#define INSN_MASK	0xc0
+#define INSN_COPYFROM_SOURCE	0000
+#define INSN_COPYFROM_TARGET	0x40
+#define INSN_COPYFROM_DATA	0x80
+#define OPERAND_MASK	0x3f
+
 #define VLI_CONTINUE	0x80
 #define VLI_DIGIT_MASK	0x7f
 #define VLI_BITS_PER_DIGIT 7
 
+struct window {
+	struct {
+		struct view *window;
+		size_t declared_len;
+	} in;
+	struct {
+		off_t off;
+		struct strbuf buf;
+		size_t declared_len;
+	} out;
+	struct strbuf instructions;
+	struct {
+		struct strbuf buf;
+		size_t declared_len;
+	} data;
+};
+
 static int read_magic(struct line_buffer *in, off_t *len)
 {
 	static const char magic[] = {'S', 'V', 'N', '\0'};
@@ -75,3 +114,229 @@ static int parse_int(const char **buf, size_t *result, const char *end)
 	return error("Invalid instruction: incomplete integer %"PRIu64,
 		     (uint64_t) rv);
 }
+
+static int read_offset(struct line_buffer *in, off_t *result, off_t *len)
+{
+	uintmax_t val;
+	if (read_int(in, &val, len))
+		return -1;
+	if (val > maximum_signed_value_of_type(off_t))
+		return error("Unrepresentable offset: %"PRIuMAX, val);
+	*result = val;
+	return 0;
+}
+
+static int read_length(struct line_buffer *in, size_t *result, off_t *len)
+{
+	uintmax_t val;
+	if (read_int(in, &val, len))
+		return -1;
+	if (val > SIZE_MAX)
+		return error("Unrepresentable length: %"PRIuMAX, val);
+	*result = val;
+	return 0;
+}
+
+static int read_chunk(struct line_buffer *delta, off_t *delta_len,
+		      struct strbuf *buf, size_t len)
+{
+	int truncated = 0;
+	strbuf_reset(buf);
+	/* Need to truncate? */
+	if (len > maximum_signed_value_of_type(off_t)) {
+		len = (size_t) maximum_signed_value_of_type(off_t);
+		truncated = 1;
+	}
+	if ((off_t) len > *delta_len) {
+		len = *delta_len;
+		truncated = 1;
+	}
+	buffer_read_binary(buf, len, delta);
+	*delta_len -= buf->len;
+	if (buf->len < len)
+		truncated = 1;
+	return truncated;
+}
+
+
+static int write_strbuf(struct strbuf *sb, FILE *out)
+{
+	if (fwrite(sb->buf, 1, sb->len, out) == sb->len)	/* Success. */
+		return 0;
+	return error("Cannot write: %s\n", strerror(errno));
+}
+
+static int copyfrom_source(struct window *ctx, const char **instructions,
+			   size_t nbytes, const char *insns_end)
+{
+	size_t offset;
+	if (parse_int(instructions, &offset, insns_end))
+		return -1;
+	if (unsigned_add_overflows(offset, nbytes) ||
+	    offset + nbytes > ctx->in.declared_len)
+		return error("Invalid delta: copies unallocated source data.");
+	if (offset + nbytes > ctx->in.window->buf.len)	/* Input exhausted. */
+		nbytes = ctx->in.window->buf.len - offset;
+	strbuf_add(&ctx->out.buf, ctx->in.window->buf.buf + offset, nbytes);
+	return 0;
+}
+
+static int copyfrom_target(struct window *ctx, const char **instructions,
+			   size_t nbytes, const char *insns_end)
+{
+	const size_t out_pos = ctx->out.buf.len;
+	size_t offset;
+	if (parse_int(instructions, &offset, insns_end))
+		return -1;
+	if (offset > out_pos)
+		return error("Invalid delta: copies from the future.");
+	if (unsigned_add_overflows(offset, nbytes) ||
+	    offset + nbytes > ctx->out.declared_len)
+		return error("Invalid delta: copies unallocated target data.");
+	while (nbytes) {
+		strbuf_addch(&ctx->out.buf, ctx->out.buf.buf[offset++]);
+		nbytes--;
+	}
+	return 0;
+}
+
+static int copyfrom_data(struct window *ctx, size_t *data_pos, size_t nbytes)
+{
+	const size_t pos = *data_pos;
+	if (unsigned_add_overflows(pos, nbytes) ||
+	    pos + nbytes > ctx->data.declared_len)
+		return error("Invalid delta: copies unallocated inline data.");
+	if (pos + nbytes > ctx->data.buf.len)	/* Data exhausted. */
+		nbytes = ctx->data.buf.len - pos;
+	strbuf_add(&ctx->out.buf, ctx->data.buf.buf + pos, nbytes);
+	*data_pos += nbytes;
+	return 0;
+}
+
+static int parse_first_operand(const char **buf, size_t *out, const char *end)
+{
+	size_t result = (unsigned char) *(*buf)++ & OPERAND_MASK;
+	if (result) {
+		*out = result;
+		return 0;
+	}
+	return parse_int(buf, out, end);
+}
+
+static int step(struct window *ctx, const char **instructions, size_t *data_pos)
+{
+	unsigned char instruction;
+	const char *insns_end = ctx->instructions.buf + ctx->instructions.len;
+	const size_t out_pos = ctx->out.buf.len;
+	size_t nbytes;
+	assert(ctx);
+	assert(instructions && *instructions);
+
+	instruction = (unsigned char) **instructions;
+	if (parse_first_operand(instructions, &nbytes, insns_end))
+		return -1;
+	if (unsigned_add_overflows(out_pos, nbytes) ||
+	    out_pos + nbytes > ctx->out.declared_len)
+		return error("Invalid delta: output overflows buffer.");
+
+	switch (instruction & INSN_MASK) {
+	case INSN_COPYFROM_SOURCE:
+		return copyfrom_source(ctx, instructions, nbytes, insns_end);
+	case INSN_COPYFROM_TARGET:
+		return copyfrom_target(ctx, instructions, nbytes, insns_end);
+	case INSN_COPYFROM_DATA:
+		return copyfrom_data(ctx, data_pos, nbytes);
+	default:
+		return error("Invalid instruction %x",
+			     (unsigned int) instruction);
+	}
+}
+
+static int apply_window_in_core(struct window *ctx)
+{
+	const char *insn = ctx->instructions.buf;
+	size_t data_pos = 0;
+
+	/*
+	 * Advance p while copying data from the source, target,
+	 * and inline data views.
+	 */
+	while (insn && insn != ctx->instructions.buf + ctx->instructions.len)
+		if (step(ctx, &insn, &data_pos))
+			return -1;
+	return 0;
+}
+
+static int apply_one_window(struct line_buffer *delta, off_t *delta_len,
+			    struct view *preimage, off_t preimage_len,
+			    off_t *out_offset, FILE *out)
+{
+	struct window ctx = {
+		{preimage, preimage_len},	/* preimage */
+		{*out_offset, STRBUF_INIT, 0},	/* postimage */
+		STRBUF_INIT,			/* instructions */
+		{STRBUF_INIT, 0}		/* inline data */
+	};
+	size_t instructions_len;
+	int rv = 0;
+	assert(out_offset);
+	assert(delta_len);
+
+	/* "source view" offset and length already handled; */
+	if (read_length(delta, &ctx.out.declared_len, delta_len) ||
+	    read_length(delta, &instructions_len, delta_len) ||
+	    read_length(delta, &ctx.data.declared_len, delta_len))
+		return -1;
+	if (read_chunk(delta, delta_len, &ctx.instructions, instructions_len))
+		warning("Invalid delta: "
+			"incomplete instructions (%"PRIu64"/%"PRIu64")",
+			(uint64_t) ctx.instructions.len,
+			(uint64_t) instructions_len);
+	if (read_chunk(delta, delta_len, &ctx.data.buf, ctx.data.declared_len))
+		; /* inline data is truncated.  okay. */
+	if (buffer_ferror(delta)) {
+		rv = error("Cannot read delta: %s", strerror(errno));
+		goto done;
+	}
+	if (apply_window_in_core(&ctx) || write_strbuf(&ctx.out.buf, out)) {
+		rv = -1;
+		goto done;
+	}
+ done:
+	strbuf_release(&ctx.out.buf);
+	strbuf_release(&ctx.instructions);
+	strbuf_release(&ctx.data.buf);
+	return rv;
+}
+
+int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
+		   struct line_buffer *preimage, FILE *postimage)
+{
+	struct view preimage_view = {preimage, 0, STRBUF_INIT};
+	off_t out_offset = 0;
+	assert(delta && preimage && postimage);
+
+	if (read_magic(delta, &delta_len))
+		goto fail;
+	while (delta_len > 0) {	/* For each window: */
+		off_t pre_off = pre_off;
+		size_t pre_len;
+		if (read_offset(delta, &pre_off, &delta_len) ||
+		    read_length(delta, &pre_len, &delta_len) ||
+		    move_window(&preimage_view, pre_off, pre_len) ||
+		    apply_one_window(delta, &delta_len,
+				     &preimage_view, pre_len,
+				     &out_offset, postimage))
+			goto fail;
+		if (delta_len && buffer_at_eof(delta)) {
+			error("Delta ends early! (%"PRIu64" bytes remaining)",
+			      (uint64_t) delta_len);
+			goto fail;
+		}
+	}
+	strbuf_release(&preimage_view.buf);
+	return 0;
+ fail:
+	strbuf_release(&preimage_view.buf);
+	return -1;
+}
diff --git a/vcs-svn/svndiff.h b/vcs-svn/svndiff.h
new file mode 100644
index 0000000..a986099
--- /dev/null
+++ b/vcs-svn/svndiff.h
@@ -0,0 +1,9 @@
+#ifndef SVNDIFF_H_
+#define SVNDIFF_H_
+
+#include "line_buffer.h"
+
+extern int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
+			  struct line_buffer *preimage, FILE *postimage);
+
+#endif
-- 
1.7.2.3
