From: Kyle McKay <mackyle@gmail.com>
Subject: [PATCH 1/2] Git.pm: add new temp_is_locked function
Date: Fri, 5 Jul 2013 20:42:03 -0700
Message-ID: <D34E9C76-89B8-44E6-B364-C71B2FC2AC52@gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: David Rothenberger <daveroth@acm.org>, Petr Baudis <pasky@ucw.cz>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Shahaf <danielsh@apache.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 06 05:42:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvJO6-0004NE-43
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jul 2013 05:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701Ab3GFDmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 23:42:08 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:58310 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660Ab3GFDmF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 23:42:05 -0400
Received: by mail-oa0-f43.google.com with SMTP id i7so4273955oag.30
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 20:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:from:to:content-type:content-transfer-encoding:subject
         :mime-version:date:cc:x-mailer;
        bh=difTwIHUnOYtWLb8E+UqJWIucFJHDBeGuBfT3AL0IGE=;
        b=cy4G3FWK/skd9FwgHcZRqle3q+GcxeyG1F49t8uUvAEDuqkKePcP6vd1igvOwy8IFg
         vemTIMriHWEKKdUYEvDVlUxMtx5dOffnKBMnKQVAPmIjgPs5nspFjtzDSEMungSSpfKU
         AZL2v1qeJ8YcjIWSaEI8G0lwzAVtrVKPIpAu+5sThtXVjZetfTQpiTMdF+RVQQltA0nj
         lzWoy2SGpOd6dbBxPu5ObkcukF0dSLPNFEzmOJy1a6LqYXF/d+a6mxYVchLm8Z7mP68k
         wm3qbzObCC3LdYJDstf9pZ/PryH1fa665jl6W3+4AWygKeoVP4cS0NpmXeS/DbVNH/jD
         QTXw==
X-Received: by 10.182.158.36 with SMTP id wr4mr13815897obb.60.1373082125084;
        Fri, 05 Jul 2013 20:42:05 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id q4sm20111033obl.1.2013.07.05.20.42.03
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jul 2013 20:42:04 -0700 (PDT)
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229692>

The temp_is_locked function can be used to determine whether
or not a given name previously passed to temp_acquire is
currently locked.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
perl/Git.pm | 17 ++++++++++++++++-
1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 7a252ef..5416b5a 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -61,7 +61,7 @@ require Exporter;
                 remote_refs prompt
                 get_tz_offset
                 credential credential_read credential_write
-                temp_acquire temp_release temp_reset temp_path);
+                temp_acquire temp_is_locked temp_release temp_reset  
temp_path);


=head1 DESCRIPTION
@@ -1206,6 +1206,21 @@ sub temp_acquire {
	$temp_fd;
}

+=item temp_is_locked ( NAME )
+
+Returns true if the file mapped to C<NAME> is currently locked.
+
+If true is returned, an attempt to C<temp_acquire()> the same C<NAME>  
will
+throw an error.
+
+=cut
+
+sub temp_is_locked {
+	my ($self, $name) = _maybe_self(@_);
+	my $temp_fd = \$TEMP_FILEMAP{$name};
+	defined $$temp_fd && $$temp_fd->opened && $TEMP_FILES{$$temp_fd} 
{locked};
+}
+
=item temp_release ( NAME )

=item temp_release ( FILEHANDLE )
-- 
1.8.3
