From: "Jerry Seutter" <jseutter@gmail.com>
Subject: [PATCH] "git svn clone" fails when tags have illegal url characters in them.
Date: Fri, 12 Dec 2008 15:46:38 -0700
Message-ID: <2c8d48d70812121446m7539a054p86588488d77302f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 12 23:47:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBGnd-0001Ks-6N
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 23:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753617AbYLLWqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 17:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753725AbYLLWqj
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 17:46:39 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:37423 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753572AbYLLWqi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 17:46:38 -0500
Received: by wa-out-1112.google.com with SMTP id v27so798721wah.21
        for <git@vger.kernel.org>; Fri, 12 Dec 2008 14:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=pDOZWRg9J9gqkWTBt5TOrXLREmD2+2lmL66pxUniFyk=;
        b=P3gXcSKhJQJEi+3VHuuHG6ng7LPIV/jM8FonyKu7jwhB47TDhDOGVz2E/K5Y6m+vKN
         wkGbRZY8fsiK4GPDK3G4OBcdKOYibyd6lxkCD51BhZmszNBKvc2vt0Zn5zndRigk82eG
         b/qz3OAJqRP2IdWVFJi0tXdPriCmT1eN6v4t0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=ud9hUx4ZyFQu6X7fFbSV7FKrdZUK/7KG0onH8OPloNGVgI8XyZFEwl6Ga3xK7gnMrI
         9rPeJG/h0vcck7NjrrfV86Bbu0wL0koNSlk73vQhiSc6EG/B6sNyckDC1UI9DexDnskk
         agVIQBHOsiCK/kMXik2TK/OM9uw1DvRjq7ylA=
Received: by 10.114.194.1 with SMTP id r1mr3071422waf.149.1229121998057;
        Fri, 12 Dec 2008 14:46:38 -0800 (PST)
Received: by 10.115.47.10 with HTTP; Fri, 12 Dec 2008 14:46:38 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102963>

Found a repository with a tag that had a hash (#) mark in the tag name.
The svn repository was available via WebDAV. "git svn clone <url>" would
generate an invalid url when trying to fetch the tag, causing a server
400 result on the other end of the connection.

The fix is to escape the url correctly.  This is a quick and dirty
hack that copies two functions from earlier in the file - only the last
line modified in the commit is important.

Signed-off-by: Jerry Seutter <jseutter@gmail.com>
---
 git-svn.perl |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 2c206e9..6b9e010 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2213,9 +2213,28 @@ sub metadata_url {
 	   (length $self->{path} ? '/' . $self->{path} : '');
 }

+sub junk_escape_uri_only {
+	my ($uri) = @_;
+	my @tmp;
+	foreach (split m{/}, $uri) {
+		s/([^~\w.%+-]|%(?![a-fA-F0-9]{2}))/sprintf("%%%02X",ord($1))/eg;
+		push @tmp, $_;
+	}
+	join('/', @tmp);
+}
+
+sub junk_escape_url {
+	my ($url) = @_;
+	if ($url =~ m#^([^:]+)://([^/]*)(.*)$#) {
+		my ($scheme, $domain, $uri) = ($1, $2, junk_escape_uri_only($3));
+		$url = "$scheme://$domain$uri";
+	}
+	$url;
+}
+
 sub full_url {
 	my ($self) = @_;
-	$self->{url} . (length $self->{path} ? '/' . $self->{path} : '');
+	junk_escape_url($self->{url} . (length $self->{path} ? '/' .
$self->{path} : ''));
 }


-- 
1.6.1.rc2.20.gde0d.dirty
