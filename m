From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] git send-email: interpret unknown files as revision
 lists
Date: Tue, 04 Nov 2008 15:54:26 -0800
Message-ID: <7v1vxroxn1.fsf@gitster.siamese.dyndns.org>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org>
 <1225815858-30617-1-git-send-email-madcoder@debian.org>
 <1225815858-30617-2-git-send-email-madcoder@debian.org>
 <1225815858-30617-3-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Nov 05 00:56:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxVlL-0006wl-HV
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 00:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758907AbYKDXym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 18:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758540AbYKDXyl
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 18:54:41 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55596 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757450AbYKDXyj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 18:54:39 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DF445793F4;
	Tue,  4 Nov 2008 18:54:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 66346793F3; Tue,
  4 Nov 2008 18:54:33 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F0FAA546-AACB-11DD-8134-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100122>

Pierre Habouzit <madcoder@debian.org> writes:

> diff --git a/git-send-email.perl b/git-send-email.perl
> index aaace02..c29868a 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -22,8 +22,11 @@ use Term::ReadLine;
>  use Getopt::Long;
>  use Data::Dumper;
>  use Term::ANSIColor;
> +use File::Temp qw/ tempdir /;

We seem to use File::Temp::tempdir already elsewhere, but they are in
archimport, cvsexportcommit and cvsserver, all of which are rather rarely
used ones.  I think this is Perl 5.6.1 addition.  Is everybody Ok with
this dependency?  Just double checking.

> @@ -363,10 +366,22 @@ if (@alias_files and $aliasfiletype and defined $parse_alias{$aliasfiletype}) {
>  
>  ($sender) = expand_aliases($sender) if defined $sender;
>  
> +sub check_file_rev_conflict($) {
> +	my $f = shift;
> +	if ($repo->command('rev-parse', '--verify', '--quiet', $f)) {
> +		die("revision/filename conflict on `$f'");

Perhaps wording this a bit more to the point?  This is triggered when 
'$f' can be both a filename or a revision, so...

	File '$f' exists but it could also be the range of commits
        to produce patches for.  Please disambiguate by...

	* Saying "./$f" if you mean a file; or
        * Giving -F option if you mean a range.

Earlier I suggested that "origin^0" is a way for the user to disambiguate
favouring a rev, but such a filename can exist, so we cannot blindly
suggest to say "$f^0" here.  I think adding -F (or --format-patch) option
to send-email to explicitly disable file/directory interpretation would be
a cleaner solution for this (and it would allow you to drive this from a
script without worrying about what garbage files you happen to have in the
working tree).
