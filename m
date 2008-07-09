From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH (WIP)] Git.pm: Add get_config() method and related subroutines
Date: Thu, 10 Jul 2008 01:33:36 +0200
Message-ID: <200807100133.38163.jnareb@gmail.com>
References: <200807031824.55958.jnareb@gmail.com> <20080709160303.GL10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Lea Wiemann <lewiemann@gmail.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jul 10 01:30:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGj7T-0005Id-7o
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 01:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbYGIX3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 19:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751889AbYGIX3o
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 19:29:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:31924 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbYGIX3n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 19:29:43 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1265075fgg.17
        for <git@vger.kernel.org>; Wed, 09 Jul 2008 16:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=JAxCIKH1VFN7iHcVCqjmZge4rhn0Al/ELSZ0dsbKa8Q=;
        b=cf/cpOwHA5vmyg+6hkWieIv65J38dU287zJmfqMN2Vcwc17rJYB+TB3nAidloMsVdQ
         FM0sIA1FCT2wiz6Cvrhu/NvRM/y5tA2UV1UkVpD3ficlAvOC/W5Fyl6b9Ed2bek2HWgM
         gBdf6DiTfqtIf2l0sQP1BrHwCMiWoicMX0oOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=chUSE6sfxpSdVm0LI2mNIKQA5DZuINKyG05PlqgUoXdfs4zQ6ncOvw9b/ahZBladXf
         f75+qa1IYCjG91cuYBnBk035+/8hOIsS+dXplhQVgn9ogtcuYsfz/gYichsjP2kK70yG
         Pj8WpNZENBf4omMP5jXBZTasJsQXsQ73mV5Fo=
Received: by 10.86.66.19 with SMTP id o19mr7781887fga.78.1215646181497;
        Wed, 09 Jul 2008 16:29:41 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.249.234])
        by mx.google.com with ESMTPS id l19sm9929256fgb.7.2008.07.09.16.29.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Jul 2008 16:29:39 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080709160303.GL10151@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87924>

On Wed, Jul 09, 2008, Petr "Pasky" Baudis wrote:
> On Thu, Jul 03, 2008 at 06:24:53PM +0200, Jakub Narebski wrote:
> >
> > There are also a few things which I'd like some comments about:
> > 
> >  * Do config_val_to_bool and config_val_to_int should be exported
> >    by default?
> 
>   Yes with the current API, not with object API (see below). But if
> exported by default, there should be definitely a git_ prefix.

Object API for config is definitely good idea; some more reasons are
given below.

> >  * Should config_val_to_bool and config_val_to_int throw error or
> >    just return 'undef' on invalid values?  One can check if variable
> >    is defined using "exists($config_hash{'varname'})".
> 
>   I think that it's more reasonable to throw an error here (as long as
> you don't throw an error on undef argument). This particular case is
> clearly a misconfiguration by the user and you rarely need to handle
> this more gracefully, I believe.

If we follow git-config convention (and I guess we should), it would be
value of appropriate type if variable value is of appropriate type,
'undef' (no output in the case of git-config) when variable does not 
exists, and throwing error (status and "fatal: ..." message on STDERR
in the case of git-config) if variable is not of given type.

> >  * How config_val_to_bool etc. should be named? Perhaps just
> >    config_to_bool, like in gitweb?
> 
>   What about Git::Config::bool()? ;-) (See below.)
> 
> >  * Is "return wantarray ? %config : \%config;" DWIM-mery good style?
> >    I am _not_ a Perl hacker...
> 
> I maybe wouldn't be as liberal myself, but I can't tell if it's a bad
> style either.

This won't matter, I think, in the case of object API (returning 
Git::Config instead of hash or hashref).

> >  * Should ->get_config() use ->command_output_pipe, or simpler
> >    ->command() method, reading whole config into array?
> 
> You have the code written already, I'd stick with it.

This is simple rewrite of code which is in gitweb, changing open '-|'
into ->command_output_pipe, but we could just read the whole config
into array using ->command(), which would be a bit simpler.

> >  * What should ->get_config() have as an optional parameter:
> >    PREFIX (/^$prefix/o), or simply SECTION (/^(?:$section)\./o)?
> 
>   Do we even _need_ a parameter like that? I don't understand what is
> this interface trying to address.

For example if one wants to access _all_ variables in gitweb.* section
(or in gitcvs.* section), and _only_ config variables in given section.

> >  * Should we perltie hash?
> 
>   I agree with Lea that we should actually bless it. :-) Returning a
> Git::Config object provides a more flexible interface, and you can
> also do $repo->get_config()->bool('key') which is quite more elegant
> way than the val_ functions, I think.

Yes it is.

Also it does allow to use any capitalization of the section name and 
variable name (which are case insensitive), so you can write either

  $repo->get_config()->get('gitcvs.dbtablenameprefix');

but also

  $repo->get_config()->get('gitcvs.dbTableNamePrefix');

or even better, as below:

  $config = $repo->get_config();
  $config->get('gitcvs.dbTableNamePrefix');

BTW. what should non-typecasting should be named? $c->get(<VAR>), 
$c->value(<VAR>), $c->param(<VAR>), or something yet different?

> Also, having accessors for special types lets you return undef when
> the type really isn't defined, instead of e.g. true with current
> config_val_bool, which is clearly bogus and requires complicated code
> on the user side. 
 
I don't follow you.  Didn't we agree on casting an error when variable
is not of given type?

By the way, bool values are processed a bit strangely.  Value is true
if it there is no value[*1*], if it is 'true' or 'yes' case insensitive, 
or of it is integer != 0.  Value is false if it has empty value[*2*], 
if it is 'false' or 'no' case insensitive, and if it is integer of 
value '0'.  All other values are invalid (and should cause throwing an 
error).

Both current config_val_to_bool() and config_val_to_int() implementation 
are too forbidding.

> > As this is an RFC I have not checked if manpage (generated from
> > embedded POD documentation) renders correctly.
> 
>   By the way, unless you know already, you can do that trivially by
> issuing:
> 
> 	perldoc perl/Git.pm

Thanks, I didn't knew this.

> -- 
> 				Petr "Pasky" Baudis
> The last good thing written in C++ was the Pachelbel Canon. 
>                                                  -- J. Olson 

Eh? Isn't it written C# rather?

-- 
Jakub Narebski
Poland
