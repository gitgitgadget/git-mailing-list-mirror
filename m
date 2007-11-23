From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Add config_int() method to the Git perl module
Date: Fri, 23 Nov 2007 19:04:52 +0100
Message-ID: <200711231904.53551.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 19:06:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ivcu0-000681-93
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 19:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbXKWSE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 13:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753421AbXKWSE7
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 13:04:59 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:49873 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332AbXKWSE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 13:04:58 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2849124nfb
        for <git@vger.kernel.org>; Fri, 23 Nov 2007 10:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=+MArRsjLbW2r7d7FeItS4aoifYs483w+DCNxw8fiuQE=;
        b=YLpj8eBrs/pKOkX0siBVulvA939RvGNYTN0sr3y5YVLafYME6l2TKOygO2XjczX2pF1ApVdtKSue1wJW8nqQ7IXWFBFyQj93Cm5+RwSNWf+HTxbwEQEefTERtrSUcn/MWmLlk2A8rmVy4ZAiyBEQ6z9B5SHimOPUOPFwqnlRFjg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GxiFyRet5NeIMWYtiAcBq3U1R5bYEyciT40Sz/so4abMin/7jGzXbwTr2JjFYIyoViZ2fLy5NRlUm8XD/46B5AbBGpQeFIjPbRTAeK2zP88PDufW4L/IMTf5QB/vfVjXOQblc41iZxjmCf52DgDmzbURvj0FVvQBTmAGCY85IQA=
Received: by 10.86.4.2 with SMTP id 2mr9743939fgd.1195841096903;
        Fri, 23 Nov 2007 10:04:56 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.249.172])
        by mx.google.com with ESMTPS id d6sm2860357fga.2007.11.23.10.04.54
        (version=SSLv3 cipher=OTHER);
        Fri, 23 Nov 2007 10:04:55 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65907>

Integer variables can have optional 'k', 'm' or 'g' suffix.
config_int() method will return simple decimal number, taking
care of those suffixes.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
For completness (I don't think anything in Perl uses / tries to use
integer configuration variables).

(Commit message could be better. Hmmm...)

 perl/Git.pm |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index dca92c8..7468460 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -549,6 +549,37 @@ sub config_bool {
 	};
 }
 
+=item config_int ( VARIABLE )
+
+Retrieve the integer configuration C<VARIABLE>. The return value
+is simple decimal number.  An optional value suffix of 'k', 'm',
+or 'g' in the config file will cause the value to be multiplied
+by 1024, 1048576 (1024^2), or 1073741824 (1024^3) prior to output.
+It would return C<undef> if configuration variable is not defined,
+
+Must be called on a repository instance.
+
+This currently wraps command('config') so it is not so fast.
+
+=cut
+
+sub config_int {
+	my ($self, $var) = @_;
+	$self->repo_path()
+		or throw Error::Simple("not a repository");
+
+	try {
+		return $self->command_oneline('config', '--int', '--get', $var);
+	} catch Git::Error::Command with {
+		my $E = shift;
+		if ($E->value() == 1) {
+			# Key not found.
+			return undef;
+		} else {
+			throw $E;
+		}
+	};
+}
 
 =item ident ( TYPE | IDENTSTR )
 
-- 
1.5.3.5
