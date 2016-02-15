From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn dcommit doesn't support --username option for file:///
 urls
Date: Mon, 15 Feb 2016 10:06:36 +0000
Message-ID: <20160215100636.GA5785@dcvr.yhbt.net>
References: <CAGZMbfc5Oi=EOYbCbZWfM1T65AZwCEbsso+QTkAe1sa4hRC61A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Ringenbach <tim.ringenbach@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 11:06:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVG3L-0004tC-7q
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 11:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644AbcBOKGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 05:06:38 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:38614 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752625AbcBOKGh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 05:06:37 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8D5F2030F;
	Mon, 15 Feb 2016 10:06:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAGZMbfc5Oi=EOYbCbZWfM1T65AZwCEbsso+QTkAe1sa4hRC61A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286195>

Tim Ringenbach <tim.ringenbach@gmail.com> wrote:
> Hi,
> 
> 'git svn dcommit' doesn't seem to honor the --username argument when
> my svn repository url is a file:/// url.  It doesn't complain either,
> it just seems to silently ignore the option. My dcommits show up as
> the user I'm logged in as. The only way I found to change that is to
> 'sudo' to some other user.
> 
> The actual 'svn' command does support --username with 'svn commit'.

Interesting, I didn't know --username would be handled with
file:// at all by svn(1).  I don't think we do anything special
depending on the URL scheme for auth, either.

I took a quick look at the svn(1) code
(subversion/svn/svn.c in git://git.apache.org/subversion.git)
but didn't see anything jump out at me (I'm not really familiar
with that code, either).

Totally untested, but does flipping the order of auth providers
help at all?

diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index e764696..c6ce247 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -43,6 +43,7 @@ END {
 sub _auth_providers () {
 	require SVN::Client;
 	my @rv = (
+	  SVN::Client::get_username_provider(),
 	  SVN::Client::get_simple_provider(),
 	  SVN::Client::get_ssl_server_trust_file_provider(),
 	  SVN::Client::get_simple_prompt_provider(
@@ -53,7 +54,6 @@ sub _auth_providers () {
 	  SVN::Client::get_ssl_client_cert_pw_file_provider(),
 	  SVN::Client::get_ssl_client_cert_pw_prompt_provider(
 	    \&Git::SVN::Prompt::ssl_client_cert_pw, 2),
-	  SVN::Client::get_username_provider(),
 	  SVN::Client::get_ssl_server_trust_prompt_provider(
 	    \&Git::SVN::Prompt::ssl_server_trust),
 	  SVN::Client::get_username_prompt_provider(


(I'm not sure if it breaks other things, either).
