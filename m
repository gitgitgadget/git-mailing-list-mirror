From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 2/4] gitweb: git_get_heads_list accepts an optional
 list of refs.
Date: Sun, 16 Nov 2008 09:29:24 -0800
Message-ID: <7vod0f37gr.fsf@gitster.siamese.dyndns.org>
References: <1226842089-1159-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1226842089-1159-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1226842089-1159-3-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 18:31:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1lSl-0003Fs-UM
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 18:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbYKPR3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 12:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbYKPR3w
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 12:29:52 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56659 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbYKPR3w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 12:29:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2631A16D56;
	Sun, 16 Nov 2008 12:29:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EEC9C16D48; Sun,
 16 Nov 2008 12:29:26 -0500 (EST)
In-Reply-To: <1226842089-1159-3-git-send-email-giuseppe.bilotta@gmail.com>
 (Giuseppe Bilotta's message of "Sun, 16 Nov 2008 14:28:07 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2BF69BC8-B404-11DD-B3B2-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101144>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> git_get_heads_list(limit, class1, class2, ...) can now be used to retrieve
> refs/class1, refs/class2 etc. Defaults to ('heads') or ('heads', 'remotes')
> depending on the remote_heads option.
>
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index e1f81f6..0512020 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2681,15 +2681,18 @@ sub parse_from_to_diffinfo {
>  ## parse to array of hashes functions
>  
>  sub git_get_heads_list {
> -	my $limit = shift;
> +	my ($limit, @class) = @_;
> +	unless (defined @class) {
> +		my $remote_heads = gitweb_check_feature('remote_heads');
> +		@class = ('heads', $remote_heads ? 'remotes' : undef);
> +	}
> +	my @refs = map { "refs/$_" } @class;

Makes sense, except that I'd suggest passing a hash of "refs/$path" =>
$class as I illustrated in my comments to [1/4], instead of passing a list
of ("head", "remote"), because that will later allow you to have
multi-level $path that does not necessarily limited to a $class that is a
substring of $path, and doing so does not make the code any more complex.
There is another reason to do so I'll mention in I comment on [3/4].
