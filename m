From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv7 07/11] gitweb: remotes view for a single remote
Date: Thu, 11 Nov 2010 13:26:14 +0100
Message-ID: <1289478378-15604-8-git-send-email-giuseppe.bilotta@gmail.com>
References: <1289478378-15604-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 11 13:27:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGWF6-0000Sd-WB
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 13:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756511Ab0KKM0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 07:26:48 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43993 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756482Ab0KKM0r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 07:26:47 -0500
Received: by mail-wy0-f174.google.com with SMTP id 28so630026wyb.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 04:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=YkJWXY214TAZZGgFmD6iAoOZ3b+Zcgc1Edbj9qdi/M8=;
        b=OFl+uAZC6GQizQW33ZcqdA4naluMXpakW1I2SWKl2YfQBPoux3mIf+brM/9VWT+RmB
         ReRWtDz2VlHVr8h0Pp0mU8M3kxI2YBrauKyVIvUghasuXd8lyz2M2KkYApRIDHFyQWSj
         zix6yehgtYAchycwBOo/ru1zpuhXFsWQk+Wrs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cCANe9rq3SQDEjTp81iLxPj4PhAws8IyqSJV11gfAp9sz6CnjrJ1wnqvJLJAv+Z1Bq
         pbLvBDiuJqyfdH1p0mLRoWCihrgUfHCtYKkJGo4RvNBz5bkQoQ23kRwvoQrYlStQQ5j0
         rEK2kg8hH70SS1Yg8DICtXGWVFvzx4vnm61bs=
Received: by 10.227.132.143 with SMTP id b15mr767962wbt.36.1289478406302;
        Thu, 11 Nov 2010 04:26:46 -0800 (PST)
Received: from localhost ([151.60.176.40])
        by mx.google.com with ESMTPS id x65sm1243647weq.1.2010.11.11.04.26.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 04:26:45 -0800 (PST)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1289478378-15604-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161239>

When 'remotes' view is passed the 'hash' parameter, interpret it as the
name of a remote and limit the view the the heads of that remote.

In single-remote view we let the user switch easily to the default
remotes view by specifying an -action_extra for the page header and by
enabling the 'remotes' link in the reference navigation submenu.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   30 ++++++++++++++++++++++++++----
 1 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c3b8966..bf38757 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5558,14 +5558,36 @@ sub git_remotes {
 		or die_error(403, "Remote heads view is disabled");
 
 	my $head = git_get_head_hash($project);
-	git_header_html();
-	git_print_page_nav('','', $head,undef,$head,format_ref_views('remotes'));
-	git_print_header_div('summary', $project);
+	my $remote = $input_params{'hash'};
+
+	my @remotelist;
+
+	if (defined $remote) {
+		# only display the heads in a given remote, stripping the
+		# remote name which is already visible elsewhere
+		@remotelist = map {
+			my $ref = $_ ;
+			$ref->{'name'} =~ s!^$remote/!!;
+			$ref
+		} git_get_heads_list(undef, "remotes/$remote");
+	} else {
+		@remotelist = git_get_heads_list(undef, 'remotes');
+	}
+
+	git_header_html(undef, undef, -action_extra => $remote);
+	git_print_page_nav('', '',  $head, undef, $head,
+		format_ref_views($remote ? '' : 'remotes'));
+
+	if (defined $remote) {
+		git_print_header_div('remotes', "$remote remote for $project");
+	} else {
+		git_print_header_div('summary', "$project remotes");
+	}
 
-	my @remotelist = git_get_heads_list(undef, 'remotes');
 	if (@remotelist) {
 		git_heads_body(\@remotelist, $head);
 	}
+
 	git_footer_html();
 }
 
-- 
1.7.3.68.g6ec8
