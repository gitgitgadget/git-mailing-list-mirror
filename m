From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] config: Add --null/-z option for null-delimted output
Date: Fri, 22 Jun 2007 01:56:00 +0200
Message-ID: <200706220156.01175.jnareb@gmail.com>
References: <f2t6na$5bi$1@sea.gmane.org> <11821227322913-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Fri Jun 22 02:02:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1WbP-00008O-5h
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 02:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbXFVACK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 20:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753278AbXFVACK
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 20:02:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:51084 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbXFVACH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 20:02:07 -0400
Received: by ug-out-1314.google.com with SMTP id j3so694786ugf
        for <git@vger.kernel.org>; Thu, 21 Jun 2007 17:02:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SJFAJxOjZ9ygsk6KL2QmJevoTt51qM+qdsrse86O+SdnUQabbau+ByJ7rpTrl5H7FZCXn/ZAirms9KQwJFio+g9e4PWuB+CaVBiwMz8GPPmZgsAULvNzDVvCycSvtKTjdmC6ji6qlXBAIRDXJrFY01h7Z2a1cA7grIa820g34Bo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=niofImgxCCOydyKOKGVyWpdNt9XIv1KnQgEmI+kPMrOtPGSDslF6Jf8egZVdxY/o1YVYlPNEM5GLHZ6HO+EVIg8+33wvu4QEaBXX7tdUkFLOe3awY6VwwWON0TGi0lv7sniYIdpsguANyswS+CKmnApEPa6nBc9OhN/ogXNGAQ8=
Received: by 10.82.112.16 with SMTP id k16mr5066102buc.1182470526309;
        Thu, 21 Jun 2007 17:02:06 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id y2sm6213897mug.2007.06.21.17.02.01
        (version=SSLv3 cipher=OTHER);
        Thu, 21 Jun 2007 17:02:04 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <11821227322913-git-send-email-frank@lichtenheld.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50660>

On Mon, 18 Jun 2007, Frank Lichtenheld wrote:
> Use \n as delimiter between key and value and \0 as
> delimiter after each key/value pair. This should be
> easily parsable output.
> 
> Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
> ---
>  builtin-config.c |   15 +++++++++++----
>  1 files changed, 11 insertions(+), 4 deletions(-)

No documentation. But this is an RFC.
 
>  Note the FIXME. Does anyone remember the reason why --get-regexp
>  and --list use different output format?

I don't know, but at least two scripts use --get-regexp, namely
git-remote and git-submodule. So we would have to be careful about
changing that.
 

I would be enough to add the following to your patch:

> @@ -12,14 +12,16 @@ static int use_key_regexp;
>  static int do_all;
>  static int do_not_match;
>  static int seen;
> +static char delim = '=';
> +static char term = '\n';
  +static char key_delim = ' ';
>  static enum { T_RAW, T_INT, T_BOOL } type = T_RAW;
[...]
> @@ -39,6 +41,7 @@ static int show_config(const char* key_, const char* value_)
>  		return 0;
>  
>  	if (show_keys)
> +		/* FIXME: not useful with --null */
  - 		printf("%s ", key_);
  + 		printf("%s%c", key_, key_delim);
>  	if (seen && !do_all)
>  		dup_error = 1;
[...]
> @@ -155,6 +158,10 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		}
>  		else if (!strcmp(argv[1], "--system"))
>  			setenv("GIT_CONFIG", ETC_GITCONFIG, 1);
> +		else if (!strcmp(argv[1], "--null") || !strcmp(argv[1], "-z")) {
> +			term = '\0';
> +			delim = '\n';
  +			key_delim = '\n';
> +		}
>  		else if (!strcmp(argv[1], "--rename-section")) {
>  			int ret;
>  			if (argc != 4)


By the way, I have tried to use git-config --null to redo config
file parsing in gitweb, so one git-config call would be needed for
all the config. I have noticed that --bool option description does
not describe the observed behavior fully. For example it returns
'true' not only for '1', but for any integer != 0, including 0xdeadbeef.

By the way, the error message when key value _cannot_ be converted to
the boolean is somewhat misleading:

  $ GIT_CONFIG=conftest git config --bool bool.key7
  fatal: bad config value for 'bool.key7' in conftest

-- 
Jakub Narebski
Poland
