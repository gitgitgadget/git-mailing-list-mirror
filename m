From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-send-email and "mailhost" misbehavior
Date: Tue, 16 Nov 2010 11:06:20 -0800
Message-ID: <7vy68tgkb7.fsf@alter.siamese.dyndns.org>
References: <AANLkTinAjqb7cuCaiu=UvT9m5R=RM5E0hf4zPuKYVmHn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mike Frysinger <vapier@gentoo.org>
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Tue Nov 16 20:06:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIQrf-0001dw-Mi
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 20:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757276Ab0KPTGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 14:06:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58663 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757263Ab0KPTGa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 14:06:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5F94D29E6;
	Tue, 16 Nov 2010 14:06:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r6CLc3PbFCBYXsbVdHnD0NEP97k=; b=bwuZtX
	5J5m8K+XJfndr6yjjtHI9OCebvHF6b8buSjK1PAb8Q+Z5A5tUVDRcO8sVD6h2hxx
	2jTLgF3nHXzdR8v7IOZmfbjZT5xhpr/Hrop7Bg/JVdTZI+eS1o5CY+QpG/MnNGjP
	7J3PKng5dsUjF3GrYoq8ivosxGmckso022sqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gZVXxBn3nsUuclsLp+peEBfXOmB408Pa
	xHKTVCg292zjfuFg8eaeiVuqLzKxd3XQ0S9XmVjMerNQvQE0gLgEZsCIBH2K5eiU
	T9SKaYfsyFjvU5Nr7jzfPVA+Jw8wkU1Az8mo1xhm2KlyHpTim3GSo7sorxG0XJA4
	CJ7BfGLRtss=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2C57C29E5;
	Tue, 16 Nov 2010 14:06:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0979729E3; Tue, 16 Nov 2010
 14:06:31 -0500 (EST)
In-Reply-To: <AANLkTinAjqb7cuCaiu=UvT9m5R=RM5E0hf4zPuKYVmHn@mail.gmail.com>
 (Mike Frysinger's message of "Mon\, 15 Nov 2010 15\:24\:02 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A2295FB6-F1B4-11DF-82E6-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161576>

Mike Frysinger <vapier@gentoo.org> writes:

> i have sendemail in my ~/.gitconfig setup like so:
> [sendemail]
>     smtpserver = localhost:1111
>
> and i have a ssh tunnel running there to forward my e-mail to another
> machine's localhost:25
>
> however, when i attempt to send e-mail from some systems, the `git
> send-email` process pauses for like 2 minutes without doing anything.
> after hassling my e-mail admin about greylisting (which is disabled
> for localhost), i looked at git-send-email a bit closer.
>
> running it through a heavy strace shows the source of the pause:
> connect(6, {sa_family=AF_INET, sin_port=htons(25),
> sin_addr=inet_addr("208.68.139.38")}, 16)
> then there's a timeout after 120 seconds trying to connect to this guy
>
> so wtf is "208.68.139.38" !?  well, my shitty ISP (comcast) is doing
> DNS hijacking for unresolved DNS names.  so git-send-email tried to
> look up some host and it got back "208.68.139.38".  while comcast is
> wrong here, why is git-send-email looking up anything at all
> considering my sendemail.smtpserver is configured to localhost ?
>
> it seems that buried in the bowels of git-send-email and totally
> undocumented is this nugget:
> /usr/libexec/git-core/git-send-email:
> ...
> sub maildomain_mta {
>     my $maildomain;
>
>     if (eval { require Net::SMTP; 1 }) {
>         for my $host (qw(mailhost localhost)) {
>             my $smtp = Net::SMTP->new($host);
> ...
>
> so git-send-email is so kind as to attempt port 25 connections to
> "mailhost:25" and "localhost:25" while attempting to locate its FQDN
> !?  this doesnt sound right at all.  DNS lookups do not require actual
> TCP/IP connection attempts.
>
> stubbing out "mailhost" to 127.0.0.1 in /etc/hosts fixes my troubles.
> -mike

Redirecting to Jari Aalto for 134550f (git-send-email.perl - try to give
real name of the calling host to HELO/EHLO, 2010-03-14)
