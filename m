From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 1/6] gitweb: Load checking
Date: Fri, 18 Dec 2009 17:36:04 +0100
Message-ID: <200912181736.07008.jnareb@gmail.com>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org> <4B21AC4D.2020407@kernel.org> <200912111109.17047.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: "J.H." <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 18 17:36:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLfoc-0000Ur-PJ
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 17:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbZLRQgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 11:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754919AbZLRQgY
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 11:36:24 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:55781 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908AbZLRQgW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 11:36:22 -0500
Received: by fxm21 with SMTP id 21so2982479fxm.21
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 08:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=tynhwnxM/mVp7MHMYlbLFe3VX0EUGebbKFzlavHYxhc=;
        b=XrGxzRI7dlDDka9aRLSpuAfWzwbBA4bLwv6qvfFBeGQkqsIuMSeQa/cIhzBNHuHGXV
         UDUfauJfHpsb6PNVAxSgU+GLnndBC5D7L6FWDh1mewPN5ma7UEp6uugu3V8iyDX2Bfuz
         C3bjOwWKxRfg86ZRy5JZ6GObVbo4TWH35WLuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Ff1gjLUyxTzLejkyBsuz668PQszLyuICjci/FE2BHAVmGOJLSXEKZeb1jwpf+lqAOz
         smGN5143RIXNx8T3TiQKzTfv0IXOXxe9kCNfqNEWX8yq8Be9GwVRVl/gUoaourH/WCU+
         PLF6dSpW88sS/26GQ00WnFXAxLA717o1jVf/U=
Received: by 10.223.61.72 with SMTP id s8mr1086963fah.56.1261154179572;
        Fri, 18 Dec 2009 08:36:19 -0800 (PST)
Received: from ?192.168.1.13? (abwt9.neoplus.adsl.tpnet.pl [83.8.243.9])
        by mx.google.com with ESMTPS id 12sm5237684fks.9.2009.12.18.08.36.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Dec 2009 08:36:18 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200912111109.17047.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135418>

From: John 'Warthog9' Hawley <warthog9@kernel.org>

This changes slightly the behavior of gitweb, so that it verifies
that the box isn't inundated with before attempting to serve gitweb.
If the box is overloaded, it basically returns a 503 Server Unavailable
until the load falls below the defined threshold.  This helps dramatically
if you have a box that's I/O bound, reaches a certain load and you
don't want gitweb, the I/O hog that it is, increasing the pain the
server is already undergoing.

This behavior is controlled by $maxload configuration variable.
Default is a load of 300, which for most cases should never be hit.
Unset it (set it to undefined value, i.e. undef) to turn off checking.

Currently it requires that '/proc/loadavg' file exists, otherwise the
load check is bypassed (load is taken to be 0).  So platforms that do
not implement '/proc/loadavg' currently cannot use this feature.

Signed-off-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is my take on this patch, with all my concerns taken into 
consideration... well, all except describing alterante approaches
to straight using /proc/loadavg.

Differences to original version by John 'Warthog9' Hawley (J.H.):
* Slightly improved wording in commit message and in comments
* $maxload described in gitweb/README, in "Gitweb config file variables"
  section
* You can use '$maxload = undef;' to turn off load checking
* Error page for too high load is generated using die_error, which had
  to be extended to handle 503 Service Unavailable HTTP error code

 gitweb/README      |    7 ++++++-
 gitweb/gitweb.perl |   39 +++++++++++++++++++++++++++++++++++----
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index e34ee79..6c2c8e1 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -174,7 +174,7 @@ not include variables usually directly set during build):
    Base URL for relative URLs in pages generated by gitweb,
    (e.g. $logo, $favicon, @stylesheets if they are relative URLs),
    needed and used only for URLs with nonempty PATH_INFO via
-   <base href="$base_url>.  Usually gitweb sets its value correctly,
+   <base href="$base_url">.  Usually gitweb sets its value correctly,
    and there is no need to set this variable, e.g. to $my_uri or "/".
  * $home_link
    Target of the home link on top of all pages (the first part of view
@@ -228,6 +228,11 @@ not include variables usually directly set during build):
    repositories from launching cross-site scripting (XSS) attacks.  Set this
    to true if you don't trust the content of your repositories. The default
    is false.
+ * $maxload
+   Used to set the maximum load that we will still respond to gitweb queries.
+   If server load exceed this value then return "503 Service Unavaliable" error.
+   Server load is taken to be 0 if gitweb cannot determine its value.  Set it to
+   undefined value to turn it off.  The default is 300.
 
 
 Projects list file format
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7e477af..a0f0444 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -221,6 +221,12 @@ our %avatar_size = (
 	'double'  => 32
 );
 
+# Used to set the maximum load that we will still respond to gitweb queries.
+# If server load exceed this value then return "503 server busy" error.
+# If gitweb cannot determined server load, it is taken to be 0.
+# Leave it undefined (or set to 'undef') to turn off load checking.
+our $maxload = 300;
+
 # You define site-wide feature defaults here; override them with
 # $GITWEB_CONFIG as necessary.
 our %feature = (
@@ -551,6 +557,26 @@ if (-e $GITWEB_CONFIG) {
 	do $GITWEB_CONFIG_SYSTEM if -e $GITWEB_CONFIG_SYSTEM;
 }
 
+# Get loadavg of system, to compare against $maxload.
+# Currently it requires '/proc/loadavg' present to get loadavg;
+# if it is not present it returns 0, which means no load checking.
+sub get_loadavg {
+	open my $fd, '<', '/proc/loadavg'
+		or return 0;
+	my @load = split(/\s+/, scalar <$fd>);
+	close $fd;
+
+	# The first three columns measure CPU and IO utilization of the last one,
+	# five, and 10 minute periods.  The fourth column shows the number of
+	# currently running processes and the total number of processes in the m/n
+	# format.  The last column displays the last process ID used.
+	return $load[0] || 0;
+}
+
+if (defined $maxload && get_loadavg() > $maxload) {
+	die_error(503, "The load average on the server is too high");
+}
+
 # version of the core git binary
 our $git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
 $number_of_git_cmds++;
@@ -3354,14 +3380,19 @@ sub git_footer_html {
 # 500: The server isn't configured properly, or
 #      an internal error occurred (e.g. failed assertions caused by bugs), or
 #      an unknown error occurred (e.g. the git binary died unexpectedly).
+# 503: The server is currently unavailable (because it is overloaded,
+#      or down for maintenance).  Generally, this is a temporary state.
 sub die_error {
 	my $status = shift || 500;
 	my $error = shift || "Internal server error";
 
-	my %http_responses = (400 => '400 Bad Request',
-			      403 => '403 Forbidden',
-			      404 => '404 Not Found',
-			      500 => '500 Internal Server Error');
+	my %http_responses = (
+		400 => '400 Bad Request',
+		403 => '403 Forbidden',
+		404 => '404 Not Found',
+		500 => '500 Internal Server Error',
+		503 => '503 Service Unavailable',
+	);
 	git_header_html($http_responses{$status});
 	print <<EOF;
 <div class="page_body">
-- 
1.6.5.3
