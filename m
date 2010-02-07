From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/2] gitweb: Protect escaping functions against calling on
	undef
Date: Sun, 07 Feb 2010 21:52:25 +0100
Message-ID: <20100207205130.11146.30664.stgit@localhost.localdomain>
References: <20100207204539.11146.36972.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 07 21:53:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeE7s-0003lI-T5
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 21:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213Ab0BGUw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 15:52:59 -0500
Received: from mail-fx0-f211.google.com ([209.85.220.211]:34128 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568Ab0BGUw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 15:52:58 -0500
Received: by fxm3 with SMTP id 3so6727789fxm.39
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 12:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=uPqmqt2o7ax5LL1GxR5By9w1r/eVQl2wQk6tiQF5sLw=;
        b=HXYeaNbRTOkZt4ve14baIFX8QCzz7cjFq5p0QMZCD3jj9yxjC/TzSKhsKFmDHDLYwG
         p7djh/jRu5AKtL+fOMJdKTjO4WbauKxG6j22PLFLLd0+32qnc+sX5jjb3MKDaHpL8mKA
         pVwV3sBM7UCykllSGpRLa2jOn6fnGvsRn7Ny8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=oD900Dgg0BGymCVnXuMitAFxe07mjM/iP/Q5D5L6mO3cidjXWcYSA9fVX1jN3XjBqB
         zVg4j9O6Oeq1R5NYZw/xYhuKmwMUUBuKaShsG1VWIEcnksCVGxI8tDvJzIsahwvAl98L
         Ac9v/OkQgiwmkftu/jbZu8TgRm+SPBnJyQR2s=
Received: by 10.102.207.12 with SMTP id e12mr3837759mug.97.1265575976807;
        Sun, 07 Feb 2010 12:52:56 -0800 (PST)
Received: from localhost.localdomain (abvv164.neoplus.adsl.tpnet.pl [83.8.219.164])
        by mx.google.com with ESMTPS id 14sm11352251muo.55.2010.02.07.12.52.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Feb 2010 12:52:55 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o17KqP17011282;
	Sun, 7 Feb 2010 21:52:35 +0100
In-Reply-To: <20100207204539.11146.36972.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139255>

This is a bit of future-proofing esc_html and friends: when called
with undefined value they would now would return undef... which would
probably mean that error would still occur, but closer to the source
of problem.

This means that we can safely use
  esc_html(shift) || "Internal Server Error"
in die_error() instead of
  esc_html(shift || "Internal Server Error")

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Without the second part (i.e. the change in die_error) those two
patches would be totally independent.

 gitweb/gitweb.perl |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e393f65..c10967c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1145,6 +1145,7 @@ sub validate_refname {
 # in utf-8 thanks to "binmode STDOUT, ':utf8'" at beginning
 sub to_utf8 {
 	my $str = shift;
+	return undef unless defined $str;
 	if (utf8::valid($str)) {
 		utf8::decode($str);
 		return $str;
@@ -1157,6 +1158,7 @@ sub to_utf8 {
 # correct, but quoted slashes look too horrible in bookmarks
 sub esc_param {
 	my $str = shift;
+	return undef unless defined $str;
 	$str =~ s/([^A-Za-z0-9\-_.~()\/:@ ]+)/CGI::escape($1)/eg;
 	$str =~ s/ /\+/g;
 	return $str;
@@ -1165,6 +1167,7 @@ sub esc_param {
 # quote unsafe chars in whole URL, so some charactrs cannot be quoted
 sub esc_url {
 	my $str = shift;
+	return undef unless defined $str;
 	$str =~ s/([^A-Za-z0-9\-_.~();\/;?:@&=])/sprintf("%%%02X", ord($1))/eg;
 	$str =~ s/\+/%2B/g;
 	$str =~ s/ /\+/g;
@@ -1176,6 +1179,8 @@ sub esc_html {
 	my $str = shift;
 	my %opts = @_;
 
+	return undef unless defined $str;
+
 	$str = to_utf8($str);
 	$str = $cgi->escapeHTML($str);
 	if ($opts{'-nbsp'}) {
@@ -1190,6 +1195,8 @@ sub esc_path {
 	my $str = shift;
 	my %opts = @_;
 
+	return undef unless defined $str;
+
 	$str = to_utf8($str);
 	$str = $cgi->escapeHTML($str);
 	if ($opts{'-nbsp'}) {
@@ -3389,7 +3396,7 @@ sub git_footer_html {
 #      or down for maintenance).  Generally, this is a temporary state.
 sub die_error {
 	my $status = shift || 500;
-	my $error = esc_html(shift || "Internal Server Error");
+	my $error = esc_html(shift) || "Internal Server Error";
 	my $extra = shift;
 
 	my %http_responses = (
