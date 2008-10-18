From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Git.pm: do not break inheritance
Date: Sat, 18 Oct 2008 13:50:30 -0700
Message-ID: <7vabd1aaqx.fsf@gitster.siamese.dyndns.org>
References: <2980b5cead38d5ae3510e4ed9adc847c80be1075.1224360106.git.christian@jaeger.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Christian Jaeger <christian@jaeger.mine.nu>
X-From: git-owner@vger.kernel.org Sat Oct 18 22:52:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrImI-0001dg-Ml
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 22:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbYJRUul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 16:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbYJRUul
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 16:50:41 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60654 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbYJRUuk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 16:50:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 81A558CA21;
	Sat, 18 Oct 2008 16:50:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AB19C8CA20; Sat, 18 Oct 2008 16:50:33 -0400 (EDT)
In-Reply-To: <2980b5cead38d5ae3510e4ed9adc847c80be1075.1224360106.git.christian@jaeger.mine.nu> (Christian Jaeger's message of "Sat, 18 Oct 2008 20:25:12 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6BF822A6-9D56-11DD-86D9-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98571>

Christian Jaeger <christian@jaeger.mine.nu> writes:

> Make it possible to write subclasses of Git.pm
>
> Signed-off-by: Christian Jaeger <christian@jaeger.mine.nu>
> ---
>
>  I don't really know what the reason for the _maybe_self behaviour
>  was; I'm hoping this fix doesn't break anything,

That's how you would write class methods, isn't it?  IOW, your callers
can say:

	my $self = new Git();
        $self->method(qw(a b c));
        Git::method(qw(a b c))

and you can start your method like this:

	sub method {
        	my ($self, @args) = _maybe_self(@_)
                ...
	}

and use @args the same way for either form of the call in the
implementation.  Two obvious pitfalls are:

 - You cannot use $self if you set up your parameters with _maybe_self;

 - The second form of the call would call directly into Git::method, never
   your subclasses implementation, even if you write:

	use Git;
        package CJGit;
        our @ISA = qw(Git);

        sub method {
        	...
	}

>  sub _maybe_self {
> -	# This breaks inheritance. Oh well.
> -	ref $_[0] eq 'Git' ? @_ : (undef, @_);
> +	UNIVERSAL::isa($_[0], 'Git') ? @_ : (undef, @_);
>  }
>  
>  # Check if the command id is something reasonable.

The patch looks Ok, as long as you have a working UNIVERSAL::isa() in your
version of Perl.  My reading of perl561delta,pod says that Perl 5.6.1 and
later should have a working implementation.
