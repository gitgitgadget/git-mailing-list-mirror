From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH (WIP)] Git.pm: Add get_config() method and related subroutines
Date: Fri, 4 Jul 2008 01:45:12 +0200
Message-ID: <200807040145.14724.jnareb@gmail.com>
References: <200807031824.55958.jnareb@gmail.com> <486D36CB.3090400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 01:46:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEYVi-0001JX-2d
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 01:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798AbYGCXpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 19:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753745AbYGCXpt
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 19:45:49 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:24119 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458AbYGCXps (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 19:45:48 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1235613rvb.1
        for <git@vger.kernel.org>; Thu, 03 Jul 2008 16:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=dEuQ3MGC05nHOl0mJSW3Vd1WvoWFKaqAWobr16ykU/Y=;
        b=UniOXRj0QJMsOimSE3l1Ba4zisRERdxSfWRt4ZRN3foJwiYNSVcWkO2vzIi9CKW8ki
         BI5fjCFc12b8DD0P9FxOV6QWntijNVrJYAlr3pZa7H+bkaYpt2qu2SGIYxUd7QfFrW6l
         FDHe6PkDZa1ccGVP9voK3PvTm0CH1nDp1ygF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Qk0emAVR9hfkDQHVylNB50DDDVY13jV4d4+DYnp5LgwMXTwsY39lBqItcivjv514ib
         zsaKF+A97ygoc468+PN5szGkYs/B5A7FoRhHICYgyhyleBzM2jMnHArzBbYvR2ucipDY
         3TSaz8rC3IFBhm0dQYhA291A9+VESp/xyOzQ8=
Received: by 10.115.14.1 with SMTP id r1mr1895708wai.206.1215128747462;
        Thu, 03 Jul 2008 16:45:47 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.222.3])
        by mx.google.com with ESMTPS id i5sm3109498mue.2.2008.07.03.16.45.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Jul 2008 16:45:45 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <486D36CB.3090400@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87337>

Lea Wiemann wrote:
> Jakub Narebski wrote:
>>
>> Add get_config([PREFIX]) method [...]
>
> FWIW, I don't think it'll make much of a difference for gitweb, since
> the 'git config -l' output is cached anyway, but it's good someone's
> extracting this.  Do you have any user for that function besides gitweb?

If I remember correctly git-cvsserver used to have Perl parser for
_simplified_ config format, but now it uses `git config -l -z` or
`git config -l`.  Other git commands written in Perl which uses a lot
of configuration option could use it, like git-svn or git-send-email,
although for them shaving a little bit of execution time is not that
important (git-svn from what I understand still calls git-config
for each config variable).
 
>>  * Should config_val_to_bool and config_val_to_int throw error or
>>    just return 'undef' on invalid values?
> 
> I suspect that if you have, say, command line tools, throwing an error
> is better UI behavior than silently ignoring the entry.  And developers
> can always catch errors if they want to.

Actually for ->config_bool(<VARIABLE>) throwing error was the _only
way_ to distinguish between *non-existent* config variable (which we
can test using exists($config{<VARIABLE>}) when using ->get_config(),
and for which ->config_bool(<VARIABLE>) returned 'undef'), and
*non-bolean* value (for which config_val_to_bool($config{<VARIABLE>})
can return 'undef', and for which ->config_bool(<VARIABLE>) threw
error).
 
So we don't _need_ to _throw_ an error; we can detect error condition
in other way.

>>  * Is "return wantarray ? %config : \%config;" DWIM-mery good style?
> 
> Gitweb uses it as well, and it seems reasonable IMVHO.

Errr... if I remember correctly, the code in gitweb is by yours truly
:-), and as I have stated I am *not* a Perl hacker.
 
>>  * Should ->get_config() use ->command_output_pipe, or simpler
>>    ->command() method, reading whole config into array?
> 
> Does it make a difference?  If you're worried about performance, config
> files are so short that it won't matter; use the easier path.

I think using ->command() would be easier...
 
>>  * What should ->get_config() method be named? ->get_config()
>>    or perhaps ->config_hash(), or ->config_hashref()?
> 
> Regarding the method naming, how about making this an object oriented
> interface?  [...] if you can wait a week or so, you could maybe
> integrate this into the Git::Repo interface [...]

I'd rather have both functional (of sorts) and object interface.
Git::Repo / Git::Config could use methods / subroutines from Git.pm;

>>  * What should ->get_config() have as an optional parameter:
>>    PREFIX (/^$prefix/o), or simply SECTION (/^(?:$section)\./o)?
> 
> Off the top of my head, I don't see much need for a prefix parameter, so
> I'd go for 'section'.

O.K. (that is by the way how it is done in gitweb).
 
> I haven't been able to answer all of the questions, but I hope this helps.

Thanks a lot!

-- 
Jakub Narebski
Poland
