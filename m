From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 4/4] gitweb: show notes in commit(diff) view
Date: Sat, 6 Feb 2010 14:16:28 +0100
Message-ID: <201002061416.29481.jnareb@gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> <1265300338-25021-5-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 14:17:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdkWi-0008F1-Vb
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 14:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755602Ab0BFNQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 08:16:39 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:33754 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755485Ab0BFNQj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 08:16:39 -0500
Received: by fxm20 with SMTP id 20so69897fxm.1
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 05:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=DkBK6cJktupns/dwV1PjDUziEwys5btg4ZToUjokyvU=;
        b=UxWU9uJNs8B4MV6xPWnk2AV0MNliK93fv7666ArLhDtr4mbvaXa3lI9sw2mJOF3H1a
         6wGs9wA7kTw5JAwkRsH7fMbBEufGvN67EnJGlFgxXdFkQp8Hd5l9l8+9tJwCipom9QwJ
         UjABset6QgIsTWxGCrKduYpv2erD8VsDpYTuo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=RDXcnX4iMUTqwKL2cpScv3en0dQ5td1MZkMc7JJwxBlL/j3uAJdMKe7tdQrDiJtjNo
         NPMq8QcbmWxbwkupDjC6ZgcNAJZYOVni+KOW/pArPzZ0GkkEbACGYN8ftYKYfEdyi9/O
         js9/CohdKn3dnbo8SFDN1j/IOZuITnduhTDNQ=
Received: by 10.87.67.10 with SMTP id u10mr4156794fgk.28.1265462197361;
        Sat, 06 Feb 2010 05:16:37 -0800 (PST)
Received: from ?192.168.1.13? (abws80.neoplus.adsl.tpnet.pl [83.8.242.80])
        by mx.google.com with ESMTPS id 16sm1081312fxm.0.2010.02.06.05.16.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Feb 2010 05:16:36 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1265300338-25021-5-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139163>

On Thu, 4 Jan 2010, Giuseppe Bilotta wrote:

> The notes are shown side-by-side along the bottom of the commit
> message. 

The same question apply as for previous commit.

What happens if screen size is too small to contain both commit message
and notes?  Does it do the sensible thing of putting notes _below_
commit message in such situation?  I do not know CSS+HTML enogh to
answer this question myself.

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 0d0877e..0d03026 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2837,12 +2837,31 @@ sub parse_commit {
>  	%co = parse_commit_text(<$fd>, 1);
>  	close $fd;
>  
> +	my %notes = ();
> +	foreach my $note_ref (get_note_refs()) {
> +		my $obj = "$note_ref:$co{'id'}";
> +		if (open my $fd, '-|', git_cmd(), 'rev-parse',
> +			'--verify', '-q', $obj) {
> +			my $exists = <$fd>;
> +			close $fd;
> +			if (defined $exists) {
> +				if (open $fd, '-|', git_cmd(), 'show', $obj) {
> +					$notes{$note_ref} = scalar <$fd>;
> +					close $fd;
> +				}
> +			}
> +		}
> +	}
> +	$co{'notes'} = \%notes;
> +
>  	return %co;
>  }

Duplicated code.  Please put this code in a separate subroutine, to be
called in those two places.
  
>  # return all refs matching refs/notes/<globspecs> where the globspecs
>  # are taken from the notes feature content.
>  sub get_note_refs {
> +	local $/ = "";
> +

Why it is needed here?  Why you want to use empty lines as terminator
(which means reading whole paragraphs), while treating two or more
consecutive empty lines as a single empty line (according to
perlvar(1))?

If you want to slurp whole file, this should be

   	local $/;

or more explicit

   	local $/ = undef;

>  	my @globs = gitweb_get_feature('notes');
>  	my @note_refs = ();
>  	foreach my $glob (@globs) {
> @@ -5875,6 +5894,7 @@ sub git_commit {
>  
>  	print "<div class=\"page_body\">\n";
>  	git_print_log($co{'comment'});
> +	print format_notes_html($co{'notes'}, 'div');
>  	print "</div>\n";
>  
>  	git_difftree_body(\@difftree, $hash, @$parents);
> @@ -6230,6 +6250,7 @@ sub git_commitdiff {
>  			git_print_log($co{'comment'}, -final_empty_line=> 1, -remove_title => 1);
>  			print "</div>\n"; # class="log"
>  		}
> +		print format_notes_html($co{'notes'}, 'div');
>  
>  	} elsif ($format eq 'plain') {
>  		my $refs = git_get_references("tags");

This of course assumes that we want notes treated exactly (or almost
exactly) the same way for 'log', 'commit' and 'commitdiff' views.
Perhaps it is a good assumption (at least for first step)...

-- 
Jakub Narebski
Poland
