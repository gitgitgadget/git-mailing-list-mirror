From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Use GITWEB_CONFIG_SYSTEM even if GITWEB_CONFIG does exist
Date: Sun, 15 May 2011 11:53:07 +0200
Message-ID: <201105151153.08826.jnareb@gmail.com>
References: <201105142137.16541.jnareb@gmail.com> <20110514210603.GA11502@elie>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 15 11:53:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLY0s-0002qh-GS
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 11:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071Ab1EOJxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 05:53:22 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61330 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979Ab1EOJxV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 05:53:21 -0400
Received: by bwz15 with SMTP id 15so3057633bwz.19
        for <git@vger.kernel.org>; Sun, 15 May 2011 02:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=i+vl2tYAN042wv7VnegtYAzGXNI7I6OhQ1xfB/CzlKE=;
        b=uXQSLT3Jnj4I0s1ugec25n2Y4PIUbaEEMgztr/hK3hnnKw4zESd/vy52Yu+yir88u6
         tsvXyiB3k+4wbHi6uNdsCXuY93YpJntDY/z4GgfgGDfQKOicdaV8LC4md4L50fCRslAd
         89Dz0vM/t50pYMD3kmLgGWbvu9yEklKibnA+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=KbhNmVJMWf2yDjXH0NW5kt0LlD9Wo2m+KHxAgWKkmXCo1zvAMLbAaPsqvhjAajSuFg
         tYamZRjgmXeqa8crKbAOZ5UAZh+5jMdAyyW7PnaOI/VFY03b7wWJT9zQaQWF72XhZJmZ
         OXOe52vmoOdSdazkcZVMqJ64otq9o0wH4sy0I=
Received: by 10.204.133.27 with SMTP id d27mr3102116bkt.69.1305453199687;
        Sun, 15 May 2011 02:53:19 -0700 (PDT)
Received: from [192.168.1.13] (aeho161.neoplus.adsl.tpnet.pl [79.186.196.161])
        by mx.google.com with ESMTPS id d25sm2343330bkd.5.2011.05.15.02.53.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 May 2011 02:53:18 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110514210603.GA11502@elie>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173624>

On Sat, 14 May 2011, Jonathan Nieder wrote:
> Jakub Narebski wrote:
> 
> > If per-instance configuration file exists, then system-wide
> > configuration was _not used at all_.  This is quite untypical and
> > suprising behavior.
> 
> I agree.  How to avoid breaking existing installations, though?  (I'm
> especially worried because distro packages tend to ship their own
> /etc/gitweb.conf, so the admin might not even know about what's
> there.)  For example, depending on the content of /etc/gitweb.conf,
> this has the potential to break "git instaweb".

I don't think that this change has potential to break "git instaweb",
because "git instaweb" creates its own gitweb_conf.perl - settings
there would override distro's /etc/gitweb.conf.  But I have not checked
if it doesn't rely on some values being default; it shouldn't though.

It is a PITA to have to retain backward compatibility with our bugs
and mistakes.  Perhaps this change is for 1.8.0 version boundary, then?

> 
> It could be simpler to document that users should put
> 
> 	do $GITWEB_CONFIG_SYSTEM;

Well, you need to check if file exists, and die if there were any bugs
parsing this file (otherwise you can get strange errors which are really
hard to debug, to notice that they stem from broken configuration file;
I am speaking here from my bitter experience ;-)).

> 
> at the start of gitweb_config.conf to reuse options from the system
> configuration file and override them.  But that's not very satisfying,
> since I don't see a nice way to move to a better behavior after that
> without breaking some existing installations.  (It would be possible
> to check for a new ./gitweb-config-in-addition-to-what-was-in-etc.conf
> file but that doesn't seem so nice.)

Right.

> 
> If this were a command-line tool, I would be happy as long as there is
> some way to prevent reading /etc/gitweb.conf through the environment.
> For a webapp I don't know how easy it is to set environment variables
> typically.  So thoughts from people in that corner of the world would
> be interesting.

For Apache it is as simple as using

  SetEnv	GITWEB_CONFIG_SYSTEM	/dev/null

(Sidenote: I just noticed that if $GITWEB_CONFIG_SYSTEM eq $GITWEB_CONFIG,
then we don't need and should not re-read config file).

For Lighttpd it would be

  setenv.add-environment = ( "GITWEB_CONFIG_SYSTEM" => "/dev/null" )

For Mongoose it would be

  cgi_env	GITWEB_CONFIG_SYSTEM=/dev/null

For nginx it would be

  env		GITWEB_CONFIG_SYSTEM=/dev/null;

For IIS... is anyone running gitweb under IIS?


All examples taken from either gitweb/README, gitweb/INSTALL, or
git-instaweb.sh.  Instead of /dev/null it can be anything that
does not exist, but is not a false value (so "" won't work).

Not tested!
-- 
Jakub Narebski
Poland
