From: "P. Christeas" <p_christ@hol.gr>
Subject: [PATCH]: Allow misc https cert for git-svnimport
Date: Fri, 28 Apr 2006 18:01:05 +0300
Message-ID: <200604281801.07155.p_christ@hol.gr>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_y4iUEiAM19GmrEW"
X-From: git-owner@vger.kernel.org Fri Apr 28 17:02:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZUU8-0007Ql-OK
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 17:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030426AbWD1PCS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Apr 2006 11:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030429AbWD1PCS
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Apr 2006 11:02:18 -0400
Received: from [62.38.115.9] ([62.38.115.9]:44222 "EHLO pfn3.pefnos")
	by vger.kernel.org with ESMTP id S1030426AbWD1PCR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Apr 2006 11:02:17 -0400
Received: from xorhgos2.pefnos (xorhgos2.pefnos [192.168.0.3])
	by pfn3.pefnos (Postfix) with ESMTP id EBEC432864;
	Fri, 28 Apr 2006 18:02:12 +0300 (EEST)
To: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
User-Agent: KMail/1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19282>

--Boundary-00=_y4iUEiAM19GmrEW
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Just had to access a server with a broken certificate (self signed), so I 
added that patch to git-svnimport.


--Boundary-00=_y4iUEiAM19GmrEW
Content-Type: text/x-diff;
  charset="us-ascii";
  name="git-svnimport-ssl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="git-svnimport-ssl.patch"

--- /usr/bin/git-svnimport	2006-04-13 09:39:39.000000000 +0300
+++ /home/panos/bin/git-svnimport	2006-04-28 17:55:45.000000000 +0300
@@ -96,9 +96,14 @@
 sub conn {
 	my $self = shift;
 	my $repo = $self->{'fullrep'};
-	my $auth = SVN::Core::auth_open ([SVN::Client::get_simple_provider,
+# 	my $auth = SVN::Core::auth_open ([SVN::Client::get_simple_provider,
+# 			  SVN::Client::get_ssl_server_trust_file_provider,
+# 			  SVN::Client::get_ssl_server_trust_prompt_provider(\&_trust_callback),
+# 			  SVN::Client::get_username_provider]);
+	my $auth = [SVN::Client::get_simple_provider,
 			  SVN::Client::get_ssl_server_trust_file_provider,
-			  SVN::Client::get_username_provider]);
+			  SVN::Client::get_ssl_server_trust_prompt_provider(\&_trust_callback),
+			  SVN::Client::get_username_provider];
 	my $s = SVN::Ra->new(url => $repo, auth => $auth);
 	die "SVN connection to $repo: $!\n" unless defined $s;
 	$self->{'svn'} = $s;
@@ -125,6 +130,45 @@
 	return $name;
 }
 
+sub _trust_callback {
+	my ($cred,$realm,$ifailed,$server_cert_info,$may_save) = @_;
+	#$cred->accepted_failures($SVN::Auth::SSL::UNKNOWNCA);
+	print "SSL certificate is not trusted: $ifailed \n";
+	print "Fingerprint: " . $server_cert_info->fingerprint . "\n";
+	print "Hostname:    ". $server_cert_info->hostname ;
+	print " (MISMATCH)" if ( $ifailed & $SVN::Auth::SSL::CNMISMATCH);
+	print "\n";
+	
+	print "Valid from:  ". $server_cert_info->valid_from;
+	print " (NOT YET)" if ( $ifailed & $SVN::Auth::SSL::NOTYETVALID);
+	print "\n";
+	
+	print "Valid until: ". $server_cert_info->valid_until;
+	print " (EXPIRED)" if ( $ifailed & $SVN::Auth::SSL::EXPIRED);
+	print "\n";
+	
+	print "Issuer:      ". $server_cert_info->issuer_dname;
+	print " (UNKNOWN)" if ( $ifailed & $SVN::Auth::SSL::UNKNOWNCA);
+	print "\n\n";
+	
+	print "Do you still want to accept that certificate? [y/N] ";
+	my $accept = <STDIN>;
+	chomp($accept);
+	print "\n";
+	if (($accept eq "y") or ($accept eq "Y" )) {
+		$cred->accepted_failures($ifailed);
+	# 	print "Save cert, so that it is accepted in future calls? [y/N] ";
+	# 	my $mmsave = <STDIN>;
+	# 	chomp($mmsave);
+	# 	if (($mmsave eq "y") or ($mmsave eq "Y" )) {
+	# 		$may_save = 1;
+	# 	}
+		print "\n";
+	}
+
+}
+
+
 package main;
 use URI;
 

--Boundary-00=_y4iUEiAM19GmrEW--
