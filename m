From: Andrew Keller <andrew@kellerfarm.com>
Subject: [PATCH] gitweb: Avoid overflowing page body frame with large images
Date: Thu, 6 Feb 2014 22:31:20 -0500
Message-ID: <2452A253-A926-4A40-9F08-6E28EFF229F3@kellerfarm.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Tony Finch <dot@dotat.at>,
	Krzesimir Nowak <krzesimir@endocode.com>,
	=?iso-8859-1?Q?J=FCrgen_Kreileder?= <jk@blackdown.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 07 04:31:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBcAF-000424-Sv
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 04:31:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbaBGDbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 22:31:24 -0500
Received: from atl4mhob12.myregisteredsite.com ([209.17.115.50]:60367 "EHLO
	atl4mhob12.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750774AbaBGDbX convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 6 Feb 2014 22:31:23 -0500
Received: from mailpod.hostingplatform.com ([10.30.71.209])
	by atl4mhob12.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s173VLGr017178
	for <git@vger.kernel.org>; Thu, 6 Feb 2014 22:31:21 -0500
Received: (qmail 3115 invoked by uid 0); 7 Feb 2014 03:31:21 -0000
X-TCPREMOTEIP: 23.28.12.255
X-Authenticated-UID: andrew@kellerfarm.com
Received: from unknown (HELO ?192.168.0.103?) (andrew@kellerfarm.com@23.28.12.255)
  by 0 with ESMTPA; 7 Feb 2014 03:31:21 -0000
X-Mailer: Apple Mail (2.1085)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241760>

When displaying a blob in gitweb, if it's an image, specify constraints for
maximum display width and height to prevent the image from overflowing the
frame of the enclosing page_body div.

This change assumes that it is more desirable to see the whole image without
scrolling (new behavior) than it is to see every pixel without zooming
(previous behavior).

Signed-off-by: Andrew B Keller <andrew@kellerfarm.com>
---

I recently used Git to archive a set of scanned photos, and I used gitweb to provide access to them.  Overall, everything worked well, but I found it undesirable that I had to zoom out in my browser on every photo to see the whole photo.  In the spirit of making the default behavior the most likely correct behavior, this patch seems to be a good idea.

However, I'm not an expert on the use cases of gitweb.  In order for the maximum size constraints to take effect, the image would have to be at least the size of the web browser window (minus a handful of pixels), so the affected images are usually going to be pretty big.  Are there any common use cases for displaying a large image without scaling (and hence, with scrolling)?

Thanks,
Andrew


 gitweb/gitweb.perl       |    2 +-
 gitweb/static/gitweb.css |    5 +++++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3bc0f0b..2c6a77f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -7094,7 +7094,7 @@ sub git_blob {
 	git_print_page_path($file_name, "blob", $hash_base);
 	print "<div class=\"page_body\">\n";
 	if ($mimetype =~ m!^image/!) {
-		print qq!<img type="!.esc_attr($mimetype).qq!"!;
+		print qq!<img class="image_blob" type="!.esc_attr($mimetype).qq!"!;
 		if ($file_name) {
 			print qq! alt="!.esc_attr($file_name).qq!" title="!.esc_attr($file_name).qq!"!;
 		}
diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index 3b4d833..cd57c2f 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -32,6 +32,11 @@ img.avatar {
 	vertical-align: middle;
 }
 
+img.image_blob {
+	max-height: 100%;
+	max-width: 100%;
+}
+
 a.list img.avatar {
 	border-style: none;
 }
-- 
1.7.7.1
