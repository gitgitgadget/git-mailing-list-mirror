From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Don't escape attributes in CGI.pm HTML methods
Date: Wed, 7 Mar 2007 02:21:25 +0100
Message-ID: <200703070221.25519.jnareb@gmail.com>
References: <20070306093917.GA1761@coredump.intra.peff.net> <200703070137.07477.jnareb@gmail.com> <7vvehdnaib.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	"Li Yang-r58472" <LeoLi@freescale.com>, "Jeff King" <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 07 02:19:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOkoB-00049l-Tz
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 02:19:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161115AbXCGBTA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 20:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161114AbXCGBTA
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 20:19:00 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:26466 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161113AbXCGBS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 20:18:58 -0500
Received: by ug-out-1314.google.com with SMTP id 44so377177uga
        for <git@vger.kernel.org>; Tue, 06 Mar 2007 17:18:57 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PXzQ8MuHOiuPznTrxRVkUpBk6AHWRy7forPV/T4K6RClgdKeOpur+/UZE1EDahE36V9EvfyQ/8d9gUB9YgX7Z4XYpiykNrTXkAHu+JYhJLLMCiqU4Bn67BkVXAJge9DTLoH2x/NS9D+coVY3a8AmPZOFvxkq/l1gW3ukJPLL1nM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qIZhoXw7Wov0Poo1FLbnCyAuk1uP59W5jq4O+x648UXmkKghVKPofw52SJd6S3WPqxV9czNtV0ytGyhnzsIhu8kd11UcYBLnGhNlTyeVps6Xmh7HBcDuKMeq/5iiYx2bei35LN7HUEGbSKQEarAQtZfb9AO/2tUahh8G+6ySxpk=
Received: by 10.67.89.5 with SMTP id r5mr2960139ugl.1173230337444;
        Tue, 06 Mar 2007 17:18:57 -0800 (PST)
Received: from host-81-190-22-152.torun.mm.pl ( [81.190.22.152])
        by mx.google.com with ESMTP id j9sm13416mue.2007.03.06.17.18.55;
        Tue, 06 Mar 2007 17:18:56 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vvehdnaib.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41633>

There is no need to escape HTML tag's attributes in CGI.pm
HTML methods (like CGI::a()), because CGI.pm does attribute
escaping automatically.

Explanation:
  $cgi->a({ ... -attribute => atribute_value }, tag_contents)
is translated to
  <a ... attribute="attribute_value">tag_contents</a>
The rules for escaping attribute values (which are string contents) are
different. For example you have to take care about escaping embedded '"'
and "'" characters; CGI::a() does that for us automatically.

CGI::a() cannot HTML escape tag contents automatically; we might want to
write
  <a href="URL">some <b>bold</b> text</a>
for example. So we have to esc_html (or esc_path) if needed.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> In short: escape tag contents if needed, do not escape attrbure values.
> 
> I trust a patch from you will follow shortly?

Here it is. I hope I found everything.

Commit message is bit long, so you can cut it to first sentence only
(or even only to title/subject).


 gitweb/gitweb.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 653ca3c..ea58946 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1974,17 +1974,17 @@ sub git_print_page_path {
 			$fullname .= ($fullname ? '/' : '') . $dir;
 			print $cgi->a({-href => href(action=>"tree", file_name=>$fullname,
 			                             hash_base=>$hb),
-			              -title => esc_html($fullname)}, esc_path($dir));
+			              -title => $fullname}, esc_path($dir));
 			print " / ";
 		}
 		if (defined $type && $type eq 'blob') {
 			print $cgi->a({-href => href(action=>"blob_plain", file_name=>$file_name,
 			                             hash_base=>$hb),
-			              -title => esc_html($name)}, esc_path($basename));
+			              -title => $name}, esc_path($basename));
 		} elsif (defined $type && $type eq 'tree') {
 			print $cgi->a({-href => href(action=>"tree", file_name=>$file_name,
 			                             hash_base=>$hb),
-			              -title => esc_html($name)}, esc_path($basename));
+			              -title => $name}, esc_path($basename));
 			print " / ";
 		} else {
 			print esc_path($basename);
-- 
1.5.0.2
