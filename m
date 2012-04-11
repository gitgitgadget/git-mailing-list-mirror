From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] remote-helpers: set up a pipe to read fast-import
 response
Date: Wed, 11 Apr 2012 09:32:49 -0500
Message-ID: <20120411143249.GA4140@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Ivankov <divanorama@gmail.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 16:33:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHybl-0004kK-R2
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 16:33:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509Ab2DKOdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 10:33:13 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65104 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760375Ab2DKOdM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 10:33:12 -0400
Received: by iagz16 with SMTP id z16so1345106iag.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=BoizA+wCBzl+5jtZXJRNYWcy7SNeZb60xzYWwXjMwzs=;
        b=dLwluqnE8IJI67zRkt4h0KmRWjHEWNmPRM2WOvRsJM3t8o9H3ToB8Pj22n1BSKxq+e
         bMcy6F15M/cOZU+IBmECjArRgu28zxiz0t3HcYSYaoiB91rzQmMAxO+aOis99NtT36Gx
         Xj/pfP3O3/LiH8J1IPx/J4wf0eqtQC64bomLY1HGa/L0BaUkOiKMwi2CVuJ9+D1O3gmE
         u/K3+9xLpQ7oIBxbV5D2f6oUF4kRhCqcjeLk0RUmy4QEgUFQgm8OxfOd0fZTp49nYzH5
         9wwolaSGYL9vF3ce5sk0A9P56nCNr+05p3qSYTi3mdeSdO8guehFIAejm91PNHSWsoOk
         DJNA==
Received: by 10.50.157.137 with SMTP id wm9mr2313842igb.64.1334154791439;
        Wed, 11 Apr 2012 07:33:11 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id xf6sm8162769igb.13.2012.04.11.07.33.02
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 07:33:02 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195186>

From: Dmitry Ivankov <divanorama@gmail.com>
Date: Tue, 21 Jun 2011 20:52:34 +0600

Remote helpers may want to issue "ls" or "cat-blob" requests to
fast-import.  For example, the svn remote helper from the
svn-dump-fast-import project uses that capability.

The response should be fed back to remote helper; let it go to the
remote helper's standard input (command stream).

After listing the branches to import:

	'import' SP 'refs/heads/foo' LF
	'import' SP 'refs/heads/bar' LF
	'import' SP 'refs/heads/baz' LF
	LF

the transport-helper does not send any commands to the remote helper
until the remote helper sends the "done" command to fast-import, so
this does not result in interleaved output from the transport-helper
and fast-import.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

Something like this patch was sitting in my tree gathering moss but I
quite like it so I thought I should send it out for feedback.

I can't seem to find any copy of this patch in the list archives.
Maybe I received it by private email.  Dmitry, do you remember better?

Can also be found at

  git://repo.or.cz/git/jrn.git topics/di/remote-helper-blob-access

and will be part of the svn-fe-pu branch there in the next push.

It is possible (likely, even) that this doesn't work on Windows since
file descriptors are not inherited by default, but it won't cause harm
until someone tries to use "ls" or "cat-blob" from a remote helper.
If someone wants to write tests for it, that would be very useful.
Otherwise, we can deal with it once the remote helper hits the tree.

Changes since v2:

 - new description
 - documented in remote-helpers manpage
 - don't waste so much space for fastimport->argv.  (I restrained
   myself from using malloc in place of calloc since that change
   probably belongs in a separate patch.)

Thoughts?  Bugs?  Improvements?

Thanks,
Jonathan

 Documentation/git-remote-helpers.txt |    5 ++++-
 transport-helper.c                   |    6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 3a23477c..0cae14c7 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -133,7 +133,10 @@ Supported if the helper has the "push" capability.
 
 'import' <name>::
 	Produces a fast-import stream which imports the current value
-	of the named ref. It may additionally import other refs as
+	of the named ref. Standard input for the helper is connected
+	to the fast-import backend's cat-blob stream so the helper
+	can read responses from "ls" and "cat-blob" requests.
+	The helper may additionally import other refs as
 	needed to construct the history efficiently. The script writes
 	to a helper-specific private namespace. The value of the named
 	ref should be written to a location in this namespace derived
diff --git a/transport-helper.c b/transport-helper.c
index acfc88e3..4c547b9a 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -349,12 +349,16 @@ static int fetch_with_fetch(struct transport *transport,
 
 static int get_importer(struct transport *transport, struct child_process *fastimport)
 {
+	char buf[32];
+	struct helper_data *data = transport->data;
 	struct child_process *helper = get_helper(transport);
 	memset(fastimport, 0, sizeof(*fastimport));
 	fastimport->in = helper->out;
-	fastimport->argv = xcalloc(5, sizeof(*fastimport->argv));
+	fastimport->argv = xcalloc(4, sizeof(*fastimport->argv));
 	fastimport->argv[0] = "fast-import";
 	fastimport->argv[1] = "--quiet";
+	snprintf(buf, 32, "--cat-blob-fd=%d", data->helper->in);
+	fastimport->argv[2] = buf;
 
 	fastimport->git_cmd = 1;
 	return start_command(fastimport);
-- 
1.7.10
