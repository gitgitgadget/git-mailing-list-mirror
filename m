From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Better processing format string in custom links in
	navbar
Date: Sun, 12 Oct 2008 00:02:32 +0200
Message-ID: <20081011215456.22315.5977.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 12 00:04:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KomZc-0006Jx-0F
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 00:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755118AbYJKWDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 18:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754883AbYJKWDO
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 18:03:14 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:56965 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbYJKWDN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 18:03:13 -0400
Received: by fk-out-0910.google.com with SMTP id 18so988104fkq.5
        for <git@vger.kernel.org>; Sat, 11 Oct 2008 15:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=36IOgPFRoSMqVuobEuqdfyp3Hib0275xM7R6w7CO3/Y=;
        b=t+PjXjw2Ds5BF4ua7/RtRMOcp95BH8RpBrENWd73O3u/EHyTPfqj+11ul/WZsDxx3Q
         qS1o76ufkBQbf2SYwBb3+EszBJ5+cidF1mshJhF5WTo/cLwG3HhNIGwxG2ghEcPPHmrb
         JG8GEV03NwoU0xYeekl0Qd/pfrbOlwytMRZ9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=ikqpzfM+TmGTGlCmw1DAPLFm7vjKTHxqg+UFUgsyajq2/1suxs70kysaHpGjvv/nq3
         2EsSQE4+88zXhO67ybvM3ErIQ2ct3XM19aMS6DKHkjuk7SEr0hmfdsH19NcTn6ED+P/x
         ohZBqqHNJnsmWqRxfhaZBaAtnd/KjLIdW0G3M=
Received: by 10.181.146.11 with SMTP id y11mr3311878bkn.60.1223762591027;
        Sat, 11 Oct 2008 15:03:11 -0700 (PDT)
Received: from localhost.localdomain (abwl133.neoplus.adsl.tpnet.pl [83.8.235.133])
        by mx.google.com with ESMTPS id 1sm3645151nfv.18.2008.10.11.15.03.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 11 Oct 2008 15:03:09 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m9BM2W6t022409;
	Sun, 12 Oct 2008 00:02:43 +0200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97994>

Make processing format string in custom links in action bar ('actions'
feature) more robust.  Now there would be no problems if one of
expanded values (for example project name, of project filename)
contains '%'; additionally format string supports '%' escaping by
doubling, i.e. '%%' expands to '%'.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Neither of parameters we expand to ($projec, $git_dir, $treehash,
$treebase) is ensured to have no '%' in the value.  Therefore
sequential expansion, i.e. expanding one parameter after another could
lead to error.

Also there was no way to put '%' on the link; now it is possible
thanks to '%%' -> '%' expansion.

I have tred to be not too generic; you can check unquote() subroutine
to see how such more generic function (something like tsprintf_simple)
should look like


Pasky, could you check if it works correctly?

 gitweb/gitweb.perl |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1116800..cc6edbe 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -290,10 +290,10 @@ our %feature = (
 
 	# The 'default' value consists of a list of triplets in the form
 	# (label, link, position) where position is the label after which
-	# to inster the link and link is a format string where %n expands
+	# to insert the link and link is a format string where %n expands
 	# to the project name, %f to the project path within the filesystem,
 	# %h to the current hash (h gitweb parameter) and %b to the current
-	# hash base (hb gitweb parameter).
+	# hash base (hb gitweb parameter); %% expands to %.
 
 	# To enable system wide have in $GITWEB_CONFIG e.g.
 	# $feature{'actions'}{'default'} = [('graphiclog',
@@ -2866,14 +2866,19 @@ sub git_print_page_nav {
 	$arg{'tree'}{'hash_base'} = $treebase if defined $treebase;
 
 	my @actions = gitweb_check_feature('actions');
+	my %repl = (
+		'%' => '%',
+		'n' => $project,         # project name
+		'f' => $git_dir,         # project path within filesystem
+		'h' => $treehead || '',  # current hash ('h' parameter)
+		'b' => $treebase || '',  # hash base ('hb' parameter)
+	);
 	while (@actions) {
-		my ($label, $link, $pos) = (shift(@actions), shift(@actions), shift(@actions));
+		my ($label, $link, $pos) = splice(@actions,0,3);
+		# insert
 		@navs = map { $_ eq $pos ? ($_, $label) : $_ } @navs;
 		# munch munch
-		$link =~ s#%n#$project#g;
-		$link =~ s#%f#$git_dir#g;
-		$treehead ? $link =~ s#%h#$treehead#g : $link =~ s#%h##g;
-		$treebase ? $link =~ s#%b#$treebase#g : $link =~ s#%b##g;
+		$link =~ s/%([%nfhb])/$repl{$1}/g;
 		$arg{$label}{'_href'} = $link;
 	}
 

-- 
Stacked GIT 0.14.3
git version 1.6.0.2
