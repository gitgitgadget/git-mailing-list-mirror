From: Guillaume Seguin <guillaume@segu.in>
Subject: [PATCH] gitweb : disambiguate heads and tags withs the same name
Date: Sat, 03 Nov 2007 22:40:32 +0100
Message-ID: <1194126032.15420.4.camel@ed3n-m>
References: <e877c31c0710280612l5d783ab0o50ce00c70b3311db@mail.gmail.com>
	 <7v3avsmpmj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: pasky@ucw.cz
X-From: git-owner@vger.kernel.org Sat Nov 03 22:49:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoQs2-0001Ru-Al
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 22:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756456AbXKCVtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 17:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756258AbXKCVtU
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 17:49:20 -0400
Received: from hu-out-0506.google.com ([72.14.214.229]:47426 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756138AbXKCVtT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 17:49:19 -0400
Received: by hu-out-0506.google.com with SMTP id 19so491000hue
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 14:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding:sender;
        bh=X0qHA7LxVY29DKsRVhxoNBJqHF5JWsaMLipn8wZ50kw=;
        b=CEdMSOSmroXOAA7mFOEjwHQpx3s8wXKkEoD9QfdRgAfy0+kXM1e7+xiSuajlmnCZAAxX4zHGZIwNjdLvLqn2CEBwBaSVgrgZgTvsBnafWNudyDVhCYga5sImk9vl2cd+T/v587qa22A06M9hF6Pnt9Ze3aXNWOOsA9DkYzNBkoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding:sender;
        b=o6AsnZFCpWK7fl1rI5YsSxbwtyB6uA4C9sAxP7BjH5ecSGWpnILyucNKGskJRZQZkzspA5rj+scPlkxNbbBKSWGxMRa3oxhtVwqO0niiHTImwaaydWkim4K8asTorbb8TTTGBdA5krh9+Di7OMCW6H5VnVzUdFRholDJCDX2ZGU=
Received: by 10.78.168.1 with SMTP id q1mr2530230hue.1194126555733;
        Sat, 03 Nov 2007 14:49:15 -0700 (PDT)
Received: from ?127.0.0.1? ( [195.114.19.35])
        by mx.google.com with ESMTPS id g17sm4679397nfd.2007.11.03.14.49.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 03 Nov 2007 14:49:14 -0700 (PDT)
In-Reply-To: <7v3avsmpmj.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63317>

   Avoid wrong disambiguation that would link logs/trees of tags and heads which 
   share the same name to the same page, leading to a disambiguation that would
   prefer the tag, thus making it impossible to access the corresponding
   head log and tree without hacking the url by hand.

   Signed-off-by: Guillaume Seguin <guillaume@segu.in>

---
 gitweb/gitweb.perl |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl 
index 48e21da..f918c00 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3534,6 +3534,7 @@ sub git_tags_body {
     for (my $i = $from; $i <= $to; $i++) {
         my $entry = $taglist->[$i]; 
         my %tag = %$entry;
+        my $name = "refs/tags/$tag{'name'}";
         my $comment = $tag{'subject'};
         my $comment_short;
         if (defined $comment) {
@@ -3570,8 +3571,8 @@ sub git_tags_body { 
               "<td class=\"link\">" . " | " .
               $cgi->a({-href => href(action=>$tag{'reftype'}, hash=>$tag{'refid'})}, $tag{'reftype'}); 
         if ($tag{'reftype'} eq "commit") {
-            print " | " . $cgi->a({-href => href(action=>"shortlog", hash=>$tag{'name'})}, "shortlog") . 
-                  " | " . $cgi->a({-href => href(action=>"log", hash=>$tag{'name'})}, "log");
+            print " | " . $cgi->a({-href => href(action=>"shortlog", hash=>$name)}, "shortlog") . 
+                  " | " . $cgi->a({-href => href(action=>"log", hash=>$name)}, "log");
         } elsif ($tag{'reftype'} eq "blob") {
             print " | " . $cgi->a({-href => href(action=>"blob_plain", hash=>$tag{'refid'})}, "raw"); 
         }
@@ -3597,6 +3598,7 @@ sub git_heads_body {
     for (my $i = $from; $i <= $to; $i++) {
         my $entry = $headlist->[$i];
         my %ref = %$entry;
+        my $name = "refs/heads/$ref{'name'}"; 
         my $curr = $ref{'id'} eq $head;
         if ($alternate) {
             print "<tr class=\"dark\">\n";
@@ -3606,13 +3608,13 @@ sub git_heads_body {
         $alternate ^= 1; 
         print "<td><i>$ref{'age'}</i></td>\n" .
               ($curr ? "<td class=\"current_head\">" : "<td>") .
-              $cgi->a({-href => href(action=>"shortlog", hash=>$ref{'name'}), 
+              $cgi->a({-href => href(action=>"shortlog", hash=>$name),
                        -class => "list name"},esc_html($ref{'name'})) .
               "</td>\n" . 
               "<td class=\"link\">" .
-              $cgi->a({-href => href(action=>"shortlog", hash=>$ref{'name'})}, "shortlog") . " | " . 
-              $cgi->a({-href => href(action=>"log", hash=>$ref{'name'})}, "log") . " | " .
-              $cgi->a({-href => href(action=>"tree", hash=>$ref{'name'}, hash_base=>$ref{'name'})}, "tree") . 
+              $cgi->a({-href => href(action=>"shortlog", hash=>$name)}, "shortlog") . " | " .
+              $cgi->a({-href => href(action=>"log", hash=>$name)}, "log") . " | " . 
+              $cgi->a({-href => href(action=>"tree", hash=>$name, hash_base=>$name)}, "tree") .
               "</td>\n" .
               "</tr>"; 
     }
-- 
1.5.3.4.395.g85b0
