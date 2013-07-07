From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] git-svn: allow git-svn fetching to work using serf
Date: Sat, 6 Jul 2013 17:24:30 -0700
Message-ID: <20130707002430.GE30132@google.com>
References: <ABDE5FFA-C19F-44BF-A360-3FD5D74F2B28@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Rothenberger <daveroth@acm.org>,
	Petr Baudis <pasky@ucw.cz>,
	Daniel Shahaf <danielsh@apache.org>,
	Eric Wong <normalperson@yhbt.net>
To: Kyle McKay <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 07 02:24:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvcma-0004kg-AA
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 02:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933Ab3GGAYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jul 2013 20:24:35 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:40798 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749Ab3GGAYe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jul 2013 20:24:34 -0400
Received: by mail-pd0-f171.google.com with SMTP id y14so2946716pdi.30
        for <git@vger.kernel.org>; Sat, 06 Jul 2013 17:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ozhtfTa+S3YYj/hLWzmQH1LOLpYTWOlYOIbUuc4DTEI=;
        b=m5cidmSlLoDWPS+qfKhZyRLo5pmfZuF3Gy4kfz/+M87yK0KJ4MlN4uSPXPI6bQp2Ic
         9LNUPcz0VG1VjTg0q9K0bkQOU6MhZ+bxrzzVAfLIM3x7pPWC4CFV94vRhgAL590wIRet
         Kz1f8RylWJo032IWllaXoPFe5Qyx7mGKeKc6bGFMAAppfASxqBl2eozgC7pwjb/OFeAO
         +9r0pLLsVPQ1GcBIAaevmUblcl/Tuj8+cbfcoqP8YGMOrz1r7268tyzIMg51vW+OzekO
         vLlhZleHm6FgplnwK1fg6+tkY6xQWlFBzr6rH7SiaaOVeBIF8EBGmeGqnn1DxOY29bNq
         McBA==
X-Received: by 10.66.162.135 with SMTP id ya7mr16696381pab.173.1373156674236;
        Sat, 06 Jul 2013 17:24:34 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id kc8sm14390222pbc.18.2013.07.06.17.24.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 06 Jul 2013 17:24:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <ABDE5FFA-C19F-44BF-A360-3FD5D74F2B28@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229707>

(cc-ing Eric Wong, who wrote this code)
Hi,

Kyle McKay wrote:

> Temp file with moniker 'svn_delta' already in use at Git.pm line 1250
> Temp file with moniker 'git_blob' already in use at Git.pm line 1250
>
> David Rothenberger <daveroth@acm.org> has determined the cause to
> be that ra_serf does not drive the delta editor in a depth-first
> manner [...]. Instead, the calls come in this order:
[...]
> --- a/perl/Git/SVN/Fetcher.pm
> +++ b/perl/Git/SVN/Fetcher.pm
> @@ -315,11 +315,13 @@ sub change_file_prop {
> sub apply_textdelta {
> 	my ($self, $fb, $exp) = @_;
> 	return undef if $self->is_path_ignored($fb->{path});
> -	my $fh = $::_repository->temp_acquire('svn_delta');
> +	my $suffix = 0;
> +	++$suffix while $::_repository->temp_is_locked("svn_delta_${$}_$suffix");
> +	my $fh = $::_repository->temp_acquire("svn_delta_${$}_$suffix");
> 	# $fh gets auto-closed() by SVN::TxDelta::apply(),
> 	# (but $base does not,) so dup() it for reading in close_file
> 	open my $dup, '<&', $fh or croak $!;
> -	my $base = $::_repository->temp_acquire('git_blob');
> +	my $base = $::_repository->temp_acquire("git_blob_${$}_$suffix");

Thanks for your work tracking this down.

I'm a bit confused.  Are you saying that apply_textdelta gets called
multiple times in a row without an intervening close_file?

Puzzled,
Jonathan
