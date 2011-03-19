From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] gitweb: rename parse_date() to format_date()
Date: Sat, 19 Mar 2011 11:33:57 +0100
Message-ID: <201103191134.00098.jnareb@gmail.com>
References: <ab54ba2199cc7487e383a31e3aa65885@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 11:31:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0tRi-0001pV-13
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 11:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755888Ab1CSKbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 06:31:41 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61070 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab1CSKbk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 06:31:40 -0400
Received: by fxm17 with SMTP id 17so4363177fxm.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 03:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=PUJPUX135gLdjxL/uvkGDB58N4+C1hNP8SE3pOrWxHY=;
        b=cOk4Ix0079qRZvkXQSjYooEP0twB07xiFoKMekBWJAV+HgdOR8VEv1oGXK0A2tB4oa
         4DPPk9XnNEkWOavLvo5+Ja2mxtusJIQ0UZRh1DxZH5HBeSHqxRFLYR2EHGVIAakAT1H7
         Tr4Hxk5uH9jGUVIsE1OQ/x4fNH7xzKD2ptEWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=qe/wAw4VhsYdjxm7jcQXKWr89u1mVtU3olxuE/ncQV5l+wECdRGHnknS5HT8nCNV5Z
         RYiyP/ftHN2MvArzj97Qch2qCyZaqccxPhKpM6OmGgi2slDaIBmYhA1CR7oTMySuq/0N
         VCp1iYJzPx/tkQqYHWPR20MwvAxmJ4B0vMN0E=
Received: by 10.223.6.11 with SMTP id 11mr2428413fax.99.1300530699393;
        Sat, 19 Mar 2011 03:31:39 -0700 (PDT)
Received: from [192.168.1.13] (abrz59.neoplus.adsl.tpnet.pl [83.8.119.59])
        by mx.google.com with ESMTPS id e17sm787679fak.0.2011.03.19.03.31.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Mar 2011 03:31:37 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <ab54ba2199cc7487e383a31e3aa65885@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169424>

On Sat, 19 Mar 2011, Kevin Cernekee wrote:

> One might reasonably expect a function named parse_date() to be used
> for something along these lines:
> 
> $unix_time_t = parse_date("2011-03-19");

First, one would expect parse_date() to return either list of year, 
month, etc., e.g. [2011, 3, 19, ...], or a hash with named
date fragments, e.g. {'year' => 2011, 'month' => 3, ...}.

Almost all other parse_* subroutines in gitweb (parse_commit, parse_tag,
parse_difftree_raw_line, parse_ls_tree_line, with the sole exception of
parse_from_to_diffinfo with perhaps a bit misleading name) return hash
of parsed and pre-formatted fragments.

So if parse_date(1300505805) returned

   (
     'hour' => 3,
     'minute' => 36,
     ...
   )

_without_ the 'rfc2822', 'mday-time' (unused), 'iso-8601', 'iso-tz',
it would be not misnamed parse_*.


Second, it is _date_ because it parses / processes dates in git internal
format.  Perhaps it should be called *_raw_date, or *_git_date, or *_epoch,
or *_timestamp and not *_date.
 
> But instead, gitweb's parse_date works more like:
> 
> &parse_date(1300505805) = {

Note: parse_date takes second argument, which is numeric timezone (defaults
to '-0000'), so one usually uses

  parse_date(1300505805, '+0200')

>         'hour' => 3,
>         'minute' => 36,
>         ...
>         'rfc2822' => 'Sat, 19 Mar 2011 03:36:45 +0000',
>         ...
> }

What I would like to see is to split parsing date from generating formatted
dates into e.g. parse_date and formatted_date, and replace calls to parse_date
with calls to formatted_date (which uses parse_date internally).
 
> Rename the function [to format_date] to improve clarity.  
> No change to functionality. 

But name *format_date* is _not_ a good name.  All other format_* 
subroutines in gitweb return _formatted string_, not a hash which contains
many formatted strings.

It is hard to come up with really good name, but perhaps one from the ;ist
below would be good idea:

 - formatted_date
 - process_date, process_raw_date, process_git_date
 - process_epoch, process_timestamp
 - date_formats
 - from_epoch, date_from_epoch

Any other ideas?
 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>  gitweb/gitweb.perl |   18 +++++++++---------
>  1 files changed, 9 insertions(+), 9 deletions(-)

> @@ -4906,7 +4906,7 @@ sub git_log_body {
>  		next if !%co;
>  		my $commit = $co{'id'};
>  		my $ref = format_ref_marker($refs, $commit);
> -		my %ad = parse_date($co{'author_epoch'});
> +		my %ad = format_date($co{'author_epoch'});
>  		git_print_header_div('commit',
>  		               "<span class=\"age\">$co{'age_string'}</span>" .
>  		               esc_html($co{'title'}) . $ref,

Hmm, we should probably fix it so it reads

  -		my %ad = parse_date($co{'author_epoch'});
  +		my %ad = formatted_date($co{'author_epoch'}, $co{'author_tz'});

Especially when preparing for 'localtime' feature.

> @@ -7064,7 +7064,7 @@ sub git_feed {
>  	if (defined($commitlist[0])) {
>  		%latest_commit = %{$commitlist[0]};
>  		my $latest_epoch = $latest_commit{'committer_epoch'};
> -		%latest_date   = parse_date($latest_epoch);
> +		%latest_date   = format_date($latest_epoch);
>  		my $if_modified = $cgi->http('IF_MODIFIED_SINCE');
>  		if (defined $if_modified) {
>  			my $since;

Similarly here.

> @@ -7195,7 +7195,7 @@ XML
>  		if (($i >= 20) && ((time - $co{'author_epoch'}) > 48*60*60)) {
>  			last;
>  		}
> -		my %cd = parse_date($co{'author_epoch'});
> +		my %cd = format_date($co{'author_epoch'});
>  
>  		# get list of changed files
>  		open my $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,

Same here.

-- 
Jakub Narebski
Poland
