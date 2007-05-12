From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Avoid "Use of uninitialized value" errors (written to logs)
Date: Fri, 11 May 2007 18:06:40 -0700
Message-ID: <7vzm4a7sv3.fsf@assigned-by-dhcp.cox.net>
References: <200705120135.30150.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 12 03:06:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmg4O-0007FB-FE
	for gcvg-git@gmane.org; Sat, 12 May 2007 03:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756001AbXELBGn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 21:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760183AbXELBGm
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 21:06:42 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:44336 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756001AbXELBGm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 21:06:42 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070512010641.VBPC26353.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Fri, 11 May 2007 21:06:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id y16g1W00b1kojtg0000000; Fri, 11 May 2007 21:06:41 -0400
In-Reply-To: <200705120135.30150.jnareb@gmail.com> (Jakub Narebski's message
	of "Sat, 12 May 2007 01:35:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47006>

Jakub Narebski <jnareb@gmail.com> writes:

> Try to avoid "Use of uninitialized value ..." errors, due to bad
> revision, incorrect filename, wrong object id, bad file etc. (wrong
> value of 'h', 'hb', 'f', etc. parameters). This avoids polluting web
> server errors log.
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> This is a bit of "bandaid" patch, as if possible the callers should
> be corrected, and should check if there is something to pass along.

If the bad values come from the end user (via the browser), I
suspect that should be checked and rejected far earlier than
this sub on the output path is called.  Are there code that
internally needs to pass bogus values to this function?

@@ -594,6 +594,9 @@ sub esc_html ($;%) {
 	my $str = shift;
 	my %opts = @_;
 
+	# empty or undefined
+	return $str unless $str;
+

I think this is wrong, as the callers of esc_html typically
concatenate the return value with other strings.  If $str could
be undef, the caller would end up getting the warning when doing
the concatenation, so you did not solve anything.

$str could be '0' (literal string constant whose length is 1 and
has character *zero* in it), in which case you return it intact.
It is safe only because esc_html('0') is '0' itself; use of
"unless $str" here is a very bad style.

A more straightforward way obviously is:

	if (!defined $str) {
        	return '';
	}

@@ -1059,6 +1062,7 @@ sub git_get_hash_by_path {
 		or die_error(undef, "Open git-ls-tree failed");
 	my $line = <$fd>;
 	close $fd or return undef;
+	$line or return undef;
 
 	#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
 	$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t/;

I think this one means well but not quite to my taste; path may
be given by the end user and we need to run ls-tree to find out
if that path exists or not here.  $line would be undefined if
path does not exist, so...

	if (!defined $line) {
        	return undef;
	}

Note that it is very unlikely that $line consists of single '0'
here, so "$line or ..." would probably not break in practice.
My preference to use defined is more style and discipline thing.

@@ -1377,7 +1381,7 @@ sub parse_commit_text {
 	pop @commit_lines; # Remove '\0'
 
 	my $header = shift @commit_lines;
-	if (!($header =~ m/^[0-9a-fA-F]{40}/)) {
+	if (!defined $header || $header !~ m/^[0-9a-fA-F]{40}/) {
 		return;
 	}
 	($co{'id'}, my @parents) = split ' ', $header;

I would prefer checking the length of @commit_linse before
blindly shifting it out.

	if (!@commit_lines) {
        	return;
	}
	my $header = shift @commit_lines;
        ...

I am Ok with "return if (!@commit_lines);" if you feel it is
more Perl-ish.

One final note.

If you think using postfix "Statement Modifiers" somehow makes
your program look more Perl-ish, I think you should reconsider.
IMHO, coding more carefully to distinguish undef and other forms
of falsehood where the difference matters would make your code
look much more Perl-ish.
