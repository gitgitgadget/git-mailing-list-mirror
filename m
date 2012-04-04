From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add -p: skip conflicted paths
Date: Wed, 04 Apr 2012 08:36:11 -0700
Message-ID: <7v398jbjbo.fsf@alter.siamese.dyndns.org>
References: <7viphov839.fsf@alter.siamese.dyndns.org>
 <1332966017-6100-1-git-send-email-kusmabite@gmail.com>
 <7viphotng8.fsf@alter.siamese.dyndns.org>
 <7vaa30tmk9.fsf@alter.siamese.dyndns.org>
 <7v62dotltk.fsf@alter.siamese.dyndns.org>
 <20120329054558.GA27604@sigill.intra.peff.net>
 <CABPQNSY8gNPZTV77AjFbHn1HA9S=fw3NC+H8bCzZOPFyLg0nHQ@mail.gmail.com>
 <7v398mgfdu.fsf@alter.siamese.dyndns.org>
 <20120404094618.GA13870@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, git@vger.kernel.org,
	matthieu.moy@grenoble-inp.fr, hellmuth@ira.uka.de
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 17:36:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFSFw-0002bl-K0
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 17:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221Ab2DDPgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 11:36:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64906 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756311Ab2DDPgO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 11:36:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96B8D6548;
	Wed,  4 Apr 2012 11:36:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YIb9Y+VVokR5k4mwPTgcBCRWjeA=; b=ckANmS
	LGfvbyboJiokbugFyzAeVDo3CVZ7uDdNqeISTIub7c1qd73Ntp9YHJ7T/Yfv2E36
	/Z9cPIZNOLQM27V1U9LprzidNgOzfodNCak1rxbDf+q5bv7Q6giRtQdA+KZB99x9
	c4eOZHZ71PTtMozDFFYWkOVJtIThP1qyUdIOw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MXjYXBm6bnQbifuGbp5lA/34yVx/ogz/
	ALx8fahGGwDed00pEqRCQEXW4gbkhdmT4LOMNuaHh0QltbbzHkO8EPWtlopoBz2k
	3ltUnm/vrmsG3MRlXi3YB6E/W7ahhgyYf+oDjzg1PYWxDdUiq2npOHzKF//pfhIR
	xcDF46Qt7DQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E1656547;
	Wed,  4 Apr 2012 11:36:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B3BA6546; Wed,  4 Apr 2012
 11:36:13 -0400 (EDT)
In-Reply-To: <20120404094618.GA13870@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 4 Apr 2012 05:46:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8DD50E4-7E6B-11E1-AE2B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194702>

Jeff King <peff@peff.net> writes:

> I do still think it would be nicer to pass the information out to the
> caller instead of just filtering.

Indeed.

> So combining the two patches, we have
> something like:

Hrm.  I kind of liked the idea of doing this with a single plumbing call
to diff-files (the entries that come from --raw will be mostly discarded
except for the ones that are marked with "U"), though.

> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 2ee0908..0a83f56 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -292,7 +292,7 @@ sub get_empty_tree {
>  # FILE_ADDDEL:	is it add/delete between index and file?
>  
>  sub list_modified {
> -	my ($only) = @_;
> +	my ($only, $note_unmerged) = @_;
>  	my (%data, @return);
>  	my ($add, $del, $adddel, $file);
>  	my @tracked = ();
> @@ -370,6 +370,18 @@ sub list_modified {
>  		}
>  	}
>  
> +	if ($note_unmerged) {
> +		for (run_cmd_pipe(qw(git ls-files -u --), @ARGV)) {
> +			chomp $_;
> +			if (/^[0-7]+ [0-9a-f]{40} [0-3]	(.*)/) {
> +				my $path = unquote_path($1);
> +				if (exists($data{$path})) {
> +					$data{$path}{UNMERGED} = 1;
> +				}
> +			}
> +		}
> +	}
> +
>  	for (sort keys %data) {
>  		my $it = $data{$_};
>  
> @@ -1211,10 +1223,14 @@ sub apply_patch_for_checkout_commit {
>  }
>  
>  sub patch_update_cmd {
> -	my @all_mods = list_modified($patch_mode_flavour{FILTER});
> +	my @all_mods = list_modified($patch_mode_flavour{FILTER}, 'note-unmerged');
>  	my @mods = grep { !($_->{BINARY}) } @all_mods;
>  	my @them;
>  
> +	print colored $error_color, "ignoring unmerged: $_->{VALUE}\n"
> +		for grep { $_->{UNMERGED} } @mods;
> +	@mods = grep { !$_->{UNMERGED} } @mods;
> +
>  	if (!@mods) {
>  		if (@all_mods) {
>  			print STDERR "Only binary files changed.\n";
