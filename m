From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: handle email address with quoted comma
Date: Thu, 18 Dec 2008 22:40:13 -0800
Message-ID: <7vej04d5wy.fsf@gitster.siamese.dyndns.org>
References: <1229658012-9240-1-git-send-email-fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wu Fengguang <fengguang.wu@intel.com>
X-From: git-owner@vger.kernel.org Fri Dec 19 07:41:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDZ3K-0003eN-9u
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 07:41:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621AbYLSGkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 01:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752620AbYLSGkU
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 01:40:20 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63442 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbYLSGkT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 01:40:19 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DFE6B88BCB;
	Fri, 19 Dec 2008 01:40:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AE1E288BCA; Fri,
 19 Dec 2008 01:40:15 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E6EC9E44-CD97-11DD-A495-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103551>

Wu Fengguang <fengguang.wu@intel.com> writes:

> Correctly handle email addresses containing quoted commas, e.g.
>
> 	"Zhu, Yi" <yi.zhu@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>
>
> Here the commas inside the double quotes are NOT email separators.

Thanks.

> @@ -359,6 +360,12 @@ foreach my $entry (@bcclist) {
>  	die "Comma in --bcclist entry: $entry'\n" unless $entry !~ m/,/;
>  }
>  
> +sub split_addrs($) {
> +	my ($addrs) = @_;
> +
> +	return &quotewords('\s*,\s*', 1, $addrs);
> +}
> +

Does it add real value (e.g. type safety, simplified interface to the
caller, etc.) to force scalar context to the callers?  It has been my
experience that use of prototypes (aka "parameter context templates") in
Perl programs tend to make the code less readable and more error prone in
longer term.  I would further say that, even though you do not have any
existing caller of split_addrs sub that uses it for more than two values,
not using the prototype would be a better way to write this sub in this
particular case, because it would allow callers to say [*1*]:

	@addrs = split_addr(@list_of_addr_lines);

It also is a bit funny-looking to invoke &function() (it is Perl4 style,
isn't it?)

IOW, wouldn't this be a better alternative?

	sub split_addrs {
        	return quotewords('\s*,\s*', 1, @_);
	}

[Footnote]

*1*  This program demonstrates why use of prototype in this case is more
confusing than it is worth.

-- >8 --
#!/usr/bin/perl -w

use Text::ParseWords;

sub foo ($) { my ($addrs) = @_; return quotewords('\s*,\s*', 1, $addrs); }
sub bar { return quotewords('\s*,\s*', 1, @_); }
my @addrs = ('Frotz, "Xyzzy, Zork", Nitfol', 'Yomin, Rezrov');
my @addr = ($addrs[0]);
for (foo($addrs[0])) {
	print "foo(\$addrs[0]) <<$_>>\n";
}
for (foo(@addr)) {
	print "foo(\@addr) <<$_>>\n";
}
for (bar($addrs[0])) {
	print "bar(\$addrs[0]) <<$_>>\n";
}
for (bar(@addr)) {
	print "bar(\@addr) <<$_>>\n";
}
-- 8< --

The output from the above (the fourth one is the most interesting) looks
like this.

foo($addrs[0]) <<Frotz>>
foo($addrs[0]) <<"Xyzzy, Zork">>
foo($addrs[0]) <<Nitfol>>
foo(@addr) <<1>>
bar($addrs[0]) <<Frotz>>
bar($addrs[0]) <<"Xyzzy, Zork">>
bar($addrs[0]) <<Nitfol>>
bar(@addr) <<Frotz>>
bar(@addr) <<"Xyzzy, Zork">>
bar(@addr) <<Nitfol>>

*2* A more detailed discussion on Perl's "prototypes" is found here:

http://web.archive.org/web/20080210085941/http://library.n0i.net/programming/perl/articles/fm_prototypes/
