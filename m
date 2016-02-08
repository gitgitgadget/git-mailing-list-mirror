From: Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>
Subject: [PATCH 2/2] git-svn: apply "svn.pathnameencoding" before URL encoding
Date: Tue, 9 Feb 2016 00:21:02 +0900
Message-ID: <56B8B25E.9000001@f2.dion.ne.jp>
References: <56B8B1EA.5020901@f2.dion.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: normalperson@yhbt.net, alex.crezoff@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 08 16:29:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSnku-0006Ge-5d
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 16:29:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754782AbcBHP32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 10:29:28 -0500
Received: from mail-ae1-f4.auone-net.jp ([106.187.231.4]:47504 "EHLO
	dmta01.auone-net.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754562AbcBHP3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 10:29:25 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Feb 2016 10:29:24 EST
Received: from amlmta402.auone-net.jp (amlmta402-MM [10.188.23.193])
	by dmta01.auone-net.jp (au one net mail) with ESMTP id C8C98560035
	for <git@vger.kernel.org>; Tue,  9 Feb 2016 00:24:21 +0900 (JST)
Received: from [0.0.0.0] ([77.247.181.163])
	by amlmta402.auone-net.jp id 56b8b3220009cdf80000213700004be83800014889f8;
	Tue, 09 Feb 2016 00:24:18 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <56B8B1EA.5020901@f2.dion.ne.jp>
X-MXM-DELIVERY-TYPE: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285777>

The conversion from "svn.pathnameencoding" to UTF-8 should be applied
first, and then URL encoding should be applied on the resulting UTF-8
path. The reversed order of these transforms (used before this fix)
makes non-UTF-8 URL which causes error from Subversion such as
"Filesystem has no item: '...' path not found" when sending a rename (or
a copy) from non-ASCII path.

Signed-off-by: Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>
---
 perl/Git/SVN/Editor.pm | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/perl/Git/SVN/Editor.pm b/perl/Git/SVN/Editor.pm
index d9d9bdf..4c4199a 100644
--- a/perl/Git/SVN/Editor.pm
+++ b/perl/Git/SVN/Editor.pm
@@ -144,11 +144,12 @@ sub repo_path {
 
 sub url_path {
 	my ($self, $path) = @_;
+	$path = $self->repo_path($path);
 	if ($self->{url} =~ m#^https?://#) {
 		# characters are taken from subversion/libsvn_subr/path.c
 		$path =~ s#([^~a-zA-Z0-9_./!$&'()*+,-])#sprintf("%%%02X",ord($1))#eg;
 	}
-	$self->{url} . '/' . $self->repo_path($path);
+	$self->{url} . '/' . $path;
 }
 
 sub rmdirs {
-- 
2.7.0
