From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Sat, 6 Feb 2010 00:44:09 +0100
Message-ID: <201002060044.11225.jnareb@gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> <1265300338-25021-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 00:44:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdXqk-0002L2-WD
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 00:44:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933930Ab0BEXoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 18:44:20 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:51223 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933483Ab0BEXoT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 18:44:19 -0500
Received: by fxm20 with SMTP id 20so4568979fxm.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2010 15:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=D6P4zPpJqPgxmo8i2VikVUGY1AbjAEX8CDtwJDu7LjI=;
        b=YJ3r5L67+CD7V+VE+364Vg/GQsD+4DYcgPBee7C/nri0Fu+zZz7O4XcCqCxchE0T0X
         /CNXPXFNN8Da0ff2tlqgukN445zxA72m+Rf0wvjuFKSW/5jP516DwpRYdFkpUipONdiJ
         W0HufmV/o+eE2sjcMuPkPYJ/uRYRAdWZmovZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=LJSruE4g8qn4uORJM3WRK26Z913WzqxNA7dKMkNI6dhIuhW5pO8s9a3Kbd9AHmCCdv
         qEtC7zGQA3qGwi6ji/xGobaD/S75joS8GeU/1jFp7EpcCQ09vH62yXiNZvZlh8OiINIi
         PstaEufL2ET+NcEwmIbs05ph7Q97qCO3JOUlg=
Received: by 10.87.37.2 with SMTP id p2mr3412487fgj.66.1265413458221;
        Fri, 05 Feb 2010 15:44:18 -0800 (PST)
Received: from ?192.168.1.13? (abvb35.neoplus.adsl.tpnet.pl [83.8.199.35])
        by mx.google.com with ESMTPS id l19sm2219806fgb.10.2010.02.05.15.44.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Feb 2010 15:44:16 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1265300338-25021-2-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139123>

On Thu, 4 Feb 2010, Giuseppe Bilotta wrote:

BTW. shouldn't this series be marked as RFC?

> Introduce support for notes by collecting them when creating commit
> lists. The list of noterefs to look into is configurable, and can be a(n
> array of) refspec(s), which will be looked for in the refs/notes
> namespace.
> 
> The feature is disabled by default because it's presently not very
> efficient (one extra git call per configured refspec, plus two extra git
> calls per commit per noteref).

Signoff?
> ---
>  gitweb/gitweb.perl |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 62 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index d0c3ff2..9ba5815 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -411,6 +411,22 @@ our %feature = (
>  		'override' => 0,
>  		'default' => [16]},
>  
> +	# Notes support. When this feature is enabled, the presence of notes
> +	# for any commit is signaled, and the note content is made available
> +	# in a way appropriate for the current view.
> +	# Set this to '*' to enable all notes namespace, or to a shell-glob
> +	# specification to enable specific namespaces only.

It is not obvious from this description that you can provide _list_ of
notes namespaces (or list of shell-globs).

> +
> +	# To enable system wide have in $GITWEB_CONFIG
> +	# $feature{'notes'}{'default'} = ['*'];
> +	# To have project specific config enable override in $GITWEB_CONFIG
> +	# $feature{'notes'}{'override'} = 1;
> +	# and in project config gitweb.notes = namespace;

How you can provide list of notes here?  Is overriding limited to single
name or shell-glob?

See feature_snapshot for example implementation.

> +	'notes' => {
> +		'sub' => \&feature_notes,
> +		'override' => 0,
> +		'default' => []},
> +
>  	# Avatar support. When this feature is enabled, views such as
>  	# shortlog or commit will display an avatar associated with
>  	# the email of the committer(s) and/or author(s).
> @@ -513,6 +529,16 @@ sub feature_patches {
>  	return ($_[0]);
>  }
>  
> +sub feature_notes {
> +	my @val = (git_get_project_config('notes'));
> +
> +	if (@val) {
> +		return @val;
> +	}
> +
> +	return @_;
> +}

First, this I think limits overriding in repository config to single value.

Second, perhaps it is time to refactor all those similar feature_xxx
subroutines (just a possible suggestion)?

> +
>  sub feature_avatar {
>  	my @val = (git_get_project_config('avatar'));
>  
> @@ -2786,10 +2812,30 @@ sub parse_commit {
>  	return %co;
>  }
>  
> +# return all refs matching refs/notes/<globspecs> where the globspecs
> +# are taken from the notes feature content.
> +sub get_note_refs {
> +	my @globs = gitweb_get_feature('notes');
> +	my @note_refs = ();
> +	foreach my $glob (@globs) {
> +		if (open my $fd, '-|', git_cmd(), 'for-each-ref',
> +		    '--format=%(refname)', "refs/notes/$glob") {

   		open my $fd, '-|', git_cmd(), 'for-each-ref',
   			'--format=%(refname)', "refs/notes/$glob"
   			or return;

would reduce indent level a bit.

> +			while (<$fd>) {
> +				chomp;
> +				push @note_refs, $_ if $_;
> +			}

Why not simply

   		chomp(@note_refs = <$fd>);

> +			close $fd;
> +		}
> +	}
> +	return @note_refs;
> +}
> +
>  sub parse_commits {
>  	my ($commit_id, $maxcount, $skip, $filename, @args) = @_;
>  	my @cos;
>  
> +	my @note_refs = get_note_refs();
> +
>  	$maxcount ||= 1;
>  	$skip ||= 0;
>  
> @@ -2807,6 +2853,22 @@ sub parse_commits {
>  		or die_error(500, "Open git-rev-list failed");
>  	while (my $line = <$fd>) {
>  		my %co = parse_commit_text($line);
> +		my %notes = () ;
> +		foreach my $note_ref (@note_refs) {
> +			my $obj = "$note_ref:$co{'id'}";
> +			if (open my $fd, '-|', git_cmd(), 'rev-parse',
> +				'--verify', '-q', $obj) {
> +				my $exists = <$fd>;
> +				close $fd;
> +				if (defined $exists) {
> +					if (open $fd, '-|', git_cmd(), 'show', $obj) {
> +						$notes{$note_ref} = scalar <$fd>;
> +						close $fd;
> +					}
> +				}
> +			}
> +		}

First, there are '--batch' and '--batch-check' options to git-cat-file.
With these I think you can get all notes with just single git command,
although using it is a bit complicated (requires open2 from IPC::Open2
for bidi communication).

Second, if not using 'git cat-file --batch', perhaps it would be easier
to read each $note_ref tree using 'git ls-tree'/'git ls-tree -r', and
parse its output to check for which commits/objects there are notes
available, and only then call 'git show' (or reuse connection to
'git cat-file --batch').

The second solution, with a bit more work, could work even in presence
of fan-out schemes for notes, I think.

> +		$co{'notes'} = \%notes;
>  		push @cos, \%co;
>  	}
>  	close $fd;
> -- 
> 1.7.0.rc1.193.ge8618
> 
> 

-- 
Jakub Narebski
Poland
