From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 3/3] git-instaweb: Don't assume Apache executable is
	named apache2
Date: Fri, 23 Jul 2010 11:22:09 -0700
Message-ID: <20100723182209.GA19333@dcvr.yhbt.net>
References: <1277865900-25044-1-git-send-email-dpmcgee@gmail.com> <1277865900-25044-3-git-send-email-dpmcgee@gmail.com> <7v39w48q4a.fsf@alter.siamese.dyndns.org> <AANLkTikYNVLM9MrmL819__Viap7ucvmrs7faeC4tdDmn@mail.gmail.com> <AANLkTimfy0F7x-WZpfJ0J45jUWjb9lrJt99jY0fO6ZzC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 23 20:22:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcMsz-00049I-5z
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 20:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678Ab0GWSWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 14:22:14 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:58132 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753442Ab0GWSWK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 14:22:10 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEA811F541;
	Fri, 23 Jul 2010 18:22:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <AANLkTimfy0F7x-WZpfJ0J45jUWjb9lrJt99jY0fO6ZzC@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151563>

Dan McGee <dpmcgee@gmail.com> wrote:
> On Wed, Jun 30, 2010 at 11:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > Dan McGee <dpmcgee@gmail.com> writes:
> >
> >> On Arch Linux, we keep the original 'httpd' name for the exectuable and
> >> don't rename it or the path to the modules.
> >
> > Sorry, but I cannot parse the last 6 words here.
> 
> On Arch Linux, the executable for the Apache HTTP server keeps the
> 'httpd' name and is not named 'apache2'. The path to the server
> modules also contains 'httpd' rather than 'apache2'.

(I missed this message the first time around since I wasn't Cc-ed).

Thanks Dan,

I've pushed your series of patches up to my "instaweb" branch on
git://git.bogomips.org/git-svn and reworked the commit message of 3/3
below:

>From 4bdf85995b5d21fdb085a480d529c8da0314189e Mon Sep 17 00:00:00 2001
From: Dan McGee <dpmcgee@gmail.com>
Date: Wed, 30 Jun 2010 07:29:08 -0500
Subject: [PATCH] git-instaweb: Don't assume Apache executable is named apache2

On Arch Linux, the executable for the Apache HTTP server keeps
the 'httpd' name and is not named 'apache2'. The path to the
server modules also contains 'httpd' rather than 'apache2'.
Remove some of these assumptions and add the httpd name in where
it may be required. Finally, make some slight style adjustments
to the code we are touching to make it fit the style of the rest
of the script.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
Acked-by: Eric Wong <normalperson@yhbt.net>
---
 git-instaweb.sh |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 1d349b8..b7342e2 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -43,7 +43,8 @@ test -z "$port" && port=1234
 
 resolve_full_httpd () {
 	case "$httpd" in
-	*apache2*|*lighttpd*)
+	*apache2*|*lighttpd*|*httpd*)
+		# yes, *httpd* covers *lighttpd* above, but it is there for clarity
 		# ensure that the apache2/lighttpd command ends with "-f"
 		if ! echo "$httpd" | sane_grep -- '-f *$' >/dev/null 2>&1
 		then
@@ -300,7 +301,13 @@ EOF
 }
 
 apache2_conf () {
-	test -z "$module_path" && module_path=/usr/lib/apache2/modules
+	if test -z "$module_path"
+	then
+		test -d "/usr/lib/httpd/modules" &&
+			module_path="/usr/lib/httpd/modules"
+		test -d "/usr/lib/apache2/modules" &&
+			module_path="/usr/lib/apache2/modules"
+	fi
 	bind=
 	test x"$local" = xtrue && bind='127.0.0.1:'
 	echo 'text/css css' > "$fqgitdir/mime.types"
@@ -314,8 +321,10 @@ PidFile "$fqgitdir/pid"
 Listen $bind$port
 EOF
 
-	for mod in mime dir env log_config; do
-		if test -e $module_path/mod_${mod}.so; then
+	for mod in mime dir env log_config
+	do
+		if test -e $module_path/mod_${mod}.so
+		then
 			echo "LoadModule ${mod}_module " \
 			     "$module_path/mod_${mod}.so" >> "$conf"
 		fi
@@ -563,7 +572,7 @@ case "$httpd" in
 *lighttpd*)
 	lighttpd_conf
 	;;
-*apache2*)
+*apache2*|*httpd*)
 	apache2_conf
 	;;
 webrick)
-- 
Eric Wong
