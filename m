From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Support for git-svn propset
Date: Mon, 8 Dec 2014 21:36:36 +0000
Message-ID: <20141208213636.GA3743@dcvr.yhbt.net>
References: <20141207104723.GB54199@elvis.mu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Michael G. Schwern" <schwern@pobox.com>,
	David Fraser <davidf@sjsoft.com>
To: Alfred Perlstein <alfred@freebsd.org>
X-From: git-owner@vger.kernel.org Mon Dec 08 22:36:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy5z0-00084w-GA
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 22:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbaLHVgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 16:36:38 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:59920 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998AbaLHVgh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 16:36:37 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C4C31F7B4;
	Mon,  8 Dec 2014 21:36:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20141207104723.GB54199@elvis.mu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261083>

Alfred Perlstein <alfred@freebsd.org> wrote:
> Appearing here:
>   http://marc.info/?l=git&m=125259772625008&w=2

Probably better to use a mid URL here, too

http://mid.gmane.org/1927112650.1281253084529659.JavaMail.root@klofta.sjsoft.com

such a long URL, though...

> --- a/perl/Git/SVN/Editor.pm
> +++ b/perl/Git/SVN/Editor.pm
> @@ -288,6 +288,44 @@ sub apply_autoprops {
>  	}
>  }
>  
> +sub check_attr {
> +	my ($attr,$path) = @_;
> +	my $fh = command_output_pipe("check-attr", $attr, "--", $path);
> +	return undef if (!$fh);
> +
> +	my $val = <$fh>;
> +	close $fh;
> +	if ($val) { $val =~ s/^[^:]*:\s*[^:]*:\s*(.*)\s*$/$1/; }
> +	return $val;
> +}

I just noticed command_output_pipe didn't use a corresponding
command_close_pipe to check for errors, but command_oneline is even
better.  I'll squash the following:

--- a/perl/Git/SVN/Editor.pm
+++ b/perl/Git/SVN/Editor.pm
@@ -290,11 +290,7 @@ sub apply_autoprops {
 
 sub check_attr {
 	my ($attr,$path) = @_;
-	my $fh = command_output_pipe("check-attr", $attr, "--", $path);
-	return undef if (!$fh);
-
-	my $val = <$fh>;
-	close $fh;
+	my $val = command_oneline("check-attr", $attr, "--", $path);
 	if ($val) { $val =~ s/^[^:]*:\s*[^:]*:\s*(.*)\s*$/$1/; }
 	return $val;
 }

In your test, "local" isn't portable, unfortunately, but tests seem to
work fine without local so I've removed them:

--- a/t/t9148-git-svn-propset.sh
+++ b/t/t9148-git-svn-propset.sh
@@ -29,10 +29,9 @@ test_expect_success 'fetch revisions from svn' '
 	git svn fetch
 	'
 
-set_props()
-{
-	local subdir="$1"
-	local file="$2"
+set_props () {
+	subdir="$1"
+	file="$2"
 	shift;shift;
 	(cd "$subdir" &&
 		while [ $# -gt 0 ] ; do
@@ -43,10 +42,9 @@ set_props()
 		git commit -m "testing propset" "$file")
 }
 
-confirm_props()
-{
-	local subdir="$1"
-	local file="$2"
+confirm_props () {
+	subdir="$1"
+	file="$2"
 	shift;shift;
 	(set -e ; cd "svn_project/$subdir" &&
 		while [ $# -gt 0 ] ; do

Unless there's other improvements we missed, I'll push out your v3 with
my changes squashed in for Junio to pull in a day or two.  Thank you
again for working on this!
