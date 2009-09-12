From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v7 3/6] fast-import: add feature command
Date: Sat, 12 Sep 2009 11:51:22 -0700
Message-ID: <20090912185122.GQ1033@spearce.org>
References: <1252247748-14507-1-git-send-email-srabbelier@gmail.com> <1252247748-14507-2-git-send-email-srabbelier@gmail.com> <1252247748-14507-3-git-send-email-srabbelier@gmail.com> <1252247748-14507-4-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.clatworthy@canonical.com>,
	Matt McClure <mlm@aya.yale.edu>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	vcs-fast-import-devs@lists.launchpad.net
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 20:51:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmXh1-00053C-P4
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 20:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754865AbZILSvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 14:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754810AbZILSvT
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 14:51:19 -0400
Received: from george.spearce.org ([209.20.77.23]:32941 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbZILSvT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 14:51:19 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 32693381FD; Sat, 12 Sep 2009 18:51:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1252247748-14507-4-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128284>

Sverre Rabbelier <srabbelier@gmail.com> wrote:
> This allows the fronted to require a specific feature to be supported
> by the frontend, or abort.
>
> Also add support for the first feature, date-format=.
...
> +`feature`
> +~~~~~~~~~
> +Require that fast-import supports the specified feature, or abort if
> +it does not.
> +
> +....
> +	'feature' SP <feature> LF
> +....
> +
> +The <feature> part of the command may be any string matching
> +[a-zA-Z-] and should be understood by a version of fast-import.
> +

Where is the documentation for 'feature date-format=<FORMAT>'?

Also, IIRC the fast-import list agreed that the <feature> name must
match the re ^[a-zA-Z][a-zA-Z-]*$.  Saying that here does somewhat
help another fast-import developer to use the same stream format,
but it does not help a user to understand what features they can
ask for in their stream.

> diff --git a/fast-import.c b/fast-import.c
> index 812fcf0..9bf06a4 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -2450,6 +2450,17 @@ static void parse_one_option(const char *option)
>  	}
>  }
>  
> +static void parse_feature(void)
> +{
> +	char *feature = command_buf.buf + 8;
> +
> +	if (!prefixcmp(feature, "date-format=")) {
> +		option_date_format(feature + 12);
> +	} else {
> +		die("This version of fast-import does not support feature %s.", feature);
> +	}
> +}
> +
>  static int git_pack_config(const char *k, const char *v, void *cb)
>  {
>  	if (!strcmp(k, "pack.depth")) {
> @@ -2526,6 +2537,8 @@ int main(int argc, const char **argv)
>  			parse_checkpoint();
>  		else if (!prefixcmp(command_buf.buf, "progress "))
>  			parse_progress();
> +		else if (!prefixcmp(command_buf.buf, "feature "))
> +			parse_feature();

So its legal to change the data format in the middle of a stream?
I thought we agreed on fast-import list that "feature" needs to come
before any data commands, and isn't legal once data commands have
appeared in the stream.  Thus it should not be possible to request
a change in the date-format once a blob or commit has been stored.

-- 
Shawn.
