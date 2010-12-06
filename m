From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 22/24] gitweb: Support legacy options used by kernel.org caching engine
Date: Tue,  7 Dec 2010 00:11:07 +0100
Message-ID: <1291677069-6559-23-git-send-email-jnareb@gmail.com>
References: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	demerphq <demerphq@gmail.com>,
	Aevar Arnfjord Bjarmason <avarab@gmail.com>,
	Thomas Adam <thomas@xteddy.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 00:20:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPkM3-0003kw-Bb
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 00:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180Ab0LFXUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 18:20:13 -0500
Received: from mail-ew0-f45.google.com ([209.85.215.45]:58044 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837Ab0LFXUM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 18:20:12 -0500
Received: by mail-ew0-f45.google.com with SMTP id 10so7585290ewy.4
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 15:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/3DergsPcYY5aII1HMbGw4q4Ce3crpQAGirXQQA1T6c=;
        b=BilF0ayKPp+VeDw32RCrz+xR0zTNFRYLgJ/Lu5A68k/imz6bo/n8mb7IXv8Ugzdwd+
         LTeEhjA5KELBC8A6s/uQmmfFA9Emu4CFL3ZcAjs3trBUjWEe5RJ+qmV531SG3PSplGqL
         pqoE9DKA626rJJl7ochNXOQLzqPtc1Z6H69mA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=u2r43M1/dyedd4w/+T9HXQwmRSveSlWPCQS1yes/3otZPh9BTsYEaAYzO9QPl7G5AS
         Bu77N3wgQ074YwPLW2Iiv4hEI9W+hQ2OsvdC1zHJX1nSFY6QteKYvjW4IdzS/3qhvXPc
         y0TVCyFdzlhAjkOwwn5xcB57JChs0dDLyI7fg=
Received: by 10.213.4.84 with SMTP id 20mr106028ebq.74.1291677156779;
        Mon, 06 Dec 2010 15:12:36 -0800 (PST)
Received: from localhost.localdomain (abwg200.neoplus.adsl.tpnet.pl [83.8.230.200])
        by mx.google.com with ESMTPS id y5sm5190626eeh.22.2010.12.06.15.12.34
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 15:12:36 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163058>

Try to translate between config variables used by gitweb caching
patches[1] by John 'Warthog9' Hawley (J.H.) used, among others, by
git.kernel.org, and new %cache_options options, but only if the legacy
config variables were set in the config file.

Note that $cache_enable is *not* translated to $caching_enabled.

Footnotes:
~~~~~~~~~~
[1] See for example "Gitweb caching v7" thread on git mailing list:
    http://thread.gmane.org/gmane.comp.version-control.git/160147

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch was not present in previous version of this series.

The drawback of this patch is that if any legacy config variable is set
in config file, then any change to %cache_options covering the same area
as legacy config variable would be ignored.  I don't see a better
solution, unless we can somehow check if value of %cache_options was
changed via gitweb config file.

I wonder how useful this patch would be; do people using caching from
"Gitweb caching v7" (caching feom git.kernel.org) configure it, or do
they use default configuration?

 gitweb/gitweb.perl |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5904d27..1521bf2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -284,6 +284,9 @@ our $caching_enabled = 0;
 # Suggested mechanism:
 # mv $cachedir $cachedir.flush && mkdir $cachedir && rm -rf $cachedir.flush
 our $cache;
+
+# Legacy options configuring behavior of git.kernel.org caching
+our ($minCacheTime, $maxCacheTime, $cachedir, $backgroundCache, $maxCacheLife);
 # You define site-wide cache options defaults here; override them with
 # $GITWEB_CONFIG as necessary.
 our %cache_options = (
@@ -1363,6 +1366,19 @@ sub configure_caching {
 		$cache ||= 'GitwebCache::FileCacheWithLocking';
 		eval "require $cache";
 		die $@ if $@;
+
+		# support for legacy config variables configuring cache behavior
+		# (those variables are/were used by caching engine by John Hawley,
+		# used among others by custom gitweb at http://git.kernel.org);
+		# it assumes that if those variables are defined, then we should
+		# use them - no provision is made for having both legacy variables
+		# and new %cache_options set in config file(s).
+		$cache_options{'cache_root'} = $cachedir if defined $cachedir;
+		$cache_options{'expires_min'} = $minCacheTime if defined $minCacheTime;
+		$cache_options{'expires_max'} = $maxCacheTime if defined $maxCacheTime;
+		$cache_options{'background_cache'} = $backgroundCache if defined $backgroundCache;
+		$cache_options{'max_lifetime'} = $maxCacheLife if defined $maxCacheLife;
+
 		$cache = $cache->new({
 			%cache_options,
 			#'cache_root' => '/tmp/cache',
-- 
1.7.3
