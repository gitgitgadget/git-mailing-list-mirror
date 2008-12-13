From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH] guilt: add option guilt.diffstat
Date: Sat, 13 Dec 2008 21:17:00 +0800
Message-ID: <20081213131700.GA8649@localhost>
References: <20081213021422.GA28249@localhost> <20081213044357.GD15407@josefsipek.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"Boyd Stephen Smith Jr." <bss03@volumehost.net>
To: Josef Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Sat Dec 13 14:18:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBUO7-00055A-2v
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 14:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436AbYLMNRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 08:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755216AbYLMNRN
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 08:17:13 -0500
Received: from mga03.intel.com ([143.182.124.21]:29901 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755224AbYLMNRM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 08:17:12 -0500
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 13 Dec 2008 05:17:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.36,216,1228118400"; 
   d="scan'208";a="89828201"
Received: from unknown (HELO localhost) ([10.254.154.84])
  by azsmga001.ch.intel.com with ESMTP; 13 Dec 2008 05:17:06 -0800
Received: from wfg by localhost with local (Exim 4.69)
	(envelope-from <fengguang.wu@intel.com>)
	id 1LBUMe-0003e4-Ib; Sat, 13 Dec 2008 21:17:00 +0800
Content-Disposition: inline
In-Reply-To: <20081213044357.GD15407@josefsipek.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102997>

Hi Jeff,

On Sat, Dec 13, 2008 at 06:43:57AM +0200, Josef Jeff Sipek wrote:
> On Sat, Dec 13, 2008 at 10:14:22AM +0800, Wu Fengguang wrote:
> > Introduce option guilt.diffstat so that we don't have to type
> > "guilt refresh --diffstat" in its full form every time.
> 
> Good idea.

Thanks.

> Could you throw a quick note into the manpages?

Sure. Here is the updated patch.  This time I used "git-config --bool"
to ensure diffstat will be either "true" or "false":

        The type specifier can be either --int or --bool, which will
        make git-config ensure that the variable(s) are of the given
        type and convert the value to the canonical form (simple
        decimal number for int, a "true" or "false" string for bool).
        If no type specifier is passed, no checks or transformations
        are performed on the value.

Thanks,
Fengguang
---
guilt: add option guilt.diffstat

Introduce option guilt.diffstat so that we don't have to type
"guilt refresh --diffstat" in its full form every time.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
diff --git a/Documentation/guilt-refresh.txt b/Documentation/guilt-refresh.txt
index 9a0b4e8..7757bdc 100644
--- a/Documentation/guilt-refresh.txt
+++ b/Documentation/guilt-refresh.txt
@@ -20,8 +20,14 @@ OPTIONS
 	format (e.g., rename and copy detection).
 
 --diffstat::
-	Include a diffstat output in the patch file. Useful for cases where
-	patches will be submitted with other tools.
+Include a diffstat output in the patch file. Useful for cases where
+patches will be submitted with other tools.
++
+If the command line option is omitted, the corresponding git-config
+option "guilt.diffstat" will be queried. So this would enable diffstat
+output by default:
+
+	git config --global guilt.diffstat true
 
 Author
 ------
diff --git a/guilt b/guilt
index fabee17..12361da 100755
--- a/guilt
+++ b/guilt
@@ -544,7 +544,7 @@ __refresh_patch()
 
 		[ ! -z "$4" ] && diffopts="-C -M --find-copies-harder"
 		
-		if [ ! -z "$5" ]; then
+		if [ -n "$5" -o $diffstat = "true" ]; then
 			(
 				echo "---"
 				git diff --stat $diffopts "$2"
@@ -633,6 +633,9 @@ guilt_push_diff_context=1
 # default autotag value
 AUTOTAG_DEFAULT=1
 
+# default diffstat value: true or false
+DIFFSTAT_DEFAULT="false"
+
 #
 # Parse any part of .git/config that belongs to us
 #
@@ -641,6 +644,10 @@ AUTOTAG_DEFAULT=1
 autotag=`git config guilt.autotag`
 [ -z "$autotag" ] && autotag=$AUTOTAG_DEFAULT
 
+# generate diffstat?
+diffstat=`git config --bool guilt.diffstat`
+[ -z "$diffstat" ] && diffstat=$DIFFSTAT_DEFAULT
+
 #
 # The following gets run every time this file is source'd
 #
