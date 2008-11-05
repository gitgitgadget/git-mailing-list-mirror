From: "Sam Liddicott" <sam@liddicott.com>
Subject: let git-diff allow patch to delete empty files?
Date: Wed, 05 Nov 2008 12:22:06 -0000
Organization: Liddicott.com
Message-ID: <49118FEE.30408@liddicott.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 05 13:24:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxhR0-0008Kh-Qi
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 13:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754090AbYKEMXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 07:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753937AbYKEMXL
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 07:23:11 -0500
Received: from timbuctoo.liddicott.com ([206.123.89.57]:53185 "EHLO
	timbuctoo.liddicott.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194AbYKEMXK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 07:23:10 -0500
Received: from [192.168.0.180] (82.153.158.114 [82.153.158.114])
	by timbuctoo.liddicott.com; Wed, 05 Nov 2008 12:22:07 -0000
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100155>

In some cases "patch" cannot apply diff's generated using git-diff, I've
had a "git diff" output look like this when an empty file was removed as
the only change:

diff --git a/source3/include/dcerpc.h b/source3/include/dcerpc.h
deleted file mode 100644
index e69de29..0000000

which patch rejected, saying:
patch: **** Only garbage was found in the patch input.

There is a ghastly diff notation recognized by patch, using the magic
date 1970-01-01 01:00:00.000000000 to signify deletion which git-diff
properly uses for non-empty files.

Empty files are a different matter because there is no unified diff that
can represent deletion of an empty file because patch doesn't like
unified diff's with no context.

However this equivalent pair works by making the file non-empty and then
deleting it.

diff -Nru 1/here 2/here
--- 1/here    2008-11-05 09:43:55.000000000 +0000
+++ 2/here    2008-11-05 09:43:58.000000000 +0000
@@ -0,0 +1 @@
+
diff -Nru 1/here 2/here
--- 1/here    2008-11-05 09:37:23.000000000 +0000
+++ 2/here    1970-01-01 01:00:00.000000000 +0100
@@ -1 +0,0 @@
-


In considering this filthy hack we should recognize that currently :

* patch will choke on certain "git diff" output. If patch's exit code is
checked as part of a loop of patches, then the patch procedure will
fail. This happened to me
* if delete-empty-file is one action in a larger patch file it will do
nothing - which can be worse if the "existence" of a file affects the
build system.

This filthy hack fixes both problems.

Sam
