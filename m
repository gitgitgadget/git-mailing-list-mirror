Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49482C05027
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 10:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjBNKPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 05:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBNKPw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 05:15:52 -0500
Received: from abrecht.li (75-128-16-94.static.cable.fcom.ch [94.16.128.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F4E15CA2
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 02:15:50 -0800 (PST)
Received: from toucan.dmz.abrecht.li (unknown [IPv6:fc00:4::a3c:111])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by abrecht.li (Postfix) with ESMTPSA id 74C6036C029E;
        Tue, 14 Feb 2023 10:15:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 abrecht.li 74C6036C029E
MIME-Version: 1.0
Date:   Tue, 14 Feb 2023 11:15:44 +0100
From:   Daniel Abrecht <git-git@nodmarc.danielabrecht.ch>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] gitweb: fix base url set if PATH_INFO is used, add a /
 at the end
In-Reply-To: <xmqqfsbel9sf.fsf@gitster.g>
References: <20230209222648.z-sqdvWiK7xa-NLagt3B_X_4bFQJBsA8cA06YvgXqWQ@z>
 <xmqqfsbel9sf.fsf@gitster.g>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <522571c427c937ef52bb69b88cb3dea1@nodmarc.danielabrecht.ch>
X-Sender: git-git@nodmarc.danielabrecht.ch
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 2023-02-10 00:05, schrieb Junio C Hamano:
> Daniel Abrecht <git-git@nodmarc.danielabrecht.ch> writes:
>> +	# the browser will strip away the last component for relative URLs.
>> +	# Add the / if it's missing.
> 
> The above is not an incorrect statement per-se, but if $base were
> pointing at the document, we would likely break if we add an extra
> slash.  Don't we want to say something like
> 
> 	# $base_url at this point points at a directory, not a
>         # single document, and later is used in the <base> tag.
>         # Make sure it ends in a '/'.  Otherwise, we'd lose the last
>         # component when forming a relative URL.
> 
> perhaps?

After thinking about this for a while, I realized that this isn't as 
simple as I thought.

I'm currently using apache and some rewrite rules so I can access 
projects at /git/myproject.git/ (See my config below).
So in my case, $base_url is /git at this point, and I need to add a /.

But if I didn't have those rewrite rules, I could instead access the 
repos using /git/gitweb.cgi/myproject.git/ .
In that case, $base_url would be /git/gitweb.cgi at this point, so it 
does refer to the script / document.
The assets are still at /git/ and not at /git/gitweb.cgi/, so links are 
relative to /git/gitweb.cgi/ but assets are
relative to /git/. It seams relative URLs are only used for assets, so 
the $base_url should really be /git/gitweb.cgi
or alternatively just /git/ there, and just adding a slash would be 
wrong in that case.

Given this, I no longer think I should change the way it currently is.
I will just override $base_url in my config file instead.



<Macro gitweb $location>
   SetEnv GITWEB_CONFIG /etc/gitweb.conf
   SetEnv GIT_HTTP_EXPORT_ALL
   ScriptAliasMatch \
   "(?x)^/.*/(.*\.git/(HEAD | \
       info/refs | \
       objects/(info/[^/]+ | \
          [0-9a-f]{2}/[0-9a-f]{38} | \
          pack/pack-[0-9a-f]{40}\.(pack|idx)) | \
       git-(upload|receive)-pack))$" \
   /usr/lib/git-core/git-http-backend/$1
   Alias $location/ /usr/share/gitweb/
   RewriteRule 
^$location/.*\.git/(HEAD|info|objects|refs|git-(upload|receive)-pack) - 
[E=GIT_PROJECT_ROOT:%{DOCUMENT_ROOT}$location/,PT,END]
   RewriteRule ^$location/(.*\.git(/.*)?)?$ $location/gitweb.cgi/$1 
[E=GIT_PROJECT_ROOT:%{DOCUMENT_ROOT}$location/,L,PT]
   <Location $location>
     Require all granted
     AllowOverride None
   </Location>
   <Directory /usr/share/gitweb/>
     Options +FollowSymLinks +ExecCGI
     AddHandler cgi-script .cgi
   </Directory>
</Macro>

<VirtualHost *:443>
   Use VHostSSL projects.dpa.li
   DocumentRoot /var/www/projects.dpa.li/
   Use gitweb /git
</VirtualHost>
