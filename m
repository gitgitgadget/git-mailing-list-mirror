From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email.perl: implement suggestions made by
 perlcritic
Date: Thu, 21 Mar 2013 08:29:28 -0700
Message-ID: <7vd2usbwkn.fsf@alter.siamese.dyndns.org>
References: <1363869587-10462-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 16:29:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIhRG-0004SK-6R
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 16:29:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453Ab3CUP3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 11:29:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33838 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752514Ab3CUP3a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 11:29:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FF4EABB1;
	Thu, 21 Mar 2013 11:29:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fGC2yUhoXOMHXdlSochmFLTnb2w=; b=bS7SzG
	yy4A4M9ZsU0pc7FiKL0nOqCQBtHccb5UWAQ4rUqWXcRbz9o2pRHAULoDjW2TzIvW
	aauH0KxYOmXtMdJe4EHDyP6tFROwSd48PiePwtpkOXhGDh16TGRTKDolpgBIaa/z
	GPfz0cgmpw382GeMiyZdDcVZ+OxMyVoMLe5fY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J22RDe6Wu6Z9HqKgE6ewPBjts9DBt9o7
	bo9HPqge8e3nnjR2/+7FKNMHJSDEn8vEZ8KTYL5pkMPifsCaBaxk8hTX1ct0gWxp
	A9n+tvL/CkXh2DYcZwNK64V8e/J2Sy8hnXR7y+U3FlbcPzOf5aq4Bo6LifdECH9w
	L6bBcm/1M4U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1494AABB0;
	Thu, 21 Mar 2013 11:29:30 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78154ABAF; Thu, 21 Mar 2013
 11:29:29 -0400 (EDT)
In-Reply-To: <1363869587-10462-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Thu, 21 Mar 2013 18:09:47 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1F474E0C-923C-11E2-84EF-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218735>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> diff --git a/git-send-email.perl b/git-send-email.perl
> index be809e5..e974b11 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -513,7 +513,7 @@ if (@alias_files and $aliasfiletype and defined $parse_alias{$aliasfiletype}) {
>  ($sender) = expand_aliases($sender) if defined $sender;
>  
>  # returns 1 if the conflict must be solved using it as a format-patch argument
> -sub check_file_rev_conflict($) {
> +sub check_file_rev_conflict {

Have you verified that the callers of this sub are OK with this
change?  It used to force scalar context on its arguments but now it
does not.

I am not saying I know the callers will get broken.  I am trying to
make sure that this is *not* the result of blindly following
perlcritic output without understanding the ramifications of the
change.

> @@ -1438,7 +1438,7 @@ sub recipients_cmd {
>  
>  	my $sanitized_sender = sanitize_address($sender);
>  	my @addresses = ();
> -	open my $fh, "$cmd \Q$file\E |"
> +	open my $fh, q{-|}, "$cmd \Q$file\E"

Strange quoting (why not just say "-|"?) aside, if you are moving
away from the two-param form of open(), it would be a sane thing to
do to also stop concatenating the arguments to commands to avoid
shell metacharacter gotcha.  It will make the resulting code much
safer.
