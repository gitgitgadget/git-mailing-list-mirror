From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add--interactive: respect diff.algorithm
Date: Sun, 23 Jun 2013 12:19:05 -0700
Message-ID: <7v8v20fxee.fsf@alter.siamese.dyndns.org>
References: <20130610142825.GI22905@serenity.lan>
	<7v38sphiiw.fsf@alter.siamese.dyndns.org>
	<20130610211140.GD13333@sigill.intra.peff.net>
	<20130610214638.GK22905@serenity.lan>
	<20130610215656.GA28345@sigill.intra.peff.net>
	<20130612184410.GB23890@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jun 23 21:19:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uqpof-0002OQ-Qt
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 21:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110Ab3FWTTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 15:19:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46657 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750879Ab3FWTTI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 15:19:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D107D2AFB9;
	Sun, 23 Jun 2013 19:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c6lXgd8P9wvyzagPylJtcUXVeMc=; b=aOJNrt
	nfad+0KxfAxrQhrSfVTQ8tgbA3yt3hLW02UWxOwDYmbd0oZLyjFvREmvSPouuyYR
	pFmcUxnfCcgaFr7jHrLm5NY+o6BrdSLgi69gRVjEAErJM3MvjBHzvDI7Rd+FO37f
	eWYpb8gHyTLcnwq+ZTWk2TWTSNKTWxRQi99Sc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZanDIDW0Y0TVS/KmCJA5VMvZoWdObZil
	bKPiNiLHh27CAi2ISuqq6WXYvl3ypWXcQ6boT6RQcPSq9vxUdo2W0P8CfVGn9oFI
	hskHCW6sfJ+FsKM4nj//FkxdgCr/AWLLT+1V4Rb+GFS2PXxAXs0NecZcb2lbLXkT
	aoFurWtiB1Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C43492AFB8;
	Sun, 23 Jun 2013 19:19:07 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 183352AFB7;
	Sun, 23 Jun 2013 19:19:07 +0000 (UTC)
In-Reply-To: <20130612184410.GB23890@serenity.lan> (John Keeping's message of
	"Wed, 12 Jun 2013 19:44:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C63413FC-DC39-11E2-990E-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228757>

John Keeping <john@keeping.me.uk> writes:

>> > +my $diff_algorithm = ($repo->config('diff.algorithm') or 'default');
>> > +
>> >  my $use_readkey = 0;
>> >  my $use_termcap = 0;
>> >  my %term_escapes;
>> > @@ -731,6 +733,9 @@ sub run_git_apply {
>> >  sub parse_diff {
>> >  	my ($path) = @_;
>> >  	my @diff_cmd = split(" ", $patch_mode_flavour{DIFF});
>> > +	if ($diff_algorithm ne "default") {
>> > +		push @diff_cmd, "--diff-algorithm=${diff_algorithm}";
>> > +	}

This is not exactly sanitary for "stash -p", whose DIFF element is
defined like so:

	'stash' => {
		DIFF => 'diff-index -p HEAD',

and you will end up appending an option after a non-option argument,

It may happen to be accepted by the command line parser which is
overly lax, but we would want to tighten it in the longer term.

As a band-aid, we could do something like the attached patch, but
for the longer term, we might need to rethink the way the tweaking
of the command line is done by $patch_mode_revision.

-- >8 --
Subject: add -i: add extra options at the right place in "diff" command line

Appending "--diff-algorithm=histogram" at the end of canned command
line for various modes of "diff" is correct for most of them but not
for "stash" that has a non-option already wired in, like so:

	'stash' => {
		DIFF => 'diff-index -p HEAD',

Appending an extra option after non-option may happen to work due to
overly lax command line parser, but that is not something we should
rely on.  Instead, splice in the extra argument immediately after a
'-p' option, which is an option to ask for textual diff output that
has to be in all variants.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-add--interactive.perl | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 5310959..b50551a 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -730,11 +730,23 @@ sub run_git_apply {
 	return close $fh;
 }
 
+# The command array must have a single "-p" to ask for output in the
+# patch form.  Splice additional options immediately after it; we
+# should not be randomly appending them, as some of the canned command.
+# has non-option argument like HEAD already on it.
+
+sub splice_diff_options {
+	my $diff_cmd = shift;
+	@$diff_cmd = map {
+		($_ eq '-p') ? ($_, @_) : $_;		
+	} @$diff_cmd;
+}
+
 sub parse_diff {
 	my ($path) = @_;
 	my @diff_cmd = split(" ", $patch_mode_flavour{DIFF});
 	if (defined $diff_algorithm) {
-		push @diff_cmd, "--diff-algorithm=${diff_algorithm}";
+		splice_diff_options(\@diff_cmd, "--diff-algorithm=${diff_algorithm}");
 	}
 	if (defined $patch_mode_revision) {
 		push @diff_cmd, $patch_mode_revision;
