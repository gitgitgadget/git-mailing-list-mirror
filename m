From: Andrew Keller <andrew@kellerfarm.com>
Subject: [PATCH] gitweb: Improve diffs when filenames contain problem characters
Date: Sun, 30 Mar 2014 22:05:11 -0400
Message-ID: <1394DF8B-FD0D-4E5E-9BDE-79B487A725B6@kellerfarm.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jakub Narebski <jnareb@gmail.com>,
	Krzesimir Nowak <krzesimir@endocode.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 31 04:05:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WURbJ-0001OA-5P
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 04:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbaCaCFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2014 22:05:16 -0400
Received: from atl4mhob13.myregisteredsite.com ([209.17.115.51]:51191 "EHLO
	atl4mhob13.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752011AbaCaCFP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 22:05:15 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.208])
	by atl4mhob13.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s2V25CG9014039
	for <git@vger.kernel.org>; Sun, 30 Mar 2014 22:05:12 -0400
Received: (qmail 15299 invoked by uid 0); 31 Mar 2014 02:05:12 -0000
X-TCPREMOTEIP: 23.28.12.255
X-Authenticated-UID: andrew@kellerfarm.com
Received: from unknown (HELO ?192.168.0.103?) (andrew@kellerfarm.com@23.28.12.255)
  by 0 with ESMTPA; 31 Mar 2014 02:05:12 -0000
X-Mailer: Apple Mail (2.1085)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245490>

When formatting a diff header line, be sure to escape the raw output from git
for use as HTML.  This ensures that when "problem characters" (&, <, >, ?, etc.)
exist in filenames, gitweb displays them as text, rather than letting the
browser interpret them as HTML.

Reported-by: Dongsheng Song <dongsheng.song@gmail.com>
Signed-off-by: Andrew Keller <andrew@kellerfarm.com>
---
Steps to reproduce:

1)  Create a repository that contains a commit that adds a file:
    * with an ampersand in the filename
    * with binary contents
2)  Make the repository visible to gitweb
3)  In gitweb, navigate to the page that shows the diff for the commit
    that added the file

Behavior without patch: Page stops rendering when it gets to one of
the instances of the filename (in the diff header, to be specific), and
a light-red box appears a the top of the page, saying something like
this:

    This page contains the following errors:

    error on line 67 at column 22: xmlParseEntityRef: no name

    Below is a rendering of the page up to the first error.


(This particular error is what you get with an unescaped ampersand)

Behavior with patch: You see the ampersand in the file name, and the
page renders as one would expect.


Other notes:

Several helper methods exist for escaping HTML, and I was unsure
about which one to use.  Although this patch fixes the problem,
it is possible that it may be more correct to use, for example, the
'esc_html' helper method instead of interacting with $cgi directly.

The first hunk in the diff seems to be all that's required to experience
the good behavior, however upon inspecting the code, it seems
prudent to also include the second one.  It's a nearby section of code,
doing similar work, and is called from the same function as the
former, and with similar arguments.


Thanks,
Andrew Keller


 gitweb/gitweb.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 79057b7..6c559f8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2223,6 +2223,8 @@ sub format_git_diff_header_line {
 	my $diffinfo = shift;
 	my ($from, $to) = @_;
 
+	$line = $cgi->escapeHTML($line);
+
 	if ($diffinfo->{'nparents'}) {
 		# combined diff
 		$line =~ s!^(diff (.*?) )"?.*$!$1!;
@@ -2259,6 +2261,8 @@ sub format_extended_diff_header_line {
 	my $diffinfo = shift;
 	my ($from, $to) = @_;
 
+	$line = $cgi->escapeHTML($line);
+
 	# match <path>
 	if ($line =~ s!^((copy|rename) from ).*$!$1! && $from->{'href'}) {
 		$line .= $cgi->a({-href=>$from->{'href'}, -class=>"path"},
-- 
1.7.7.1
