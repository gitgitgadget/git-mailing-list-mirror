From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/2] gitweb: esc_html (short) error message in die_error
Date: Sun, 07 Feb 2010 21:51:18 +0100
Message-ID: <20100207204803.11146.57731.stgit@localhost.localdomain>
References: <20100207204539.11146.36972.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 07 21:51:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeE6h-00038D-1W
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 21:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413Ab0BGUvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 15:51:46 -0500
Received: from mail-fx0-f211.google.com ([209.85.220.211]:59453 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568Ab0BGUvp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 15:51:45 -0500
Received: by fxm3 with SMTP id 3so6726723fxm.39
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 12:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=CsKc4awZxNh5RUn3Kxdvj9r/FlcIi4OTFjFVzgh8Jyw=;
        b=I56Xz8blR7l3h6BIKxHjYLXYEzd2fB2mziRDc3hZpme+8lvMqpRuEDa0CHO+QEztkC
         Ld9xj0AaShKOt70qmZqWsPXNwfegVoDaUYU/ApHTJA4kFfL9aPV1wAHWhweG9YwX9t9x
         c67JGgbfR6E2L78JLToMMhnyfCSsnCWt4YG6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=v1ZXSb2oChzU8a5klX0mHXauCNINyCrMKW3mlHzTKPK6cNTMwMsFHU3es2ZaHV0V+O
         8QdyUcIvcQ2bgF82wmWXXwdQ+yol3YskXKvwOFc34o9McTjO4ctLXIjtnXTgDjKjTfo4
         Uhwc3+ty/ItFHdS7ZRqcfLLiNjIEerMYkGru8=
Received: by 10.103.81.20 with SMTP id i20mr3901882mul.21.1265575903790;
        Sun, 07 Feb 2010 12:51:43 -0800 (PST)
Received: from localhost.localdomain (abvv164.neoplus.adsl.tpnet.pl [83.8.219.164])
        by mx.google.com with ESMTPS id u9sm17724089muf.18.2010.02.07.12.51.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Feb 2010 12:51:42 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o17KpImd011261;
	Sun, 7 Feb 2010 21:51:28 +0100
In-Reply-To: <20100207204539.11146.36972.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139254>

The error message (second argument to die_error) is meant to be short,
one-line text description of given error.  A few callers call
die_error with error message containing unescaped user supplied data
($hash, $file_name).  Instead of forcing callers to escape data,
simply call esc_html on the parameter.

Note that optional third parameter, which contains detailed error
description, is meant to be HTML formatted, and therefore should be
not escaped.

While at it update esc_html synopsis/usage, and bring default error
description to read 'Internal Server Error' (titlecased).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Alternate solution would be to do escaping in call sites for die_error.

But in error messages shown on 'die' via CGI::Carp qw(fatalsToBrowser)
the error message is HTML escaped, so in fact we are following here
this "calling convention".

Note that for any patch relied on 'Internal server error' as error
message, it must be changed to not fail wrongly.

 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a5bc359..e393f65 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3374,7 +3374,7 @@ sub git_footer_html {
 	      "</html>";
 }
 
-# die_error(<http_status_code>, <error_message>)
+# die_error(<http_status_code>, <error_message>[, <detailed_html_description>])
 # Example: die_error(404, 'Hash not found')
 # By convention, use the following status codes (as defined in RFC 2616):
 # 400: Invalid or missing CGI parameters, or
@@ -3389,7 +3389,7 @@ sub git_footer_html {
 #      or down for maintenance).  Generally, this is a temporary state.
 sub die_error {
 	my $status = shift || 500;
-	my $error = shift || "Internal server error";
+	my $error = esc_html(shift || "Internal Server Error");
 	my $extra = shift;
 
 	my %http_responses = (
