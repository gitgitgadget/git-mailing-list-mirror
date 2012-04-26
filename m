From: Igor <mrigor83@gmail.com>
Subject: Re: git-svn won't remember pem password
Date: Thu, 26 Apr 2012 11:31:03 -0700
Message-ID: <761A0E26-E2CB-4D50-8F7A-C562A929A372@gmail.com>
References: <E56535F6-2C9B-4D14-A88F-2471E34D2769@gmail.com> <20120219013011.GB31886@dcvr.yhbt.net> <20120426180018.GX4023@login.drsnuggles.stderr.nl> <41A093CB-CA4A-4FEF-9F5C-A9B626D10AFB@gmail.com> <20120426181327.GZ4023@login.drsnuggles.stderr.nl>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
To: Matthijs Kooijman <matthijs@stdin.nl>
X-From: git-owner@vger.kernel.org Thu Apr 26 20:31:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNTTF-00008Q-Sq
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 20:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758820Ab2DZSbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 14:31:08 -0400
Received: from mail-pz0-f51.google.com ([209.85.210.51]:41557 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756893Ab2DZSbH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Apr 2012 14:31:07 -0400
Received: by dadz8 with SMTP id z8so1926313dad.10
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 11:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=sVqhxR1EyRwoWpViiHq+ew3U2rBaZ7ck81FamatEOhE=;
        b=i0K0hpuY3fdwXVpwSmvq4PploZ0w0swPzkGBcPnZTmPyJPKPjfHVk5Gj7JJks205x2
         fNSSccRqaoUw/X6r5jZ6GBk2St+/rek8HqIWBCyqMl6ot4SwaTrg/z2tQO+gN3vK9wxm
         4mCKFK1not4xxjtaDE/5ZBiOFxArh0MzjqiVwSruRbtGUzqzMasxn7p9D5jnGdJryijC
         EUE39F9G3gIniik9UcJoyUkTyWs00TIV3MHr++GFD+l5+iaXGMoLK2fuC2rWk1nUk/RI
         d4oH15gVXWg7eP776dy5ELrqDu3hSk+KUwcR/w4Bdx4N3BbJ8GvMfRqZcmr6lBH3Y2EF
         qEQQ==
Received: by 10.68.189.41 with SMTP id gf9mr2881939pbc.17.1335465066891;
        Thu, 26 Apr 2012 11:31:06 -0700 (PDT)
Received: from [172.17.61.81] (50-0-2-21.static.sonic.net. [50.0.2.21])
        by mx.google.com with ESMTPS id d4sm3971706pbe.36.2012.04.26.11.31.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 Apr 2012 11:31:06 -0700 (PDT)
In-Reply-To: <20120426181327.GZ4023@login.drsnuggles.stderr.nl>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196387>

Nice, that seems to work. I got prompted to allow access to my KeyChain.

Thanks!

On Apr 26, 2012, at 11:13 AM, Matthijs Kooijman wrote:

>> Did you forget to attach the patch?
> No, but I wrote it in invisible ink! But here's the patch in regular
> ink, just in case.... *cough*
> 
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -5436,7 +5436,7 @@ BEGIN {
> }
> 
> sub _auth_providers () {
> -       [
> +       my @rv = (
>          SVN::Client::get_simple_provider(),
>          SVN::Client::get_ssl_server_trust_file_provider(),
>          SVN::Client::get_simple_prompt_provider(
> @@ -5452,7 +5452,23 @@ sub _auth_providers () {
>            \&Git::SVN::Prompt::ssl_server_trust),
>          SVN::Client::get_username_prompt_provider(
>            \&Git::SVN::Prompt::username, 2)
> -       ]
> +       );
> +
> +       # earlier 1.6.x versions would segfault, and <= 1.5.x didn't have
> +       # this function
> +       if ($SVN::Core::VERSION gt '1.6.12') {
> +               my $config = SVN::Core::config_get_config($config_dir);
> +               my ($p, @a);
> +               # config_get_config returns all config files from
> +               # ~/.subversion, auth_get_platform_specific_client_providers
> +               # just wants the config "file".
> +               @a = ($config->{'config'}, undef);
> +               $p = SVN::Core::auth_get_platform_specific_client_providers(@a);
> +               # Insert the return value from
> +               # auth_get_platform_specific_providers
> +               unshift @rv, @$p;
> +       }
> +       \@rv;
> }
> 
> sub escape_uri_only {
