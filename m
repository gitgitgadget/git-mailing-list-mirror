From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9 v8] difftool: print list of valid tools with
 '--tool-help'
Date: Wed, 28 Mar 2012 11:58:01 -0700
Message-ID: <7vvclov9hi.fsf@alter.siamese.dyndns.org>
References: <1332959684-2231-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davvid@gmail.com
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 20:58:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCy4R-00070U-2S
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 20:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754199Ab2C1S6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 14:58:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57732 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752294Ab2C1S6E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 14:58:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A077703C;
	Wed, 28 Mar 2012 14:58:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/e0wqrLdX7R/MmoGy+7V3eVPd5g=; b=IxeNcz
	ScjLgTlNYFS3/Q06egGhmRub6+R5005REQBn9XZ56xJ2bhuVDYBm8P6kSP0wVNwk
	GwL81TuawnFgW6bZhbYM6Fl5wAhyMHPGjtsnLJPOA76JAoTiyHH6vK4FQjlSiGcu
	YQ5bG7pjo3p55seN3pbRq/XU7hWYH96kiUuzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ao4R1TKeO1HdGcYqk0rbUDxxVpzcwvtL
	UzCoawC9i19ds74Qm96VjaWpI7hsZhKaYnWoeWqXxY6ph2UclTJS8qsJDpKBN0TP
	6KWiny8/VfgN6Vzoe0oXftsClYfbUUrAsqgDvo7Z/AfCo7cu8Ker1e1zBZDzEz4/
	Ids1uZwPXso=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A86F703B;
	Wed, 28 Mar 2012 14:58:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D37647039; Wed, 28 Mar 2012
 14:58:02 -0400 (EDT)
In-Reply-To: <1332959684-2231-1-git-send-email-tim.henigan@gmail.com> (Tim
 Henigan's message of "Wed, 28 Mar 2012 14:34:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1F29860-7907-11E1-B1A1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194163>

Tim Henigan <tim.henigan@gmail.com> writes:

> Changes in v8:
>   - Replaced 'glob' with 'File::Find'. Glob will fail if file paths include
>     spaces.  Using File::Find overcomes that limitation.

OK, but doesn't File::Find recurse into its subdirectories?  If you create
a 'foo' directory there and drop a 'bar' script in it, is the rest of the
code prepared to give you "git difftool -t foo/bar"?

>   - Added 'TOOL_MODE=DIFF' prior to calling 'git-mergetool--lib.sh'. This
>     insures that the shell script executes as designed.
>   - difftool now calls 'can_diff' from 'git-mergetool--lib.sh' to insure that
>     only tools that are capable of diffing are shown as valid options. For
>     example, 'tortoisemerge' cannot be used as a diff viewer.

Good that you caught these brown-paper-bag bugs ;-) It feels a bit awkward
that nobody pointed these out, even though the series has been queued in
'pu' since its early iterations.

> diff --git a/git-difftool.perl b/git-difftool.perl
> index 0fa131c..15fd572 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -38,6 +39,40 @@ USAGE
>  	exit($exitcode);
>  }
>  
> +sub print_tool_help
> +{
> +	my ($cmd, @found, @notfound, @tools);
> +	my $gitpath = Git::exec_path();
> +
> +	find(sub { push(@tools, $_) unless (-d $_) }, "$gitpath/mergetools");
> +
> +	for (@tools) {
> +		my $tool = $_;
> +		next if ($tool eq "defaults");

Now you use File::Find::find(), you probably should do this kind of
trivial filtering inside the callback, no?
