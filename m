From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] git-gui: recognize submodule diff when replaced by file
Date: Sat, 9 Jun 2012 15:47:29 +0200
Message-ID: <20120609134729.GA16268@book.hvoigt.net>
References: <CAOkDyE9q1n=oLoEXXxurDjNM0B2+cZ9eoeGE57F9hEQUjK0hZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>,
	Pat Thoyts <patthoyts@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Jun 09 15:51:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdM4d-0004rZ-VG
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jun 2012 15:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753235Ab2FINu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jun 2012 09:50:59 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.43]:59760 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806Ab2FINu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2012 09:50:58 -0400
Received: from [77.20.33.80] (helo=localhost)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1SdM0o-0006eI-IA; Sat, 09 Jun 2012 15:47:30 +0200
Content-Disposition: inline
In-Reply-To: <CAOkDyE9q1n=oLoEXXxurDjNM0B2+cZ9eoeGE57F9hEQUjK0hZg@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199549>

When coloring the diff in submodule mode we previously just looked
for the submodule change markers and not normal diff markers. Since
a submodule can be replaced by a file and vice versa lets also support
hunk, + and - lines.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
Hi,

On Fri, Jun 01, 2012 at 11:31:26AM +0100, Adam Spiers wrote:
> At this point, git citool outputs:
> 
>     error: Unhandled submodule diff marker: {@@ }
>     error: Unhandled submodule diff marker: {+on}

This fixes that error message (and is hopefully doing the right thing).

There will be another patch fixing the error popup.

Cheers Heiko

 git-gui/lib/diff.tcl | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index ec44055..a3c997b 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -467,8 +467,16 @@ proc read_diff {fd conflict_size cont_info} {
 				{  >} {set tags d_+}
 				{  W} {set tags {}}
 				default {
-					puts "error: Unhandled submodule diff marker: {$op}"
-					set tags {}
+					set op [string index $line 0]
+					switch -- $op {
+						{-} {set tags d_-}
+						{+} {set tags d_+}
+						{@} {set tags d_@}
+						default {
+							puts "error: Unhandled submodule diff marker: {$op}"
+							set tags {}
+						}
+					}
 				}
 				}
 			}
-- 
1.7.10.2.522.g93b45fe
