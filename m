From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-whatchanged -p anomoly?
Date: Thu, 18 Aug 2005 15:13:39 -0700
Message-ID: <7vacjehp0s.fsf@assigned-by-dhcp.cox.net>
References: <200508182049.j7IKn7TA010456@agluck-lia64.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 00:15:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5se0-0007A7-Jn
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 00:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbVHRWNq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 18:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVHRWNp
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 18:13:45 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:37831 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932493AbVHRWNp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 18:13:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050818221341.RUGD7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 18 Aug 2005 18:13:41 -0400
To: "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <200508182049.j7IKn7TA010456@agluck-lia64.sc.intel.com> (Tony
	Luck's message of "Thu, 18 Aug 2005 13:49:07 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

"Luck, Tony" <tony.luck@intel.com> writes:

>  $ git-whatchanged -p test ^linus | diffstat -p1
>  $ git-diff-tree -p linus test | diffstat -p1

git-whatchanged internally uses git-rev-list which skips merge
commits.  You need '-m' to cause it not to.

    $ git-whatchanged -m -p linus..test | diffstat -p1

would still not _match_ "git-diff-tree -p linus test | diffstat
-p1" output because conflict-resolving merges inevitably causes
the same file to be touched twice (hence diffstat shows patches
for the same fime twice, adding up the count of the changes), so
in practice, my "use -m if you want to see merges" advice would
not be much useful if you want to _count_ lines using diffstat.

For example, one of the files you had trouble with are touched
by the following commits; only the last one is a non-merge and
that is what you get when you do not give -m to whatchanged:

$ git-whatchanged -m --pretty=oneline test ^linus \
	-p Documentation/acpi-hotkey.txt

diff-tree 75304b938dcc2cb89c2bb1174a92ffc76520a899 (from 470ceb05d9a2b4d61c19fac615a79e56e8401565)
Pull ngam-maule-steiner into test branch
diff --git a/Documentation/acpi-hotkey.txt b/Documentation/acpi-hotkey.txt
--- a/Documentation/acpi-hotkey.txt
+++ b/Documentation/acpi-hotkey.txt
@@ -33,3 +33,6 @@ The result of the execution of this aml
 attached to /proc/acpi/hotkey/poll_method, which is dnyamically
 created.  Please use command "cat /proc/acpi/hotkey/polling_method"
 to retrieve it.
+
+Note: Use cmdline "acpi_generic_hotkey" to over-ride
+loading any platform specific drivers.

diff-tree 2dbff4d454d3ee733f120ad531560a734a6e39d6 (from 715caa83e762c86241ae4450693bb969d03027c4)
Auto-update from upstream
diff --git a/Documentation/acpi-hotkey.txt b/Documentation/acpi-hotkey.txt
--- a/Documentation/acpi-hotkey.txt
+++ b/Documentation/acpi-hotkey.txt
@@ -33,3 +33,6 @@ The result of the execution of this aml
 attached to /proc/acpi/hotkey/poll_method, which is dnyamically
 created.  Please use command "cat /proc/acpi/hotkey/polling_method"
 to retrieve it.
+
+Note: Use cmdline "acpi_generic_hotkey" to over-ride
+loading any platform specific drivers.

diff-tree f812175c8007fdb614833830ca107062df2845dd (from c1ffb910f7a4e1e79d462bb359067d97ad1a8a25)
Pull prarit-bus-sysdata into test branch
diff --git a/Documentation/acpi-hotkey.txt b/Documentation/acpi-hotkey.txt
--- a/Documentation/acpi-hotkey.txt
+++ b/Documentation/acpi-hotkey.txt
@@ -33,6 +33,3 @@ The result of the execution of this aml
 attached to /proc/acpi/hotkey/poll_method, which is dnyamically
 created.  Please use command "cat /proc/acpi/hotkey/polling_method"
 to retrieve it.
-
-Note: Use cmdline "acpi_generic_hotkey" to over-ride
-loading any platform specific drivers.

diff-tree b63d6e09b432e6873d072a767c87218f8e73e66c (from 12aaa0855b39b5464db953fedf399fa91ee365ed)
[IA64, X86_64] fix swiotlb sizing
diff --git a/Documentation/acpi-hotkey.txt b/Documentation/acpi-hotkey.txt
--- a/Documentation/acpi-hotkey.txt
+++ b/Documentation/acpi-hotkey.txt
@@ -33,6 +33,3 @@ The result of the execution of this aml
 attached to /proc/acpi/hotkey/poll_method, which is dnyamically
 created.  Please use command "cat /proc/acpi/hotkey/polling_method"
 to retrieve it.
-
-Note: Use cmdline "acpi_generic_hotkey" to over-ride
-loading any platform specific drivers.
