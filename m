Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37B2A2C
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 00:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="w9eQQyQW"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 02C9F1D5550;
	Wed, 10 Jan 2024 19:17:56 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IR/oPii6X13A3PHUKyMTqT+FMJb6f6sRTArcta
	lVsSc=; b=w9eQQyQWFWwdHlF1bXKWOmDk57kLBPBtcUekT242z2bMbYfZ/2ECV0
	YKfQ/yGO7vsVwOYauhYp6NItMscltQUfTa8dNa628rx22uJ7RhIfa9Xms54bNubn
	HixtKzFqeuA/OkvegeJpgpju9z/unMj001dxzwMN0N/8DTxOEYu1w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EBDF61D554F;
	Wed, 10 Jan 2024 19:17:55 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5DB7C1D554E;
	Wed, 10 Jan 2024 19:17:55 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Marcelo Roberto Jimenez <marcelo.jimenez@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] gitweb: Fixes error handling when reading configuration
In-Reply-To: <20240110225709.30168-1-marcelo.jimenez@gmail.com> (Marcelo
	Roberto Jimenez's message of "Wed, 10 Jan 2024 19:57:09 -0300")
References: <CACjc_5pdijCZrrXQWHswsxYrGUzZ7pZq+nj3SzY1z+Xxop64Ww@mail.gmail.com>
	<20240110225709.30168-1-marcelo.jimenez@gmail.com>
Date: Wed, 10 Jan 2024 16:17:54 -0800
Message-ID: <xmqqzfxc7mfh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DDEAB642-B016-11EE-B8FF-25B3960A682E-77302942!pb-smtp2.pobox.com

Marcelo Roberto Jimenez <marcelo.jimenez@gmail.com> writes:

> This patch fixes a possibility of a permission to access error go
> unnoticed.
>
> Perl uses two different variables to manage errors from a do. One
> is $@, which is set in this case when do is unable to compile the
> file. The other is $!, which is set in case do cannot read the file.
> By printing the value of $! I found out that it was set to Permission
> denied. Since the script does not currently test for $!, the error
> goes unnoticed.

Well explained how the current code behaves and why.

With my devil's advocate hat on, I suspect that the current
behaviour comes from the wish to see "file exists but unreadable"
and "the named file does not exist" behave the same way.  If you
pass the name of a configuration file that does not exist, however,
the codeblock to die does not trigger at all.  If a file does exist
but unreadable, to gitweb, it is just as good as having no file to
read configuration data from---either way, it cannot use anything
useful from the named file.  So returning silently, which is the
"bug" you are fixing, does not sound too bad.

I dunno.  Let's queue and see what others would say.

Thanks.

> Perl do block documentation: https://perldoc.perl.org/functions/do
>
> Signed-off-by: Marcelo Roberto Jimenez <marcelo.jimenez@gmail.com>
> ---
>  gitweb/gitweb.perl | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index e66eb3d9ba..5d0122020f 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -728,9 +728,11 @@ sub filter_and_validate_refs {
>  sub read_config_file {
>  	my $filename = shift;
>  	return unless defined $filename;
> -	# die if there are errors parsing config file
>  	if (-e $filename) {
>  		do $filename;
> +		# die if there is a problem accessing the file
> +		die $! if $!;
> +		# die if there are errors parsing config file
>  		die $@ if $@;
>  		return 1;
>  	}
