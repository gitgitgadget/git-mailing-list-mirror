From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH] gitweb: Fail early
Date: Tue, 19 May 2009 22:40:31 +0200
Message-ID: <200905192240.34199.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 22:41:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6W7I-0002VX-Rk
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 22:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579AbZESUko (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 16:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753441AbZESUko
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 16:40:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:54879 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753392AbZESUkn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 16:40:43 -0400
Received: by fg-out-1718.google.com with SMTP id 16so14607fgg.17
        for <git@vger.kernel.org>; Tue, 19 May 2009 13:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=G4VikndDNdQZAQeh6BdLtxT1HP9OPiGVuhfRC4Wrt1M=;
        b=xn0edB7iEAhDvurPK6FIaskogsud7KiwWAt5H/z0gLk+obMEuGf+cE5Ls9RRCMCRu9
         VU2v4XoS90G2lNrjUpzNobl6dxwDmZfj08obQ1f48TdL6FHtf88eeoHbRDNMOAZB117K
         t8jNxUywv8LnTtkct6xAdVGXGltXBScw0cY3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=VLLVYP4/+YgRpnIpoE2Pq8F0si6b/odB/cmTybZDI9ovaGlvWReWL+cj5K043uHa1k
         d2bt30p4NFX2okrsoSPtBjLi/hIwbG41S/cLoqPL+JhmQApQcQg1nZeFKCqomlw2OL1A
         /7HnT5vEkPjo90hrXvADD2pqFzgxW32JsR0zk=
Received: by 10.86.79.6 with SMTP id c6mr463593fgb.52.1242765643827;
        Tue, 19 May 2009 13:40:43 -0700 (PDT)
Received: from ?192.168.1.13? (abvi55.neoplus.adsl.tpnet.pl [83.8.206.55])
        by mx.google.com with ESMTPS id e11sm7576910fga.21.2009.05.19.13.40.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 May 2009 13:40:43 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119567>

Return HTTP 500 Internal Server Error if $GIT is not defined (which
would cause Perl error), or if "$GIT --version" failed to run.  This
should not happen often, but I think this change would make diagnosing
misconfiguration easier.
---
Is "git version" in 'git --version' output ensured? How did other git
implementations and ports (like msysGit and jgit) output of --version
looks like?

Does it make sense to check whether output matches, and if it doesn't
match assume that $GIT points to something other, perhaps some other
git like GIT Interactive Tools or something?

Does it makes sense to try various other checks to make error message
more detailed like $GIT is not found, or is not executable?

diff --git i/gitweb/gitweb.perl w/gitweb/gitweb.perl
index 05702e4..0cb53ca 100755
--- i/gitweb/gitweb.perl
+++ w/gitweb/gitweb.perl
@@ -471,7 +471,13 @@ if (-e $GITWEB_CONFIG) {
 }
 
 # version of the core git binary
+if (!defined $GIT) {
+	die_error(500, "Undefined path to git binary");
+}
 our $git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
+if ($?) {
+	die_error(500, "Error calling '$GIT --version': $?");
+}
 
 $projects_list ||= $projectroot;
 
